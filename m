Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF49A7B4077
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 15:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmZxn-0007k9-C6; Sat, 30 Sep 2023 09:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxm-0007jt-2W
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:54 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qmZxU-0007fP-6c
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 09:24:53 -0400
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-99bdcade7fbso1972616866b.1
 for <qemu-devel@nongnu.org>; Sat, 30 Sep 2023 06:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696080273; x=1696685073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slz8qWjHNTG7InzTPdZXE1gby9QxHwRFl16WHX2T1IE=;
 b=gLKtHC7XxpWBia0CPPuDqoLpKbyJeYBDfQAS/xEvhFNwUHvoUYh/t8g1s/8D7Wvmay
 ii/6001bJjRH3nPnit64wA7nmIJ580+7noSDqIXP8Pgl1ftotJk4cfcEZ5XN7uPMlfq/
 dL6/nUFj1h73G9WcJ4lopFM2PiO9dq4hSkycPJL/casK2aQWp4w+Ahw8CI6/TwgAWt5C
 xGhJZVv7IsZYe3Z+k7SXLtx6mb4EaArGHW61P3Mkj4zpNjljbgK3UkUavAmaTrHkPnsG
 unLb0vGNk4G/RQ63mAVc4V31a1SzFAJuMh75HTx9RKiPw6Dzk7kH22nJolVEjNwCclNe
 mn6w==
X-Gm-Message-State: AOJu0Yyf5dmDheJNONEgH6Obq1e0dufOOAZ4EsAqPbQQoeVSwWIS8x12
 fo0e17Ta3UDl0TIsu6JC125JLo5pPao=
X-Google-Smtp-Source: AGHT+IFIzm9Dxwk0GmWXP19a/Sr06F0bi1sZtkbUJKKbtBKB45zLO9rDyPvgzu3bHLv6JM5HwcM/zg==
X-Received: by 2002:a17:906:2090:b0:9b2:8df4:f2de with SMTP id
 16-20020a170906209000b009b28df4f2demr6420953ejq.15.1696080273123; 
 Sat, 30 Sep 2023 06:24:33 -0700 (PDT)
Received: from fedora.. (ip-109-43-177-123.web.vodafone.de. [109.43.177.123])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a170906944f00b00993928e4d1bsm13919471ejx.24.2023.09.30.06.24.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Sep 2023 06:24:32 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 4/5] hw/m68k/next-cube: Remove unused NEXTDMA_EN code
Date: Sat, 30 Sep 2023 15:23:50 +0200
Message-ID: <20230930132351.30282-5-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230930132351.30282-1-huth@tuxfamily.org>
References: <20230930132351.30282-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_MSPIKE_H2=-0.708,
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

The network code should reside in a separate file, so remove the
related handlers from next-cube.c.

Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 50f2cd0c61..d9a0dca07f 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -589,8 +589,6 @@ static const MemoryRegionOps scr_ops = {
 
 #define NEXTDMA_SCSI(x)      (0x10 + x)
 #define NEXTDMA_FD(x)        (0x10 + x)
-#define NEXTDMA_ENTX(x)      (0x110 + x)
-#define NEXTDMA_ENRX(x)      (0x150 + x)
 #define NEXTDMA_CSR          0x0
 #define NEXTDMA_NEXT         0x4000
 #define NEXTDMA_LIMIT        0x4004
@@ -605,37 +603,6 @@ static void dma_writel(void *opaque, hwaddr addr, uint64_t value,
     NeXTState *next_state = NEXT_MACHINE(opaque);
 
     switch (addr) {
-    case NEXTDMA_ENRX(NEXTDMA_CSR):
-        if (value & DMA_DEV2M) {
-            next_state->dma[NEXTDMA_ENRX].csr |= DMA_DEV2M;
-        }
-
-        if (value & DMA_SETENABLE) {
-            /* DPRINTF("SCSI DMA ENABLE\n"); */
-            next_state->dma[NEXTDMA_ENRX].csr |= DMA_ENABLE;
-        }
-        if (value & DMA_SETSUPDATE) {
-            next_state->dma[NEXTDMA_ENRX].csr |= DMA_SUPDATE;
-        }
-        if (value & DMA_CLRCOMPLETE) {
-            next_state->dma[NEXTDMA_ENRX].csr &= ~DMA_COMPLETE;
-        }
-
-        if (value & DMA_RESET) {
-            next_state->dma[NEXTDMA_ENRX].csr &= ~(DMA_COMPLETE | DMA_SUPDATE |
-                                                  DMA_ENABLE | DMA_DEV2M);
-        }
-        /* DPRINTF("RXCSR \tWrite: %x\n",value); */
-        break;
-    case NEXTDMA_ENRX(NEXTDMA_NEXT_INIT):
-        next_state->dma[NEXTDMA_ENRX].next_initbuf = value;
-        break;
-    case NEXTDMA_ENRX(NEXTDMA_NEXT):
-        next_state->dma[NEXTDMA_ENRX].next = value;
-        break;
-    case NEXTDMA_ENRX(NEXTDMA_LIMIT):
-        next_state->dma[NEXTDMA_ENRX].limit = value;
-        break;
     case NEXTDMA_SCSI(NEXTDMA_CSR):
         if (value & DMA_DEV2M) {
             next_state->dma[NEXTDMA_SCSI].csr |= DMA_DEV2M;
@@ -692,15 +659,6 @@ static uint64_t dma_readl(void *opaque, hwaddr addr, unsigned int size)
     case NEXTDMA_SCSI(NEXTDMA_CSR):
         DPRINTF("SCSI DMA CSR READ\n");
         return next_state->dma[NEXTDMA_SCSI].csr;
-    case NEXTDMA_ENRX(NEXTDMA_CSR):
-        return next_state->dma[NEXTDMA_ENRX].csr;
-    case NEXTDMA_ENRX(NEXTDMA_NEXT_INIT):
-        return next_state->dma[NEXTDMA_ENRX].next_initbuf;
-    case NEXTDMA_ENRX(NEXTDMA_NEXT):
-        return next_state->dma[NEXTDMA_ENRX].next;
-    case NEXTDMA_ENRX(NEXTDMA_LIMIT):
-        return next_state->dma[NEXTDMA_ENRX].limit;
-
     case NEXTDMA_SCSI(NEXTDMA_NEXT):
         return next_state->dma[NEXTDMA_SCSI].next;
     case NEXTDMA_SCSI(NEXTDMA_NEXT_INIT):
-- 
2.41.0


