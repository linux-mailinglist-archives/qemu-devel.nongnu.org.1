Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D97D9262
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 10:43:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwIQB-0005R7-U2; Fri, 27 Oct 2023 04:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIQ8-0005Qw-82; Fri, 27 Oct 2023 04:42:20 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwIQ6-00017G-6I; Fri, 27 Oct 2023 04:42:19 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32dc9ff4a8fso1159665f8f.1; 
 Fri, 27 Oct 2023 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698396136; x=1699000936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=I4YW6v0nwEzTaGHDzniJxz3Wp+GrgF6w84+hb3xLCwk=;
 b=k2G9q9zY8AYNyFSe9Qqw42eQ7GDZva6BEc+gvSnW2+O9R8H2MJpHQHcS0tFZMyo9Zf
 yLTVejI7bFthuzx5Tb/wp9t2RS2ShjhAJJPXttVfsOpGviwieOkORG5apmT1h97YDybw
 Ik7KTxTuhEAFkY07E+X4IZAuPNFi82SPGYHu08Pw67BqGNRVHXUck5g158eWB/NtTxeJ
 Qa7zMCqR0yZCMk2L6dmrDyVvRM2cchPNeV96V9mw7jimTbjQyCfSyNzk6r4e3r9443uH
 8PHvilSp1o5iwIozk0JFBHotoCXLkDysJZVz0jo+Bfpi9eZwk+k/4NtB6DSZfd3Xsn4d
 +iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698396136; x=1699000936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4YW6v0nwEzTaGHDzniJxz3Wp+GrgF6w84+hb3xLCwk=;
 b=cB55e5f32SU2TO82YKg+39dYvtqeHfeZb7wEluKMfS7/38n4YeaewbRy0W+MiydUqf
 ERtarHHjmOTnn38tP/LMaXzpO9bPYjdZfZSXof/T+M3PK87VRMU0dkMqkGX0IvFTDZtL
 m2zESo+kPJ7vEd54ojN6r0WGLfHQemuTjOIpzC8Xwh8S5BycWIaNqW8s8460TTrmNscf
 e8qbxFMuJuGtrnMm5PKbeOyE0YBWRrHFiDFFd2zW+y4Tg1g1AILOFFJpRBKiRIYH/UFt
 yb4cVZqQJEyd3t3OqTvRd5KiA4U1kUYC3kCQVYBPAa4YMP6CGs8MS3tNGxHtm5ZdSAu8
 9W8Q==
X-Gm-Message-State: AOJu0Yyv49RVBxrG3BkZeW92Tyu2QIwEpQFHAZCg18wUOQh7eTGCuMgE
 ajKG4Vb9e6D3trKb04zqJLA=
X-Google-Smtp-Source: AGHT+IHYKFjE7/5s/eYCnVaerp95T/CLeSS0gWC6UKfDnf6cIdlOYl4zJ2dW3VoRlx9dX62JxFte9A==
X-Received: by 2002:a5d:4a4c:0:b0:32d:d2ef:b0c1 with SMTP id
 v12-20020a5d4a4c000000b0032dd2efb0c1mr1586686wrs.33.1698396135916; 
 Fri, 27 Oct 2023 01:42:15 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 q12-20020adffecc000000b0032dc1fc84f2sm1294729wrs.46.2023.10.27.01.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 01:42:15 -0700 (PDT)
