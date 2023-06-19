Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7560735D28
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 19:49:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBIyK-00027g-6J; Mon, 19 Jun 2023 13:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBIyG-00026n-9b
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:47:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qBIyB-0001xv-US
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 13:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687196835;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YK4WCF3YeKTmc4l8nyZ4zPDv8RPSACgDLOvZL/+BDCk=;
 b=a9R0mgtqdIEQRZQ1yrjnF8sYpifG5C/jVp8gOrOMKbBWhU7gPc3pfOSlULu7+RWSdZmHx1
 oMrJW7MMVp8jXXJaHMtSVz8e1jX117SJ9YfSeTozSndo4O+eNCbyeyl0fWiKgMnVzIB7ZX
 i5pPp6cWZsPvFNz/hD/7LSWQlVkkG/o=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-Ayaa9cH8OeWaf-SS3Q84Pw-1; Mon, 19 Jun 2023 13:47:11 -0400
X-MC-Unique: Ayaa9cH8OeWaf-SS3Q84Pw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2DD3F3C0ED4C;
 Mon, 19 Jun 2023 17:47:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.57])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78CCD2026D49;
 Mon, 19 Jun 2023 17:47:09 +0000 (UTC)
Date: Mon, 19 Jun 2023 18:47:07 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/12] hw/virtio: Add support for apple virtio-blk
Message-ID: <ZJCUm0i7LHFHorvo@redhat.com>
References: <20230614224038.86148-1-graf>
 <20230614225626.97734-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230614225626.97734-1-graf@amazon.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

On Wed, Jun 14, 2023 at 10:56:22PM +0000, Alexander Graf wrote:
> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new discard
> command.
> 
> This patch adds a new qdev property called "apple-type" to virtio-blk-pci.
> When that property is set, we assume the virtio-blk device is an Apple one
> of the specific type and act accordingly.

I wonder if we should treat these as two separate devices. ie define
a 'apple-virtio-blk' device name, and have it be a subclass of the
main virtio blk impl. That would allow distros to drop the apple
forked impl in their downstream when they seek to minimize their
support matrix.

> 
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>  hw/block/virtio-blk.c                       | 23 +++++++++++++++++++++
>  hw/virtio/virtio-blk-pci.c                  |  7 +++++++
>  include/hw/pci/pci_ids.h                    |  1 +
>  include/hw/virtio/virtio-blk.h              |  1 +
>  include/standard-headers/linux/virtio_blk.h |  3 +++
>  5 files changed, 35 insertions(+)
> 
> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> index 39e7f23fab..76b85bb3cb 100644
> --- a/hw/block/virtio-blk.c
> +++ b/hw/block/virtio-blk.c
> @@ -1120,6 +1120,20 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>  
>          break;
>      }
> +    case VIRTIO_BLK_T_APPLE1:
> +    {
> +        if (s->conf.x_apple_type) {
> +            /* Only valid on Apple Virtio */
> +            char buf[iov_size(in_iov, in_num)];
> +            memset(buf, 0, sizeof(buf));
> +            iov_from_buf(in_iov, in_num, 0, buf, sizeof(buf));
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);
> +        } else {
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
> +        }
> +        virtio_blk_free_request(req);
> +        break;
> +    }
>      default:
>          virtio_blk_req_complete(req, VIRTIO_BLK_S_UNSUPP);
>          virtio_blk_free_request(req);
> @@ -1351,6 +1365,10 @@ static void virtio_blk_update_config(VirtIODevice *vdev, uint8_t *config)
>      } else {
>          blkcfg.zoned.model = VIRTIO_BLK_Z_NONE;
>      }
> +    if (s->conf.x_apple_type) {
> +        /* Apple abuses the same location for its type id */
> +        blkcfg.max_secure_erase_sectors = s->conf.x_apple_type;
> +    }
>      memcpy(config, &blkcfg, s->config_size);
>  }
>  
> @@ -1625,6 +1643,10 @@ static void virtio_blk_device_realize(DeviceState *dev, Error **errp)
>  
>      s->config_size = virtio_get_config_size(&virtio_blk_cfg_size_params,
>                                              s->host_features);
> +    if (s->conf.x_apple_type) {
> +        /* Apple Virtio puts the blk type at 0x3c, make sure we have space. */
> +        s->config_size = MAX(s->config_size, 0x3d);
> +    }
>      virtio_init(vdev, VIRTIO_ID_BLOCK, s->config_size);
>  
>      s->blk = conf->conf.blk;
> @@ -1734,6 +1756,7 @@ static Property virtio_blk_properties[] = {
>                         conf.max_write_zeroes_sectors, BDRV_REQUEST_MAX_SECTORS),
>      DEFINE_PROP_BOOL("x-enable-wce-if-config-wce", VirtIOBlock,
>                       conf.x_enable_wce_if_config_wce, true),
> +    DEFINE_PROP_UINT32("x-apple-type", VirtIOBlock, conf.x_apple_type, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
> index 9743bee965..5fbf98f750 100644
> --- a/hw/virtio/virtio-blk-pci.c
> +++ b/hw/virtio/virtio-blk-pci.c
> @@ -62,6 +62,13 @@ static void virtio_blk_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
>      }
>  
>      qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
> +
> +    if (conf->x_apple_type) {
> +        /* Apple virtio-blk uses a different vendor/device id */
> +        pci_config_set_vendor_id(vpci_dev->pci_dev.config, PCI_VENDOR_ID_APPLE);
> +        pci_config_set_device_id(vpci_dev->pci_dev.config,
> +                                 PCI_DEVICE_ID_APPLE_VIRTIO_BLK);
> +    }
>  }
>  
>  static void virtio_blk_pci_class_init(ObjectClass *klass, void *data)
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index e4386ebb20..74e589a298 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -188,6 +188,7 @@
>  #define PCI_DEVICE_ID_APPLE_UNI_N_AGP    0x0020
>  #define PCI_DEVICE_ID_APPLE_U3_AGP       0x004b
>  #define PCI_DEVICE_ID_APPLE_UNI_N_GMAC   0x0021
> +#define PCI_DEVICE_ID_APPLE_VIRTIO_BLK   0x1a00
>  
>  #define PCI_VENDOR_ID_SUN                0x108e
>  #define PCI_DEVICE_ID_SUN_EBUS           0x1000
> diff --git a/include/hw/virtio/virtio-blk.h b/include/hw/virtio/virtio-blk.h
> index dafec432ce..7117ce754c 100644
> --- a/include/hw/virtio/virtio-blk.h
> +++ b/include/hw/virtio/virtio-blk.h
> @@ -46,6 +46,7 @@ struct VirtIOBlkConf
>      uint32_t max_discard_sectors;
>      uint32_t max_write_zeroes_sectors;
>      bool x_enable_wce_if_config_wce;
> +    uint32_t x_apple_type;
>  };
>  
>  struct VirtIOBlockDataPlane;
> diff --git a/include/standard-headers/linux/virtio_blk.h b/include/standard-headers/linux/virtio_blk.h
> index 7155b1a470..bbea5d50b9 100644
> --- a/include/standard-headers/linux/virtio_blk.h
> +++ b/include/standard-headers/linux/virtio_blk.h
> @@ -204,6 +204,9 @@ struct virtio_blk_config {
>  /* Reset All zones command */
>  #define VIRTIO_BLK_T_ZONE_RESET_ALL 26
>  
> +/* Write zeroes command */
> +#define VIRTIO_BLK_T_APPLE1	0x10000
> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000
> -- 
> 2.39.2 (Apple Git-143)
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


