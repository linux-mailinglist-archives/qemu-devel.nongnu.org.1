Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 233B374DD1C
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 20:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIvMF-0004PI-3D; Mon, 10 Jul 2023 14:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qIvMA-0004Ov-3K
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:11:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qIvM7-0006WA-CN
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 14:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689012685;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAjBzspD/Pu4o0rK84lvrCZ6W7zyAgzOxZhYKkm+pow=;
 b=ab7rkiMrdcsFlWK/0+DWfL9ifH/tpMjNHBoPPZUt7ptk7EVB914MSJJjwS97kr3xIk/3ME
 0XGvjpQtnKIu9dqPvpT6ANEwwuMMRjBx1A5zG5bsJ3TdrM6s9zNi4VrlZIZvhY1YwlqU/A
 UFJErv6Q/7CRG9pt8Bwcs/gUBtYp34E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-221-r180vhUCNRyNMU63rP8esg-1; Mon, 10 Jul 2023 14:11:22 -0400
X-MC-Unique: r180vhUCNRyNMU63rP8esg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EACC71C28CE5;
 Mon, 10 Jul 2023 18:11:21 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10243200A7CA;
 Mon, 10 Jul 2023 18:11:20 +0000 (UTC)
Date: Mon, 10 Jul 2023 19:11:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH] tests/migration: Restrict initrd-stress.img to Linux
Message-ID: <ZKxJxkw/zUkgrlr8@redhat.com>
References: <20230710175607.32818-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710175607.32818-1-philmd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 10, 2023 at 07:56:07PM +0200, Philippe Mathieu-Daudé wrote:
> Trying to build initrd-stress.img on Darwin we get:
> 
>   $ ninja tests/migration/initrd-stress.img
>   Compiling C object tests/migration/stress.p/stress.c.o
>   FAILED: tests/migration/stress.p/stress.c.o
>   ../tests/migration/stress.c:24:10: fatal error: 'linux/random.h' file not found
>   #include <linux/random.h>
>            ^~~~~~~~~~~~~~~~

I think that's historical accident, as AFAICT, nothing in stress.c
needs that include to be present.

>   1 error generated.
>   ninja: build stopped: subcommand failed.
> 
> Per the include path, this test is Linux specific.
> Since this is the single binary built in this directory,
> restrict the whole meson.build to Linux.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/migration/meson.build | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/migration/meson.build b/tests/migration/meson.build
> index ac71f13290..56523e0785 100644
> --- a/tests/migration/meson.build
> +++ b/tests/migration/meson.build
> @@ -1,3 +1,7 @@
> +if targetos != 'linux'
> +   subdir_done()
> +endif
> +
>  sysprof = dependency('sysprof-capture-4', required: false)
>  glib_static = dependency('glib-2.0', version: glib_req_ver, required: false,
>                           method: 'pkg-config', static: true)
> -- 
> 2.38.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


