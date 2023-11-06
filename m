Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EFE7E1AAD
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:05:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztg3-0006Nq-I7; Mon, 06 Nov 2023 02:05:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztd1-0000cU-5O
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:32 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcr-00020Y-KV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:29 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-280200949c3so3006282a91.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254138; x=1699858938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZ6ASpRcT/Xlbl/IqgWgNPX4+U13cawDV+cHG4YYem0=;
 b=exGH93dSvuEWCSL5u9gAvjbaCGcOGFPR2niCXbzRbogiPpb9JX0LhcYETDFQllbLug
 FryG72h8vSlotCeW9EKSYyxZQozE1btsXbXZiTdwXNF1O9Dr2o+KWqTWE4z7UyJlpifO
 mdLWKmidc7MOseD5385GsNQ63Gtprp39V4maTg08bPc4vYgpzKRMQkpshWyTJjyhk7Vz
 5B6w2Peyg9y0OA9Ld6Zh76OjMq9/aEaudpJNcGoQuG8eSHEOFwPAMreyEWqN88VX4c1c
 oqVQq+BrTsXgRUiBcwQ4lZVNwKWSkVIFspgFdhB3tCPqxGwlerovhfwtT/xAdAoTNYa9
 BnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254138; x=1699858938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ6ASpRcT/Xlbl/IqgWgNPX4+U13cawDV+cHG4YYem0=;
 b=ejjV8IiYX66n0+I9paXNK1oLRsIRgAl5aIuAM20MQIjfUtwI5+K0wMMgCyx7faLYk0
 YWiPpJZoNplWMt/bHHex8dt/7M7xTETmxRFLO+2b9hlK2WSV0926Lnr3s0tW17dFHcS6
 Ja1Q4yv6mnp22E+TJsNOZfiTWxCzrMwotB/FuYwBdHbYj/uWinDioOyktAtFhdZIb/oN
 iB5NXljgl+z7Yq7ejOwfm+XdYEdX7qqgDezdtWh9k1yjCiaCJGkhRNM9vMFwcIkBThid
 fedlXbi5KDJ0bJqi84i4nXvvS3Aq+n4OhCIAMvqvDajdcoMmGTFXi12TRbi27RvzLAoF
 UZ3w==
X-Gm-Message-State: AOJu0YzuhGKHi9/oANdaCvxjImi6a1x5PhVNRkp9KH8VSvr6tdn4hRFy
 mFI5hI3pT2J9Y+9JyQuphsC6J62UMKVrLGKHKB0=
X-Google-Smtp-Source: AGHT+IHgCniXNZcpAzvHDgik2kupjV9spbbg2JLay3CwaTwG23j0Ty15Aelf5VfD7IHTvwtqzrhRTA==
X-Received: by 2002:a17:90a:5c:b0:27e:3b1c:4f03 with SMTP id
 28-20020a17090a005c00b0027e3b1c4f03mr22238651pjb.38.1699254138479; 
 Sun, 05 Nov 2023 23:02:18 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 57/71] hw/tpm: Constify VMState
Date: Sun,  5 Nov 2023 22:58:13 -0800
Message-Id: <20231106065827.543129-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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


