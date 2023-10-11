Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E787C4DAE
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 10:52:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqUwC-0006yu-3y; Wed, 11 Oct 2023 04:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqUwA-0006yk-Iu
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 04:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qqUw8-0006KT-MD
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 04:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697014284;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7iuSnJxYVa1cGtJXdZql/BMmNgLBTmM1FZB/apojDW4=;
 b=Dizb64AweGSZZftlo0iDqZiBDYbq7XQgT5o07ky3TOne8PNdQ+nDRgJj1oX9tfnQ5M2wm0
 BW4mvI5R7DD/HIgXR461k5+XG6ka9AkxBEirwb2gzBVq4ZGEtvBYp2WTT3xGcLoGqdODV7
 03wPLQmvNnfGUeKCKypQUvyMIwTEuII=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-gRtt5SGbP0K4t3flUYajsQ-1; Wed, 11 Oct 2023 04:51:19 -0400
X-MC-Unique: gRtt5SGbP0K4t3flUYajsQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBF49101AA6D;
 Wed, 11 Oct 2023 08:51:18 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D13D111CD23;
 Wed, 11 Oct 2023 08:51:15 +0000 (UTC)
Date: Wed, 11 Oct 2023 09:51:12 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v9 23/23] plugins: Support C++
Message-ID: <ZSZiAHtXGOZnZNas@redhat.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
 <20231011070335.14398-24-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011070335.14398-24-akihiko.odaki@daynix.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 11, 2023 at 04:03:09PM +0900, Akihiko Odaki wrote:
> Make qemu-plugin.h consumable for C++ platform.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  docs/devel/tcg-plugins.rst |  4 ++++
>  meson.build                |  2 +-
>  include/qemu/qemu-plugin.h |  4 ++++
>  tests/plugin/cc.cc         | 16 ++++++++++++++++
>  tests/plugin/meson.build   |  5 +++++
>  tests/tcg/Makefile.target  |  3 +--
>  6 files changed, 31 insertions(+), 3 deletions(-)
>  create mode 100644 tests/plugin/cc.cc
> 
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index c9f8b27590..984d8012e9 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -283,6 +283,10 @@ run::
>    160          1      0
>    135          1      0
>  
> +- contrib/plugins/cc.cc
> +
> +A pure test plugin to ensure that the plugin API is compatible with C++.
> +

IMHO we don't need to be adding a test just to prove the
existance of the G_BEGIN_DECLS/G_END_DECLS macros in the
plugin header.

>  - contrib/plugins/hotblocks.c
>  
>  The hotblocks plugin allows you to examine the where hot paths of
> diff --git a/meson.build b/meson.build
> index 9f4c4f2f1e..c289bb8948 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -20,7 +20,7 @@ config_host = keyval.load(meson.current_build_dir() / 'config-host.mak')
>  
>  cc = meson.get_compiler('c')
>  all_languages = ['c']
> -if targetos == 'windows' and add_languages('cpp', required: false, native: false)
> +if add_languages('cpp', required: false, native: false)
>    all_languages += ['cpp']
>    cxx = meson.get_compiler('cpp')
>  endif

Our goal has been to entirely eliminate C++ from our build system,
even the Windows piece will ideally go away eventually. So I'm
loathe to see us expand where we use C++ again, even if only for
a unit test.

> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 40aae8db68..55f514ca6c 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -16,6 +16,8 @@
>  #include <stdbool.h>
>  #include <stddef.h>
>  
> +G_BEGIN_DECLS
> +
>  /*
>   * For best performance, build the plugin with -fvisibility=hidden so that
>   * QEMU_PLUGIN_LOCAL is implicit. Then, just mark qemu_plugin_install with
> @@ -710,4 +712,6 @@ int qemu_plugin_find_register(unsigned int vcpu_index, int file,
>   */
>  int qemu_plugin_read_register(GByteArray *buf, int reg);
>  
> +G_END_DECLS
> +
>  #endif /* QEMU_QEMU_PLUGIN_H */
> diff --git a/tests/plugin/cc.cc b/tests/plugin/cc.cc
> new file mode 100644
> index 0000000000..297a7e4f3f
> --- /dev/null
> +++ b/tests/plugin/cc.cc
> @@ -0,0 +1,16 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <qemu-plugin.h>
> +
> +extern "C" {
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
> +
> +QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
> +                                           const qemu_info_t *info, int argc,
> +                                           char **argv)
> +{
> +    return 0;
> +}
> +
> +};
> diff --git a/tests/plugin/meson.build b/tests/plugin/meson.build
> index 322cafcdf6..fed14aa0c2 100644
> --- a/tests/plugin/meson.build
> +++ b/tests/plugin/meson.build
> @@ -5,6 +5,11 @@ if get_option('plugins')
>                         include_directories: '../../include/qemu',
>                         dependencies: glib)
>    endforeach
> +  if 'cpp' in all_languages
> +    t += shared_module('cc', files('cc.cc'),
> +                       include_directories: '../../include/qemu',
> +                       dependencies: glib)
> +  endif
>  endif
>  if t.length() > 0
>    alias_target('test-plugins', t)
> diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> index 462289f47c..66a20d0f2c 100644
> --- a/tests/tcg/Makefile.target
> +++ b/tests/tcg/Makefile.target
> @@ -145,10 +145,9 @@ RUN_TESTS=$(patsubst %,run-%, $(TESTS))
>  
>  # If plugins exist also include those in the tests
>  ifeq ($(CONFIG_PLUGIN),y)
> -PLUGIN_SRC=$(SRC_PATH)/tests/plugin
>  PLUGIN_LIB=../../plugin
>  VPATH+=$(PLUGIN_LIB)
> -PLUGINS=$(patsubst %.c, lib%.so, $(notdir $(wildcard $(PLUGIN_SRC)/*.c)))
> +PLUGINS=$(notdir $(wildcard $(PLUGIN_LIB)/*.so))
>  
>  # We need to ensure expand the run-plugin-TEST-with-PLUGIN
>  # pre-requistes manually here as we can't use stems to handle it. We
> -- 
> 2.42.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


