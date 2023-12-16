Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E1815877
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 10:08:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEQeF-0001nB-Q3; Sat, 16 Dec 2023 04:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEQeC-0001mn-0T
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 04:07:48 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEQeA-0004bF-1a
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 04:07:47 -0500
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a1f47f91fc0so169064466b.0
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 01:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702717664; x=1703322464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjBwf5YIBGxHWcaArQFrXueP1pyE9pdZV/7Ybdy6yEo=;
 b=JfYoHoEiuYFNsjxAQgeON8LsiafPfStJoysTj5PkL8eRCe/yGBs/OR6I2o2K4z+XKD
 J7apdlxDID4H6/w0ioQJ7gV0L93wEap+82ZXFto0FnyqEY3Md6/L2O6SOkMWDAO89SqA
 KgLFdup3K1TfuqB4Qpb4M0rzJSbtaC9YRjsCGoN3TgnfJbR/ujqkwj5vnoPAJfR7ZUsO
 K3x2Ty151XM2kpA5xTH3iEFBnZZtXayR4kG0G/CBWtXnmEJvyexaxJwKX+jOBVKrYSJK
 W1/31RUaeJMu0v8vBVZw6MtptW6Q2HGeXKsa2lTtmgt3qFWZBlboAHLCF91WK1SbmjCJ
 gI9A==
X-Gm-Message-State: AOJu0Yzh2tQqq4kPGWE5Y+XReW0d7eb0HYr2G8kEpT3geNEhfTgaXX2S
 MrFK4yy2g56MkL0r8SqMT6k=
X-Google-Smtp-Source: AGHT+IHbHKUsszTlzjHL60qjtJ+CCeXTY1AtLS74zW1B0lRMKBMolNBXgJCTuEfwFXNMNBJorDXa6A==
X-Received: by 2002:a17:906:3289:b0:9c4:54c6:8030 with SMTP id
 9-20020a170906328900b009c454c68030mr6028664ejw.6.1702717664439; 
 Sat, 16 Dec 2023 01:07:44 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 rg14-20020a1709076b8e00b00a23002c8059sm4707771ejc.70.2023.12.16.01.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 01:07:43 -0800 (PST)
Date: Sat, 16 Dec 2023 10:07:42 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/12] next-cube.c: don't pulse SCSI DMA IRQ upon
 reception of FLUSH command
Message-ID: <20231216100742.0de18a1d@fedora>
In-Reply-To: <20231215200009.346212-3-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.218.45; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f45.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Am Fri, 15 Dec 2023 19:59:59 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Normally a DMA FLUSH command is used to ensure that data is completely written
> to the device and/or memory, so remove the pulse of the SCSI DMA IRQ if a DMA
> FLUSH command is received. This enables the NeXT ROM monitor to start to load
> from a SCSI disk.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index feeda23475..87ddaf4329 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -473,7 +473,6 @@ static void scr_writeb(NeXTPC *s, hwaddr addr, uint32_t value)
>              DPRINTF("SCSICSR FIFO Flush\n");
>              /* will have to add another irq to the esp if this is needed */
>              /* esp_puflush_fifo(esp_g); */
> -            qemu_irq_pulse(s->scsi_dma);
>          }
>  
>          if (value & SCSICSR_ENABLE) {

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

