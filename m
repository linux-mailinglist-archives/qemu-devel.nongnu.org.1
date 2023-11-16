Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4457EE623
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gUR-0005gd-6j; Thu, 16 Nov 2023 12:49:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3gUO-0005gF-Tg
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r3gUN-0000Dl-2N
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 12:49:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700156954;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m1SkVei98m6H3xodn9W/QDpr9B7r0y4wA6iegBDoYzc=;
 b=IouLzulEjKPyl9nOwEC71LAXOddswFks6787oafvLxa4IzKNPlqxRTlD8huOXUcy1asUNK
 1Ewv4xMM1XjyuSA/XF2Ox3dqZY/BsmVS3xQuhj8jQVgp4A9CbsbMhS/nbDPHlGbOKnDBLs
 bJLyhm7PrOdaQDMJSht4YDmNa0CdVs0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-eYbhWakPOR2nJdqZnz7mDA-1; Thu,
 16 Nov 2023 12:49:10 -0500
X-MC-Unique: eYbhWakPOR2nJdqZnz7mDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 657FF3811F39;
 Thu, 16 Nov 2023 17:49:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A6F51C060AE;
 Thu, 16 Nov 2023 17:49:09 +0000 (UTC)
Date: Thu, 16 Nov 2023 17:49:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH] configure: don't try a "native" cross for i386
Message-ID: <ZVZWEhYbF_0MzEFA@redhat.com>
References: <20231116172820.2481604-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116172820.2481604-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 16, 2023 at 05:28:20PM +0000, Alex Bennée wrote:
> As 32 bit x86 become rarer we are starting to run into problems with
> search paths. Although we switched to a Debian container we still
> favour the native CC on a Bookworm host. As a result we have a broken
> cross compile setup which then fails to build with:
> 
>     BUILD   i386-linux-user guest-tests
>   In file included from /usr/include/linux/stat.h:5,
>                    from /usr/include/bits/statx.h:31,
>                    from /usr/include/sys/stat.h:465,
>                    from /home/alex/lsrc/qemu.git/tests/tcg/multiarch/linux/linux-test.c:28:
>   /usr/include/linux/types.h:5:10: fatal error: asm/types.h: No such file or directory
>       5 | #include <asm/types.h>
>         |          ^~~~~~~~~~~~~
>   compilation terminated.
>   make[1]: *** [Makefile:119: linux-test] Error 1
>   make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:50: build-tcg-tests-i386-linux-user] Error 2
> 
> So lets stop trying to be cute and honour cross_prefix_i386 when
> searching locally. We also need to ensure we are using the correct
> prefix if we do end up using the container version. We can also drop
> the extra CFLAGS while we are at it.
> 
> Fixes: 791e6fedc5 (tests/docker: replace fedora-i386 with debian-i686)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/configure b/configure
> index 5e7b76e3a1..2343d629ec 100755
> --- a/configure
> +++ b/configure
> @@ -1190,7 +1190,6 @@ fi
>  : ${cross_cc_cflags_armeb="-mbig-endian"}
>  : ${cross_cc_hexagon="hexagon-unknown-linux-musl-clang"}
>  : ${cross_cc_cflags_hexagon="-mv73 -O2 -static"}
> -: ${cross_cc_cflags_i386="-m32"}
>  : ${cross_cc_cflags_ppc="-m32 -mbig-endian"}
>  : ${cross_cc_cflags_ppc64="-m64 -mbig-endian"}
>  : ${cross_cc_ppc64le="$cross_cc_ppc64"}
> @@ -1308,7 +1307,7 @@ probe_target_compiler() {
>          ;;
>        i386)
>          container_image=debian-i686-cross
> -        container_cross_prefix=
> +        container_cross_prefix=i686-linux-gnu-
>          ;;
>        loongarch64)
>          container_image=debian-loongarch-cross
> @@ -1394,7 +1393,6 @@ probe_target_compiler() {
>    case "$target_arch:$cpu" in
>      aarch64_be:aarch64 | \
>      armeb:arm | \
> -    i386:x86_64 | \
>      mips*:mips64 | \
>      ppc*:ppc64 | \
>      sparc:sparc64 | \

I kinda wonder if we have people using the rest of this arch compat
stuff too ? With debian making it easy to parallel install the full
cross-arch toolchains + matching libraries, it shouldn't be needed in
general for any arch ?  Getting rid of QEMU specific special cases
like this in configure would be nice.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


