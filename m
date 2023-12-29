Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E80168201BD
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKPh-00072B-1V; Fri, 29 Dec 2023 16:29:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPe-0006jl-GQ
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:02 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPc-0000MK-C2
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:02 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6dc02727c62so1747797a34.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885339; x=1704490139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dhfGylU0tZW2Dh+UHioxT5DQ6oaJb1b9JbJR4l6mL0Y=;
 b=UyPUJzbQVDcjyvgR6KxcNCreYvicIqeXvmnSJAYFZyCDLxxROfQcWogNIe0HiCDvQq
 ZAytVUpTYJ/XL//jjqg03VxCmLmpZBUZndMmMkGbg1I0tVOJhsX/kav6xaFvxKh0O9FB
 EibJB3x8pQIoEQVb2d/AcwkUj4Cfr05/5pzuwdh8Q4qD7VqmXCrWg3BEQ9YJPvvsLiC+
 jlhtSf8xhP6OEIVa5Rm4/yN+dQ1/3jdzqUo53Df2BXEgZfLixe1Jnty5At1WQtopy8zv
 NftEqnG1D7KcPnXSwJOS81JG0LYSiacfCXlSyRzxC5mBx1Ce1smJCjy8rl9R7v/Kj/V8
 uC9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885339; x=1704490139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhfGylU0tZW2Dh+UHioxT5DQ6oaJb1b9JbJR4l6mL0Y=;
 b=dy1NguSJKR8WEoHHImzwvdWHk7QWmwaGbL4nW1S+oP1qpc8rlPRlh2coxClrgZG0vB
 XQxqut7LFo01mSPmayyasYhqsMQuEN1C/kF9tR1iRPBAj14/tsAyqxHHT7o2YNcNtES+
 2SI5ttuk60ZRmSOiinjMQBhZesIhZGMORPosslnrOiL+JAbWtwBAzG4H18JDzPPL9XFi
 CMWObA4BS0Sg4VlAGO4SJNCmgw2BtmfObXwf+LQPYRTt5N+Q0TIwiJmagk0D0b1/JXGJ
 nuYse+Rm8FH4ZtwKhgYvrcws/oBkRLmN7/sIyOuDUXL+uyeu1vv7wMcQR6olfVJMpa2l
 BiOA==
X-Gm-Message-State: AOJu0Yy07aQKrJIBuAJmladbJ3P3CESmpfOq1VD3k+BRUkLR1KHA5lu6
 nx2CWWpTmpYfqlam+nH5o6yeNAgdA+rbTqZ0RC7EMbAlL4OhzA==
X-Google-Smtp-Source: AGHT+IHAZaeAcclqHqQCZk76EDbqaV7csnhiomqU+9QCdjtHjgDD1grxcj+rhTNB9j+UEPHbC9FVnQ==
X-Received: by 2002:a05:6830:85:b0:6db:a64e:f25e with SMTP id
 a5-20020a056830008500b006dba64ef25emr9276876oto.50.1703885339123; 
 Fri, 29 Dec 2023 13:28:59 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.28.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:28:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 53/71] hw/sensor: Constify VMState
Date: Sat, 30 Dec 2023 08:23:28 +1100
Message-Id: <20231229212346.147149-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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
Message-Id: <20231221031652.119827-54-richard.henderson@linaro.org>
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


