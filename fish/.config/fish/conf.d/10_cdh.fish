# Set dirprev and dirnext as universal variables for cdh.
if not set --universal --query dirprev
    set --universal dirprev
end

if not set --universal --query dirnext
    set --universal dirnext
end
