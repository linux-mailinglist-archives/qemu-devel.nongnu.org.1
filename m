Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E027E1A91
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 07:59:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZO-0004Uo-Fy; Mon, 06 Nov 2023 01:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZL-0004Rp-3g
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:43 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZI-0001O1-Kq
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:41 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc2fc281cdso29838375ad.0
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253919; x=1699858719; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KY46huI3mUxtNUliqIZ5HRP38hRIGMvbGBE0iwxXC4=;
 b=FX+mVFdlKArQzE/ZsfPantgoTPpZTAmuXYHgjXAHGnzOWXKQ/Ws4s2i4WblNgUhc0r
 NXNgVo/PoY9OAsOhDO7EIVx3/maZVtTAMAJBj9mUYavdI9v2ob2vD2cptVi+M1nnw9Ij
 jfAhgacPar1XndP4n+n+WO+Z5RGr2wgsZ7+KloHLulAVgKm5NA4Ku+kYBObFILzqtnPy
 g+AxK81+OulOfwr5JfoMXS9PC8LjX9MjboC+0Oaed4aascQJEQa2D11ccPZirHa2X7ef
 WMEqG3lhSN6Arlmy88EQedLUt+GAYDPUmklhd/+95xcrJWwgdxV723fI7bWbtwjGtnTE
 6cjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253919; x=1699858719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KY46huI3mUxtNUliqIZ5HRP38hRIGMvbGBE0iwxXC4=;
 b=tXRMD4ubLsX6e4zFfrr5IxH1X7v8TDiSMBe1x6KGEdLSzu9gyvMD9njnvH8Ffmv2hG
 DT+XmhlxknWfmlibf6tn5QOz6yuptfIurCsaunTeLy57hCtM8Fyik105JGw2puOfWsUm
 keNArDVcMsFMlKQJBa63CghUF9pmn36TpmAegRFFgEUN9XhJdpEkLGeNROlRGcFiL0HC
 yrA01tzdZ/ctGGsskEg7ydf6ZtuZRVK0/UwUR3EKv4Ru1K25IWPbaJ0vQ3SF9fl5jHp5
 XIfZixQ7GcH6ZFk79A4AhaLqS362RaA5uqira+m6iL+Mgv7Cow7czhxGLCh8gViRAARI
 F3zA==
X-Gm-Message-State: AOJu0YzsZy872TPfHF5vR4EPo8gOI8woURIjP0x5KkPhVzs72b8u/5PK
 6WnuCGtdal5nI1tCw8iCYWiS6L3r7Kx8wOkMMo4=
X-Google-Smtp-Source: AGHT+IGkzlgIBtWA5ImgnpqHrFY6itWZc0CDFcvkuzpBa1de+UEaBT0bGgDr++BmZNBeJRm9FswXwQ==
X-Received: by 2002:a17:902:904a:b0:1ca:86db:1d31 with SMTP id
 w10-20020a170902904a00b001ca86db1d31mr23046151plz.7.1699253918970; 
 Sun, 05 Nov 2023 22:58:38 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 11/71] target/microblaze: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:27 -0800
Message-Id: <20231106065827.543129-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
 target/microblaze/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index d24def3992..51705e4f5c 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -22,7 +22,7 @@
 #include "migration/cpu.h"
 
 
-static VMStateField vmstate_mmu_fields[] = {
+static const VMStateField vmstate_mmu_fields[] = {
     VMSTATE_UINT64_2DARRAY(rams, MicroBlazeMMU, 2, TLB_ENTRIES),
     VMSTATE_UINT8_ARRAY(tids, MicroBlazeMMU, TLB_ENTRIES),
     VMSTATE_UINT32_ARRAY(regs, MicroBlazeMMU, 3),
@@ -60,7 +60,7 @@ static const VMStateInfo vmstate_msr = {
     .put = put_msr,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32_ARRAY(regs, CPUMBState, 32),
 
     VMSTATE_UINT32(pc, CPUMBState),
@@ -92,7 +92,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, MicroBlazeCPU, 1, vmstate_env, CPUMBState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


