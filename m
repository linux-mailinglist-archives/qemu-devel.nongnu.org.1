Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DABAE91B7F0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:15:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5jl-0006WQ-3m; Fri, 28 Jun 2024 03:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5j3-0005xM-KY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:55 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5j0-0004TL-TN
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:08:53 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso3130005e9.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558528; x=1720163328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jmktXx8YFnfnnA13QTx+BBHRiUUuhl67+QJQQVhLdE0=;
 b=ahiRMwIw3aERPlYCuXQSXbYylhgdavHJXon7bKbnahtGKcuGixUv0pnTuWqyw6OxKc
 RkAoD4G3rhPguAPus7y2QSfg1EPzgoIz2/TKGfOdEqcm2QfgsPbTamMlR9c6DiEtErZi
 0UNUIVM+f6RP71zvhLYA2CWRSBj1inSOBojSfxgMZSA4bDPf/+PpPvvR6LmKA0tzbzHZ
 s+FiR07SajeSVf323YNwzX71O5pCZrXsNujdgiMed5cMbbv6SPvK2+sSmfAYh+K5TyF3
 zNhlsOylQtq09x8KoT73FJeAOF0g/oqG3CkoEPuPqC+gy5Eqk69Mvzb7AH76r8tiEL83
 dK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558528; x=1720163328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jmktXx8YFnfnnA13QTx+BBHRiUUuhl67+QJQQVhLdE0=;
 b=Z15GAhIqQgb9oTYmqD6Bza1Ak2fsZVm99ciVe2lTeWWUmO56rcRED9EDfc779/10jR
 9W60QIOaKDREDcO0VgDIzNm65xJfjTNnIP7y8WSAB3JiXk0vBT1WyklbHXi6hfJX+BGC
 mQEuXmpTF/DHnWDof85oYx6wSRjCy766dxOj/eP8exonUgtCrToTXJG6hfC2u3/6dpTm
 kpfGDW5TMgrQbOGNpmqw6iXZIeVTyzd1XCibDW0vcBpOj6Muq/BYBPiPo4LxF6Gi59aw
 OkpuoVT1vIJbrPrdrbr2NSoc/mYEEPICjG6vfoOnmpCTND/2bLjbyQ7a3AB8hwa3ARc4
 COrA==
X-Gm-Message-State: AOJu0YyTdRbAMoanAqaReO4aFnFlbSSo90Q/92nueQfE3VTcbRf6tPC8
 /Acus7pdoR9/CTKiRpGbtF728WFWm+OA9J1/uORVuwAYM6lvdXqb/PCajKcL1GPDIdGGX30IZ4d
 duLw=
X-Google-Smtp-Source: AGHT+IH3YKDP6eCh0IpKJTsmXxCc0GW8yUzq7vU1+qG8XgwAN+jpFRYUhUG93d+b47W1N7886cJzYQ==
X-Received: by 2002:a5d:59ac:0:b0:366:f74f:abf0 with SMTP id
 ffacd0b85a97d-366f74faceamr14448624f8f.16.1719558527904; 
 Fri, 28 Jun 2024 00:08:47 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd71esm1346641f8f.21.2024.06.28.00.08.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:08:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 64/98] hw/sd/sdcard: Add sd_cmd_APP_CMD handler (CMD55)
Date: Fri, 28 Jun 2024 09:01:40 +0200
Message-ID: <20240628070216.92609-65-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4d78ac5b59..5461e56e17 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -245,7 +245,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
                                             [25]    = "WRITE_MULTIPLE_BLOCK",
         [26]    = "MANUF_RSVD",
         [40]    = "DPS_spec",
-        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
         [56]    = "GEN_CMD",
         [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
         [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
@@ -1624,9 +1623,34 @@ static sd_rsp_type_t sd_cmd_LOCK_UNLOCK(SDState *sd, SDRequest req)
     return sd_cmd_to_receivingdata(sd, req, 0, 0);
 }
 
+/* CMD55 */
+static sd_rsp_type_t sd_cmd_APP_CMD(SDState *sd, SDRequest req)
+{
+    switch (sd->state) {
+    case sd_ready_state:
+    case sd_identification_state:
+    case sd_inactive_state:
+        return sd_invalid_state_for_cmd(sd, req);
+    case sd_idle_state:
+        if (!sd_is_spi(sd) && sd_req_get_rca(sd, req) != 0x0000) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
+        }
+        /* fall-through */
+    default:
+        break;
+    }
+    if (!sd_is_spi(sd) && !sd_req_rca_same(sd, req)) {
+        return sd_r0;
+    }
+    sd->expecting_acmd = true;
+    sd->card_status |= APP_CMD;
+
+    return sd_r1;
+}
+
 static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
 {
-    uint16_t rca;
     uint64_t addr;
 
     sd->last_cmd_name = sd_cmd_name(sd, req.cmd);
@@ -1713,29 +1737,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     /* Application specific commands (Class 8) */
-    case 55:  /* CMD55:  APP_CMD */
-        rca = sd_req_get_rca(sd, req);
-        switch (sd->state) {
-        case sd_ready_state:
-        case sd_identification_state:
-            return sd_illegal;
-        case sd_idle_state:
-            if (rca) {
-                qemu_log_mask(LOG_GUEST_ERROR,
-                              "SD: illegal RCA 0x%04x for APP_CMD\n", req.cmd);
-            }
-        default:
-            break;
-        }
-        if (!sd_is_spi(sd)) {
-            if (sd->rca != rca) {
-                return sd_r0;
-            }
-        }
-        sd->expecting_acmd = true;
-        sd->card_status |= APP_CMD;
-        return sd_r1;
-
     case 56:  /* CMD56:  GEN_CMD */
         switch (sd->state) {
         case sd_transfer_state:
@@ -2321,6 +2322,7 @@ static const SDProto sd_proto_spi = {
         [50] = {10, sd_spi, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
+        [55] = {8,  sd_spi, "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_spi, "DIRECT_SECURE_WRITE", sd_cmd_optional},
     },
     .acmd = {
@@ -2373,6 +2375,7 @@ static const SDProto sd_proto_sd = {
         [50] = {10, sd_adtc, "DIRECT_SECURE_READ", sd_cmd_optional},
         [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
         [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
+        [55] = {8,  sd_ac,   "APP_CMD", sd_cmd_APP_CMD},
         [57] = {10, sd_adtc, "DIRECT_SECURE_WRITE", sd_cmd_optional},
         [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
         [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
-- 
2.41.0


