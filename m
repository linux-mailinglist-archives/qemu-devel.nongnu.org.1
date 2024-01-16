Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4622C82EF38
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 13:55:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPix3-0004QI-Ra; Tue, 16 Jan 2024 07:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rPix1-0004Pb-EI
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 07:53:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rPiwz-0004qJ-Kn
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 07:53:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-40e857ce803so4851675e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 04:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705409631; x=1706014431; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9aqK08wufU5uXoPLSqlNaOYiNFaqBwBPzJjyRb7+Gqs=;
 b=fYk0kVo1FY5beIVc523S55dC/hL8IsUg7seks/l5bjyidab1sKuj8Y22xl/DOu0XqG
 XfJQYYDVP6dUqP+bfGg0Ayc2HncU7zalYIKdclgyHcYGcJ03V89ApI6qKTJbSKAuM8a7
 OzqHnGsSLwi0a8Z6MmTtx115ZL3L85a23OfxfhBslMfqI4evhXRW3YR0koKRy274pTv5
 gvTvifBxe4J8HEX5ZTsQpyKHIXe1gEqr67M8DD3tGnnyIWcV9VHijcOx6ghlqKoX4YMm
 xIoJ1EkOL16FCsS2fmzo19vx5dcvXuRGRuO2k1Z4wnaYq1mnlKV+y8DeIktMAkX2v3fC
 g9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705409631; x=1706014431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aqK08wufU5uXoPLSqlNaOYiNFaqBwBPzJjyRb7+Gqs=;
 b=QYwrsZ0OYrNrG8Jsk76jBeJbBrUp/3vpyshjuZPgikung4LCaAvvKOYJB5685vsxL1
 COmf4Fw7LVfQIBLdaYuZOfNjfPSiTZ7qJi763siA7WnX0whxweGFz0Dei36fjeaALu+4
 euWT0zx6hrp/W5Da4ZXA9p1r4kQLVKZFoizweI8L9KbZzAHitv8RvwHHWV0VBNL7kKcc
 smi4i/oqR1+CRrNDWG55QyCKh5FtKaDMLePD/1tUmTnJEF8qxON5UessUXyyk+Z/KZnZ
 n5+zVAv9rwvcC/2OXQDWQ0zxtywHxVJkVgNEPjngwXMiLWKwLxJZ6bnoiq8wEJQZoWYB
 3g8Q==
X-Gm-Message-State: AOJu0YzsEWWcNInK65Jahf/HeaDQcQLFKKoh0qhs7l61XEE42xPUBJ/S
 E5cDesvyeO+FjPUVF4y/tL3mx5KRLeg7UQ==
X-Google-Smtp-Source: AGHT+IFs7RHM8bN9ESugov3Qa030SKGE6FmOl9EJqBKW85Jv50PZ9aV1nAWmfQVkTcyDuFddI88uOw==
X-Received: by 2002:a7b:c8cc:0:b0:40e:5327:91b4 with SMTP id
 f12-20020a7bc8cc000000b0040e532791b4mr3418376wml.222.1705409631093; 
 Tue, 16 Jan 2024 04:53:51 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 v13-20020a05600c444d00b0040e526bd5fdsm1264683wmn.1.2024.01.16.04.53.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 04:53:50 -0800 (PST)
Date: Tue, 16 Jan 2024 12:53:59 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, mst@redhat.com, clg@redhat.com,
 alex.williamson@redhat.com
Subject: Re: [PATCH] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Message-ID: <20240116125359.GA710190@myrica>
References: <20231221134505.100916-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221134505.100916-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Dec 21, 2023 at 08:45:05AM -0500, Eric Auger wrote:
> We used to set default page_size_mask to qemu_target_page_mask() but
> with VFIO assignment it makes more sense to use the actual host page mask
> instead.
> 
> So from now on qemu_real_host_page_mask() will be used as a default.
> To be able to migrate older code, we increase the vmstat version_id
> to 3 and if an older incoming v2 stream is detected we set the previous
> default value.
> 
> The new default is well adapted to configs where host and guest have
> the same page size. This allows to fix hotplugging VFIO devices on a
> 64kB guest and a 64kB host. This test case has been failing before
> and even crashing qemu with hw_error("vfio: DMA mapping failed,
> unable to continue") in VFIO common). Indeed the hot-attached VFIO
> device would call memory_region_iommu_set_page_size_mask with 64kB
> mask whereas after the granule was frozen to 4kB on machine init done.

I guess TARGET_PAGE_MASK is always 4kB on arm64 CPUs, since it's the
smallest supported and the guest configures its page size at runtime.
Even if QEMU's software IOMMU can deal with any page size, VFIO can't so
passing the host page size seems more accurate than forcing a value of
4kB.

> Now this works. However the new default will prevent 4kB guest on
> 64kB host because the granule will be set to 64kB which would be
> larger than the guest page size. In that situation, the virtio-iommu
> driver fails the viommu_domain_finalise() with
> "granule 0x10000 larger than system page zie 0x1000".

"size"
(it could matter if someone searches for this message later)

> 
> The current limitation of global granule in the virtio-iommu
> should be removed and turned into per domain granule. But
> until we get this upgraded, this new default is probably
> better because I don't think anyone is currently interested in
> running a 4kB page size guest with virtio-iommu on a 64kB host.
> However supporting 64kB guest on 64kB host with virtio-iommu and
> VFIO looks a more important feature.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

So to summarize the configurations that work for hotplug (tested with QEMU
system emulation with SMMU + QEMU VMM with virtio-iommu):

 Host | Guest | virtio-net | IGB passthrough
  4k  | 4k    | Y          | Y
  64k | 64k   | Y          | N -> Y (fixed by this patch)
  64k | 4k    | Y -> N     | N
  4k  | 64k   | Y          | Y

The change is a reasonable trade-off in my opinion. It fixes the more common
64k on 64k case, and for 4k on 64k, the error is now contained to the
guest and made clear ("granule 0x10000 larger than system page size
0x1000") instead of crashing the VMM. A guest OS now discovers that the
host needs DMA buffers aligned on 64k and could actually support this case
(but Linux won't because it can't control the origin of all DMA buffers).
Later, support for page tables will enable 4k on 64k for all devices.

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/virtio/virtio-iommu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 9d463efc52..b77e3644ea 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -1313,7 +1313,7 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>       * in vfio realize
>       */
>      s->config.bypass = s->boot_bypass;
> -    s->config.page_size_mask = qemu_target_page_mask();
> +    s->config.page_size_mask = qemu_real_host_page_mask();
>      s->config.input_range.end = UINT64_MAX;
>      s->config.domain_range.end = UINT32_MAX;
>      s->config.probe_size = VIOMMU_PROBE_SIZE;
> @@ -1491,13 +1491,16 @@ static int iommu_post_load(void *opaque, int version_id)
>       * still correct.
>       */
>      virtio_iommu_switch_address_space_all(s);
> +    if (version_id <= 2) {
> +        s->config.page_size_mask = qemu_target_page_mask();
> +    }
>      return 0;
>  }
>  
>  static const VMStateDescription vmstate_virtio_iommu_device = {
>      .name = "virtio-iommu-device",
>      .minimum_version_id = 2,
> -    .version_id = 2,
> +    .version_id = 3,
>      .post_load = iommu_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_GTREE_DIRECT_KEY_V(domains, VirtIOIOMMU, 2,
> -- 
> 2.27.0
> 

