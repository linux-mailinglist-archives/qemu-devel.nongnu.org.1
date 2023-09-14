Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7CE79FE20
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 10:19:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qghYL-0000Ne-14; Thu, 14 Sep 2023 04:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qghYH-0000NP-HR
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qghYD-0000yI-I9
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 04:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694679492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=KHZkvMYQUVYiftqEwDriFaOumZdYBnbGU8+Fb6CiNeA=;
 b=OrbcZVXV3eKNqhMtBYzbe+OrIKV2/0Y5/rUY7jjU4uYwxkhJqHGFPu6DaxTxyXS73MAHsu
 2sCKVG7bSbzm6XOX60xFEQtyqVMxOAxKHgm3Ksac75wvTCUnAI3g/nEIk3QuJ/ylf2dF8e
 DykV+vVztZRxyn2aBG1NON+6j12PA7I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-599-7-mSPFGfOg-Pc3ck9gsVwg-1; Thu, 14 Sep 2023 04:18:08 -0400
X-MC-Unique: 7-mSPFGfOg-Pc3ck9gsVwg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A921856501;
 Thu, 14 Sep 2023 08:18:08 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BDD0410F1BE8;
 Thu, 14 Sep 2023 08:18:07 +0000 (UTC)
Date: Thu, 14 Sep 2023 09:18:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/3] linux-user/syscall.c: do_ppoll: eliminate large
 alloca
Message-ID: <ZQLBvThMJK7LzoOw@redhat.com>
References: <20230914074337.149897-1-mjt@tls.msk.ru>
 <20230914074337.149897-4-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914074337.149897-4-mjt@tls.msk.ru>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 14, 2023 at 10:43:37AM +0300, Michael Tokarev wrote:
> do_ppoll() in linux-user/syscall.c uses alloca() to allocate
> an array of struct pullfds on the stack.  The only upper
> boundary for number of entries for this array is so that
> whole thing fits in INT_MAX.  This is definitely too much
> for stack allocation.
> 
> Use heap allocation when large number of entries is requested
> (currently 32, arbitrary), and continue to use alloca() for

Typo ? The code uses 64 rather than 32.

> smaller allocations, to optimize small operations for small
> sizes.  The code for this optimization is small, I see no
> reason for dropping it.
> 
> This eliminates last large user-controlled on-stack allocation
> from syscall.c.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  linux-user/syscall.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index eabdf50abc..1dbe28eba4 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1489,7 +1489,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>  {
>      struct target_pollfd *target_pfd = NULL;
>      unsigned int nfds = arg2;
> -    struct pollfd *pfd = NULL;
> +    struct pollfd *pfd = NULL, *heap_pfd = NULL;

g_autofree struct pollfd *heap_pdf = NULL;

>      unsigned int i;
>      abi_long ret;
>  
> @@ -1503,7 +1503,17 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>              return -TARGET_EFAULT;
>          }
>  
> -        pfd = alloca(sizeof(struct pollfd) * nfds);
> +        /* arbitrary "small" number to limit stack usage */
> +        if (nfds <= 64) {
> +            pfd = alloca(sizeof(struct pollfd) * nfds);
> +        } else {
> +            heap_pfd = g_try_new(struct pollfd, nfds);
> +            if (!heap_pfd) {
> +                ret = -TARGET_ENOMEM;
> +                goto out;
> +            }
> +            pfd = heap_pfd;
> +        }
>          for (i = 0; i < nfds; i++) {
>              pfd[i].fd = tswap32(target_pfd[i].fd);
>              pfd[i].events = tswap16(target_pfd[i].events);
> @@ -1567,6 +1577,7 @@ static abi_long do_ppoll(abi_long arg1, abi_long arg2, abi_long arg3,
>      }
>  
>  out:
> +    g_free(heap_pfd);

This can be dropped with g_autofree usage

>      unlock_user(target_pfd, arg1, sizeof(struct target_pollfd) * nfds);
>      return ret;
>  }
> -- 
> 2.39.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


