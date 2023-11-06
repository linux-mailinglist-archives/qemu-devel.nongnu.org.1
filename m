Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D17E1AF2
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:14:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztfW-0004ry-Fj; Mon, 06 Nov 2023 02:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztdD-00017w-3Y
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:46 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztcw-00021a-Hp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 02:02:37 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so2527435a12.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 23:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254144; x=1699858944; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DG0aaoeEohQ09SvvzgB8FkzO0oCsIp6ZWWtbFbko7Wg=;
 b=HqvAVFRVcSSFI6aE0+3VINukfB1RgBnsBDzJ/G5u5ePzoniQLfsHEGvkOl4tRizw/J
 FFhpNdUCSEdA3n+4lTjrbw8WeZ+S/7Q8aSiE1Y4/c0ZlAQJDcI4yj1iGU0wyvg69ylZc
 yWHBLOmswZDB0f9NTM8ocmM71FeVDQBTMGwiL/kK0vnWoPnFNTBhj4BOruk744AspNWY
 xVPLmE7JKlrv/UXwI0vb2ZbC3L2VlNmcJ2b6Ttky1szCyom22EqVlrmB/GosKCoGjjct
 HOOeI+pRfUtpbpyfkwbw4EglVZqF97WqXXc2gvPJpIzF8WcWqya4F6/KEhGRaDKhXX42
 WeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254144; x=1699858944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DG0aaoeEohQ09SvvzgB8FkzO0oCsIp6ZWWtbFbko7Wg=;
 b=vHnPDdulHFWcZNUQEyHnTZRQmokW7RzO3Wz1H6qqbSL2og4XgD+FgNtD4P47bAoFS3
 aAsWogYbgEcDu3AYzq6hSM98bZbl+rLBbd4VEQXrhvFoEhFdDk9Q1YjnRHqTwTwkkdY3
 icHkXiRbYoZekyNFksoYlg4rMiTyLug/QbKFbVk70kfcDG1Q+u6QZcw8lZ1h1xCcQded
 prt0A+hfBSQusCbHuejvKkhlH0GbgTlL3ul6BCbzAjrI5pFIEvEV7Aw204gFIxw1gZB0
 dazdDYTqUb2Sq2woe5SOFX5zS/7QjDhpy0GwyhKo6f0YB0keNEMp3p6F8AnfxItIt1Md
 A5xw==
X-Gm-Message-State: AOJu0YxQr1rwj7wrKIp9ZuRy5eH8Bo7gAJBGOFtZc3CDqQZE8TwbA8Aw
 qzUhJ8UTAxOHZSj/ZKdmmoVhio3xclcRU3iVGsc=
X-Google-Smtp-Source: AGHT+IFxIt1QXeN/sgwsLG8Qwbv0022v/d1Vtxya+5PumYh/5+wdzNGBPH3OizKzdm/mRZowgdLEyQ==
X-Received: by 2002:a05:6a20:42a5:b0:15d:624c:6e43 with SMTP id
 o37-20020a056a2042a500b0015d624c6e43mr27264126pzj.3.1699254144012; 
 Sun, 05 Nov 2023 23:02:24 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 8-20020a17090a194800b0027d88387287sm5319650pjh.51.2023.11.05.23.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 23:02:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 64/71] backends: Constify VMState
Date: Sun,  5 Nov 2023 22:58:20 -0800
Message-Id: <20231106065827.543129-65-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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


