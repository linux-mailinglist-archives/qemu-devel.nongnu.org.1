Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D398AE91D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Apr 2024 16:08:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGnT-0005xj-NK; Tue, 23 Apr 2024 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzGnR-0005xa-UB
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 10:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rzGnO-0004a4-5A
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 10:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713881212;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPcKcQpH81DNw8YXrHzaTyqM/JBQZBhaEu+q0ux3Vwc=;
 b=ZKezB7xMvwFKKzp2dbTCaqr7ujDOAU9yBlMLQxZc2QKcTQsC6Wxe4lA2M7pnTLn30iE27p
 4fqTbpREL39BoAQvICAYxTESDu5UXKRpxM/MlN2K9JVBXPndVTTa2MkAZhyulmIZemQi1V
 0RVllv+ywVTOi8bjs5YvEiNhwWiYTAU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-6GlgUWa4OS6pz3VGDfWasw-1; Tue,
 23 Apr 2024 10:06:49 -0400
X-MC-Unique: 6GlgUWa4OS6pz3VGDfWasw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58D121C0314D;
 Tue, 23 Apr 2024 14:06:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 32D992166B32;
 Tue, 23 Apr 2024 14:06:47 +0000 (UTC)
Date: Tue, 23 Apr 2024 15:06:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: dongwon.kim@intel.com
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v10 2/6] ui/console: new dmabuf.h and dmabuf.c for
 QemuDmaBuf struct and helpers
Message-ID: <ZifAdRBCndQeOAwh@redhat.com>
References: <20240423022253.1003295-1-dongwon.kim@intel.com>
 <20240423022253.1003295-3-dongwon.kim@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423022253.1003295-3-dongwon.kim@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

On Mon, Apr 22, 2024 at 07:22:49PM -0700, dongwon.kim@intel.com wrote:
> From: Dongwon Kim <dongwon.kim@intel.com>
> 
> New header and source files are added for containing QemuDmaBuf struct
> definition and newly introduced helpers for creating/freeing the struct
> and accessing its data.
> 
> v10: Change the license type for both dmabuf.h and dmabuf.c from MIT to
>      GPL to be in line with QEMU's default license
>      (Daniel P. Berrangé <berrange@redhat.com>)
> 
> Suggested-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
> ---
>  include/ui/console.h |  20 +----
>  include/ui/dmabuf.h  |  64 +++++++++++++++
>  ui/dmabuf.c          | 189 +++++++++++++++++++++++++++++++++++++++++++
>  ui/meson.build       |   1 +
>  4 files changed, 255 insertions(+), 19 deletions(-)
>  create mode 100644 include/ui/dmabuf.h
>  create mode 100644 ui/dmabuf.c
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 0bc7a00ac0..a208a68b88 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -7,6 +7,7 @@
>  #include "qapi/qapi-types-ui.h"
>  #include "ui/input.h"
>  #include "ui/surface.h"
> +#include "ui/dmabuf.h"
>  
>  #define TYPE_QEMU_CONSOLE "qemu-console"
>  OBJECT_DECLARE_TYPE(QemuConsole, QemuConsoleClass, QEMU_CONSOLE)
> @@ -185,25 +186,6 @@ struct QEMUGLParams {
>      int minor_ver;
>  };
>  
> -typedef struct QemuDmaBuf {
> -    int       fd;
> -    uint32_t  width;
> -    uint32_t  height;
> -    uint32_t  stride;
> -    uint32_t  fourcc;
> -    uint64_t  modifier;
> -    uint32_t  texture;
> -    uint32_t  x;
> -    uint32_t  y;
> -    uint32_t  backing_width;
> -    uint32_t  backing_height;
> -    bool      y0_top;
> -    void      *sync;
> -    int       fence_fd;
> -    bool      allow_fences;
> -    bool      draw_submitted;
> -} QemuDmaBuf;
> -
>  enum display_scanout {
>      SCANOUT_NONE,
>      SCANOUT_SURFACE,
> diff --git a/include/ui/dmabuf.h b/include/ui/dmabuf.h
> new file mode 100644
> index 0000000000..7a60116ee6
> --- /dev/null
> +++ b/include/ui/dmabuf.h
> @@ -0,0 +1,64 @@
> +/*
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * QemuDmaBuf struct and helpers used for accessing its data
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef DMABUF_H
> +#define DMABUF_H
> +
> +typedef struct QemuDmaBuf {
> +    int       fd;
> +    uint32_t  width;
> +    uint32_t  height;
> +    uint32_t  stride;
> +    uint32_t  fourcc;
> +    uint64_t  modifier;
> +    uint32_t  texture;
> +    uint32_t  x;
> +    uint32_t  y;
> +    uint32_t  backing_width;
> +    uint32_t  backing_height;
> +    bool      y0_top;
> +    void      *sync;
> +    int       fence_fd;
> +    bool      allow_fences;
> +    bool      draw_submitted;
> +} QemuDmaBuf;
> +
> +QemuDmaBuf *qemu_dmabuf_new(uint32_t width, uint32_t height,
> +                                   uint32_t stride, uint32_t x,
> +                                   uint32_t y, uint32_t backing_width,
> +                                   uint32_t backing_height, uint32_t fourcc,
> +                                   uint64_t modifier, int32_t dmabuf_fd,

Should be 'int' not 'int32_t' for FDs.

> +                                   bool allow_fences, bool y0_top);
> +void qemu_dmabuf_free(QemuDmaBuf *dmabuf);
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(QemuDmaBuf, qemu_dmabuf_free);
> +
> +int32_t qemu_dmabuf_get_fd(QemuDmaBuf *dmabuf);

Again should be 'int' not 'int42_t'

I think there ought to also be a

  int qemu_dmabuf_dup_fd(QemuDmaBuf *dmabuf);

to do the dup() call in one go too

> diff --git a/ui/dmabuf.c b/ui/dmabuf.c
> new file mode 100644
> index 0000000000..f447cce4fe
> --- /dev/null
> +++ b/ui/dmabuf.c

> +
> +void qemu_dmabuf_free(QemuDmaBuf *dmabuf)
> +{
> +    if (dmabuf == NULL) {
> +        return;
> +    }
> +

I think this method should be made to call

  qemu_dmabuf_close()

to release the FD, if not already released, otherwise
this method could be a resource leak.

> +    g_free(dmabuf);
> +}
> +

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


