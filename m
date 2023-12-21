Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A757881AD7E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:28:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fI-0000Sr-TL; Wed, 20 Dec 2023 22:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9f1-0008Ol-Np
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:49 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ey-0007X5-5l
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:23:47 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-67f83812a32so490656d6.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129023; x=1703733823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isRZ/SxidlzQo6pUw7G3KxWkLynKxgsqEOBPePgg8nU=;
 b=BapNg4f3+oURKp5f9YiJxhAjrIE4PPCsFjVzvLO0+9E8z8cesQ4TbPGvOn7xT0aGTr
 SUbyUffRjpOYemYjVJcVMfnZFHShMllw6sU4qkC8t5+wvJIFos5sLOoE/f5Kpw0qn8np
 1bkYt7e9+R9JgHZTWmrbpyZaQMcWP5md/+fN6puzSsvH4DvDk8LO+XF5B3Ycn57+bz3u
 UEb+avTnNMKi1ZK5mDRgRYQcOfqfPzmcl3xhRQZZ2MZ+v3sHTZG9z7lQstauuQv7GMg4
 3KZtJv9NNqjnOSad+C8jJjgpBq2JcCwg8vNEAWtQPgHKW0Gtxl/LRGGYH1Ir4/C/En5H
 g+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129023; x=1703733823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=isRZ/SxidlzQo6pUw7G3KxWkLynKxgsqEOBPePgg8nU=;
 b=PpEDsIxwknz9OstFwN6qjXp70Eti5WvhTCFgEN0C62dHFCIJjsql4VoVoKfs/4JUMl
 M2kdAvqN77kyLjhmkUV1EO9YWwVbIdbJtRfRzMrLaYkbyiKrh9Z+lY1YWfxXWw6Pbh2C
 9NBwzTXWB4JLRi/2GSsMb8hxv7cn/XBTyDyaZHuWFv/l39ywFor7IQlAA31DIuhFzshT
 Z4oD1zCRRTkN0vajpsB0ZQpEU6VTb4vU9IRj02yhymBKBZLTvJhRTUKdHmOiuYUdt1Ca
 xokss2SjTlksfMuKSJpwzHBONuNu1VpjssOygyX5tsTdikfRPEJRT8OI9hOwg/uMbAV7
 7DAg==
X-Gm-Message-State: AOJu0YymTRgatAQ97qgYEW3rS7ef4eV8r7tVMoiiYN+Y9Cto63Ap50uJ
 Q/Y5rM8vHYilhiq8ThVcu8BCToC3VVVHQw+zWaDBVJNc
X-Google-Smtp-Source: AGHT+IHf+1bNQU7yTtPfWe9P3T4m+W430YVlF98ra9NwJADnMtfpC7hBV1TQ3QGyN9hgONwNroKh1A==
X-Received: by 2002:a05:6214:da5:b0:67f:3f42:cf61 with SMTP id
 h5-20020a0562140da500b0067f3f42cf61mr7056718qvh.59.1703129023343; 
 Wed, 20 Dec 2023 19:23:43 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:43 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 53/71] hw/sensor: Constify VMState
