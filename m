Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455382C677
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 21:54:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOWR-0005KC-2X; Fri, 12 Jan 2024 15:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOWP-0005K4-Oa
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:52:57 -0500
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOWO-0007S9-4E
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:52:57 -0500
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-db4364ecd6aso5225160276.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 12:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705092775; x=1705697575; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=a0m+Oud9m7uxtHVFUb7jrQ4JPyahkzhBPmawrOgrbOc=;
 b=cXovyHeR8ycQSVtqBU5+5RaXjYyVJxJHLObA8Y+MQ6Q1T1j3Q1RPSi3MnU2SCTDQF3
 9UjytfpEee+iHI/+AcOQDc+C/5EHDuqXNc6yQTMyP9A+Gt1lLVl8ZnjqcLEkJXB9CgLr
 VxOjhVhfOyn0Nllzx6thLBnA38nV90i/bBXosLPiCQtZJMztSlSo/YncdD4mlZD69Q7Q
 ihrDsHzG1d7sEQWCtrixejA93r871QCB9Qcu1cxf0bpQcteJu5Zrbl++70xKe4XdRdY0
 iO4jy4wcbFVAodT6guGQSoPz448hn8DkkFY51hwdJ3u1Ol96T3vxyqwAj3W11TwBjOXS
 EABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705092775; x=1705697575;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a0m+Oud9m7uxtHVFUb7jrQ4JPyahkzhBPmawrOgrbOc=;
 b=Sm+QzEo28GFztFtSBBuPgUPueATq88KBollMBZkAozRpu9T+73zXUH/N3IpMP9oC7e
 7r3XAOcU6lWGTj1r6tT1XLFWIr8fuPaul5NpIrz3bT5eENszClLeoxHzmg6Ygv3se+E3
 tpS41jy7rFYp/pPubS5sQdcCL+bHIkJV0gAvyfXEtWcA7v6+5sl0r8V1RNM+N54QWd27
 gfEskV6Jv+umR2AbktuUOqwOQZsqsmyrLMm/En3WoskLm5T6YCD8ZQK1ORzAYfYynSfh
 16463wB8jNNBuD8z5adRJfvazKMtwrLgAddCim36JXrywQWE6gjdvaicZ4X1eRB9UEBZ
 3U2w==
X-Gm-Message-State: AOJu0YzepfD17eZLyq4ajbWczVxYIkpn9VUAl4wTPWAY2nyNr8xdb7lG
 LafCzAVOTAjU7Eo1un4p4D8=
X-Google-Smtp-Source: AGHT+IHkDm0Y12hEaU1gP+7pt38S+7ejEGV49sSDlq1BAoAKdMNZPolLduuUTqUFy8GYkx/XUzVbYw==
X-Received: by 2002:a25:2d1b:0:b0:dbd:2a5f:6a96 with SMTP id
 t27-20020a252d1b000000b00dbd2a5f6a96mr962011ybt.80.1705092774629; 
 Fri, 12 Jan 2024 12:52:54 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a258e90000000b00db41482d349sm1457301ybl.57.2024.01.12.12.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 12:52:54 -0800 (PST)
Date: Fri, 12 Jan 2024 12:52:53 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/4] esp-pci.c: synchronise setting of DMA_STAT_DONE with
 ESP completion interrupt
Message-ID: <34ba2dd7-60a7-4b03-bdee-63422f2f1e74@roeck-us.net>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
 <20240112131529.515642-4-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112131529.515642-4-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=groeck7@gmail.com; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jan 12, 2024 at 01:15:28PM +0000, Mark Cave-Ayland wrote:
> The setting of DMA_STAT_DONE at the end of a DMA transfer can be configured to
> generate an interrupt, however the Linux driver manually checks for DMA_STAT_DONE
> being set and if it is, considers that a DMA transfer has completed.
> 
> If DMA_STAT_DONE is set but the ESP device isn't indicating an interrupt then
> the Linux driver considers this to be a spurious interrupt. However this can
> occur in QEMU as there is a delay between the end of DMA transfer where
> DMA_STAT_DONE is set, and the ESP device raising its completion interrupt.
> 
> This appears to be an incorrect assumption in the Linux driver as the ESP and
> PCI DMA interrupt sources are separate (and may not be raised exactly
> together), however we can work around this by synchronising the setting of
> DMA_STAT_DONE at the end of a DMA transfer with the ESP completion interrupt.
> 
> In conjunction with the previous commit Linux is now able to correctly boot
> from an am53c974 PCI SCSI device on the hppa C3700 machine without emitting
> "iget: checksum invalid" and "Spurious irq, sreg=10" errors.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/scsi/esp-pci.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index 15dc3c004d..875a49199d 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -93,6 +93,18 @@ static void esp_irq_handler(void *opaque, int irq_num, int level)
>  
>      if (level) {
>          pci->dma_regs[DMA_STAT] |= DMA_STAT_SCSIINT;
> +
> +        /*
> +         * If raising the ESP IRQ to indicate end of DMA transfer, set
> +         * DMA_STAT_DONE at the same time. In theory this should be done in
> +         * esp_pci_dma_memory_rw(), however there is a delay between setting
> +         * DMA_STAT_DONE and the ESP IRQ arriving which is visible to the
> +         * guest that can cause confusion e.g. Linux
> +         */
> +        if ((pci->dma_regs[DMA_CMD] & DMA_CMD_MASK) == 0x3 &&
> +            pci->dma_regs[DMA_WBC] == 0) {
> +                pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
> +        }
>      } else {
>          pci->dma_regs[DMA_STAT] &= ~DMA_STAT_SCSIINT;
>      }
> @@ -306,9 +318,6 @@ static void esp_pci_dma_memory_rw(PCIESPState *pci, uint8_t *buf, int len,
>      /* update status registers */
>      pci->dma_regs[DMA_WBC] -= len;
>      pci->dma_regs[DMA_WAC] += len;
> -    if (pci->dma_regs[DMA_WBC] == 0) {
> -        pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
> -    }
>  }
>  
>  static void esp_pci_dma_memory_read(void *opaque, uint8_t *buf, int len)
> @@ -363,24 +372,13 @@ static const VMStateDescription vmstate_esp_pci_scsi = {
>      }
>  };
>  
> -static void esp_pci_command_complete(SCSIRequest *req, size_t resid)
> -{
> -    ESPState *s = req->hba_private;
> -    PCIESPState *pci = container_of(s, PCIESPState, esp);
> -
> -    esp_command_complete(req, resid);
> -    pci->dma_regs[DMA_WBC] = 0;
> -    pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
> -    esp_pci_update_irq(pci);
> -}
> -
>  static const struct SCSIBusInfo esp_pci_scsi_info = {
>      .tcq = false,
>      .max_target = ESP_MAX_DEVS,
>      .max_lun = 7,
>  
>      .transfer_data = esp_transfer_data,
> -    .complete = esp_pci_command_complete,
> +    .complete = esp_command_complete,
>      .cancel = esp_request_cancelled,
>  };
>  
> -- 
> 2.39.2
> 

