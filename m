Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B1769B4B
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 17:52:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQVB2-0002HR-E7; Mon, 31 Jul 2023 11:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQVAt-0002GT-57
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:51:13 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQVAp-0001NK-K8
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 11:51:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690818665; x=1691423465; i=deller@gmx.de;
 bh=XnCSHGJESBqxxbcwLhXYt3t+aHuBt6upEJFETbIscaE=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=OR77PJj7vlV4nrukonkS5MH+vtnBF2Wa1xqouNv+sbEL6SxXsQgcaZFYHRACS5VmaIyElW1
 /3KWo4ZO2KGYaj6BgYuug8ClG8EZmLYNYQ25PNYLlMezz+Ts46wgQmnN3mm5p3wVhcfcBJjvr
 FYq3e4qkMBrC6VZ0c7jh3oR7va1OIjZGieZUqgYtmTvtIGhKyoVUi31V1J6/4SQbkyEaaZGMn
 PKzQ4kZIJdRgDJeV9YQbjzeTpIeaq9h+/Sys+CMSkf0PdoFvIfdpkJHuDcRLrzYoO2AFzpoML
 jrzMaLV8xCxj2WokkwhvsvxKlKderYGa2qAsTEE6BH0UG5PIBy7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.159.238]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1pnoLl0CNw-017UuR; Mon, 31
 Jul 2023 17:51:05 +0200
Message-ID: <7b55e607-45f9-a574-fb00-b65508e57b10@gmx.de>
Date: Mon, 31 Jul 2023 17:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] linux-user: Do not align brk with host page size
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
 <20230731080317.112658-6-akihiko.odaki@daynix.com>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20230731080317.112658-6-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qGZUE9rVKOsHcotlC87zpHkjlei+7AcGYUDpEIJ7bu+W9yU+A/I
 P1BQN/aJCadNKCA1mxCTwlU3msiF7yc9Nezy8uXwKfMHj8K3VMWtNfSrvj2LqPlqxdCG7yu
 /T/silLXS3efSnhqOrzLAUgwaZiNA5FDpx4YUqnh8r9JPnA2sle7ppeUtfxfLwCcEGrpJ0i
 ewvA1Wf5Wo6qZ+YFSl4IQ==
UI-OutboundReport: notjunk:1;M01:P0:/dewN4zENV4=;8A9Ndw5xGX5xI4nmMK64TnlNAL6
 fhvrbxhClpAi6R6Ypjh55g5Ev9lonIB+FA7fvAaNT9HxiNUJ85mpBsdRHAfy1XiPEu4aa259i
 lV7USJFyILnH3gpMTLinyOuYU0E3D2hvipHdPyH5SXjXxvedaE/zs7wHhS2I9mVz4WwNIUdty
 HgMHeGxICZ+POV4lnSVasnWdb9GFFI84PcpdW8yriX7E6oiO8fctbqYeBWtmrw8lGEEwJBtvJ
 q10nNGCp2uU0gq0Y7pdzGU+imE9zYwZWm+cCRwFLBwLVEdKmg5q4dZDYkB/CsUuKrhhlj8lNU
 cYpSEObdSU5+vuJHqKVz/jd2vaFR9anN17N7T5nHrWYY5E5LQy9bDJw6bpFBkRqLevx4Pw8S4
 bbdnJgevyPfqI5XW6r85FhEFqg92Lm6coiWAthM7+gx/EDvWu/k+2N/B5u5tlgC8aeDEOYGpv
 aXAJ7Q7jIIq5dUhwM+8UR49f6aooehwxs8syS4HcdAwGBbD7yxqsyMxSD3zoB2wDLwZ7L8DDd
 zSA9KwIpnGfVWDacVeyKGZ5jWOZxL7ct7D7SYCdLQpBySZ0COHrjhbIsVnSSbLIv2YKDwhAva
 kIZuXyqYT4EG0mHwC9G0BI472R0N2rsH+7g2J4R6MmPrwT5NkQ5GWuvD2Lltrgm1TUgCPhsrt
 oAJUkhx+vRh5zXAJR+MKyr2g+0c4va4yDwHkVB5avSQFrFCCJS7VsCyQwKV4U9iLfYWfJTiO5
 NegCjNDYuiZ1zZ4hefWj9U1ISoyPreAgIlpmV7m9zBB5FdsuseuTwFRlyMlUlN+GFYIO365TO
 POkp2OgH28ZLR5AaWkJIrE/Khw7liS2APhu+LTdtmOTY0NhmVsPDyw2+hD1neQZefn+9N68x/
 jq72F0wlg99PK32jWjX5P9w5HB/NY++8JCvs2xGVRT3rb7SNphuhgZJdhOHRMzfvE/rX/+JSf
 OX6Z/eDGvSDn4ieMkgJbV8T4Dxo=
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/31/23 10:03, Akihiko Odaki wrote:
> do_brk() minimizes calls into target_mmap() by aligning the address
> with host page size, which is potentially larger than the target page
> size.

