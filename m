Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEEF722174
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 10:53:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q65xq-0004TE-3k; Mon, 05 Jun 2023 04:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q65xm-0004Se-0U
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:53:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q65xk-0003yj-F6
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 04:53:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685955194;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sD4VKrApZ64AQmfEU+SxJqotDXeKPpXBuTnI+6y3ES8=;
 b=ijeDJ3hFYG9grLYtUPMhXojhQqqGNbRa4HD5TRY3t8qb4C1CiQOWEc4OLMznNJImDRk7sm
 6+O2Lx4vQzcqlyYFJiWdOYN+1SG1pz2IKr3CBcghWBJnjLaHHROjWQbrbNjbFN8SiH9nco
 +BKnFBDycCKW5QSJEw5dVgqSLbW1VAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-5AjhV17YOseb7376Gf2w_Q-1; Mon, 05 Jun 2023 04:53:11 -0400
X-MC-Unique: 5AjhV17YOseb7376Gf2w_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 678BA8032EF;
 Mon,  5 Jun 2023 08:53:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.224])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A2589E72;
 Mon,  5 Jun 2023 08:53:10 +0000 (UTC)
Date: Mon, 5 Jun 2023 09:53:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Message-ID: <ZH2ic6zsehZzRC/u@redhat.com>
References: <20230602163452.521305-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230602163452.521305-1-thuth@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 02, 2023 at 06:34:52PM +0200, Thomas Huth wrote:
> There is no need to disable this useful compiler warning for
> all versions of the SDL. Unfortunately, various versions are
> buggy (beside SDL 2.0.8, the version 2.26.0 and 2.26.1 are
> broken, too, see https://github.com/libsdl-org/SDL/issues/6619 ),
> but we can use a simple compiler check to see whether we need
> the -Wno-undef or not.
> 
> This also enables the printing of the version number with
> good versions of the SDL in the summary of the meson output
> again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Compile test code instead of hard-coding the version number
> 
>  meson.build | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index a61d3e9b06..a4c69616c3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1273,10 +1273,16 @@ if not get_option('sdl').auto() or have_system
>    sdl_image = not_found
>  endif
>  if sdl.found()
> -  # work around 2.0.8 bug
> -  sdl = declare_dependency(compile_args: '-Wno-undef',
> -                           dependencies: sdl,
> -                           version: sdl.version())
> +  # Some versions of SDL have problems with -Wundef
> +  if not cc.compiles('''
> +                     #include <SDL.h>
> +                     #include <SDL_syswm.h>
> +                     int main(int argc, char *argv[]) { return 0; }
> +                     ''', dependencies: sdl, args: '-Wundef')

Don't you need to pass '-Werror' there too, otherwise -Wundef will
merely generate an warning and still succeed.

> +    sdl = declare_dependency(compile_args: '-Wno-undef',
> +                             dependencies: sdl,
> +                             version: sdl.version())
> +  endif
>    sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
>                           method: 'pkg-config')
>  else
> -- 
> 2.31.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