Message-ID: <a0798190-e5da-42fd-af1c-17af48e9fe89@gmail.com>
Date: Fri, 27 Oct 2023 09:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/28] hw/xen: update Xen PV NIC to XenDevice model
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-20-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-20-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x42a.google.com
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

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> This allows us to use Xen PV networking with emulated Xen guests, and to
> add them on the command line or hotplug.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/net/meson.build        |   2 +-
>   hw/net/trace-events       |  11 +
>   hw/net/xen_nic.c          | 484 +++++++++++++++++++++++++++++---------
>   hw/xenpv/xen_machine_pv.c |   1 -
>   4 files changed, 381 insertions(+), 117 deletions(-)
> 
> diff --git a/hw/net/meson.build b/hw/net/meson.build
> index 2632634df3..f64651c467 100644
> --- a/hw/net/meson.build
> +++ b/hw/net/meson.build
> @@ -1,5 +1,5 @@
>   system_ss.add(when: 'CONFIG_DP8393X', if_true: files('dp8393x.c'))
> -system_ss.add(when: 'CONFIG_XEN', if_true: files('xen_nic.c'))
> +system_ss.add(when: 'CONFIG_XEN_BUS', if_true: files('xen_nic.c'))
>   system_ss.add(when: 'CONFIG_NE2000_COMMON', if_true: files('ne2000.c'))
>   
>   # PCI network cards
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 3abfd65e5b..3097742cc0 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -482,3 +482,14 @@ dp8393x_receive_oversize(int size) "oversize packet, pkt_size is %d"
>   dp8393x_receive_not_netcard(void) "packet not for netcard"
>   dp8393x_receive_packet(int crba) "Receive packet at 0x%"PRIx32
>   dp8393x_receive_write_status(int crba) "Write status at 0x%"PRIx32
> +
> +# xen_nic.c
> +xen_netdev_realize(int dev, const char *info, const char *peer) "vif%u info '%s' peer '%s'"
> +xen_netdev_unrealize(int dev) "vif%u"
> +xen_netdev_create(int dev) "vif%u"
> +xen_netdev_destroy(int dev) "vif%u"
> +xen_netdev_disconnect(int dev) "vif%u"
> +xen_netdev_connect(int dev, unsigned int tx, unsigned int rx, int port) "vif%u tx %u rx %u port %u"
> +xen_netdev_frontend_changed(const char *dev, int state) "vif%s state %d"
> +xen_netdev_tx(int dev, int ref, int off, int len, unsigned int flags, const char *c, const char *d, const char *m, const char *e) "vif%u ref %u off %u len %u flags 0x%x%s%s%s%s"
> +xen_netdev_rx(int dev, int idx, int status, int flags) "vif%u idx %d status %d flags 0x%x"
> diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
> index 9bbf6599fc..af4ba3f1e6 100644
> --- a/hw/net/xen_nic.c
> +++ b/hw/net/xen_nic.c
> @@ -20,6 +20,13 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/cutils.h"
> +#include "qemu/log.h"
> +#include "qemu/qemu-print.h"
> +#include "qapi/qmp/qdict.h"
> +#include "qapi/error.h"
> +
>   #include <sys/socket.h>
>   #include <sys/ioctl.h>
>   #include <sys/wait.h>
> @@ -27,18 +34,26 @@
>   #include "net/net.h"
>   #include "net/checksum.h"
>   #include "net/util.h"
> -#include "hw/xen/xen-legacy-backend.h"
> +
> +#include "hw/xen/xen-backend.h"
> +#include "hw/xen/xen-bus-helper.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/qdev-properties-system.h"
>   
>   #include "hw/xen/interface/io/netif.h"
> +#include "hw/xen/interface/io/xs_wire.h"
> +
> +#include "trace.h"
>   
>   /* ------------------------------------------------------------- */
>   
>   struct XenNetDev {
> -    struct XenLegacyDevice      xendev;  /* must be first */
> -    char                  *mac;
> +    struct XenDevice      xendev;  /* must be first */
> +    XenEventChannel       *event_channel;
> +    int                   dev;
>       int                   tx_work;
> -    int                   tx_ring_ref;
> -    int                   rx_ring_ref;
> +    unsigned int          tx_ring_ref;
> +    unsigned int          rx_ring_ref;
>       struct netif_tx_sring *txs;
>       struct netif_rx_sring *rxs;
>       netif_tx_back_ring_t  tx_ring;
> @@ -47,6 +62,11 @@ struct XenNetDev {
>       NICState              *nic;
>   };
>   
> +typedef struct XenNetDev XenNetDev;
> +
> +#define TYPE_XEN_NET_DEVICE "xen-net-device"
> +OBJECT_DECLARE_SIMPLE_TYPE(XenNetDev, XEN_NET_DEVICE)
> +
>   /* ------------------------------------------------------------- */
>   
>   static void net_tx_response(struct XenNetDev *netdev, netif_tx_request_t *txp, int8_t st)
> @@ -68,7 +88,8 @@ static void net_tx_response(struct XenNetDev *netdev, netif_tx_request_t *txp, i
>       netdev->tx_ring.rsp_prod_pvt = ++i;
>       RING_PUSH_RESPONSES_AND_CHECK_NOTIFY(&netdev->tx_ring, notify);
>       if (notify) {
> -        xen_pv_send_notify(&netdev->xendev);
> +        xen_device_notify_event_channel(XEN_DEVICE(netdev),
> +                                        netdev->event_channel, NULL);
>       }
>   
>       if (i == netdev->tx_ring.req_cons) {
> @@ -104,13 +125,16 @@ static void net_tx_error(struct XenNetDev *netdev, netif_tx_request_t *txp, RING
>   #endif
>   }
>   
> -static void net_tx_packets(struct XenNetDev *netdev)
> +static bool net_tx_packets(struct XenNetDev *netdev)
>   {
> +    bool done_something = false;
>       netif_tx_request_t txreq;
>       RING_IDX rc, rp;
>       void *page;
>       void *tmpbuf = NULL;
>   
> +    assert(qemu_mutex_iothread_locked());
> +
>       for (;;) {
>           rc = netdev->tx_ring.req_cons;
>           rp = netdev->tx_ring.sring->req_prod;
> @@ -122,49 +146,52 @@ static void net_tx_packets(struct XenNetDev *netdev)
>               }
>               memcpy(&txreq, RING_GET_REQUEST(&netdev->tx_ring, rc), sizeof(txreq));
>               netdev->tx_ring.req_cons = ++rc;
> +            done_something = true;
>   
>   #if 1
>               /* should not happen in theory, we don't announce the *
>                * feature-{sg,gso,whatelse} flags in xenstore (yet?) */
>               if (txreq.flags & NETTXF_extra_info) {
> -                xen_pv_printf(&netdev->xendev, 0, "FIXME: extra info flag\n");
> +                qemu_log_mask(LOG_UNIMP, "vif%u: FIXME: extra info flag\n",
> +                              netdev->dev);
>                   net_tx_error(netdev, &txreq, rc);
>                   continue;
>               }
>               if (txreq.flags & NETTXF_more_data) {
> -                xen_pv_printf(&netdev->xendev, 0, "FIXME: more data flag\n");
> +                qemu_log_mask(LOG_UNIMP, "vif%u: FIXME: more data flag\n",
> +                              netdev->dev);
>                   net_tx_error(netdev, &txreq, rc);
>                   continue;
>               }
>   #endif

I know that this is just translation but the fact the above code is 
there indicates that you're likely to see problems here. Not supporting 
extra_info is likely ok as long as RSS, TSO or multicast filtering is 
not advertized (as the comment says). But lack of support for more_data 
basically means your frontend needs to send all packets in a single frag 
(e.g. no header split) so that might bite pretty quickly. I guess it 
goes to show that no-one has used this code in many many years.

The translation looks ok to me though so...

Reviewed-by: Paul Durrant <paul@xen.org>


