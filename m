Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D71D756390
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 14:57:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLNgr-0002Wx-2x; Mon, 17 Jul 2023 08:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdu-0008Th-94
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:48:03 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLNdp-0008TZ-Nh
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 08:47:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31590e4e27aso4023989f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689598071; x=1692190071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fm7KSG5NrB8kIIZoFYKUbYE9OkMwBur5haFqwy0lLuU=;
 b=LBJBrnKHnBJ7Jkw/hZ3RoZkFVs/VVlV7w4myj8JMR/OTdeBvq0DGXU5/EPp41o3moW
 w/nYN3onsfgiCWPhIJ018C5usmnrjOf1O25YZMl1nyFp7Ug1wLxLm2V3i3geehqmIxt1
 3xmjFWZgq5pmXjK+xH/dh0XcWNgU3KEMSvdpchZFMm1TXBUD+/XgRbV9P0Nk194K9us6
 Uh97KEkYdQM3ujjIj8bMAzsfwADv7Z/vtJ5BvQjFyhY77ND5U4RtYjyRjbSK3g9MABM3
 mFp4XWU0nHCYKLqNaMByINTbMkH9+bG4kn1iMLO2f53uZzfMaLlRkqxxiJDlTdDqhvRM
 HrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689598071; x=1692190071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fm7KSG5NrB8kIIZoFYKUbYE9OkMwBur5haFqwy0lLuU=;
 b=GLGWefEueG6SVPtl+vHQHZCeFlmN6OZb7Ev4O+jqMKFbdkJvQ3J2ITouueDhBpzfpF
 WyzYo3HbBQSEp6ct2cergfZHMT0ylwqCT0u+1wCyiSQ6An6XvLJ/UiRX7RQuyCxkjgPr
 xV5xJ4I9S6eUc2cHMC8r7ioIm+K+kam4aw0B2+1X5y6DxL3Y2/+rLt8bbVKV/EiY2OFT
 uvqEVMFNqSOAtZJyaVNKAIxtuuoGDgnT7LT3CocFmMB5tj2JQxPcz4ttNVwDasgbMZ1y
 4eBJjZGZYc23aenQ89PKw4lhFfEanlCpAQrOzDjxp0qx3iTKGtHYJkdMVVOHQoL2p1WY
 96ig==
X-Gm-Message-State: ABy/qLbb8Uxis9d1hXkVH/c2P356pl9n4U1xKbgrJtfpCEDUdYmJ2IVe
 Z2BKKngSJtFUS3TVxgZMYCajDXQ5f+OFOGVl8po=
X-Google-Smtp-Source: APBJJlH0bVXCfop2RRBQYpyP9vhuUzMzvgePOOOv0zaS1utNMtdtHAlneFeWQ8c5K5/cYnlHI2LWAQ==
X-Received: by 2002:adf:d4c4:0:b0:313:e953:65d0 with SMTP id
 w4-20020adfd4c4000000b00313e95365d0mr9147896wrk.28.1689598070913; 
 Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d6790000000b003112ab916cdsm19337737wru.73.2023.07.17.05.47.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 05:47:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 7/7] hw/nvram: Avoid unnecessary Xilinx eFuse backstore write
Date: Mon, 17 Jul 2023 13:47:46 +0100
Message-Id: <20230717124746.759085-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717124746.759085-1-peter.maydell@linaro.org>
References: <20230717124746.759085-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Tong Ho <tong.ho@amd.com>

Add a check in the bit-set operation to write the backstore
only if the affected bit is 0 before.

With this in place, there will be no need for callers to
do the checking in order to avoid unnecessary writes.

Signed-off-by: Tong Ho <tong.ho@amd.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/nvram/xlnx-efuse.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index fdfffaab99c..655c40b8d1e 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -143,6 +143,8 @@ static bool efuse_ro_bits_find(XlnxEFuse *s, uint32_t k)
 
 bool xlnx_efuse_set_bit(XlnxEFuse *s, unsigned int bit)
 {
+    uint32_t set, *row;
+
     if (efuse_ro_bits_find(s, bit)) {
         g_autofree char *path = object_get_canonical_path(OBJECT(s));
 
@@ -152,8 +154,13 @@ bool xlnx_efuse_set_bit(XlnxEFuse *s, unsigned int bit)
         return false;
     }
 
-    s->fuse32[bit / 32] |= 1 << (bit % 32);
-    efuse_bdrv_sync(s, bit);
+    /* Avoid back-end write unless there is a real update */
+    row = &s->fuse32[bit / 32];
+    set = 1 << (bit % 32);
+    if (!(set & *row)) {
+        *row |= set;
+        efuse_bdrv_sync(s, bit);
+    }
     return true;
 }
 
-- 
2.34.1


