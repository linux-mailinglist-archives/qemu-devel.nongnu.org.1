Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 180FF7B6AFB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 16:02:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnfxw-0004RW-Vn; Tue, 03 Oct 2023 10:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnfxt-0004R1-NA
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:01:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnfxq-0001UP-Pd
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 10:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696341688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jq9GPNXQxzHYYbaCq77DUNmQ27gaVVcisUa2cju/e4o=;
 b=Wqv1ppDoIeZ+wEcfNEr4d3JArV8R5WEOmIceoBH810JPtgxJh7iq/klAJh8YhnDhrXLxdC
 NKFmng6Ol9pu41RYx1fniu88yEy3mwt0mDgdcJPQnfkOdQa+5ZEgNn+nWfwVLL4JulIoY7
 SyJ4o1SG/Jhok5cFZ4wzCpuE6aUyRdE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-U5NflQ-sPgaWPS8lVoaOjw-1; Tue, 03 Oct 2023 10:01:25 -0400
X-MC-Unique: U5NflQ-sPgaWPS8lVoaOjw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-405535740d2so7311265e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 07:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696341684; x=1696946484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jq9GPNXQxzHYYbaCq77DUNmQ27gaVVcisUa2cju/e4o=;
 b=lV0boSMly/7eclcK/LNJgxEPUfvWvdxlU83c+lFS6AW4j09cbX7gqc8EcLPEXTHrB0
 U8wlTtRLro9YOOaWNZ1W7hFJBnBYnV0fOBrE2iHcTMqpCZvr25uVDuh6acGI2ppWwc7b
 FyWSBLjbz71XrJXqrHgXZ3bq57AdpnkVWEU7F8YgVoFrtrf9a/rpxQGuhmijJvpdcrmq
 9VFLK0iFz6MVXTe43UttH70uERvw1CsFFFudqG+20eiwHgP2IJoonK0aZAp2SfaAGiRT
 5xK2MTZxOv4Mk0zJqfNPFgexBYszqqREXTQhNksB0JyT8jj1LfgxY1kEVfEjZ1wzHEMK
 MQ/w==
X-Gm-Message-State: AOJu0Yy/xcjT0C3kcR5PPxPN3P3gchdgObQKZ3nvodtdh4FhVgadkRMx
 q9Gf4pwRjaGWsO0OGj1Lx1lSqr/01w2MtZeLODqJSSRQGGPzHmX+LhgHF8U0pSgKaWLxXGGq7UU
 /jg98NrZDly+aGgI=
X-Received: by 2002:a05:600c:3786:b0:405:359a:c965 with SMTP id
 o6-20020a05600c378600b00405359ac965mr13194441wmr.4.1696341684317; 
 Tue, 03 Oct 2023 07:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv+qtIqA9g8h7h20OODCW3EJ4aFxIGQJ6qbP7cNrhN3fbPuV7R4YJhzr8OQ0B7Gj/ssb+GCg==
X-Received: by 2002:a05:600c:3786:b0:405:359a:c965 with SMTP id
 o6-20020a05600c378600b00405359ac965mr13194361wmr.4.1696341682838; 
 Tue, 03 Oct 2023 07:01:22 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 t8-20020adff048000000b0031431fb40fasm1646922wro.89.2023.10.03.07.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 07:01:22 -0700 (PDT)
Date: Tue, 3 Oct 2023 10:01:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vhost: Perform memory section dirty scans once per
 iteration
Message-ID: <20231003095019-mutt-send-email-mst@kernel.org>
References: <20230927111428.15982-1-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927111428.15982-1-joao.m.martins@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Sep 27, 2023 at 12:14:28PM +0100, Joao Martins wrote:
> On setups with one or more virtio-net devices with vhost on,
> dirty tracking iteration increases cost the bigger the number
> amount of queues are set up e.g. on idle guests migration the
> following is observed with virtio-net with vhost=on:
> 
> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
> 
> With high memory rates the symptom is lack of convergence as soon
> as it has a vhost device with a sufficiently high number of queues,
> the sufficient number of vhost devices.
> 
> On every migration iteration (every 100msecs) it will redundantly
> query the *shared log* the number of queues configured with vhost
> that exist in the guest. For the virtqueue data, this is necessary,
> but not for the memory sections which are the same. So
> essentially we end up scanning the dirty log too often.
> 
> To fix that, select a vhost device responsible for scanning the
> log with regards to memory sections dirty tracking. It is selected
> when we enable the logger (during migration) and cleared when we
> disable the logger.
> 
> The real problem, however, is exactly that: a device per vhost worker/qp,
> when there should be a device representing a netdev (for N vhost workers).
> Given this problem exists for any Qemu these days, figured a simpler
> solution is better to increase stable tree's coverage; thus don't
> change the device model of sw vhost to fix this "over log scan" issue.
> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
> I am not fully sure the heuristic captures the myriad of different vhost
> devices -- I think so. IIUC, the log is always shared, it's just whether
> it's qemu head memory or via /dev/shm when other processes want to
> access it.