Date: Thu, 21 Dec 2023 14:16:34 +1100
Message-Id: <20231221031652.119827-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf36.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sensor/adm1266.c        | 2 +-
 hw/sensor/adm1272.c        | 2 +-
 hw/sensor/dps310.c         | 2 +-
 hw/sensor/emc141x.c        | 2 +-
 hw/sensor/lsm303dlhc_mag.c | 2 +-
 hw/sensor/max31785.c       | 2 +-
 hw/sensor/max34451.c       | 2 +-
 hw/sensor/tmp105.c         | 6 +++---
 hw/sensor/tmp421.c         | 2 +-
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/sensor/adm1266.c b/hw/sensor/adm1266.c
index 5ae4f82ba1..5454b73a63 100644
--- a/hw/sensor/adm1266.c
+++ b/hw/sensor/adm1266.c
@@ -202,7 +202,7 @@ static const VMStateDescription vmstate_adm1266 = {
     .name = "ADM1266",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_PMBUS_DEVICE(parent, ADM1266State),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/sensor/adm1272.c b/hw/sensor/adm1272.c
index 8f4a1c2cd4..1f7c8abb83 100644
--- a/hw/sensor/adm1272.c
+++ b/hw/sensor/adm1272.c
@@ -457,7 +457,7 @@ static const VMStateDescription vmstate_adm1272 = {
     .name = "ADM1272",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_PMBUS_DEVICE(parent, ADM1272State),
         VMSTATE_UINT64(ein_ext, ADM1272State),
         VMSTATE_UINT32(pin_ext, ADM1272State),
diff --git a/hw/sensor/dps310.c b/hw/sensor/dps310.c
index addee99b19..01c776dd7a 100644
--- a/hw/sensor/dps310.c
+++ b/hw/sensor/dps310.c
@@ -188,7 +188,7 @@ static const VMStateDescription vmstate_dps310 = {
     .name = "DPS310",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, DPS310State),
         VMSTATE_UINT8_ARRAY(regs, DPS310State, NUM_REGISTERS),
         VMSTATE_UINT8(pointer, DPS310State),
diff --git a/hw/sensor/emc141x.c b/hw/sensor/emc141x.c
index 7ce8f4e979..95079558e8 100644
--- a/hw/sensor/emc141x.c
+++ b/hw/sensor/emc141x.c
@@ -228,7 +228,7 @@ static const VMStateDescription vmstate_emc141x = {
     .name = "EMC141X",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, EMC141XState),
         VMSTATE_UINT8(data, EMC141XState),
         VMSTATE_UINT8(pointer, EMC141XState),
diff --git a/hw/sensor/lsm303dlhc_mag.c b/hw/sensor/lsm303dlhc_mag.c
index bb8d48b2fd..343ff98990 100644
--- a/hw/sensor/lsm303dlhc_mag.c
+++ b/hw/sensor/lsm303dlhc_mag.c
@@ -442,7 +442,7 @@ static const VMStateDescription vmstate_lsm303dlhc_mag = {
     .name = "LSM303DLHC_MAG",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
 
         VMSTATE_I2C_SLAVE(parent_obj, LSM303DLHCMagState),
         VMSTATE_UINT8(len, LSM303DLHCMagState),
diff --git a/hw/sensor/max31785.c b/hw/sensor/max31785.c
index 8b95e32481..916ed4d457 100644
--- a/hw/sensor/max31785.c
+++ b/hw/sensor/max31785.c
@@ -487,7 +487,7 @@ static const VMStateDescription vmstate_max31785 = {
     .name = TYPE_MAX31785,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_PMBUS_DEVICE(parent, MAX31785State),
         VMSTATE_UINT16_ARRAY(mfr_mode, MAX31785State,
                              MAX31785_TOTAL_NUM_PAGES),
diff --git a/hw/sensor/max34451.c b/hw/sensor/max34451.c
index 9db52ef677..031ae53f59 100644
--- a/hw/sensor/max34451.c
+++ b/hw/sensor/max34451.c
@@ -654,7 +654,7 @@ static const VMStateDescription vmstate_max34451 = {
     .name = TYPE_MAX34451,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_PMBUS_DEVICE(parent, MAX34451State),
         VMSTATE_UINT16_ARRAY(power_good_on, MAX34451State,
                              MAX34451_NUM_PWR_DEVICES),
diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 2056449489..a8730d0b7f 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -238,7 +238,7 @@ static const VMStateDescription vmstate_tmp105_detect_falling = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = detect_falling_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(detect_falling, TMP105State),
         VMSTATE_END_OF_LIST()
     }
@@ -249,7 +249,7 @@ static const VMStateDescription vmstate_tmp105 = {
     .version_id = 0,
     .minimum_version_id = 0,
     .post_load = tmp105_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, TMP105State),
         VMSTATE_UINT8_ARRAY(buf, TMP105State, 2),
         VMSTATE_UINT8(pointer, TMP105State),
@@ -260,7 +260,7 @@ static const VMStateDescription vmstate_tmp105 = {
         VMSTATE_I2C_SLAVE(i2c, TMP105State),
         VMSTATE_END_OF_LIST()
     },
-    .subsections = (const VMStateDescription*[]) {
+    .subsections = (const VMStateDescription * const []) {
         &vmstate_tmp105_detect_falling,
         NULL
     }
diff --git a/hw/sensor/tmp421.c b/hw/sensor/tmp421.c
index a3db57dcb5..b6f0b62ab1 100644
--- a/hw/sensor/tmp421.c
+++ b/hw/sensor/tmp421.c
@@ -290,7 +290,7 @@ static const VMStateDescription vmstate_tmp421 = {
     .name = "TMP421",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, TMP421State),
         VMSTATE_UINT8_ARRAY(buf, TMP421State, 2),
         VMSTATE_UINT8(pointer, TMP421State),
-- 
2.34.1


