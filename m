Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6448882C679
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 21:54:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOWF-0005Is-3n; Fri, 12 Jan 2024 15:52:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOWA-0005Ik-8b
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:52:42 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOW8-0007Kf-Lq
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:52:42 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-dbe78430946so6146036276.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 12:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705092759; x=1705697559; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=luIW2RT4CRd8asoVBoSr9vaj0NpvkwoWvvq2cAYhAWg=;
 b=e9FWKAjIhmCI+mXhX/Z94Dj2ZLs5GvdcJAw8MHkhCvEOAydBPLvlCC2ZU8A8/14qWO
 n9ONTPXjcV7b33wjXlqYqcy5dRgTnJW09rnZefI8NbPSLOnhXf9Yq0XqL6In9k2u9GwW
 bkMw5+krT3g6vSJ5mSN639mIWWmd8UIPR99v1Q1WfZW0tQt4LdSzcat7Q39rfVWyWO6N
 PpXJcZcPOUTyCD+rqqUHlRMXkdIIJt4i61c3FjWrSB2IKrw+O4Zr9f1ldnjX8PXKEvqb
 CclQvRqjBPufKEzuliBfJG6tg2kR7flKMEF1Q4+3WWsRC4SWoFn1Q+eKvQM3GuriTchC
 ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705092759; x=1705697559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=luIW2RT4CRd8asoVBoSr9vaj0NpvkwoWvvq2cAYhAWg=;
 b=J3RvD7LZbwYuBdi+1YHb40+77ykk5yphTXimIU14ewzW9cKQM1ekCYrgkiyJFU6lNG
 qLj2n/GX5Z7boafLujEkEvr3t4MwFt8TbfVW6ElL3zE6KyO+WGa9kOp/mcBLbLhJwJal
 ZiFCQGnpg3ss/ugb7z0E+EBMjYvgPtbMbTaVmKJmDL7UAzQctffYgEKSceLnDBMtcTbP
 5Se9kvTaBZdWF0FCZQgKMuRPG+OPP1ESUnH/aEzWjPJVd8QP35ghrOPfb8XmW6qO1+pw
 oiOeY/rdZEi+cfnwBGGL2tP7HX0nepCtKxWrkaWIELU1dOZOt2ZD4MccDiCXB4BOcAFm
 PBNA==
X-Gm-Message-State: AOJu0YxSN6TstBE2fN6R17pbfdI7GBjsVAkIINCvNuQxVEzsWIj0CIYm
 1NTyIYtPZxdtK/Pz+Q7mB6M=
X-Google-Smtp-Source: AGHT+IHkXFx39W+ChPSfP1R8Zs0K3J+mtiKpIXcod9hiwxJvW6jYuwlUjKPYw03guu2ehCTIoO4oDA==
X-Received: by 2002:a05:6902:2211:b0:dbe:a328:3ef9 with SMTP id
 dm17-20020a056902221100b00dbea3283ef9mr1313048ybb.78.1705092759437; 
 Fri, 12 Jan 2024 12:52:39 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a252e46000000b00dbd97f482c6sm1458852ybn.39.2024.01.12.12.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 12:52:39 -0800 (PST)
Date: Fri, 12 Jan 2024 12:52:37 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/4] esp-pci.c: generate PCI interrupt from separate ESP
 and PCI sources
Message-ID: <f96907b5-63da-4d84-bd62-291dd404ac4f@roeck-us.net>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
 <20240112131529.515642-3-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112131529.515642-3-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=groeck7@gmail.com; helo=mail-yb1-xb2c.google.com
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