Thanks for working on this.

I don't think this works like this because different types of different
vhost devices have different regions - see e.g. vhost_region_add_section
I am also not sure all devices are running at the same time - e.g.
some could be disconnected, and vhost_sync_dirty_bitmap takes this
into account.

But the idea is I think a good one - I just feel more refactoring is
needed.

We also have a FIXME:

static void vhost_log_sync_range(struct vhost_dev *dev,
                                 hwaddr first, hwaddr last)
{   
    int i;
    /* FIXME: this is N^2 in number of sections */
    for (i = 0; i < dev->n_mem_sections; ++i) {
        MemoryRegionSection *section = &dev->mem_sections[i];
        vhost_sync_dirty_bitmap(dev, section, first, last);
    }
}       

that it would be nice to address. Thanks!


> ---
>  hw/virtio/vhost.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446b7..70646c2b533c 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -44,6 +44,7 @@
>  
>  static struct vhost_log *vhost_log;
>  static struct vhost_log *vhost_log_shm;
> +static struct vhost_dev *vhost_log_dev;
>  
>  static unsigned int used_memslots;
>  static QLIST_HEAD(, vhost_dev) vhost_devices =
> @@ -124,6 +125,21 @@ bool vhost_dev_has_iommu(struct vhost_dev *dev)
>      }
>  }
>  
> +static bool vhost_log_dev_enabled(struct vhost_dev *dev)
> +{
> +    return dev == vhost_log_dev;
> +}
> +
> +static void vhost_log_set_dev(struct vhost_dev *dev)
> +{
> +    vhost_log_dev = dev;
> +}
> +
> +static bool vhost_log_dev_is_set(void)
> +{
> +    return vhost_log_dev != NULL;
> +}
> +
>  static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>                                     MemoryRegionSection *section,
>                                     hwaddr first,
> @@ -141,13 +157,16 @@ static int vhost_sync_dirty_bitmap(struct vhost_dev *dev,
>      start_addr = MAX(first, start_addr);
>      end_addr = MIN(last, end_addr);
>  
> -    for (i = 0; i < dev->mem->nregions; ++i) {
> -        struct vhost_memory_region *reg = dev->mem->regions + i;
> -        vhost_dev_sync_region(dev, section, start_addr, end_addr,
> -                              reg->guest_phys_addr,
> -                              range_get_last(reg->guest_phys_addr,
> -                                             reg->memory_size));
> +    if (vhost_log_dev_enabled(dev)) {
> +        for (i = 0; i < dev->mem->nregions; ++i) {
> +            struct vhost_memory_region *reg = dev->mem->regions + i;
> +            vhost_dev_sync_region(dev, section, start_addr, end_addr,
> +                                  reg->guest_phys_addr,
> +                                  range_get_last(reg->guest_phys_addr,
> +                                                 reg->memory_size));
> +        }
>      }
> +
>      for (i = 0; i < dev->nvqs; ++i) {
>          struct vhost_virtqueue *vq = dev->vqs + i;
>  
> @@ -943,6 +962,19 @@ static int vhost_dev_set_log(struct vhost_dev *dev, bool enable_log)
>              goto err_vq;
>          }
>      }
> +
> +    /*
> +     * During migration devices can't be removed, so we at log start
> +     * we select our vhost_device that will scan the memory sections
> +     * and skip for the others. This is possible because the log is shared
> +     * amongst all vhost devices.
> +     */
> +    if (enable_log && !vhost_log_dev_is_set()) {
> +        vhost_log_set_dev(dev);
> +    } else if (!enable_log) {
> +        vhost_log_set_dev(NULL);
> +    }
> +
>      return 0;
>  err_vq:
>      for (; i >= 0; --i) {
> -- 
> 2.39.3


