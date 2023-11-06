Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FEC7E1AB3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:06:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztdp-0002Ce-Rc; Mon, 06 Nov 2023 02:03:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-0000cS-4I
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020F-JD
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:28 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2800f7c8125so4097958a91.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254135; x=1699858935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/DAqRb/YvkfB+IMhHLNMx9PB+A0mfV7BrZG2PN2lPw=;
 b=V2QwEoVHhltywAU+jT0flpEzayUKnAb+xJMW2DbyxIL4RGmnPev718LZsd9yZHqECV
 Vv5nOy+lIHfoz86bDwAvutzMDWMLkSNKQdZFAMn6euxYHGlD58OL3GvycnSIDwJ4eAbf
 BR7qu131eqKUertg0qF6Jc8ghqIPRLt276/zD43kvXIz02g7+TRdHwiKaH9oaAbYXQJ5
 J9QwWtP3dKCWaEvoXmll+PntI5Px+qTe/PPgCZzNHhA/D9zw09OZw/jRjIsdrhFPMwl5
 RqQ4/uSIYnT4qV0cBfMiVESkBGWZLll+s12nilqZWsLvRvTHGxlaNjCNTWcQBglQuFTm
 DWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254135; x=1699858935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l/DAqRb/YvkfB+IMhHLNMx9PB+A0mfV7BrZG2PN2lPw=;
 b=b6bMdd0jjxds9EdIRJ+xmw7RobarK7emWfFW/enFmJrr77tveyxTeLAK0R4VySmzb9
 aAQEvQwvtjzD9DzIeRVSx3OW8ipWLGQy+jnugDuHHrBftK/f0qQRY35NI5tiEdQIgILr
 tIwfyVSVumcnLOT8+tiZMxt5hkQQxNXBmqnLZk8lYeXMTOKY789aJevBqNp7PtA2MEjl
 5mdPwg2GSv3E0AM3w3Milc0B8hmOMVa8pFfColGd8t0tsRGIJ+OnJB8qkgJCAeZutqmm
 E9J1HtlSiap/z+kAK4Hnql5bkeg42nFPEbeNFxM2mqkIxkEjPTSSbsPcDWr5TvvdVPmQ
 yRKg==
X-Gm-Message-State: AOJu0YxU50b40wWThSe83CoB9YTZdq0HEQHjFUFiU9gOIh4QL/szXzob
 8f9HKFYMa7FAN4b4A0rOWHaV+hryQgnI9Z+6wWY=
X-Google-Smtp-Source: AGHT+IEBMRAEN6r3D5QercvAm/cl4MCP35eXN1kNcx5T786gUXQY9ojvSQ8bVOJbSmBLKSvl9X9Jlw==
X-Received: by 2002:a17:90b:3e88:b0:27c:df02:88b3 with SMTP id
 rj8-20020a17090b3e8800b0027cdf0288b3mr13081464pjb.8.1699254135326; 
 Sun, 05 Nov 2023 23:02:15 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:14 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 53/71] hw/sensor: Constify VMState
Date: Sun,  5 Nov 2023 22:58:09 -0800
Message-Id: <20231106065827.543129-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/sensor/adm1272.c        | 2 +-
 hw/sensor/dps310.c         | 2 +-
 hw/sensor/emc141x.c        | 2 +-
 hw/sensor/lsm303dlhc_mag.c | 2 +-
 hw/sensor/max31785.c       | 2 +-
 hw/sensor/max34451.c       | 2 +-
 hw/sensor/tmp105.c         | 6 +++---
 hw/sensor/tmp421.c         | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

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


