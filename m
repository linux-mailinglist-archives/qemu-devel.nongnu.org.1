Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980208201D6
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:32:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKQI-0000fB-Qv; Fri, 29 Dec 2023 16:29:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ3-0008Ra-GW
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:32 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKQ0-0000QI-20
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:29:27 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6d9aef87d44so1519464b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885362; x=1704490162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fgC12UagrksFWuSMkuP25mZZ0t/ZqvQsDdnKNN0TPhA=;
 b=BRoOhXpHRovmbqCFZardOMWC3OpJkyi8x3upaXOFYzDSFL5RMDu5nam9mzMMluOvtw
 E6Vf9gsePRCdx+/PiC3C6LJApBZWlrOZcya+PIQaInUL+SjQ8jzzD3wDeCFLJdfCHmjy
 jM+tkab6BZeEI9wohGQuqQQkQ+Pmkt9ityqV4x0QM43l8TmiJa6yTHkFsxA2b+PXW+Vh
 2e57gBcLUCDWxhkZwsDGly5IQAsjLkQZY1j6uHgL37rvBnRTw3yX+DRYkIfoILE8fHIb
 2VGwwWraWrpftdtRdEQmbw3S+53QdYnOvv5Gx97qsclPSoFmYV2HWNwhl2712VSNA54+
 Ow+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885362; x=1704490162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgC12UagrksFWuSMkuP25mZZ0t/ZqvQsDdnKNN0TPhA=;
 b=txjgqzN7J4hhVBMGlrR6Das4dTP74tWeUTLhSxuQ70ZB7GALYltpu+HPnoGAsyN9H6
 2Hn6dXWakfqOQvfdxog3F3GvR1FCiTAggbIGuby1egpQOfKBBho/5TkyMXwKpw6mgBTy
 Qg337Y3GBUy0MeGbj4aAy+DXQlkN9XYLI+2K27eWbFYu+ytlyV/fsA6nP2VYQCN0UtmH
 Xe94Vd9+mjZTq1Nsr3YeXeievMyRXHa1EYIDNaucyhN7TX9ufNIQhzPIdbqIOw64K/ji
 koS8t8S5DLg6DhZiVdAwrvNYVTiQCzQ9BV0uZW8+uAnu/pmO0UrmjPlKornqqKTk5GDn
 ONIA==
X-Gm-Message-State: AOJu0Yw6nBxmztksiN/KcrfCgCSniFjJJlgKSgl18p2VmjT4J6wq6Lcb
 P94MMPqJatLhcD6b4Tq951UUGbHLYh4bL+bZsIIm0lkljl6awA==
X-Google-Smtp-Source: AGHT+IGl7WDA0XWJUX9OHmmJVwKIngd8VecTxF3J7K35aABqMdyv47lOWebN+IyWuZQTHkTjBG2lLA==
X-Received: by 2002:a05:6a00:22ce:b0:6d9:e9ea:cfc8 with SMTP id
 f14-20020a056a0022ce00b006d9e9eacfc8mr4713639pfj.16.1703885362693; 
 Fri, 29 Dec 2023 13:29:22 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 bd33-20020a056a0027a100b006d9a96b7d0dsm11285396pfb.208.2023.12.29.13.29.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:29:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 64/71] backends: Constify VMState
Date: Sat, 30 Dec 2023 08:23:39 +1100
Message-Id: <20231229212346.147149-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
Message-Id: <20231221031652.119827-65-richard.henderson@linaro.org>
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


