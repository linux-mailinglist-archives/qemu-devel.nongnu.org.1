Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 044DD73D9B4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:29:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhaq-0000t6-Ra; Mon, 26 Jun 2023 04:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDhao-0000sq-HD
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:29:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qDhai-00045A-3V
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:29:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687768134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=S7ETPVPhujVOJqH0RDKl/Q6XYGC3lUCNPs+88ENb7L0=;
 b=GigHFf6h5YmczKxq+y3q8apYoPEDTLUmYHZ+TUFi3TUF0fHYTiWcAyKRiQj3QfkAM3FY6m
 nO5GcpnHgLJsEDSBgPmv89PYsDAuinkgAT5ir1PWc05X1JldKADHcJRFTWmSf/x6uuhnx6
 dXDmrHc0xQ0TDtjpfZTbPrm8076PBSU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-VQPL1D_QPeCn8f1V_WWr7w-1; Mon, 26 Jun 2023 04:28:52 -0400
X-MC-Unique: VQPL1D_QPeCn8f1V_WWr7w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BB703855567;
 Mon, 26 Jun 2023 08:28:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70F0F200B677;
 Mon, 26 Jun 2023 08:28:51 +0000 (UTC)
Date: Mon, 26 Jun 2023 09:28:49 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: RFC: bsd-user broken a while ago, is this the right fix?
Message-ID: <ZJlMQQP7Y8r6Wrd7@redhat.com>
References: <CANCZdfrHEQ=dMfpKGvYBHbXMfbQb9fDQh+bkdZW0Z6zQWVVUCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfrHEQ=dMfpKGvYBHbXMfbQb9fDQh+bkdZW0Z6zQWVVUCA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Just CC'ing Richard to make sure it catches his attention.

On Sat, Jun 24, 2023 at 12:40:33AM -0600, Warner Losh wrote:
> This change:
> 
> commit f00506aeca2f6d92318967693f8da8c713c163f3
> Merge: d37158bb242 87e303de70f
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Wed Mar 29 11:19:19 2023 +0100
> 
>     Merge tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu into
> staging
> 
>     Use a local version of GTree [#285]
>     Fix page_set_flags vs the last page of the address space [#1528]
>     Re-enable gdbstub breakpoints under KVM
> 
>     # -----BEGIN PGP SIGNATURE-----
>     #
>     # iQFRBAABCgA7FiEEekgeeIaLTbaoWgXAZN846K9+IV8FAmQjcLIdHHJpY2hhcmQu
>     # aGVuZGVyc29uQGxpbmFyby5vcmcACgkQZN846K9+IV8rkgf/ZazodovRKxfaO622
>     # mGW7ywIm+hIZYmKC7ObiMKFrBoCyeXH9yOLSx42T70QstWvBMukjovLMz1+Ttbo1
>     # VOvpGH2B5W76l3i+muAlKxFRbBH2kMLTaL+BXtkmkL4FJ9bS8WiPApsL3lEX/q2E
>     # 3kqaT3N3C09sWO5oVAPGTUHL0EutKhOar2VZL0+PVPFzL3BNPhnQH9QcbNvDBV3n
>     # cx3GSXZyL7Plyi+qwsKf/3Jo+F2wr2NVf3Dqscu9T1N1kI5hSjRpwqUEJzJZ5rei
>     # ly/gBXC/J7+WN+x+w2JlN0kWXWqC0QbDfZnj96Pd3owWZ7j4sT9zR5fcNenecxlR
>     # 38Bo0w==
>     # =ysF7
>     # -----END PGP SIGNATURE-----
>     # gpg: Signature made Tue 28 Mar 2023 23:56:50 BST
>     # gpg:                using RSA key
> 7A481E78868B4DB6A85A05C064DF38E8AF7E215F
>     # gpg:                issuer "richard.henderson@linaro.org"
>     # gpg: Good signature from "Richard Henderson <
> richard.henderson@linaro.org>" [full]
>     # Primary key fingerprint: 7A48 1E78 868B 4DB6 A85A  05C0 64DF 38E8
> AF7E 215F
> 
>     * tag 'pull-tcg-20230328' of https://gitlab.com/rth7680/qemu:
>       softmmu: Restore use of CPU watchpoint for all accelerators
>       softmmu/watchpoint: Add missing 'qemu/error-report.h' include
>       softmmu: Restrict cpu_check_watchpoint / address_matches to TCG accel
>       linux-user/arm: Take more care allocating commpage
>       include/exec: Change reserved_va semantics to last byte
>       linux-user: Pass last not end to probe_guest_base
>       accel/tcg: Pass last not end to tb_invalidate_phys_range
>       accel/tcg: Pass last not end to tb_invalidate_phys_page_range__locked
>       accel/tcg: Pass last not end to page_collection_lock
>       accel/tcg: Pass last not end to PAGE_FOR_EACH_TB
>       accel/tcg: Pass last not end to page_reset_target_data
>       accel/tcg: Pass last not end to page_set_flags
>       linux-user: Diagnose misaligned -R size
>       tcg: use QTree instead of GTree
>       util: import GTree as QTree
> 
>     Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> breaks bsd-user. when I merge it to the bsd-user upstream blitz branch I
> get memory allocation errors on startup. At least for armv7.
> 
> specifically, if I back out the bsd-user part of both
> commit 95059f9c313a7fbd7f22e4cdc1977c0393addc7b
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Mar 6 01:26:29 2023 +0300
> 
>     include/exec: Change reserved_va semantics to last byte
> 
>     Change the semantics to be the last byte of the guest va, rather
>     than the following byte.  This avoids some overflow conditions.
> 
>     Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> and
> 
> commit 49840a4a098149067789255bca6894645f411036
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Mar 6 01:51:09 2023 +0300
> 
>     accel/tcg: Pass last not end to page_set_flags
> 
>     Pass the address of the last byte to be changed, rather than
>     the first address past the last byte.  This avoids overflow
>     when the last page of the address space is involved.
> 
>     Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1528
>     Reviewed-by: Philippe Mathieu-Daud<C3><A9> <philmd@linaro.org>
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> things work again. If I backout parts, it fails still. If I back out only
> one of
> the two, but not both, then it fails.
> 
> What's happening is that we're picking a reserved_va that's overflowing when
> we add 1 to it. this overflow goes away if I make the overflows not
> possible:
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index a88251f8705..bd86c0a8689 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -237,8 +237,8 @@ unsigned long last_brk;
>  static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
>                                          abi_ulong alignment)
>  {
> -    abi_ulong addr;
> -    abi_ulong end_addr;
> +    uint64_t addr;
> +    uint64_t end_addr;
>      int prot;
>      int looped = 0;
> 
> My question is, is this the right fix? The old code avoided the overflow in
> two ways. 1 it set reserve_va to a page short (which if I fix that, it
> works better, but not quite right). and it never computes an address that
> may overflow (which the new code does without the above patch).
> 
> It seems to work, but it looks super weird.
> 
> Comments?
> 
> Warrner

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


