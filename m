Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D7790175
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 19:29:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc7wT-0004eq-97; Fri, 01 Sep 2023 13:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7wR-0004bi-1Q
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:28:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qc7wJ-0001hL-HA
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 13:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693589290;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rZeeHzOro6xjre21jtFOqOZWCF8fDuv0GFSXGmwQz1Y=;
 b=V5W4TzWP1GKmkDfC9ReVwfKU5NZBSRGpRJDEK+f+A/neYa3A82kvaaisgwY/vUgH5gikn2
 97JB8guAWiqCnIbQlSZ+lCySfGpBaJFLdqZ5c/4LkAD7AvpP4BvZZbzYKleQJtndFeulfD
 xVMHwekhBsX+ug1dnrBF6KhwKmURkHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-VCkxchGIMWKFOJTUFOaEFA-1; Fri, 01 Sep 2023 13:28:08 -0400
X-MC-Unique: VCkxchGIMWKFOJTUFOaEFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C89519469A2
 for <qemu-devel@nongnu.org>; Fri,  1 Sep 2023 17:28:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 38B1740C84A5;
 Fri,  1 Sep 2023 17:28:07 +0000 (UTC)
Date: Fri, 1 Sep 2023 18:28:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 54/67] ui/vc: console-vc requires PIXMAN
Message-ID: <ZPIfJd0h6h5zeiMa@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-55-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230830093843.3531473-55-marcandre.lureau@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Wed, Aug 30, 2023 at 01:38:28PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Add stubs for the fallback paths.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  ui/console-vc-stubs.c | 59 +++++++++++++++++++++++++++++++++++++++++++
>  ui/meson.build        |  2 +-
>  2 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 ui/console-vc-stubs.c
> 
> diff --git a/ui/console-vc-stubs.c b/ui/console-vc-stubs.c
> new file mode 100644
> index 0000000000..76ea880d27
> --- /dev/null
> +++ b/ui/console-vc-stubs.c
> @@ -0,0 +1,59 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + * QEMU VC stubs
> + */
> +#include "qemu/osdep.h"
> +
> +#include "qapi/error.h"
> +#include "qemu/error-report.h"
> +#include "qemu/option.h"
> +#include "chardev/char.h"
> +#include "ui/console-priv.h"
> +
> +void qemu_text_console_select(QemuTextConsole *c)
> +{
> +}
> +
> +const char * qemu_text_console_get_label(QemuTextConsole *c)
> +{
> +    return NULL;
> +}
> +
> +void qemu_text_console_update_cursor(void)
> +{
> +}
> +
> +void qemu_text_console_handle_keysym(QemuTextConsole *s, int keysym)
> +{
> +}
> +
> +#define TYPE_CHARDEV_VC "chardev-vc"
> +
> +static void vc_chr_parse(QemuOpts *opts, ChardevBackend *backend, Error **errp)
> +{
> +    const char *id = qemu_opts_id(opts);
> +
> +    warn_report("%s: this is a dummy VC driver. "
> +                "Use '-nographic' or a different chardev.", id);
> +}

Why should this be an error_setg() call given we have a errp
parameter, so make this unsupportable config into an error ?
Ignoring invalid user configs is not desirable in general.

> +
> +static void char_vc_class_init(ObjectClass *oc, void *data)
> +{
> +    ChardevClass *cc = CHARDEV_CLASS(oc);
> +
> +    cc->parse = vc_chr_parse;
> +}
> +
> +static const TypeInfo char_vc_type_info = {
> +    .name = TYPE_CHARDEV_VC,
> +    .parent = TYPE_CHARDEV,
> +    .class_init = char_vc_class_init,
> +};
> +
> +void qemu_console_early_init(void)
> +{
> +    /* set the default vc driver */
> +    if (!object_class_by_name(TYPE_CHARDEV_VC)) {
> +        type_register(&char_vc_type_info);
> +    }
> +}
> diff --git a/ui/meson.build b/ui/meson.build
> index 0a1e8272a3..3085e10a72 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -6,7 +6,6 @@ system_ss.add(png)
>  system_ss.add(files(
>    'clipboard.c',
>    'console.c',
> -  'console-vc.c',
>    'cursor.c',
>    'input-keymap.c',
>    'input-legacy.c',
> @@ -19,6 +18,7 @@ system_ss.add(files(
>    'ui-qmp-cmds.c',
>    'util.c',
>  ))
> +system_ss.add(when: pixman, if_true: files('console-vc.c'), if_false: files('console-vc-stubs.c'))
>  if dbus_display
>    system_ss.add(files('dbus-module.c'))
>  endif
> -- 
> 2.41.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


