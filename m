Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B38457124D4
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UnZ-0008RA-3A; Fri, 26 May 2023 06:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UnX-0008Qy-F8
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UnU-0007rH-L0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:35:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685097348;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ygp8lW8JFohMIp7DvXeM+5fOzD/q8dMaH1u6oof/Dhw=;
 b=BdLOWoydK0liVW3TmVECvTqOQ4wF5A2C7TPKjaFUoMkgttXULgtUJMCt/JUUt8edOcM2Pu
 8bEUSKzP/IlbHjrhWQuN1d2AqrimKJL1lkkb99knLJoGtyyVBnPHweOvm+wfjRWESWNfUZ
 hBSmabMldRKK6p0FeBYsudDpVr4c9tw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-75-pac9rSGZPvm4x2fS4ywF5g-1; Fri, 26 May 2023 06:35:46 -0400
X-MC-Unique: pac9rSGZPvm4x2fS4ywF5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6382E1C05AAA;
 Fri, 26 May 2023 10:35:46 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EBB8DC154D1;
 Fri, 26 May 2023 10:35:44 +0000 (UTC)
Date: Fri, 26 May 2023 11:35:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/2] meson: Add static glib dependency for
 initrd-stress.img
Message-ID: <ZHCLfsReGU8nOkUE@redhat.com>
References: <20230525212044.30222-1-farosas@suse.de>
 <20230525212044.30222-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230525212044.30222-3-farosas@suse.de>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, May 25, 2023 at 06:20:44PM -0300, Fabiano Rosas wrote:
> We recently moved glib detection code to meson but the static libs
> were left out. Add a specific dependency for stress.c which is linked
> statically.
> 
> $ make V=1 tests/migration/initrd-stress.img
> 
> before:
>  cc -m64 -mcx16 -o tests/migration/stress ... -static -Wl,--start-group
>  /usr/lib64/libglib-2.0.so -Wl,--end-group
>  ...
>  bin/ld: attempted static link of dynamic object `/usr/lib64/libglib-2.0.so'
> 
> after:
>  cc -m64 -mcx16 -o tests/migration/stress ... -static -pthread
>  -Wl,--start-group -lm /usr/lib64/libpcre.a -lglib-2.0 -Wl,--end-group
> 
> Fixes: fc9a809e0d ("build: move glib detection and workarounds to meson")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/migration/meson.build | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/migration/meson.build b/tests/migration/meson.build
> index dd562355a1..ac71f13290 100644
> --- a/tests/migration/meson.build
> +++ b/tests/migration/meson.build
> @@ -1,9 +1,11 @@
>  sysprof = dependency('sysprof-capture-4', required: false)
> +glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
> +                         method: 'pkg-config', static: true)

Since required: false, the result might be "not found", which means
we'll still hit the linker error. I think we need to surround the
'executable()' bit in

  if glib_static.found()
     ...
  endif
  
>  
>  stress = executable(
>    'stress',
>    files('stress.c'),
> -  dependencies: [glib, sysprof],
> +  dependencies: [glib_static, sysprof],
>    link_args: ['-static'],
>    build_by_default: false,
>  )
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


