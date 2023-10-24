Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5F07D510C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:09:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvH7q-00009V-E4; Tue, 24 Oct 2023 09:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvH7n-00008X-D8; Tue, 24 Oct 2023 09:07:11 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvH7l-00086Y-AJ; Tue, 24 Oct 2023 09:07:11 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40859c46447so22441065e9.1; 
 Tue, 24 Oct 2023 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698152826; x=1698757626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KDzDM0YxqKCgCCdkntEeHXUAF4bF07feeutdGTXuBxI=;
 b=XIJmkTU+G83e5bfVYP2wb41eIkfgC8mbHLXJEvCiJtxSorutfFRpq0A1FOijj6Yba5
 h0riDpMmtbkhYYkZfSaFo4bwfMDScrr6fnjHc+hX43A1ComJM84uzME//EZZZoMARjw+
 WIwekaULQ02kE0u/WaVypp/AKHS1jB5f96bsqt6He0EB7H4om/v2k502GdRXW1fZ6Wcv
 DC2MPZe8JNAJyGzOamLvYlspMmbmCtl12kbqlPCaSscou8eSD+8Niph6Q5vol6UUGDqY
 nEEDupqgSp9YPxJC+fEuViHasMO8m8yY3+caRV3Lt5caEq3M13PplV7gIYRzkOgdfw1B
 je4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698152826; x=1698757626;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KDzDM0YxqKCgCCdkntEeHXUAF4bF07feeutdGTXuBxI=;
 b=JT1wO3r2UMjh6T7yJtwRAz3cF8jyVRYcc4tSRSOXmf1sRtVUsPWz7K0PQ7WMvkUAeI
 DIhZ7z0VEMNGv0AlXUxruuY97ONG8izJDPbSG//jTVBHgxWslGKSJzmfnWoAi2U6MHI4
 +4tQXIhqWRqfB0NECCZxkR0LHn2CL4adQM2ZUjH9GfGSNHeqK7sbdefKTLKhu8uDccI6
 trx/R9BnQVAnCCuHvkcQqyoC84TSBI/6x3liuYObq99P05IDW6t2f3lG5n95RmIvmnyu
 UQydPGTwrQss592wn60pxWQQwiC5Y1mmRByRKIVY+6BsW04MjsJJmttMy632DKR1t43J
 2LBg==
X-Gm-Message-State: AOJu0Yxyoi4HtGRq85l6h9uBkeJQCwS8Sm+msKdia5A1XxhkIDevhHRm
 LTPe5WnEfhye1R9rt+P+VSY=
X-Google-Smtp-Source: AGHT+IHSYBXm7ww8kEijCPU+QQVGgouuAg8InLcq90b0Np1d6JZECDcRZPI7+BoWGWskCkmYHRoZMw==
X-Received: by 2002:a05:600c:3ba5:b0:406:44d2:8431 with SMTP id
 n37-20020a05600c3ba500b0040644d28431mr9234876wms.6.1698152826259; 
 Tue, 24 Oct 2023 06:07:06 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a05600c130e00b0040772934b12sm16523555wmf.7.2023.10.24.06.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 06:07:05 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ef6b0d7c-6040-44ab-89a6-3c51831a663c@xen.org>
