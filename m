Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE804A2644E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 21:17:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf2rc-0003zG-Ca; Mon, 03 Feb 2025 15:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tf2rZ-0003yX-GU
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:16:09 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tf2rV-00057I-IQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 15:16:09 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tf2rN-00000006oHm-1qN3; Mon, 03 Feb 2025 21:15:57 +0100
Message-ID: <afb27de1-d20a-4b0d-b271-ef6eef0e06ed@maciej.szmigiero.name>
Date: Mon, 3 Feb 2025 21:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/33] migration: postcopy_ram_listen_thread() needs to
 take BQL for some calls
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Alex Williamson
 <alex.williamson@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <139bf266dbd1e25a1e5a050ecb82e3e59120d705.1738171076.git.maciej.szmigiero@oracle.com>
 <Z57TPqhRYY4V14BE@gallifrey>
 <d3a27b10-a7a6-4aa6-97ad-9c39f49df4fc@maciej.szmigiero.name>
 <Z59o4u9zui3CPrkm@gallifrey>
 <fafbc505-acee-408e-a2ef-0a62bd30689b@maciej.szmigiero.name>
 <Z6Ef3iwQs7JSFY3c@x1.local>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZdEV4gUJDWuO
 nQAKCRCEf143kM4JdyzED/0Qwk2KVsyNwEukYK2zbJPHp7CRbXcpCApgocVwtmdabAubtHej
 7owLq89ibmkKT0gJxc6OfJJeo/PWTJ/Qo/+db48Y7y03Xl+rTbFyzsoTyZgdR21FQGdgNRG9
 3ACPDpZ0UlEwA4VdGT+HKfu0X8pVb0G0D44DjIeHC7lBRzzE5JXJUGUVUd2FiyUqMFqZ8xP3
 wp53ekB5p5OstceqyZIq+O/r1pTgGErZ1No80JrnVC/psJpmMpw1Q56t88JMaHIe+Gcnm8fB
 k3LyWNr7gUwVOus8TbkP3TOx/BdS/DqkjN3GvXauhVXfGsasmHHWEFBE0ijNZi/tD63ZILRY
 wUpRVRU2F0UqI+cJvbeG3c+RZ7jqMAAZj8NB8w6iviX1XG3amlbJgiyElxap6Za1SQ3hfTWf
 c6gYzgaNOFRh77PQbzP9BcAVDeinOqXg2IkjWQ89o0YVFKXiaDHKw7VVld3kz2FQMI8PGfyn
 zg5vyd9id1ykISCQQUQ4Nw49tqYoSomLdmIgPSfXDDMOvoDoENWDXPiMGOgDS2KbqRNYCNy5
 KGQngJZNuDicDBs4r/FGt9/xg2uf8M5lU5b8vC78075c4DWiKgdqaIhqhSC+n+qcHX0bAl1L
 me9DMNm0NtsVw+mk65d7cwxHmYXKEGgzBcbVMa5C+Yevv+0GPkkwccIvps7AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZdEWBwUJ
 DWuNXAAKCRCEf143kM4Jd5OdD/0UXMpMd4eDWvtBBQkoOcz2SqsWwMj+vKPJS0BZ33MV/wXT
 PaTbzAFy23/JXbyBPcb0qgILCmoimBNiXDzYBfcwIoc9ycNwCMBBN47Jxwb8ES5ukFutjS4q
 +tPcjbPYu+hc9qzodl1vjAhaWjgqY6IzDGe4BAmM+L6UUID4Vr46PPN02bpm4UsL31J6X+lA
 Vj5WbY501vKMvTAiF1dg7RkHPX7ZVa0u7BPLjBLqu6NixNkpSRts8L9G4QDpIGVO7sOC9oOU
 2h99VYY1qKml0qJ9SdTwtDj+Yxz+BqW7O4nHLsc4FEIjILjwF71ZKY/dlTWDEwDl5AJR7bhy
 HXomkWae2nBTzmWgIf9fJ2ghuCIjdKKwOFkDbFUkSs8HjrWymvMM22PHLTTGFx+0QbjOstEh
 9i56FZj3DoOEfVKvoyurU86/4sxjIbyhqL6ZiTzuZAmB0RICOIGilm5x03ESkDztiuCtQL2u
 xNT833IQSNqyuEnxG9/M82yYa+9ClBiRKM2JyvgnBEbiWA15rAQkOqZGJfFJ3bmTFePx4R/I
 ZVehUxCRY5IS1FLe16tymf9lCASrPXnkO2+hkHpBCwt75wnccS3DwtIGqwagVVmciCxAFg9E
 WZ4dI5B0IUziKtBxgwJG4xY5rp7WbzywjCeaaKubtcLQ9bSBkkK4U8Fu58g6Hg==
