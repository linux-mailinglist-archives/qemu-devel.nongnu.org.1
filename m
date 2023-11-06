Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E90417E1AA1
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:01:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZG-0004Pc-Ja; Mon, 06 Nov 2023 01:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZC-0004OV-Sd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:34 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZB-0001Ma-3M
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:34 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so27807415ad.2
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253911; x=1699858711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diCkc088SIM1OXDEE8e4GhljSyDmKgwjUD6eAHwsXOg=;
 b=ZxCz15fhhZbq5HjcZCf/+NIUYtkkIoJq0NsNotBv8IXT7wih4GQAXqi8hAs6WF1kBY
 DwBXSle4koWh7gFrPkp7lcj6SHYIGe6lJ96DKgIgrkv22j8DVV15WVXEt5A1xMQad9OR
 17qbXnTmYjgE98sAfmCYh1T/fu6loF4rkmOIY+oezf5pJ/OKYXWpVtCJqKhZ/v+bxZL0
 Q6M4VwBoEaFBimcUhSUrIr6AVK848Yy7cmsHZqTCWe893fyKdixUR3XPq2kEacMZyMkc
 TWhvH6VJMPGGMDEGVOT6a+g7tPngPj8F19V8sXs55cHxphcMHqbLQR7n45uNZ5AOCKEM
 YKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253911; x=1699858711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diCkc088SIM1OXDEE8e4GhljSyDmKgwjUD6eAHwsXOg=;
 b=QQZG4Z7kfIedNCcmvNt7JtHBT9VWRj+RleOwMIt5QkBrtE8pu/JWOMF4S60yVIasfl
 /KUDysFOStRVSJ2lj0xdsunpY10W83M0tT0bohTKeG8uUOWRPtJs0uoqTdMQjSUMdPaF
 TwNZWwh6fg6UErvVpT1hKnQtlt4AVoLbK0j4V2JMvnRB6Q+xiuy3SNgeJlsbsIJMJ9L5
 DQ2NTNF9rmxPN68zFzVdd2hDMKJYFtWp5/AFJX6NzcqWzdn4c6YM6rIJrcO2Fu4M3BRX
 U2ysPkClIyOBVQFcB6udtok88hQ4Gj9UvcfDCCWkOmo3TrMrbXkRDnRgiHyPkOltwMs/
 PW2w==
X-Gm-Message-State: AOJu0YybdiknV2eC+CECpjQcXc/ZwkxS56wW4ApOWDeXiY+ha7/7efWG
 8L5lfV4Sq8xxIfl/B1ZLpmmxdD9GVaGyBIXny7w=
X-Google-Smtp-Source: AGHT+IHthieN0iMcmdwbGzSwOXvGETxkeYL3ezUqouFRyz3f8h5Y6nCOyCG+Yh1EHsCaIjl2MlwzSg==
X-Received: by 2002:a17:903:430c:b0:1cc:45df:4710 with SMTP id
 jz12-20020a170903430c00b001cc45df4710mr16141926plb.40.1699253911548; 
 Sun, 05 Nov 2023 22:58:31 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 03/71] targt/arm: Constify hvf/hvf.c
Date: Sun,  5 Nov 2023 22:57:19 -0800
Message-Id: <20231106065827.543129-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 target/arm/hvf/hvf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 757e13b0f9..203d88f80b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -36,7 +36,7 @@
 #define MDSCR_EL1_SS_SHIFT  0
 #define MDSCR_EL1_MDE_SHIFT 15
 
-static uint16_t dbgbcr_regs[] = {
+static const uint16_t dbgbcr_regs[] = {
     HV_SYS_REG_DBGBCR0_EL1,
     HV_SYS_REG_DBGBCR1_EL1,
     HV_SYS_REG_DBGBCR2_EL1,
@@ -54,7 +54,8 @@ static uint16_t dbgbcr_regs[] = {
     HV_SYS_REG_DBGBCR14_EL1,
     HV_SYS_REG_DBGBCR15_EL1,
 };
-static uint16_t dbgbvr_regs[] = {
+
+static const uint16_t dbgbvr_regs[] = {
     HV_SYS_REG_DBGBVR0_EL1,
     HV_SYS_REG_DBGBVR1_EL1,
     HV_SYS_REG_DBGBVR2_EL1,
@@ -72,7 +73,8 @@ static uint16_t dbgbvr_regs[] = {
     HV_SYS_REG_DBGBVR14_EL1,
     HV_SYS_REG_DBGBVR15_EL1,
 };
-static uint16_t dbgwcr_regs[] = {
+
+static const uint16_t dbgwcr_regs[] = {
     HV_SYS_REG_DBGWCR0_EL1,
     HV_SYS_REG_DBGWCR1_EL1,
     HV_SYS_REG_DBGWCR2_EL1,
@@ -90,7 +92,8 @@ static uint16_t dbgwcr_regs[] = {
     HV_SYS_REG_DBGWCR14_EL1,
     HV_SYS_REG_DBGWCR15_EL1,
 };
-static uint16_t dbgwvr_regs[] = {
+
+static const uint16_t dbgwvr_regs[] = {
     HV_SYS_REG_DBGWVR0_EL1,
     HV_SYS_REG_DBGWVR1_EL1,
     HV_SYS_REG_DBGWVR2_EL1,
@@ -2010,7 +2013,7 @@ static const VMStateDescription vmstate_hvf_vtimer = {
     .name = "hvf-vtimer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(vtimer_val, HVFVTimer),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1