Date: Tue, 24 Oct 2023 14:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] hw/xen: update Xen console to XenDevice model
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-8-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 16/10/2023 16:19, David Woodhouse wrote:
> This allows (non-primary) console devices to be created on the command
> line.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> ---
>   hw/char/trace-events        |   8 +
>   hw/char/xen_console.c       | 502 +++++++++++++++++++++++++++---------
>   hw/xen/xen-legacy-backend.c |   1 -
>   3 files changed, 381 insertions(+), 130 deletions(-)
> 
> diff --git a/hw/char/trace-events b/hw/char/trace-events
> index babf4d35ea..7a398c82a5 100644
> --- a/hw/char/trace-events
> +++ b/hw/char/trace-events
> @@ -105,3 +105,11 @@ cadence_uart_baudrate(unsigned baudrate) "baudrate %u"
>   # sh_serial.c
>   sh_serial_read(char *id, unsigned size, uint64_t offs, uint64_t val) " %s size %d offs 0x%02" PRIx64 " -> 0x%02" PRIx64
>   sh_serial_write(char *id, unsigned size, uint64_t offs, uint64_t val) "%s size %d offs 0x%02" PRIx64 " <- 0x%02" PRIx64
> +
> +# xen_console.c
> +xen_console_connect(unsigned int idx, unsigned int ring_ref, unsigned int port, unsigned int limit) "idx %u ring_ref %u port %u limit %u"
> +xen_console_disconnect(unsigned int idx) "idx %u"
> +xen_console_unrealize(unsigned int idx) "idx %u"
> +xen_console_realize(unsigned int idx, const char *chrdev) "idx %u chrdev %s"
> +xen_console_device_create(unsigned int idx) "idx %u"
> +xen_console_device_destroy(unsigned int idx) "idx %u"
> diff --git a/hw/char/xen_console.c b/hw/char/xen_console.c
> index 810dae3f44..bd20be116c 100644
> --- a/hw/char/xen_console.c
> +++ b/hw/char/xen_console.c
> @@ -20,15 +20,19 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/cutils.h"
>   #include <sys/select.h>
>   #include <termios.h>
>   
>   #include "qapi/error.h"
>   #include "sysemu/sysemu.h"
>   #include "chardev/char-fe.h"
> -#include "hw/xen/xen-legacy-backend.h"
> -
> +#include "hw/xen/xen-backend.h"
> +#include "hw/xen/xen-bus-helper.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>   #include "hw/xen/interface/io/console.h"
> +#include "trace.h"
>   
>   struct buffer {
>       uint8_t *data;
> @@ -39,16 +43,22 @@ struct buffer {
>   };
>   
>   struct XenConsole {
> -    struct XenLegacyDevice  xendev;  /* must be first */
> +    struct XenDevice  xendev;  /* must be first */
> +    XenEventChannel   *event_channel;
> +    int               dev;
>       struct buffer     buffer;
> -    char              console[XEN_BUFSIZE];
> -    int               ring_ref;
> +    char              *fe_path;
> +    unsigned int      ring_ref;
>       void              *sring;
>       CharBackend       chr;
>       int               backlog;
>   };
> +typedef struct XenConsole XenConsole;
> +
> +#define TYPE_XEN_CONSOLE_DEVICE "xen-console"
> +OBJECT_DECLARE_SIMPLE_TYPE(XenConsole, XEN_CONSOLE_DEVICE)
>   
> -static void buffer_append(struct XenConsole *con)
> +static bool buffer_append(XenConsole *con)
>   {
>       struct buffer *buffer = &con->buffer;
>       XENCONS_RING_IDX cons, prod, size;
> @@ -60,7 +70,7 @@ static void buffer_append(struct XenConsole *con)
>   
>       size = prod - cons;
>       if ((size == 0) || (size > sizeof(intf->out)))
> -        return;
> +        return false;
>   
>       if ((buffer->capacity - buffer->size) < size) {
>           buffer->capacity += (size + 1024);
> @@ -73,7 +83,7 @@ static void buffer_append(struct XenConsole *con)
>   
>       xen_mb();
>       intf->out_cons = cons;
> -    xen_pv_send_notify(&con->xendev);
> +    xen_device_notify_event_channel(XEN_DEVICE(con), con->event_channel, NULL);
>   
>       if (buffer->max_capacity &&
>           buffer->size > buffer->max_capacity) {
> @@ -89,6 +99,7 @@ static void buffer_append(struct XenConsole *con)
>           if (buffer->consumed > buffer->max_capacity - over)
>               buffer->consumed = buffer->max_capacity - over;
>       }
> +    return true;
>   }
>   
>   static void buffer_advance(struct buffer *buffer, size_t len)
> @@ -100,7 +111,7 @@ static void buffer_advance(struct buffer *buffer, size_t len)
>       }
>   }
>   
> -static int ring_free_bytes(struct XenConsole *con)
> +static int ring_free_bytes(XenConsole *con)
>   {
>       struct xencons_interface *intf = con->sring;
>       XENCONS_RING_IDX cons, prod, space;
> @@ -118,13 +129,13 @@ static int ring_free_bytes(struct XenConsole *con)
>   
>   static int xencons_can_receive(void *opaque)
>   {
> -    struct XenConsole *con = opaque;
> +    XenConsole *con = opaque;
>       return ring_free_bytes(con);
>   }
>   
>   static void xencons_receive(void *opaque, const uint8_t *buf, int len)
>   {
> -    struct XenConsole *con = opaque;
> +    XenConsole *con = opaque;
>       struct xencons_interface *intf = con->sring;
>       XENCONS_RING_IDX prod;
>       int i, max;
> @@ -141,10 +152,10 @@ static void xencons_receive(void *opaque, const uint8_t *buf, int len)
>       }
>       xen_wmb();
>       intf->in_prod = prod;
> -    xen_pv_send_notify(&con->xendev);
> +    xen_device_notify_event_channel(XEN_DEVICE(con), con->event_channel, NULL);
>   }
>   
> -static void xencons_send(struct XenConsole *con)
> +static bool xencons_send(XenConsole *con)
>   {
>       ssize_t len, size;
>   
> @@ -159,174 +170,407 @@ static void xencons_send(struct XenConsole *con)
>       if (len < 1) {
>           if (!con->backlog) {
>               con->backlog = 1;
> -            xen_pv_printf(&con->xendev, 1,
> -                          "backlog piling up, nobody listening?\n");
>           }
>       } else {
>           buffer_advance(&con->buffer, len);
>           if (con->backlog && len == size) {
>               con->backlog = 0;
> -            xen_pv_printf(&con->xendev, 1, "backlog is gone\n");
>           }
>       }
> +    return len > 0;
>   }
>   
>   /* -------------------------------------------------------------------- */
>   
> -static int store_con_info(struct XenConsole *con)
> +static bool con_event(void *_xendev)
>   {
> -    Chardev *cs = qemu_chr_fe_get_driver(&con->chr);
> -    char *pts = NULL;
> -    char *dom_path;
> -    g_autoptr(GString) path = NULL;
> +    XenConsole *con = XEN_CONSOLE_DEVICE(_xendev);
> +    bool done_something;
>   
> -    /* Only continue if we're talking to a pty. */
> -    if (!CHARDEV_IS_PTY(cs)) {
> -        return 0;
> -    }
> -    pts = cs->filename + 4;
> +    done_something = buffer_append(con);
>   
> -    dom_path = qemu_xen_xs_get_domain_path(xenstore, xen_domid);
> -    if (!dom_path) {
> -        return 0;
> +    if (con->buffer.size - con->buffer.consumed) {
> +        done_something |= xencons_send(con);
>       }
> +    return done_something;
> +}
>   
> -    path = g_string_new(dom_path);
> -    free(dom_path);
> +/* -------------------------------------------------------------------- */
>   
> -    if (con->xendev.dev) {
> -        g_string_append_printf(path, "/device/console/%d", con->xendev.dev);
> -    } else {
> -        g_string_append(path, "/console");
> +static void xen_console_disconnect(XenDevice *xendev, Error **errp)
> +{
> +    XenConsole *con = XEN_CONSOLE_DEVICE(xendev);
> +
> +    qemu_chr_fe_set_handlers(&con->chr, NULL, NULL, NULL, NULL,
> +                             con, NULL, true);
> +

nit: extraneous blank line by the looks of it.

With that fixed...

Reviewed-by: Paul Durrant <paul@xen.org>