On Fri, Jan 12, 2024 at 01:15:27PM +0000, Mark Cave-Ayland wrote:
> The am53c974/dc390 PCI interrupt has two separate sources: the first is from the
> internal ESP device, and the second is from the PCI DMA transfer logic.
> 
> Update the ESP interrupt handler so that it sets DMA_STAT_SCSIINT rather than
> driving the PCI IRQ directly, and introduce a new esp_pci_update_irq() function
> to generate the correct PCI IRQ level. In particular this fixes spurious interrupts
> being generated by setting DMA_STAT_DONE at the end of a transfer if DMA_CMD_INTE_D
> isn't set in the DMA_CMD register.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/scsi/esp-pci.c | 32 +++++++++++++++++++++++++++-----
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index 7117725371..15dc3c004d 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -77,6 +77,29 @@ struct PCIESPState {
>      ESPState esp;
>  };
>  
> +static void esp_pci_update_irq(PCIESPState *pci)
> +{
> +    int scsi_level = !!(pci->dma_regs[DMA_STAT] & DMA_STAT_SCSIINT);
> +    int dma_level = (pci->dma_regs[DMA_CMD] & DMA_CMD_INTE_D) ?
> +                    !!(pci->dma_regs[DMA_STAT] & DMA_STAT_DONE) : 0;
> +    int level = scsi_level || dma_level;
> +
> +    pci_set_irq(PCI_DEVICE(pci), level);
> +}
> +
> +static void esp_irq_handler(void *opaque, int irq_num, int level)
> +{
> +    PCIESPState *pci = PCI_ESP(opaque);
> +
> +    if (level) {
> +        pci->dma_regs[DMA_STAT] |= DMA_STAT_SCSIINT;
> +    } else {
> +        pci->dma_regs[DMA_STAT] &= ~DMA_STAT_SCSIINT;
> +    }
> +
> +    esp_pci_update_irq(pci);
> +}
> +
>  static void esp_pci_handle_idle(PCIESPState *pci, uint32_t val)
>  {
>      ESPState *s = &pci->esp;
> @@ -151,6 +174,7 @@ static void esp_pci_dma_write(PCIESPState *pci, uint32_t saddr, uint32_t val)
>              /* clear some bits on write */
>              uint32_t mask = DMA_STAT_ERROR | DMA_STAT_ABORT | DMA_STAT_DONE;
>              pci->dma_regs[DMA_STAT] &= ~(val & mask);
> +            esp_pci_update_irq(pci);
>          }
>          break;
>      default:
> @@ -161,17 +185,14 @@ static void esp_pci_dma_write(PCIESPState *pci, uint32_t saddr, uint32_t val)
>  
>  static uint32_t esp_pci_dma_read(PCIESPState *pci, uint32_t saddr)
>  {
> -    ESPState *s = &pci->esp;
>      uint32_t val;
>  
>      val = pci->dma_regs[saddr];
>      if (saddr == DMA_STAT) {
> -        if (s->rregs[ESP_RSTAT] & STAT_INT) {
> -            val |= DMA_STAT_SCSIINT;
> -        }
>          if (!(pci->sbac & SBAC_STATUS)) {
>              pci->dma_regs[DMA_STAT] &= ~(DMA_STAT_ERROR | DMA_STAT_ABORT |
>                                           DMA_STAT_DONE);
> +            esp_pci_update_irq(pci);
>          }
>      }
>  
> @@ -350,6 +371,7 @@ static void esp_pci_command_complete(SCSIRequest *req, size_t resid)
>      esp_command_complete(req, resid);
>      pci->dma_regs[DMA_WBC] = 0;
>      pci->dma_regs[DMA_STAT] |= DMA_STAT_DONE;
> +    esp_pci_update_irq(pci);
>  }
>  
>  static const struct SCSIBusInfo esp_pci_scsi_info = {
> @@ -386,7 +408,7 @@ static void esp_pci_scsi_realize(PCIDevice *dev, Error **errp)
>                            "esp-io", 0x80);
>  
>      pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &pci->io);
> -    s->irq = pci_allocate_irq(dev);
> +    s->irq = qemu_allocate_irq(esp_irq_handler, pci, 0);
>  
>      scsi_bus_init(&s->bus, sizeof(s->bus), d, &esp_pci_scsi_info);
>  }
> -- 
> 2.39.2
> 

