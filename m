Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED707D039E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:20:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaQU-0006By-TM; Thu, 19 Oct 2023 17:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQS-00069v-N9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:28 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtaQP-00052a-O3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:19:28 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a3b8b113so161635e87.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 14:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697750364; x=1698355164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Lio4zC7ynnNjMW2kZYKaezedA+r7hA/fsN71PY2N9w=;
 b=wHiAxBuqR+10D3wpJSd3ffGpJf72sIt+a1itOnMMwJsdKi0QQvEG3e+dlFjy/PLExM
 qLYG914sdcKgjSToc+aVELUZ7YvciXCqpiga5cylKxxbiJVpRzFi6F6JVHgKHF/EcUwZ
 ymT1816DoMrmUse5eT5FNITkGcSxamRg9ONAy84ulna+kjG2BX5f9PVM7Bmv06SfUPM+
 sxibP1zsICgD76YVcf1ISr/ookHr/6EkKsV2Ht68ulqlM9num3LUrHF0XoLZ/zAFgIod
 deZJWyzR9V4Ku0DSc+HzEZ2Rl38HsMJd9kKRLaCPUCQTgQ5oNwfVIibUAUzsfj144TBP
 2Dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697750364; x=1698355164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Lio4zC7ynnNjMW2kZYKaezedA+r7hA/fsN71PY2N9w=;
 b=Dm6g+Delsg0B9i9YjPeVgwVzhjTM6rOuj84whLx5PDuZoeTjvNqig9moMeeGgIzOoi
 aUILY5TmGDHhwOLSdMaTp3+TR3LhxW8LxNbI5AWFbDz022YUUP+9Yj3TrYmfW8O8jf/A
 7cIGPAyNpQPYMUO7nwCDIX+gAhqwgitOB2CMsn8x5kCn0VYp6MEjoQAlLtlb8mSCSvgv
 FcviVlZqIsunT/+mE03pTQwXDFoTbM22krxKoz79QtH3lMMIrEwdk42nDRnKxbJDnN3Y
 mSfIrkOiiaIJ0Mk5ySS2Y160Hp/XomzGvzPT4AJM1wAwoEclPXEubKAQdd5jVjig6ayc
 p16w==
X-Gm-Message-State: AOJu0Ywk9anxLzkij7lZcItLa74EWcu/JU+W2f/WDXV7Jc+tFyYhe4u2
 KoIshy+IZneUIsn+VSbfrHCkeKKENf69SIjB0OdAqw==
X-Google-Smtp-Source: AGHT+IEF96xSodiRVUgMqAgBjlpvFZlL4F5Uuj5irwJLda0jKnB34kPofQ8SrYYRHQXjWz0Td9OtCQ==
X-Received: by 2002:a05:6512:200c:b0:503:446:c7b0 with SMTP id
 a12-20020a056512200c00b005030446c7b0mr2202241lfb.32.1697750363711; 
 Thu, 19 Oct 2023 14:19:23 -0700 (PDT)
Received: from m1x-phil.lan (176-131-216-177.abo.bbox.fr. [176.131.216.177])
 by smtp.gmail.com with ESMTPSA id
 p15-20020a05600c1d8f00b00402d34ea099sm5359671wms.29.2023.10.19.14.19.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Oct 2023 14:19:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, Lu Gao <lu.gao@verisilicon.com>,
 Jianxian Wen <jianxian.wen@verisilicon.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>
Subject: [PULL 10/46] hw/sd/sdhci: Block Size Register bits [14:12] is lost
Date: Thu, 19 Oct 2023 23:17:35 +0200
Message-ID: <20231019211814.30576-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019211814.30576-1-philmd@linaro.org>
References: <20231019211814.30576-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Lu Gao <lu.gao@verisilicon.com>

Block Size Register bits [14:12] is SDMA Buffer Boundary, it is missed
in register write, but it is needed in SDMA transfer. e.g. it will be
used in sdhci_sdma_transfer_multi_blocks to calculate boundary_ variables.

Missing this field will cause wrong operation for different SDMA Buffer
Boundary settings.

Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
Fixes: dfba99f17f ("hw/sdhci: Fix DMA Transfer Block Size field")
Signed-off-by: Lu Gao <lu.gao@verisilicon.com>
Signed-off-by: Jianxian Wen <jianxian.wen@verisilicon.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-ID: <20220321055618.4026-1-lu.gao@verisilicon.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sdhci.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5564765a9b..40473b0db0 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -321,6 +321,8 @@ static void sdhci_poweron_reset(DeviceState *dev)
 
 static void sdhci_data_transfer(void *opaque);
 
+#define BLOCK_SIZE_MASK (4 * KiB - 1)
+
 static void sdhci_send_command(SDHCIState *s)
 {
     SDRequest request;
@@ -371,7 +373,8 @@ static void sdhci_send_command(SDHCIState *s)
 
     sdhci_update_irq(s);
 
-    if (!timeout && s->blksize && (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
+    if (!timeout && (s->blksize & BLOCK_SIZE_MASK) &&
+        (s->cmdreg & SDHC_CMD_DATA_PRESENT)) {
         s->data_count = 0;
         sdhci_data_transfer(s);
     }
@@ -406,7 +409,6 @@ static void sdhci_end_transfer(SDHCIState *s)
 /*
  * Programmed i/o data transfer
  */
-#define BLOCK_SIZE_MASK (4 * KiB - 1)
 
 /* Fill host controller's read buffer with BLKSIZE bytes of data from card */
 static void sdhci_read_block_from_card(SDHCIState *s)
@@ -1154,7 +1156,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             s->sdmasysad = (s->sdmasysad & mask) | value;
             MASKED_WRITE(s->sdmasysad, mask, value);
             /* Writing to last byte of sdmasysad might trigger transfer */
-            if (!(mask & 0xFF000000) && s->blkcnt && s->blksize &&
+            if (!(mask & 0xFF000000) && s->blkcnt &&
+                (s->blksize & BLOCK_SIZE_MASK) &&
                 SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
                 if (s->trnmod & SDHC_TRNS_MULTI) {
                     sdhci_sdma_transfer_multi_blocks(s);
@@ -1168,7 +1171,11 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         if (!TRANSFERRING_DATA(s->prnsts)) {
             uint16_t blksize = s->blksize;
 
-            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 12));
+            /*
+             * [14:12] SDMA Buffer Boundary
+             * [11:00] Transfer Block Size
+             */
+            MASKED_WRITE(s->blksize, mask, extract32(value, 0, 15));
             MASKED_WRITE(s->blkcnt, mask >> 16, value >> 16);
 
             /* Limit block size to the maximum buffer size */
-- 
2.41.0


