Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 923877CCFD9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 00:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qss79-0007pa-Jt; Tue, 17 Oct 2023 18:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qss6t-0007nW-Ug
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:00:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qss6q-0000W0-MU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 18:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697580013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MQyFeapujUzC5EPFuR98l+MElDouPf72NlPSas9OsIc=;
 b=WpH9WbC3GWaSEx+zQMc+SSbdmEINoZ7HToLTQqG00G3bm9I0MX+hhGm5eKW3S05RZeGEW7
 QdLSZzdWBhcq0K+cfNoBbo5c1IdvpenQvdrhBhXmC/0TJa919tw2hqmCQwm1vGnXrLNo5i
 Mit6j5YOSK7148Z+f0EA5DPhakRefe0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-KguWsQ-WNV25D_4hfUfzyg-1; Tue, 17 Oct 2023 18:00:10 -0400
X-MC-Unique: KguWsQ-WNV25D_4hfUfzyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94F9B2932494;
 Tue, 17 Oct 2023 22:00:09 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D78B25C8;
 Tue, 17 Oct 2023 22:00:08 +0000 (UTC)
Date: Tue, 17 Oct 2023 17:00:06 -0500
From: Eric Blake <eblake@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>, 
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>, 
 "open list:ARM SMMU" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH v2 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
Message-ID: <3e2wiwbl3g5t37msvmxcjxi5mhzpaazkd3phbw2p2dauuophxo@np3sbg6l7fq3>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183699.git.manos.pitsidianakis@linaro.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Oct 13, 2023 at 10:56:28AM +0300, Emmanouil Pitsidianakis wrote:
> Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

The subject line gives the 'what', but the commit body is
conspicuously lacking on the 'why'.

> ---
>  audio/pwaudio.c              |  8 ++++----
>  hw/arm/smmuv3.c              |  2 +-
>  include/qemu/compiler.h      | 30 +++++++++++++++++++++++-------
>  include/qemu/osdep.h         |  4 ++--
>  target/loongarch/cpu.c       |  4 ++--
>  target/loongarch/translate.c |  2 +-
>  tcg/optimize.c               |  8 ++++----
>  7 files changed, 37 insertions(+), 21 deletions(-)
> 
> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
> index 3ce5f6507b..bf26fadb06 100644
> --- a/audio/pwaudio.c
> +++ b/audio/pwaudio.c
> @@ -1,29 +1,29 @@
>  /*
>   * QEMU PipeWire audio driver
>   *
>   * Copyright (c) 2023 Red Hat Inc.
>   *
>   * Author: Dorinda Bassey       <dbassey@redhat.com>
>   *
>   * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  
> +#include <spa/param/audio/format-utils.h>
> +#include <spa/utils/ringbuffer.h>
> +#include <spa/utils/result.h>
> +#include <spa/param/props.h>
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "audio.h"
>  #include <errno.h>
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
> -#include <spa/param/audio/format-utils.h>
> -#include <spa/utils/ringbuffer.h>
> -#include <spa/utils/result.h>
> -#include <spa/param/props.h>

Rearranging #includes should be called out in the commit message, or
even better split into its own commit as it is distinct from renaming
the fallthrough macro.

>  
>  #include <pipewire/pipewire.h>
>  #include "trace.h"
>  
>  #define AUDIO_CAP "pipewire"
>  #define RINGBUFFER_SIZE    (1u << 22)
>  #define RINGBUFFER_MASK    (RINGBUFFER_SIZE - 1)
>  
>  #include "audio_int.h"
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6f2b2bd45f..545d82ff04 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1166,210 +1166,210 @@ smmuv3_invalidate_ste(gpointer key, gpointer value, gpointer user_data)

Wow, your git settings picked up a LOT of context - makes for a longer
email, but in this particular case, it IS nice to see the impact of
the fallthrough by seeing the full switch statment.

...
>          qemu_mutex_lock(&s->mutex);
>          switch (type) {
>          case SMMU_CMD_SYNC:
...
>          case SMMU_CMD_TLBI_NH_ALL:
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> -            QEMU_FALLTHROUGH;
> +            fallthrough;
>          case SMMU_CMD_TLBI_NSNH_ALL:

Yes, that still looks legible to me.

> +++ b/include/qemu/compiler.h
> @@ -1,215 +1,231 @@
...
>  #if defined(__OPTIMIZE__)
>  #define QEMU_ALWAYS_INLINE  __attribute__((always_inline))
>  #else
>  #define QEMU_ALWAYS_INLINE
>  #endif
>  
> -/**
> - * In most cases, normal "fallthrough" comments are good enough for
> - * switch-case statements, but sometimes the compiler has problems
> - * with those. In that case you can use QEMU_FALLTHROUGH instead.
> +/*
> + * Add the pseudo keyword 'fallthrough' so case statement blocks
> + * must end with any of these keywords:
> + *   break;
> + *   fallthrough;
> + *   continue;
> + *   goto <label>;
> + *   return [expression];
> + *
> + *  gcc: https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html#Statement-Attributes
>   */
> -#if __has_attribute(fallthrough)
> -# define QEMU_FALLTHROUGH __attribute__((fallthrough))
> +
> +/*
> + * glib_macros.h contains its own definition of fallthrough, so if we define
> + * the pseudokeyword here it will expand when the glib header checks for the
> + * attribute. glib headers must be #included after this header.
> + */
> +#ifdef fallthrough
> +#undef fallthrough
> +#endif
> +
> +#if __has_attribute(__fallthrough__)
> +# define fallthrough                    __attribute__((__fallthrough__))
>  #else
> -# define QEMU_FALLTHROUGH do {} while (0) /* fallthrough */
> +# define fallthrough                    do {} while (0)  /* fallthrough */
>  #endif
>

Looks okay.

> +++ b/include/qemu/osdep.h
> @@ -1,171 +1,171 @@
>  /*
>   * TARGET_WORDS_BIGENDIAN was replaced with TARGET_BIG_ENDIAN. Prevent it from
>   * creeping back in.
>   */
>  #pragma GCC poison TARGET_WORDS_BIGENDIAN
>  
> -#include "qemu/compiler.h"
> -
>  /* Older versions of C++ don't get definitions of various macros from
>   * stdlib.h unless we define these macros before first inclusion of
>   * that system header.
>   */
...
>  /*
>   * This is somewhat like a system header; it must be outside any extern "C"
>   * block because it includes system headers itself, including glib.h,
>   * which will not compile if inside an extern "C" block.
>   */
>  #include "glib-compat.h"
>  
> +#include "qemu/compiler.h"
> +

The commit message should detail why we had to sink this include
later, and any audit you did to ensure that none of the intermediate
code is impacted by that change.

At this point, since the series is RFC, I'll leave merely:

Acked-by: Eric Blake <eblake@redhat.com>

but if others like the approach, I'll probably replace it with R-b in
the next version.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


