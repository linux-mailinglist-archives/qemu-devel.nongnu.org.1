Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2A673A327
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:35:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLPK-0005CF-HV; Thu, 22 Jun 2023 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCLPH-0005BC-SZ
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:35:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qCLPF-0007rN-RH
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687444528;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dOBWiRTBZTY6HxGnhjCREOnLt71n1yYIHZ+SNPfpkIY=;
 b=Lglx1H4kY2Knfq2HXyMv7lNLYe+FtD8l8sQzjjQqj+ci3HoP4AWtDXU3nMEW+z50ECfXXR
 kUAs0Snx7Oxtq+eVAx+Rb44s3qnAhNqekn6guF3hQr0p1sxNpbyIh5dvEvVzocQ5DOsA5l
 zrfqtOQxfpiVkYupoipSk39F3+XiotU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-299-ixVKytbIM0GDHQwyYbOBNw-1; Thu, 22 Jun 2023 10:35:16 -0400
X-MC-Unique: ixVKytbIM0GDHQwyYbOBNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DC9410504AC;
 Thu, 22 Jun 2023 14:34:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11971207B2BC;
 Thu, 22 Jun 2023 14:34:58 +0000 (UTC)
Date: Thu, 22 Jun 2023 15:34:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] host-utils: Avoid using __builtin_subcll on buggy
 versions of Apple Clang
Message-ID: <ZJRcEUPZy2ntkjJN@redhat.com>
References: <20230622130823.1631719-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230622130823.1631719-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 02:08:23PM +0100, Peter Maydell wrote:
> We use __builtin_subcll() to do a 64-bit subtract with borrow-in and
> borrow-out when the host compiler supports it.  Unfortunately some
> versions of Apple Clang have a bug in their implementation of this
> intrinsic which means it returns the wrong value.  The effect is that
> a QEMU built with the affected compiler will hang when emulating x86
> float80 division.
> 
> The upstream LLVM issue is:
> https://github.com/llvm/llvm-project/issues/55253
> 
> The commit that introduced the bug apparently never made it into an
> upstream LLVM release without the subsequent fix
> https://github.com/llvm/llvm-project/commit/fffb6e6afdbaba563189c1f715058ed401fbc88d
> but unfortunately it did make it into Apple Clang 14.0, as shipped
> in Xcode 14.3 (14.2 is reported to be OK). The Apple bug number is
> FB12210478.
> 
> Add ifdefs to avoid use of __builtin_subcll() on Apple Clang version
> 14 or greater.  There is not currently a version of Apple Clang which
> has the bug fix -- when one appears we should be able to add an upper
> bound to the ifdef condition so we can start using the builtin again.
> We make the lower bound a conservative "any Apple clang with major
> version 14 or greater" because the consequences of incorrectly
> disabling the builtin when it would work are pretty small and the
> consequences of not disabling it when we should are pretty bad.
> 
> Many thanks to those users who both reported this bug and also
> did a lot of work in identifying the root cause; in particular
> to Daniel Bertalan and osy.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1631
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1659
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't have a setup to test this, so this needs testing by the
> people who've encountered this compiler bug to confirm it does
> the right thing...
> ---
>  include/qemu/compiler.h   | 13 +++++++++++++
>  include/qemu/host-utils.h |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index c2f49df1f91..a309f90c768 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -184,4 +184,17 @@
>  #define QEMU_DISABLE_CFI
>  #endif
>  
> +/*
> + * Apple clang version 14 has a bug in its __builtin_subcll(); define
> + * BUILTIN_SUBCLL_BROKEN for the offending versions so we can avoid it.
> + * When a version of Apple clang which has this bug fixed is released
> + * we can add an upper bound to this check.
> + * See https://gitlab.com/qemu-project/qemu/-/issues/1631
> + * and https://gitlab.com/qemu-project/qemu/-/issues/1659 for details.
> + * The bug never made it into any upstream LLVM releases, only Apple ones.

Perhaps add a reminder:

 * TODO: put a max cap on __clang_major__/__clang_minor once
 * Apple have released a version with the fix

> + */
> +#if defined(__apple_build_version__) && __clang_major__ >= 14
> +#define BUILTIN_SUBCLL_BROKEN
> +#endif

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


