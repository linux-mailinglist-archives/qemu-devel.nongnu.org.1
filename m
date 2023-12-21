Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80A81AD77
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:27:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fI-0000bM-T1; Wed, 20 Dec 2023 22:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fG-0000SD-9j
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:02 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fD-0000Tq-PV
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:01 -0500
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-67f147c04b7so1907516d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129039; x=1703733839; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PZ6ASpRcT/Xlbl/IqgWgNPX4+U13cawDV+cHG4YYem0=;
 b=f6DcTGmAjcz4sh1dBmgShaHID+FOuGQf0pfDV5uE6B+SOP1PYNtQVfxfVLu6UMV4O/
 j4OT5jzEm15KpJE5xNvtPkGNHhkprfbnTdinhobbA3EpzpIDGZ4LoFCV8gUJLfHRZMqM
 JjqXYJj3SABGi50z8J0UQnnFr50dOadxPsLXO1wnuplAZCtmrZw0xzATFbZEhmlZBZDw
 YwNeBhvPguRx+LfM7htRpte57R4ZJ/RpZiBbZPhVQzW7Fq6hcl/0I+E/UL8UVYA+vHcB
 23o2PxjXNbiPwLVX1s1Mg6flSuLFqcE98+X3n/DKxNhG7IbLPlWAe3fa+CUdBK95xfwR
 rmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129039; x=1703733839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ6ASpRcT/Xlbl/IqgWgNPX4+U13cawDV+cHG4YYem0=;
 b=YPFVL7F5l/27hkiZ+FjcHSf92vrV9TmJDOhLz/tvsTeYeiv9SsFVOn7tEz02am8JZm
 4IBBLUlTaz6tEuuPnpLH1cpEqFRKsPVuZf6I4ikLJ8VUjBaJwdCoaiVgU7fVAo7Xsuv9
 Zax9eL5VlscolfPxLQFbDiZhbwL07TYjvEmtlSTnAOpTuCwqVRvG70i7mB5074cD+A0l
 nQgHR1P5ALpz0TdCNXZo6vj2xFQi105oSDtvEyVkEV/rtBD5kms8PSqsZrE8N2nWtmKc
 08aJqIUPq76Fb+ihVs9ldg3nyRYeG5sHEZmY7cnl4VcXq3NyZHT/z/VzwHxQfP3iV+/a
 kR2w==
X-Gm-Message-State: AOJu0Yz845jy79CKygLTfVYum3xONdLBvVbv83Hk44fq2Fc0c5hPqkOP
 Ccfvo8Sk4hS+gg23QGH0S1pfRnV9SlzBcCB/NcmfGJyb
X-Google-Smtp-Source: AGHT+IGnwMpdR48Ba5ude8j6nKfkjtei3Yj3b7fUHpw2BpW6W5e1Lx+/v6FLv8XvnPcaC3p0fwY93A==
X-Received: by 2002:a05:6214:f0d:b0:67f:5b3d:5f06 with SMTP id
 gw13-20020a0562140f0d00b0067f5b3d5f06mr5804497qvb.68.1703129039030; 
 Wed, 20 Dec 2023 19:23:59 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.23.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:23:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 57/71] hw/tpm: Constify VMState
Date: Thu, 21 Dec 2023 14:16:38 +1100
Message-Id: <20231221031652.119827-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf33.google.com
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
 hw/tpm/tpm_crb.c        | 2 +-
 hw/tpm/tpm_spapr.c      | 2 +-
 hw/tpm/tpm_tis_common.c | 2 +-
 hw/tpm/tpm_tis_i2c.c    | 2 +-
 hw/tpm/tpm_tis_isa.c    | 2 +-
 hw/tpm/tpm_tis_sysbus.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index ea930da545..5cd5a2533b 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -220,7 +220,7 @@ static int tpm_crb_pre_save(void *opaque)
 static const VMStateDescription vmstate_tpm_crb = {
     .name = "tpm-crb",
     .pre_save = tpm_crb_pre_save,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index dea7b1333b..e084e987e6 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -353,7 +353,7 @@ static const VMStateDescription vmstate_spapr_vtpm = {
     .name = "tpm-spapr",
     .pre_save = tpm_spapr_pre_save,
     .post_load = tpm_spapr_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SPAPR_VIO(vdev, SpaprTpmState),
 
         VMSTATE_UINT8(state, SpaprTpmState),
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index 279ce436b5..1bfa28bfd9 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -879,7 +879,7 @@ int tpm_tis_pre_save(TPMState *s)
 const VMStateDescription vmstate_locty = {
     .name = "tpm-tis/locty",
     .version_id = 0,
-    .fields      = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state, TPMLocality),
         VMSTATE_UINT32(inte, TPMLocality),
         VMSTATE_UINT32(ints, TPMLocality),
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 4ecea7fa3e..4bb09655b4 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -115,7 +115,7 @@ static const VMStateDescription vmstate_tpm_tis_i2c = {
     .version_id = 0,
     .pre_save  = tpm_tis_i2c_pre_save,
     .post_load  = tpm_tis_i2c_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(state.buffer, TPMStateI2C),
         VMSTATE_UINT16(state.rw_offset, TPMStateI2C),
         VMSTATE_UINT8(state.active_locty, TPMStateI2C),
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 0367401586..8887b3c9c4 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -53,7 +53,7 @@ static const VMStateDescription vmstate_tpm_tis_isa = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_isa,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(state.buffer, TPMStateISA),
         VMSTATE_UINT16(state.rw_offset, TPMStateISA),
         VMSTATE_UINT8(state.active_locty, TPMStateISA),
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index 2fc550f119..941f7f7f62 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -52,7 +52,7 @@ static const VMStateDescription vmstate_tpm_tis_sysbus = {
     .name = "tpm-tis",
     .version_id = 0,
     .pre_save  = tpm_tis_pre_save_sysbus,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BUFFER(state.buffer, TPMStateSysBus),
         VMSTATE_UINT16(state.rw_offset, TPMStateSysBus),
         VMSTATE_UINT8(state.active_locty, TPMStateSysBus),
-- 
2.34.1


