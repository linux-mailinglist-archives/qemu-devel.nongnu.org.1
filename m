Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3B774E131
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 00:33:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzOg-0005hM-95; Mon, 10 Jul 2023 18:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOT-0005Lt-Pd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:30:11 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qIzOQ-0002Qj-CI
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 18:30:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc656873eso63886495e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 15:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689028204; x=1691620204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yijSgmGH6Oo6rFXhTFj5oyPztYxt45G89j4AU83zdDI=;
 b=jPUuqUkLXcZwdFCESnFiL30uQiuqYh7B7F6YuPqfGAquhVNNml/KDjkCkxPPDb9R7h
 3CPaWuDExgTf78wH5rbLBBk0ovPFsYAHTBB77Lt7WyjGxG7tIAKf9vUYBZ+01zUA/5sj
 equLZGfJdBxmrbdq8BpE+MBJ28cKdgUTyvclLbIJOFKjJFS00XQZFzdUnNqtgUX/PqAJ
 4jQoWYUd35ZSp84IgBK54a6CjJqO574l1iEHf00G9cSOkUV8prLaHb5ePFKxxmrqulAc
 V5z+Q1HyZZTITUBpTOasjlc9P+lL/ASiCySclNmZGnqc565j7eLrjiCB1xlVwuT+mx6M
 jUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689028204; x=1691620204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yijSgmGH6Oo6rFXhTFj5oyPztYxt45G89j4AU83zdDI=;
 b=ZklOQkps+OK5oYiyuviKEaGGA2RPL6mCzpMkBtM4gBQhido4h5WmAhm6ohnOJ+ft2E
 DUC/Hmi7YujgU9eW32ObAbzKKz46lZBc+Y8zObAbBvVevWUvKfw4LQHZsqiMRMCXCLAj
 7PXH+biczrj+RPEN4dWHpmK0pXvgQotsxEYtE5qd2ew5kUR87v8yWC4qAvjqf+74j3uA
 OGdFnrKfWO8eUwlibgLuI1oAJMC6y0Zv/4XtM10pGmHJ/e7gV7L5ZUGhELeGHsD5EjpQ
 ZEqSUsVr64IYN8Ud7sc9cHANOoUdklgl3n0DQ03kdkGM4SQyoWji5cpWS/IB4P2xT0B+
 2jlw==
X-Gm-Message-State: ABy/qLZI+pJDFKtnJINUu+2JTsyT1/Hh6R0ANGB2chUd8jJN8qipo2C0
 U++YrY6ORahiZ074lXOphYN9FfnsRf/i14cD7vbLgg==
X-Google-Smtp-Source: APBJJlGfG37etN/3QScSFj7RuizgnIyn83vNXa6Oq4NBzcgV3mPEbkfJfibffh3JtoCQwcQF2OMXTQ==
X-Received: by 2002:a1c:7404:0:b0:3fb:424b:ef6e with SMTP id
 p4-20020a1c7404000000b003fb424bef6emr15816852wmc.23.1689028204092; 
 Mon, 10 Jul 2023 15:30:04 -0700 (PDT)
Received: from m1x-phil.lan (mst45-h01-176-184-47-225.dsl.sta.abo.bbox.fr.
 [176.184.47.225]) by smtp.gmail.com with ESMTPSA id
 j8-20020adfe508000000b0031424950a99sm520227wrm.81.2023.07.10.15.30.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Jul 2023 15:30:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Siarhei Volkau <lis8215@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PULL 43/44] hw/ide/pci: Replace some magic numbers by constants
Date: Tue, 11 Jul 2023 00:26:10 +0200
Message-Id: <20230710222611.50978-44-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230710222611.50978-1-philmd@linaro.org>
References: <20230710222611.50978-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-Id: <20230531211043.41724-7-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.38.1