In-Reply-To: <Z6Ef3iwQs7JSFY3c@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.068, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 3.02.2025 20:58, Peter Xu wrote:
> On Mon, Feb 03, 2025 at 02:57:36PM +0100, Maciej S. Szmigiero wrote:
>> On 2.02.2025 13:45, Dr. David Alan Gilbert wrote:
>>> * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
>>>> On 2.02.2025 03:06, Dr. David Alan Gilbert wrote:
>>>>> * Maciej S. Szmigiero (mail@maciej.szmigiero.name) wrote:
>>>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>>>
>>>>>> postcopy_ram_listen_thread() is a free running thread, so it needs to
>>>>>> take BQL around function calls to migration methods requiring BQL.
>>>>>>
>>>>>> qemu_loadvm_state_main() needs BQL held since it ultimately calls
>>>>>> "load_state" SaveVMHandlers.
>>>>>>
>>>>>> migration_incoming_state_destroy() needs BQL held since it ultimately calls
>>>>>> "load_cleanup" SaveVMHandlers.
>>>>>>
>>>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>>>> ---
>>>>>>     migration/savevm.c | 4 ++++
>>>>>>     1 file changed, 4 insertions(+)
>>>>>>
>>>>>> diff --git a/migration/savevm.c b/migration/savevm.c
>>>>>> index b0b74140daea..0ceea9638cc1 100644
>>>>>> --- a/migration/savevm.c
>>>>>> +++ b/migration/savevm.c
>>>>>> @@ -2013,7 +2013,9 @@ static void *postcopy_ram_listen_thread(void *opaque)
>>>>>>          * in qemu_file, and thus we must be blocking now.
>>>>>>          */
>>>>>>         qemu_file_set_blocking(f, true);
>>>>>> +    bql_lock();
>>>>>>         load_res = qemu_loadvm_state_main(f, mis);
>>>>>> +    bql_unlock();
>>>>>
>>>>> Doesn't that leave that held for a heck of a long time?
>>>>
>>>> Yes, and it effectively broke "postcopy recover" test but I
>>>> think the reason for that is qemu_loadvm_state_main() and
>>>> its children don't drop BQL while waiting for I/O.
>>>>
>>>> I've described this case in more detail in my reply to Fabiano here:
>>>> https://lore.kernel.org/qemu-devel/0a09e627-955e-4f26-8d08-0192ecd250a8@maciej.szmigiero.name/
>>>
>>> While it might be the cause in this case, my feeling is it's more fundamental
>>> here - it's the whole reason that postcopy has a separate ram listen
>>> thread.  As the destination is running, after it loads it's devices
>>> and as it starts up the destination will be still loading RAM
>>> (and other postcopiable devices) potentially for quite a while.
>>> Holding the bql around the ram listen thread means that the
>>> execution of the destination won't be able to take that lock
>>> until the postcopy load has finished; so while that might apparently
>>> complete, it'll lead to the destination stalling until that's finished
>>> which defeats the whole point of postcopy.
>>> That last one probably won't fail a test but it will lead to a long stall
>>> if you give it a nice big guest with lots of RAM that it's rapidly
>>> changing.
>>
>> Okay, I understand the postcopy case/flow now.
>> Thanks for explaining it clearly.
>>
>>>> I still think that "load_state" SaveVMHandlers need to be called
>>>> with BQL held since implementations apparently expect it that way:
>>>> for example, I think PCI device configuration restore calls
>>>> address space manipulation methods which abort() if called
>>>> without BQL held.
>>>
>>> However, the only devices that *should* be arriving on the channel
>>> that the postcopy_ram_listen_thread is reading from are those
>>> that are postcopiable (i.e. RAM and hmm block's dirty_bitmap).
>>> Those load handlers are safe to be run while the other devices
>>> are being changed.   Note the *should* - you could add a check
>>> to fail if any other device arrives on that channel.
>>
>> I think ultimately there should be either an explicit check, or,
>> as you suggest in the paragraph below, a separate SaveVMHandler
>> that runs without BQL held.
> 
> To me those are bugs happening during postcopy, so those abort()s in
> memory.c are indeed for catching these issues too.
> 
>> Since the current state of just running these SaveVMHandlers
>> without BQL in this case and hoping that nothing breaks is
>> clearly sub-optimal.
>>
>>>> I have previously even submitted a patch to explicitly document
>>>> "load_state" SaveVMHandler as requiring BQL (which was also
>>>> included in the previous version of this patch set) and it
>>>> received a "Reviewed-by:" tag:
>>>> https://lore.kernel.org/qemu-devel/6976f129df610c8207da4e531c8c0475ec204fa4.1730203967.git.maciej.szmigiero@oracle.com/
>>>> https://lore.kernel.org/qemu-devel/e1949839932efaa531e2fe63ac13324e5787439c.1731773021.git.maciej.szmigiero@oracle.com/
>>>> https://lore.kernel.org/qemu-devel/87o732bti7.fsf@suse.de/
>>>
>>> It happens!
>>> You could make this safer by having a load_state and a load_state_postcopy
>>> member, and only mark the load_state as requiring the lock.
>>
>> To not digress too much from the subject of this patch set
>> (multifd VFIO device state transfer) for now I've just updated the
>> TODO comment around that qemu_loadvm_state_main(), so hopefully this
>> discussion won't get forgotten:
>> https://gitlab.com/maciejsszmigiero/qemu/-/commit/046e3deac5b1dbc406b3e9571f62468bd6743e79
> 
> The commit message may still need some touch ups, e.g.:
> 
>    postcopy_ram_listen_thread() is a free running thread, so it needs to
>    take BQL around function calls to migration methods requiring BQL.
>
>
> This sentence is still not correct, IMHO. As Dave explained, the ram load
> thread is designed to run without BQL at least for the major workloads it
> runs.

So what's your proposed wording of this commit then?

> I don't worry on src sending something that crashes the dest: if that
> happens, that's a bug, we need to fix it..  In that case abort() either in
> memory.c or migration/ would be the same.  

Yeah, but it would be a bug in the source (or just bit stream corruption for
any reason), yet it's the destination which would abort() or crash.

I think cases like that in principle should be handled more gracefully,
like exiting the destination QEMU with an error.
But that's something outside of the scope of this patch set.

> We could add some explicit check
> in migration code, but I don't expect it to catch anything real, at least
> such never happened since postcopy introduced.. so it's roughly 10 years
> without anything like that happens.
> 
> Taking BQL for migration_incoming_state_destroy() looks all safe.  There's
> one qemu_ram_block_writeback() which made me a bit nervous initially, but
> then looks like RAM backends should be almost noop (for shmem and
> hugetlbfs) but except pmem.

That's the only part where taking BQL is actually necessary for the
functionality of this patch set to work properly, so it's fine to leave
that call to qemu_loadvm_state_main() as-is (without BQL) for time being.

> 
> The other alternative is we define load_cleanup() to not rely on BQL (which
> I believe is true before this series?), then take it only when VFIO's path
> needs it.

I think other paths always call load_cleanup() with BQL so it's probably
safer to have consistent semantics here.

> Thanks,
> 

Thanks,
Maciej


