Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC791B7C5
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN5gS-0001sx-20; Fri, 28 Jun 2024 03:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gP-0001aL-De
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:09 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sN5gN-0003Eu-Hq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:06:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4217c7eb6b4so2621925e9.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719558366; x=1720163166; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/ayYPHbFG82day0p5Ydj8QW5gkkALIElfBxZi1L4r4c=;
 b=S1LhNJAPhNNqx3GkHfS1D0O7ub0hDsYWKJP5EC7VbPbcR3DMuf/tZjz8AXTeHuvrzN
 wJ410RKo0macjOs3MU4rranuXRqSD3LaGYIBXVLdg6wBF3GDUUDAsKhUn909EbZyp81a
 xFQ8Bsx2A+gWBJ34cl/gURArbxL4Di/XndfcQk4Zmlrj/8mBwJd6JHYLEzW4hNc8/6YA
 S+m87tqccCTIuWVPV7b3w6DbEryStF328oWXY8Snag4UIxrtcaogSZpiOD9+sbEowYo1
 Qo30iS99DoaeHV6Wgb6BcyYWv9qUnROBpPcXX+s+3ktLjlicQd//jibOMumEfBcR0wg5
 TaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719558366; x=1720163166;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ayYPHbFG82day0p5Ydj8QW5gkkALIElfBxZi1L4r4c=;
 b=xC6HG+DwOS9SBUt2Ntsv1SxkJFZ6BIxaYYCLB0+CGDwcdvOlnA9LL0WfqinHml/7UC
 pNpc3FUrDNdsxHB8qXM3dOWW9jx3xD7UnyWQ/xxwiYuvawUW3g3qZScfzyV+h+irP3KI
 hbJGprlpxhUJy3GlZm1QgwFB5Wj+o9VSOnEXQ6FsAHRwb5vMH7HINgX6aH2vcRhrY7eO
 wTmpo1YqJvmbYd83m8VAY9YyYzKxCmdwkUD94S16JE5vV+UNTEMBxnD5vz8aqQthTKt6
 iQodEZ1bQ6idZ8yeNDpYH/WCEYtTvoPv5RXRodhtBIgA7OOPHHR/xEpeQg67F13ZKIsP
 +vKg==
X-Gm-Message-State: AOJu0YzXJvCGrhNnF682BSo8gKUqtIGspw+02/Co2AmBIvIH/YQMLu9D
 YDJAZinDGRQvO5fO8lLl+48ICLX+cYm90jdJMlRgUjP/ybj1IwZN9u1GSnDJ/7yN1Z3YGdRQ4Xs
 h0ro=
X-Google-Smtp-Source: AGHT+IHPvQ58pW7UsbUDfpTX4m7FbloeUqSwnewQRoQtuub5XI+2pujdDhzk4LN+rXM6BeccZQLHsw==
X-Received: by 2002:a05:600c:12c5:b0:425:5fe5:f273 with SMTP id
 5b1f17b1804b1-4255fe5f3d0mr44347045e9.26.1719558365759; 
 Fri, 28 Jun 2024 00:06:05 -0700 (PDT)
Received: from m1x-phil.lan (cho94-h02-176-184-4-239.dsl.sta.abo.bbox.fr.
 [176.184.4.239]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a681sm21184815e9.30.2024.06.28.00.06.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 28 Jun 2024 00:06:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v42 38/98] hw/sd/sdcard: Prepare SDProto to contain more fields
Date: Fri, 28 Jun 2024 09:01:14 +0200
Message-ID: <20240628070216.92609-39-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
References: <20240628070216.92609-1-philmd@linaro.org>
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

Convert array of command handlers to array of structures.
The structure contains the command handler. No logical
change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index f4bdd12b26..558c39419d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -94,8 +94,9 @@ typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
 
 typedef struct SDProto {
     const char *name;
-    sd_cmd_handler cmd[SDMMC_CMD_MAX];
-    sd_cmd_handler acmd[SDMMC_CMD_MAX];
+    struct {
+        sd_cmd_handler handler;
+    } cmd[SDMMC_CMD_MAX], acmd[SDMMC_CMD_MAX];
 } SDProto;
 
 struct SDState {
@@ -1305,8 +1306,8 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         return sd_illegal;
     }
 
-    if (sd->proto->cmd[req.cmd]) {
-        return sd->proto->cmd[req.cmd](sd, req);
+    if (sd->proto->cmd[req.cmd].handler) {
+        return sd->proto->cmd[req.cmd].handler(sd, req);
     }
 
     switch (req.cmd) {
@@ -1753,8 +1754,8 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
                              req.cmd, req.arg, sd_state_name(sd->state));
     sd->card_status |= APP_CMD;
 
-    if (sd->proto->acmd[req.cmd]) {
-        return sd->proto->acmd[req.cmd](sd, req);
+    if (sd->proto->acmd[req.cmd].handler) {
+        return sd->proto->acmd[req.cmd].handler(sd, req);
     }
 
     switch (req.cmd) {
@@ -2267,22 +2268,22 @@ void sd_enable(SDState *sd, bool enable)
 static const SDProto sd_proto_spi = {
     .name = "SPI",
     .cmd = {
-        [0]         = sd_cmd_GO_IDLE_STATE,
-        [1]         = spi_cmd_SEND_OP_COND,
+        [0]  = {sd_cmd_GO_IDLE_STATE},
+        [1]  = {spi_cmd_SEND_OP_COND},
     },
     .acmd = {
-        [41]        = spi_cmd_SEND_OP_COND,
+        [41] = {spi_cmd_SEND_OP_COND},
     },
 };
 
 static const SDProto sd_proto_sd = {
     .name = "SD",
     .cmd = {
-        [0]         = sd_cmd_GO_IDLE_STATE,
-        [2]         = sd_cmd_ALL_SEND_CID,
-        [3]         = sd_cmd_SEND_RELATIVE_ADDR,
-        [19]        = sd_cmd_SEND_TUNING_BLOCK,
-        [23]        = sd_cmd_SET_BLOCK_COUNT,
+        [0]  = {sd_cmd_GO_IDLE_STATE},
+        [2]  = {sd_cmd_ALL_SEND_CID},
+        [3]  = {sd_cmd_SEND_RELATIVE_ADDR},
+        [19] = {sd_cmd_SEND_TUNING_BLOCK},
+        [23] = {sd_cmd_SET_BLOCK_COUNT},
     },
 };
 
-- 
2.41.0


