Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD34970D683
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:01:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MxJ-0004nk-7z; Tue, 23 May 2023 04:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1MxG-0004ji-M5
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:01:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1MxE-0001AC-NC
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:01:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684828871;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=BIB5rKV2YyXJQaMY8AsL4h4OAEln7o6vIZCuxYgaxxA=;
 b=XZ7rMPwM/3Vk6QDV4E3X1ZqGUNSWjuPPUcVGok/q3BegitpFP3xI1iIRmAO9QWA0WPxvyk
 rNPbzwhBk6j9ERVwxzAt0v5atAKSrihxG6lrv6JkgYgfvEBC8y7mJgcMRGgxhMXRf2Ojwb
 KpjizvIOe9ubte4yEOqfwc76wwJTbTc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-lidiXEX-NGS5WxPLOrJ48g-1; Tue, 23 May 2023 04:00:53 -0400
X-MC-Unique: lidiXEX-NGS5WxPLOrJ48g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B4E5811E8E;
 Tue, 23 May 2023 08:00:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CAB49D73;
 Tue, 23 May 2023 08:00:52 +0000 (UTC)
Date: Tue, 23 May 2023 09:00:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, vr_qemu@t-online.de, marcandre.lureau@redhat.com
Subject: Re: [PATCH] meson: remove -no-pie linker flag
Message-ID: <ZGxysnpYm8FtL0VM@redhat.com>
References: <20230522080816.66320-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522080816.66320-1-pbonzini@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 22, 2023 at 10:08:16AM +0200, Paolo Bonzini wrote:
> The large comment in the patch says it all; the -no-pie flag is broken and
> this is why it was not included in QEMU_LDFLAGS before commit a988b4c5614
> ("build: move remaining compiler flag tests to meson", 2023-05-18).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1664
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 0a5cdefd4d3d..6733b2917081 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -267,10 +267,15 @@ endif
>  # has explicitly disabled PIE we need to extend our cflags.
>  if not get_option('b_pie')
>    qemu_common_flags += cc.get_supported_arguments('-fno-pie')
> -  if not get_option('prefer_static')
> -    # No PIE is implied by -static which we added above.
> -    qemu_ldflags += cc.get_supported_link_arguments('-no-pie')
> -  endif
> +  # What about linker flags?  For a static build, no PIE is implied by -static
> +  # which we added above.  For dynamic linking, adding -no-pie is messy because
> +  # it overrides -shared: the linker then wants to build an executable instead
> +  # of a shared library and the build fails.  Before moving this code to Meson,
> +  # we went through a dozen different commits affecting the usage of -no-pie,
> +  # ultimately settling for a completely broken one that added -no-pie to the
> +  # compiler flags together with -fno-pie... except that -no-pie is a linker
> +  # flag that has no effect on the compiler command line.  So, don't add
> +  # -no-pie anywhere and cross fingers.
>  endif

I'm curious why we need to do anything ?  I would have thought that meson
should handle 'b_pie' itself, passing the right args to $CC that it feels
are appropriate. I don't recall seeing other apps using meson trying to
handle b_pie logic - what's special about QEMU ? IOW, is it possible to
delete this entire b_pie condition and thus avoid worrying about this
problem ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


