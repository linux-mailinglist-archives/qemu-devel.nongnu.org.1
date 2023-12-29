Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751D8201CE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:31:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQE-0008R6-Lz; Fri, 29 Dec 2023 16:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPu-0008Ef-Ii
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:18 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKPl-0000NK-1n
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:13 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d98ce84e18so5160941b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885348; x=1704490148; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vt60Tnr4DqLoORHWhbTyoaC4aknKVapk9I6rFjWSbFY=;
 b=r9JozAFP3HZdhWC8TBQmwRBg2HhFx2fgrl9ttYw3BWpmOyBKxyCYbiNXV5lxK6nAOJ
 FJQiu8qhuRSyA9lVSAs8/jrQSqnlaPcLgpCjtOqiy4pgdPd7BQWBEYa+zB/4+y+wD1Uo
 sbfWBhO3AdF19EWikWJ/Rt1TO7uGRJStpol35DqwBU3R3/AJPLHzI+ZDB3eQJ94KHwZc
 Hz7E/spLLrrlWUUGBCtfoFDaBc9ykNKPO4a/qH3RVhtnecXffIa68MyYfYZOSpwmg7v9
 fbEN+KrDRTtCMBa79WtEoHy579/R0uXm1eWZmDZTV8Y7oZcuuhQlOT9Ehql8PviyVDyf
 aewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885348; x=1704490148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vt60Tnr4DqLoORHWhbTyoaC4aknKVapk9I6rFjWSbFY=;
 b=YWJDwPyywXYk3NYb9jS5SJU99T+ApmGiE2Jy5qL7nrGAFfUOvImCv2TtqC8HIEPTCh
 300YE4DTsDiawFryOwFs/qyMvI9aQHOxsczrFJ3Tm9qxsTbXGBSJr7BzyCskO3zsEn4Q
 80md4SAPkosfmXEagqsfu7I+A9WeSDQko1BH1fN6N+KpUfRkhaPUsdgio05gPDh6O1DY
 /oLeg6XEZlIuRK7Iz+FRCrM2CIBeIkNg/V4Lp5jCQsgyvDAP8VHy55ZnxU/9IzWyxkOB
 Pp1qK5PIbaIhnlsY+UfDZIODMub/nNQxFn/kQ6OBzCOxND4RMuB29Ihx94JKC2AKeuKG
 BuXw==
X-Gm-Message-State: AOJu0Yxrcx70pHVLwXni0LSq7sS/4gOqqoQDXMNGBW1s04wHrUMYyRXI
 SCXkK7Ai/FIRCWCLaLCidGqRdHRdVOpMw+xHMOJTz1fbflreUg==
X-Google-Smtp-Source: AGHT+IGUOIYAbnddHLkVmBsxRi2d9hU5h/WLrXWUP86OWvJUC9flhaHilgAe5tTHrUYVEmPtWPMUnA==
X-Received: by 2002:aa7:8504:0:b0:6d9:b187:b176 with SMTP id
 v4-20020aa78504000000b006d9b187b176mr10404928pfn.13.1703885347722; 
 Fri, 29 Dec 2023 13:29:07 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:07 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 57/71] hw/tpm: Constify VMState
Date: Sat, 30 Dec 2023 08:23:32 +1100
Message-Id: <20231229212346.147149-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-Id: <20231221031652.119827-58-richard.henderson@linaro.org>
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


