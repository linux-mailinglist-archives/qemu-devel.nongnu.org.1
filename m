Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34323815B78
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 20:57:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEalR-0005se-5b; Sat, 16 Dec 2023 14:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEalO-0005sU-Em
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:55:54 -0500
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEalM-0002ry-9l
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:55:54 -0500
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-a1ca24776c3so543548366b.0
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 11:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702756550; x=1703361350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FDOBzWC37ueuLCzo29zEpbtEFC5MaqDxE/ag/ZAo4Uc=;
 b=SS/Fs8k+z8av3KGAxNp74WAewT7YuHphIViPOo0Xfb3PTTPJwlhyBYZY3f1vtYs57E
 c6EvDWMCDeuzVpI62w+ecGMXZR8FjQUUOthmo6cqGiJLAgGQHLSO2/q6KZXvKViFaETb
 c5F3CCd6/KaAR7Tu6yolra+X6TEwyFWwgvoRkqv786NklG8MP0+D8e8E9Y6awW1tf4yE
 Ohqib66gac4k9EEty1ixKvmadvDaYFOtgqK4FolBiHxu+Z93/r9eWM/1Prry3gwLJjRP
 EW+vvpSzEwBnFNzX3+2OiUADoALEEFlFy7yypDlOoGQyeYp2bw59mmrQZ5uEsAQLVwoD
 tV7g==
X-Gm-Message-State: AOJu0YyZAFQiJATCV6M8X0mWQI1cMvHJZkK5qr17UIEQ0zP0BTXaMqBe
 hrWZmpVqXy6BzaZvSedSR2B0kO4M2po=
X-Google-Smtp-Source: AGHT+IFmC6IZbCLVK7umSXlA50W4xrZjI4oIgH4KAIz4r3aKhr6vkp5raOacXk+e7CvW7ozGPzOk1Q==
X-Received: by 2002:a17:906:dfda:b0:a1d:9f8f:e54b with SMTP id
 jt26-20020a170906dfda00b00a1d9f8fe54bmr15018519ejc.33.1702756549805; 
 Sat, 16 Dec 2023 11:55:49 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 cu1-20020a170906ba8100b00a1f65433d08sm12197080ejd.172.2023.12.16.11.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 11:55:49 -0800 (PST)
Date: Sat, 16 Dec 2023 20:55:47 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 05/12] next-cube.c: update and improve dma_ops
Message-ID: <20231216205547.1098e9e1@fedora>
In-Reply-To: <20231215200009.346212-6-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-6-mark.cave-ayland@ilande.co.uk>
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
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

Am Fri, 15 Dec 2023 20:00:02 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Rename dma_ops to next_dma_ops and the read/write functions to next_dma_read()
> and next_dma_write() respectively, mark next_dma_ops as DEVICE_BIG_ENDIAN and
> also improve the consistency of the val variable in next_dma_read() and
> next_dma_write().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 100 ++++++++++++++++++++++++++++----------------
>  1 file changed, 63 insertions(+), 37 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

