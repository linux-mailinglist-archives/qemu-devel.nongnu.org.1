Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F40718BA8
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 23:13:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4T61-0006ZJ-5W; Wed, 31 May 2023 17:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5z-0006Wn-Iz; Wed, 31 May 2023 17:11:03 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1q4T5x-0001Fh-WD; Wed, 31 May 2023 17:11:03 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-96f850b32caso1144536766b.3; 
 Wed, 31 May 2023 14:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685567459; x=1688159459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H90sgk3WC/XQ/9Jrgh7iCqYbg+Taj+LBMBbHKL3UVtc=;
 b=V0piHODu2BjKY/kaVSbKionWfSgCvSpp0Y2oqEmUDzNNBe1lQK7VgEZmB/cNA02ohs
 H2jDVdJnwHpdRu+o//XIUKypoSQKeIqCFJM63MwZyGwCtSFCTPybXzBA1v/DllpUS/D4
 q7UIzHXHzhd9Ica6B73Rm4Qw5wkjruhlX03OEg6XNJVueqlOpttcvAzHZgrfrbASeCeB
 C8oJ7Ot32z3wXwk2l5ItubvPJlFe+T33/6eXu2PykfLVpB5C2Fh//dg4S2RuOrCOdJO6
 tG/abR411woxr0zLlSQrevrZ3xJEoeXjr+84jvCcehhUOCwqaqoinu3zuDTJNZDZSdFq
 0RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685567459; x=1688159459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H90sgk3WC/XQ/9Jrgh7iCqYbg+Taj+LBMBbHKL3UVtc=;
 b=dL97EFdJOWtX61FPh+KnM57fKOCZaOtqqt2DoIsc1eemUEJ5euuu0Xq2QPw7OB1bLP
 GQu4zSdnb8CfdLRjEjULo9SRiCk6UMVOHej6+P/t8oeEDIhhDOgMcPhwPFTxRewTV4RQ
 VkJTNNqLpEoSkVmFXRik/U5aFavcs0LQxJf3OmDk0zHvTQhZN379qYnzlvEFm2bkLY8x
 KRcD4ALOn3lT9N07Evjpwa18SBpHwtwEWDIdlArOfO304In7cQgCcuK2k5hzjhuj3MwI
 HakwcwI6zKPrq1QL1cXwjdjU08OXHiVu4K+kPiCa2GSo/Bkfc704dpjgvxQnXsks/Ti9
 iupg==
X-Gm-Message-State: AC+VfDy2+gqMzEwLSS2rujwo0Y/zTTudRp4GJNTQwgLd3jtgIxM4ktgy
 uksv41l64DzffAlYhd6Du/YbwiQpqyg=
X-Google-Smtp-Source: ACHHUZ7jAQLMsC3XZEz4roXLdcQwVNQDr8XqFSYKFCoTruu1r/LOpTtJFjoGTSh+GQhRIdepyx53rg==
X-Received: by 2002:a17:907:7ba7:b0:974:1f8f:89d7 with SMTP id
 ne39-20020a1709077ba700b009741f8f89d7mr6777727ejc.31.1685567459396; 
 Wed, 31 May 2023 14:10:59 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-078-054-159-078.78.54.pool.telefonica.de. [78.54.159.78])
 by smtp.gmail.com with ESMTPSA id
 b8-20020a1709064d4800b00965f31ff894sm9463054ejv.137.2023.05.31.14.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 14:10:58 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 6/7] hw/ide/pci: Replace some magic numbers by constants
Date: Wed, 31 May 2023 23:10:42 +0200
Message-Id: <20230531211043.41724-7-shentey@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531211043.41724-1-shentey@gmail.com>
References: <20230531211043.41724-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ide/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 0b26a4ce9f..a25b352537 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -320,7 +320,8 @@ void bmdma_cmd_writeb(BMDMAState *bm, uint32_t val)
 
 void bmdma_status_writeb(BMDMAState *bm, uint32_t val)
 {
-    bm->status = (val & 0x60) | (bm->status & 1) | (bm->status & ~val & 0x06);
+    bm->status = (val & 0x60) | (bm->status & BM_STATUS_DMAING)
+                 | (bm->status & ~val & (BM_STATUS_ERROR | BM_STATUS_INT));
 }
 
 static uint64_t bmdma_addr_read(void *opaque, hwaddr addr,
-- 
2.40.1


