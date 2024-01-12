Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44982C678
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 21:54:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOOW8-0005IN-5F; Fri, 12 Jan 2024 15:52:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOW0-0005I5-S0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:52:35 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>) id 1rOOVt-0007Jk-Ez
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 15:52:29 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e54d40cca2so57718197b3.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 12:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705092742; x=1705697542; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=4rmnGOERD90F4xyclAGtOl08/73Ma8yJ7ar/vBwuJhk=;
 b=mnF7DGWX1JYajzJOW5V96mRfhkE3gY7RBOEMv74cjxkr7rE6CCjK0s3y6gQhcE3Xhz
 xbhRtLhOXcLqpo79po7nwC7Zr56+ofWxvriZf+Mjbflyf3VxW5zXG95bOTnJmZBu1Xmd
 j9tD8nZMii9jMtdPKksoVsD9cnSNpMmxCsNQ19ukMFLmOvBFI4jFO7hsjqS3z55vc78Z
 uI07aVKCu57cNebz8PaWuySpJAvsg/bDx7UwCj/cC7dkUMtwrjYQz+Sc1Aa1EGJeZlLQ
 VHnkD1SbF97dKiSxBhoqz4p36/tz4IARAto4jPfISknLwjb5uq8nGEUtpeFTKmTPBx2H
 /1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705092742; x=1705697542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4rmnGOERD90F4xyclAGtOl08/73Ma8yJ7ar/vBwuJhk=;
 b=Bgccqp/uQk9ovysAD4RuaC58KRkA9H7LG/sV/u1ozuryK/FfuuVp0+knwT/j19UHf0
 lVXbs3vBlWdh542E4lwNuRtshq1slK5KYqHBJsUGPsghiS/PDAk3a0kNaggNOdQK+7Zi
 1EuMgHme3OoCqjEHljv6yNn3T9Cbhe9ntWbyqc8ZTeJEpsT/Csjw7OQuJUC+HB3Jgjfh
 IgBcoeYoKE/Pwp2QjVtdIfXt4hpWqSg5x8srTn3w3hS97ErIOgcoNmKtsQ8zTaMjGr7x
 iVFgSOb7zBGlYt9jkRm3dIeOk6uG0XQTTLIfQfY/C6MbKvUEIxu83D6GIJ3LSjku8mab
 w7Vg==
X-Gm-Message-State: AOJu0YxW48WnjnwXnSlax0OtBJxsbTVy0p49N61INBCTEtWK9x8pvjSs
 O9VxMeWDh72MW0BOPm1qWqc=
X-Google-Smtp-Source: AGHT+IHw/OcCCJF1VC2L07DIxsdekWnsc611UQsMfoilILbHW++j4PuRd7kT6hAcxtXo02T4x5Ngig==
X-Received: by 2002:a81:6c09:0:b0:5e8:e422:fa9b with SMTP id
 h9-20020a816c09000000b005e8e422fa9bmr1652280ywc.88.1705092741593; 
 Fri, 12 Jan 2024 12:52:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 x69-20020a0dd548000000b005f742b20f08sm1662407ywd.0.2024.01.12.12.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 12:52:20 -0800 (PST)
Date: Fri, 12 Jan 2024 12:52:18 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: pbonzini@redhat.com, fam@euphon.net, hpoussin@reactos.org,
 deller@gmx.de, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] esp-pci.c: use correct address register for PCI DMA
 transfers
Message-ID: <814cefe2-5793-452f-8618-8d43511732d5@roeck-us.net>
References: <20240112131529.515642-1-mark.cave-ayland@ilande.co.uk>
 <20240112131529.515642-2-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112131529.515642-2-mark.cave-ayland@ilande.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=groeck7@gmail.com; helo=mail-yw1-x112e.google.com
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

On Fri, Jan 12, 2024 at 01:15:26PM +0000, Mark Cave-Ayland wrote:
> The current code in esp_pci_dma_memory_rw() sets the DMA address to the value
> of the DMA_SPA (Starting Physical Address) register which is incorrect: this
> means that for each callback from the SCSI layer the DMA address is set back
> to the starting address.
> 
> In the case where only a single SCSI callback occurs (currently for transfer
> lengths < 128kB) this works fine, however for larger transfers the DMA address
> wraps back to the initial starting address, corrupting the buffer holding the
> data transferred to the guest.
> 
> Fix esp_pci_dma_memory_rw() to use the DMA_WAC (Working Address Counter) for
> the DMA address which is correctly incremented across multiple SCSI layer
> transfers.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  hw/scsi/esp-pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
> index 93b3429e0f..7117725371 100644
> --- a/hw/scsi/esp-pci.c
> +++ b/hw/scsi/esp-pci.c
> @@ -275,7 +275,7 @@ static void esp_pci_dma_memory_rw(PCIESPState *pci, uint8_t *buf, int len,
>          qemu_log_mask(LOG_UNIMP, "am53c974: MDL transfer not implemented\n");
>      }
>  
> -    addr = pci->dma_regs[DMA_SPA];
> +    addr = pci->dma_regs[DMA_WAC];
>      if (pci->dma_regs[DMA_WBC] < len) {
>          len = pci->dma_regs[DMA_WBC];
>      }
> -- 
> 2.39.2
> 

