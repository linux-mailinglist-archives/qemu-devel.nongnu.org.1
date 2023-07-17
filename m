Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F91075685D
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 17:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQXO-0006hg-Ki; Mon, 17 Jul 2023 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLQXM-0006hP-IL
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:53:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLQXJ-0002Qe-SK
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 11:53:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so46405845e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 08:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689609199; x=1692201199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WL7MtrxQXeMbdKmKMFYZi+llgqc1OhOhtC1FcVio2QA=;
 b=ypn1uEoDXQAquJ5pGuhITMulIajFf5zUKNFAq2QPQrlC2AfuV53+xhrTTTn2pRyHyK
 aeyN74v7wRZq79kkcBsFt+j7Qzmsh+GylQn0IHxvH8N1/Suse09FRjIpcA62ja9O2GMi
 /2GbXnTMzo/IettSw/wN/LGpwiNzFh97dIMVOmOFjRoYU/U0K4UmJJd9aWkDSOir0LQr
 OEklcSF9vgwJWlYQpNKcnGlov4onkRJ8s4u09frl3/FlGZNJlZRft/qHHZGgtLlh50UY
 olcdPQMUI4AKvB7Hv/Y/ePvT/I8MeQFD/jqhnyixllW79fZp6b/yssWDl5wJFJ5v967Q
 oq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689609199; x=1692201199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WL7MtrxQXeMbdKmKMFYZi+llgqc1OhOhtC1FcVio2QA=;
 b=HqqR/KvPWcutS8TSXQMglgdsMMb4IeomMpmTxOh/jAH+t5j0tm4JW1oiQ2MaJ8uAFB
 kOKCyYzEfSO3l1hIWzjp9NoP4UH9JBf1RcTJayf4dNzQvsIfYfkrSZA7ifDEfYBGydec
 ZUg4OjmNO2Gh3/TqC+f3ctzW5F2mmwBiUNXtW0gpf+DvtGCU0Mj7Yd9z1B/TWzGUvDSW
 OH5lkEe0Ri7SDhUnFb1la+96/ri2UiOiHMQJZ11nxc9DYGAXDVALWAy4+kV5fvhu0OfQ
 8veR2fdF0Ej54A3Kw+8nCR7KAEHeeL9vZYbSn53bQ9xc1bYcT/2tYRq0FT6idRveom1a
 OwcQ==
X-Gm-Message-State: ABy/qLYIropaBB8ttsCyct4GtyaURI1xVKVV1qq7cvtCnxVEls+w/XfT
 8gA0J2wFp1/8WHd7E5u2G3e/sB8jNv0XMcVYPis=
X-Google-Smtp-Source: APBJJlFNUwDTfD0v56Q+bNx/+i7x/xF4WyW94x770iIKuDWL71QGFq//PZnrgTp+TWv3QiXMCJnOaw==
X-Received: by 2002:a5d:6850:0:b0:314:53a4:2d3f with SMTP id
 o16-20020a5d6850000000b0031453a42d3fmr11362376wrw.63.1689609199542; 
 Mon, 17 Jul 2023 08:53:19 -0700 (PDT)
Received: from localhost.localdomain ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a5d684e000000b003145559a691sm19532027wrw.41.2023.07.17.08.53.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Jul 2023 08:53:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-8.1] hw/sd/sdcard: Allow users to bypass the power-of-2
 size check
Date: Mon, 17 Jul 2023 17:53:16 +0200
Message-Id: <20230717155316.17714-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since we committed a9bcedd15a ("hw/sd/sdcard: Do not allow invalid
SD card sizes") to preclude some guests to access beyond the size
of the card (leading to security issues such CVE-2020-13253), various
users complained this prevent them to run guests potencially well
behaving with non-power-of-2 card sizes. In order to allow them to
experiment with such guests, add a property to disable the pow2
check.

Resolves: https://bugs.launchpad.net/qemu/+bug/1910586
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/297
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1754
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 77a717d355..feada6607a 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -108,6 +108,7 @@ struct SDState {
     uint8_t spec_version;
     BlockBackend *blk;
     bool spi;
+    bool bypass_pow2_size_check;
 
     /* Runtime changeables */
 
@@ -2126,6 +2127,9 @@ static void sd_instance_finalize(Object *obj)
     timer_free(sd->ocr_power_timer);
 }
 
+#define PROP_NAME_BYPASS_POW2_SIZE_CHECK \
+    "allow-unsafe-unsupported-not-power-of-2-size"
+
 static void sd_realize(DeviceState *dev, Error **errp)
 {
     SDState *sd = SD_CARD(dev);
@@ -2151,7 +2155,13 @@ static void sd_realize(DeviceState *dev, Error **errp)
         }
 
         blk_size = blk_getlength(sd->blk);
-        if (blk_size > 0 && !is_power_of_2(blk_size)) {
+        if (sd->bypass_pow2_size_check) {
+            warn_report_once("Unsupported property '%s' enabled: some guests"
+                             " might trigger data corruption and/or crash"
+                             " (thus this process is vulnerable to"
+                             " CVE-2020-13253).",
+                             PROP_NAME_BYPASS_POW2_SIZE_CHECK);
+        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
             int64_t blk_size_aligned = pow2ceil(blk_size);
             char *blk_size_str;
 
@@ -2161,11 +2171,15 @@ static void sd_realize(DeviceState *dev, Error **errp)
 
             blk_size_str = size_to_str(blk_size_aligned);
             error_append_hint(errp,
-                              "SD card size has to be a power of 2, e.g. %s.\n"
+                              "SD card size should be a power of 2, e.g. %s.\n"
                               "You can resize disk images with"
                               " 'qemu-img resize <imagefile> <new-size>'\n"
                               "(note that this will lose data if you make the"
-                              " image smaller than it currently is).\n",
+                              " image smaller than it currently is).\n"
+                              "Note: you can disable this check by setting"
+                              " the '" PROP_NAME_BYPASS_POW2_SIZE_CHECK "'"
+                              " global property but this is DANGEROUS"
+                              " and unsupported.\n",
                               blk_size_str);
             g_free(blk_size_str);
 
@@ -2190,6 +2204,17 @@ static Property sd_properties[] = {
      * board to ensure that ssi transfers only occur when the chip select
      * is asserted.  */
     DEFINE_PROP_BOOL("spi", SDState, spi, false),
+    /*
+     * Some guests (at least Linux) consider sizes that are not a power
+     * of 2 as a firmware bug and round the card size up to the next
+     * power of 2. For simplicity and security (see CVE-2020-13253) we
+     * only model guest access to the full drive, so we only accept drives
+     * having a power-of-2 size. That said, some guests might behave
+     * correctly with non-power-of-2 cards. Users want to experiment
+     * booting such guests so we provide a way to disable the check.
+     */
+    DEFINE_PROP_BOOL(PROP_NAME_BYPASS_POW2_SIZE_CHECK,
+                     SDState, bypass_pow2_size_check, false),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.38.1