Keep in mind, that host page size can be smaller than target page size too=
.
That's the reason why host brk (brk_page) and target brk (target_brk)
needs to be tracked individually.
So, it's not an optimization, but required.
Btw, I think we have been there before with the idea of
just keeping track of host pages...

> However, the current implementation of this optimization has two
> bugs:
>
> - The start of brk is rounded up with the host page size while brk
>    advertises an address aligned with the target page size as the
>    beginning of brk. This makes the beginning of brk unmapped.
> - Content clearing after mapping is flawed. The size to clear is
>    specified as HOST_PAGE_ALIGN(brk_page) - brk_page, but brk_page is
>    aligned with the host page size so it is always zero.
>
> This optimization actually has no practical benefit. It makes difference
> when brk() is called multiple times with values in a range of the host
> page size. However, sophisticated memory allocators try to avoid to
> make such frequent brk() calls. For example, glibc 2.37 calls brk() to
> shrink the heap only when there is a room more than 128 KiB. It is
> rare to have a page size larger than 128 KiB if it happens.
>
> Let's remove the optimization to fix the bugs and make the code simpler.
>
> Fixes: 86f04735ac ("linux-user: Fix brk() to release pages")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1616
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   linux-user/elfload.c |  4 ++--
>   linux-user/syscall.c | 54 ++++++++++----------------------------------
>   2 files changed, 14 insertions(+), 44 deletions(-)
>
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 861ec07abc..2aee2298ec 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3678,8 +3678,8 @@ int load_elf_binary(struct linux_binprm *bprm, str=
uct image_info *info)
>        * to mmap pages in this space.
>        */
>       if (info->reserve_brk) {
> -        abi_ulong start_brk =3D HOST_PAGE_ALIGN(info->brk);
> -        abi_ulong end_brk =3D HOST_PAGE_ALIGN(info->brk + info->reserve=
_brk);
> +        abi_ulong start_brk =3D TARGET_PAGE_ALIGN(info->brk);
> +        abi_ulong end_brk =3D TARGET_PAGE_ALIGN(info->brk + info->reser=
ve_brk);

In my patchset I removed the reserve_brk stuff...

>           target_munmap(start_brk, end_brk - start_brk);
>       }
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ebdc8c144c..475260b7ce 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -802,81 +802,51 @@ static inline int host_to_target_sock_type(int hos=
t_type)
>   }
>
>   static abi_ulong target_brk, initial_target_brk;
> -static abi_ulong brk_page;

with that you loose the ability to track the brk address on host.


