Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C57B3733069
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 13:50:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA7wv-0006Uy-Jp; Fri, 16 Jun 2023 07:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qA7wt-0006UK-DY
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 07:49:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qA7wr-0004F1-KC
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 07:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686916140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L9tgbgzrBAtM2duhTjvf4sc7TXMeB8Ua4SklVk41HPw=;
 b=MmWAYme/qNmTz2a1XiLlx9rbg8lJtcEvkUM/qdkc8felVq5K4Snhyo6yiCiAcvQ42ao69P
 tR02QcjMaw4ATZHgcZ40bfXF1Nhsa7CyO4HDCssn99weSTT82pZktr6PtJ31qpK4iTXi55
 aoHnhW64u2/57hxQGd+5EY4v+A4f3YM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-E-3rkRUzNcq5644LhscMrA-1; Fri, 16 Jun 2023 07:48:56 -0400
X-MC-Unique: E-3rkRUzNcq5644LhscMrA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A701185A792;
 Fri, 16 Jun 2023 11:48:56 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5571440C20F5;
 Fri, 16 Jun 2023 11:48:53 +0000 (UTC)
Date: Fri, 16 Jun 2023 13:48:51 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 05/12] hw/virtio: Add support for apple virtio-blk
Message-ID: <ZIxMIyi1KY7Ku9Xm@redhat.com>
References: <20230614224038.86148-1-graf>
 <20230614225626.97734-1-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614225626.97734-1-graf@amazon.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 15.06.2023 um 00:56 hat Alexander Graf geschrieben:
> Apple has its own virtio-blk PCI device ID where it deviates from the
> official virtio-pci spec slightly: It puts a new "apple type"
> field at a static offset in config space and introduces a new discard
> command.

In other words, it's a different device. We shouldn't try to
differentiate only with a property, but actually model it as a separate
device.

> This patch adds a new qdev property called "apple-type" to virtio-blk-pci.
> When that property is set, we assume the virtio-blk device is an Apple one
> of the specific type and act accordingly.

Do we have any information on what the number in "apple-type" actually
means or do we have to treat it as a black box?

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

Can we have a more descriptive name?

> +    {
> +        if (s->conf.x_apple_type) {
> +            /* Only valid on Apple Virtio */
> +            char buf[iov_size(in_iov, in_num)];
> +            memset(buf, 0, sizeof(buf));
> +            iov_from_buf(in_iov, in_num, 0, buf, sizeof(buf));
> +            virtio_blk_req_complete(req, VIRTIO_BLK_S_OK);

So this is a command that simply fills the guest buffer with zeros
without accessing the disk content? Weird, but ok, if that's what they
are doing...

The commit message talks about a discard command. I would have expected
a command that discards/unmaps data from the disk. I think it would be
good to call it something else in the commit message if it has nothing
to do with this.

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

Ideally, blkcfg would contain a union there. Since this is a type
imported from the kernel, we can't change it inside of QEMU only. Works
for me with this comment.

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

In a separate device, this would probably be called "apple-type"
(without "x-") like promised in the commit message?

If not, what is the reason for having an "x-" prefix?

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

Hm... The commit message says discard, this says write zeroes, and the
implementation seems to be read zeroes? I'm confused.

> +
>  #ifndef VIRTIO_BLK_NO_LEGACY
>  /* Barrier before this op. */
>  #define VIRTIO_BLK_T_BARRIER	0x80000000

Kevin


