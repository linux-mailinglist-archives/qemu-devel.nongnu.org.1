Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE0181AD6E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9fp-0002K0-T0; Wed, 20 Dec 2023 22:24:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9fg-00022M-Oa
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:30 -0500
Received: from mail-qv1-xf29.google.com ([2607:f8b0:4864:20::f29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ff-0000zp-Cm
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:24:28 -0500
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-67f7bd86cafso2322636d6.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703129066; x=1703733866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DG0aaoeEohQ09SvvzgB8FkzO0oCsIp6ZWWtbFbko7Wg=;
 b=LGiCdEZQjpDX/katPvaVui3luiopVios+d0A7EGq/bV6p6lI4RP1KqGIYH1V6KAqSu
 ROQmWqVe+6bZ/LRMC83TlriIn8ZO51f0+Umb5XZZhzApBs91XvG9Wh6NELQT+wooibWp
 8BzoHahLrnyeCZXQQm4Qnv96wYxMQLajjMDmHFtfmcPMaJUqY8Dx/BAxa8g8u+/WElV0
 A+UMcw+YmIyB63d7jy2ysdOSJLpkMx63V/w6oOmWNren+kdkSpa/B0jKNe64QYX5kKYn
 4XEMR0H+dOmKXz84D0D0uKOtYFfa35XenMD/vTP5voIcln7XB3YkQGqU+4HYhTMM3OJc
 iXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703129066; x=1703733866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DG0aaoeEohQ09SvvzgB8FkzO0oCsIp6ZWWtbFbko7Wg=;
 b=L+5GLI8nbynYMk/ZxtOsYxGJ7JYlnYKezljY3vOGQjHp85cn1ZQljgBYJgvTehYLZq
 tTIMSElYMzrhQrrt1GNrUpDYsBinU3WkpTN0qcIyC+FKbQhc2+1of7nwzjzS0iRGyvSC
 6vMl/m5SB0NuO0vMiCxC5xc7nN9BAOVnN69Ksqct2KWossRZHvaKcTKnP2B/UPHqnJVF
 aUsYOMEuzVwh0kMWmgMEj/Yqn9m5DdDw4ODoaqYyMw3IrmsT8NmfI/xflG8i7UynwEsv
 edfgUfRY5Qf2Qs0ifg/OlL5Yh6xkl7vN4GZtlE6BQjD/rsaMUjykjDxh0KKnCkKp689q
 3Z+g==
X-Gm-Message-State: AOJu0YzPepD39X1dumF4rRNd0B5k30vIftdGNIeSGB0fjM6BC3dOao2P
 pF8WFsNNYWKwNW/cKiihFFBDSF0KmMqdil+vPP5Se9AG
X-Google-Smtp-Source: AGHT+IHjYQHuNxcs4P5DAXPkP4J+6cCzVQYefVk00MFTAoL9oFFumX+qjJte5mcBTbMYKBEcpcGVQw==
X-Received: by 2002:ad4:4eed:0:b0:67f:74f6:4cd8 with SMTP id
 dv13-20020ad44eed000000b0067f74f64cd8mr1952971qvb.130.1703129066535; 
 Wed, 20 Dec 2023 19:24:26 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 l16-20020ad44d10000000b0067f7b6318b9sm347257qvl.10.2023.12.20.19.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:24:26 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 64/71] backends: Constify VMState
Date: Thu, 21 Dec 2023 14:16:45 +1100
Message-Id: <20231221031652.119827-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f29;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf29.google.com
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
 backends/dbus-vmstate.c     | 2 +-
 backends/tpm/tpm_emulator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/backends/dbus-vmstate.c b/backends/dbus-vmstate.c
index a9d8cb0acd..be6c4d8e0a 100644
--- a/backends/dbus-vmstate.c
+++ b/backends/dbus-vmstate.c
@@ -393,7 +393,7 @@ static const VMStateDescription dbus_vmstate = {
     .version_id = 0,
     .pre_save = dbus_vmstate_pre_save,
     .post_load = dbus_vmstate_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(data_size, DBusVMState),
         VMSTATE_VBUFFER_ALLOC_UINT32(data, DBusVMState, 0, 0, data_size),
         VMSTATE_END_OF_LIST()
diff --git a/backends/tpm/tpm_emulator.c b/backends/tpm/tpm_emulator.c
index f7f1b4ad7a..ebdd2e0a69 100644
--- a/backends/tpm/tpm_emulator.c
+++ b/backends/tpm/tpm_emulator.c
@@ -939,7 +939,7 @@ static const VMStateDescription vmstate_tpm_emulator = {
     .version_id = 0,
     .pre_save = tpm_emulator_pre_save,
     .post_load = tpm_emulator_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(state_blobs.permanent_flags, TPMEmulator),
         VMSTATE_UINT32(state_blobs.permanent.size, TPMEmulator),
         VMSTATE_VBUFFER_ALLOC_UINT32(state_blobs.permanent.buffer,
-- 
2.34.1