>   void target_set_brk(abi_ulong new_brk)
>   {
>       target_brk =3D TARGET_PAGE_ALIGN(new_brk);
>       initial_target_brk =3D target_brk;
> -    brk_page =3D HOST_PAGE_ALIGN(target_brk);
>   }
>
>   /* do_brk() must return target values and target errnos. */
>   abi_long do_brk(abi_ulong brk_val)
>   {
>       abi_long mapped_addr;
> -    abi_ulong new_alloc_size;
> -    abi_ulong new_brk, new_host_brk_page;
> +    abi_ulong new_brk;
> +    abi_ulong old_brk;
>
>       /* brk pointers are always untagged */
>
> -    /* return old brk value if brk_val unchanged */
> -    if (brk_val =3D=3D target_brk) {
> -        return target_brk;
> -    }
> -
>       /* do not allow to shrink below initial brk value */
>       if (brk_val < initial_target_brk) {
>           return target_brk;
>       }
>
>       new_brk =3D TARGET_PAGE_ALIGN(brk_val);
> -    new_host_brk_page =3D HOST_PAGE_ALIGN(brk_val);
> +    old_brk =3D TARGET_PAGE_ALIGN(target_brk);
>
> -    /* brk_val and old target_brk might be on the same page */
> -    if (new_brk =3D=3D TARGET_PAGE_ALIGN(target_brk)) {
> -        /* empty remaining bytes in (possibly larger) host page */
> -        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);

you can't drop that.
guest could have clobbered the upper parts, e.g. when it first mapped
all (e.g. 8k), wrote to it, then released upper half of the host page (4k)=
 and
then remaps the upper 4k again.
In that case we need to ensure that the upper 4k gets cleaned. On a physic=
al
machine the kernel would have requested a new page, but here we are stuck
with the bigger host page which we can't simply release.

Helge

> +    /* new and old target_brk might be on the same page */
> +    if (new_brk =3D=3D old_brk) {
>           target_brk =3D brk_val;
>           return target_brk;
>       }
>
>       /* Release heap if necesary */
> -    if (new_brk < target_brk) {
> -        /* empty remaining bytes in (possibly larger) host page */
> -        memset(g2h_untagged(new_brk), 0, new_host_brk_page - new_brk);
> -
> -        /* free unused host pages and set new brk_page */
> -        target_munmap(new_host_brk_page, brk_page - new_host_brk_page);
> -        brk_page =3D new_host_brk_page;
> +    if (new_brk < old_brk) {
> +        target_munmap(new_brk, old_brk - new_brk);
>
>           target_brk =3D brk_val;
>           return target_brk;
>       }
>
> -    if (new_host_brk_page > brk_page) {
> -        new_alloc_size =3D new_host_brk_page - brk_page;
> -        mapped_addr =3D target_mmap(brk_page, new_alloc_size,
> -                                  PROT_READ | PROT_WRITE,
> -                                  MAP_FIXED_NOREPLACE | MAP_ANON | MAP_=
PRIVATE,
> -                                  0, 0);
> -    } else {
> -        new_alloc_size =3D 0;
> -        mapped_addr =3D brk_page;
> -    }
> -
> -    if (mapped_addr =3D=3D brk_page) {
> -        /* Heap contents are initialized to zero, as for anonymous
> -         * mapped pages.  Technically the new pages are already
> -         * initialized to zero since they *are* anonymous mapped
> -         * pages, however we have to take care with the contents that
> -         * come from the remaining part of the previous page: it may
> -         * contains garbage data due to a previous heap usage (grown
> -         * then shrunken).  */
> -        memset(g2h_untagged(brk_page), 0, HOST_PAGE_ALIGN(brk_page) - b=
rk_page);
> +    mapped_addr =3D target_mmap(old_brk, new_brk - old_brk,
> +                              PROT_READ | PROT_WRITE,
> +                              MAP_FIXED_NOREPLACE | MAP_ANON | MAP_PRIV=
ATE,
> +                              0, 0);
>
> +    if (mapped_addr =3D=3D old_brk) {
>           target_brk =3D brk_val;
> -        brk_page =3D new_host_brk_page;
>           return target_brk;
>       }
>


