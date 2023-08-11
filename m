Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 460FE779410
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUlE-000571-SD; Fri, 11 Aug 2023 12:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUlC-00056r-QO
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:13:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUlB-00025T-9i
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DNmWhRk4TxTKGzH5CQdf1yBwnmfvshkqEAfHGtLnJrc=;
 b=KQGoT0Dd9Qn3atQvLd4RhHQmsyGtOGVPwqLHuBjeuUUpTPW2/mJhxSQZ5cNI2LvMxvZu/B
 6D1G5RIDFqXwvuduYJMFyW/UE34sYuqIb2JOOGuJLnGXcV8PT/j75AK1lPShts+I3sOV7Q
 eHzNMFkjyeKIo8hMrP5C6GGFe+u3yEQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-EoHeNSrtPuyZHotA1NHfmA-1; Fri, 11 Aug 2023 12:13:05 -0400
X-MC-Unique: EoHeNSrtPuyZHotA1NHfmA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fe3c8465e0so2246984e87.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770384; x=1692375184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNmWhRk4TxTKGzH5CQdf1yBwnmfvshkqEAfHGtLnJrc=;
 b=fgxEmjkJoXBxK0Fqc0DBbmHn2TE6AB2/Hifljf+EmUyzmN51fgv53kIJmxjh3orYkt
 7uB1GPyBBenp4yA6DMUVEMM8RSADE2/ajqDhX42hSWPfpzlPqqhTaNJBO/QzMAh3Op1N
 I5iDJjHrlbw9G5zH5dKkRq3PmEAVSM6vu48Dd6Z74mJTcZu/Jw1/k4tCcGtvwEVsIM5a
 kSTob8PurrbERKHjlo38CJJ24COmJK2lkI0ESFa4hWc5lz9bmRLKqrapK1fl+oNBnRwW
 ePdvqZd5vAFGCVaWj0Yh3cDtKfgNyIzXZWyWgpLzMszp1NMDDHgrvyBd+boCVrbTlYQR
 eJgA==
X-Gm-Message-State: AOJu0YySdrxD8xlP2V8om9rdljm/v9hhq4jSDWwK8AwQ6KyoMnniVUV1
 D0NmeJRkM0pGmoXWASs/yfoHyqsSnKfyAqxjGWRlvXBFDgzNXF16LO6comyop1uGNMc57VPeyAq
 ock9JvQHRwETw0m8=
X-Received: by 2002:ac2:4bc6:0:b0:4f9:58bd:9e5c with SMTP id
 o6-20020ac24bc6000000b004f958bd9e5cmr2268739lfq.3.1691770384392; 
 Fri, 11 Aug 2023 09:13:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa/mi+s4HnnkLVWPMMF/cFNifSwEKaIZY6zY8GeWSfVaDlNaBK0owVJOcdMwgjCwhoUPTP6Q==
X-Received: by 2002:ac2:4bc6:0:b0:4f9:58bd:9e5c with SMTP id
 o6-20020ac24bc6000000b004f958bd9e5cmr2268720lfq.3.1691770383938; 
 Fri, 11 Aug 2023 09:13:03 -0700 (PDT)
Received: from redhat.com ([2.55.27.97]) by smtp.gmail.com with ESMTPSA id
 n21-20020a05640204d500b005233885d0c6sm2199524edw.41.2023.08.11.09.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:13:03 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:12:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guoyi Tu <tugy@chinatelecom.cn>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 =?utf-8?B?6KKB5piO5rWp?= <yuanmh12@chinatelecom.cn>
Subject: Re: pci: Fix the update of interrupt disable bit in PCI_COMMAND
 register
Message-ID: <20230811120936-mutt-send-email-mst@kernel.org>
References: <ce2d0437-8faa-4d61-b536-4668f645a959@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce2d0437-8faa-4d61-b536-4668f645a959@chinatelecom.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 11, 2023 at 10:46:51PM +0800, Guoyi Tu wrote:
> The PCI_COMMAND register is located at offset 4 within
> the PCI configuration space and occupies 2 bytes. The
> interrupt disable bit is at the 10th bit, which corresponds
> to the byte at offset 5 in the PCI configuration space.
> 
> In our testing environment, the guest driver may directly
> updates the byte at offset 5 in the PCI configuration space.
> The backtrace looks like as following:
> #0  pci_default_write_config (d=0x5580bbfc6230, addr=5, val_in=5, l=1)
>     at hw/pci/pci.c:1442
> #1  0x00005580b8f3156a in virtio_write_config (pci_dev=0x5580bbfc6230,
> address=5, val=5, len=1)
>     at hw/virtio/virtio-pci.c:605
> #2  0x00005580b8ed2f3b in pci_host_config_write_common
> (pci_dev=0x5580bbfc6230, addr=5, limit=256,
>     val=5, len=1) at hw/pci/pci_host.c:81
> 
> In this situation, the range_covers_byte function called
> by the pci_default_write_config function will return false,
> resulting in the inability to handle the interrupt disable
> update event.
> 
> To fix this issue, we can use the ranges_overlap function
> instead of range_covers_byte to determine whether the interrupt
> bit has been updated.
> 
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>

Oh wow good catch!

Fixes: b6981cb57be5 ("pci: interrupt disable bit support")

clearly stable material too.


> ---
>  hw/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index b8d22e2e74..881d774fb6 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, uint32_t
> addr, uint32_t val_in, int
>          range_covers_byte(addr, l, PCI_COMMAND))
>          pci_update_mappings(d);
> 
> -    if (range_covers_byte(addr, l, PCI_COMMAND)) {
> +    if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
>          pci_update_irq_disabled(d, was_irq_disabled);
>          memory_region_set_enabled(&d->bus_master_enable_region,
>                                    (pci_get_word(d->config + PCI_COMMAND)
> -- 
> 2.27.0
> 
> --
> Guoyi


