Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D27E1A95
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:00:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztZP-0004VG-QI; Mon, 06 Nov 2023 01:58:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZL-0004T5-Fz
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:44 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZK-0001OF-0c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:43 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3388621cso39854775ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253921; x=1699858721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FD5wy/U9+bZCbaz0itBRFKutSZtCYzbYclfjlyxHVl0=;
 b=aEEnK4axA9B3VfGqCcpvNli7//hbA03xg/nImdH8EdypbRHOo86oxnTyVdOXuOFZgC
 tclmc3oDhY5CPvNeCuTgFBOCfIiJRMtmt/TA5W2wsdP5oXwPAvTqJeziyTMxUOTM8NYp
 B/XbBBbT14Lhi22kF+Row1aoikrte2q8IpqIGuNmbVDqE0xVAcc4gX7ZtgHrHUFLVSKr
 /Ny9Mmv2neKqzPP6uErgchf8/zXkjbEToHJO9aM4UhJy9bDfD8izU78CulPLdezeoSMu
 PLcyBRQlDAbWu/XUnPQbuYkce2k8sz6gJvLyCeFNwlUJVTCFgsyjxbw2dvMGaFG4kxp8
 qsHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253921; x=1699858721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FD5wy/U9+bZCbaz0itBRFKutSZtCYzbYclfjlyxHVl0=;
 b=OTCQl+bL8iI61WRp1KOyBQboghiNlKDt9nM6+N8ECiH+vA/PwAk4MN6ca6IuhCcQ48
 IPoXoo4uTT9w0uNrvBR6ZyVOHjP2plQYBjspQkntlPraz1gM7uafABHPUyf9SLhFGkEN
 GXQH2vEyexKl+tpo2mnbT8g6087ch2ir+gaOyRS2hr/y2eMkRbQpOkBvZPXfR+8ziYWz
 mFrybYgjptyP1z8F6el5issLpAXOH3E0kwCxlxZInnjx/dG/jcVwgfjiZwJAcnA4S0ZF
 k7bMQxWHHL1xRJ6D2kOLBHPxUy2NLrN4fOI7d9yOi2libgQKA8yFw3rFngT++NA+0RyW
 EDsA==
X-Gm-Message-State: AOJu0YzLciR7TDLWkONuybtMHSTYAwzyBXDfQoTckUsbw9iSzPoQ1d9F
 FsV+8ECP0P2cjMWRYbjLneNIO+7eXXPVQGb7J5o=
X-Google-Smtp-Source: AGHT+IHrVspuCwGWUC2XF0c4qa3WRr4zWztxRbJeT6Z6SMv3Cn9PdFbHV+pUC9MY7wutOxFofF5WtA==
X-Received: by 2002:a17:902:cecd:b0:1cc:6078:52ff with SMTP id
 d13-20020a170902cecd00b001cc607852ffmr14669326plg.26.1699253920872; 
 Sun, 05 Nov 2023 22:58:40 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 13/71] target/openrisc: Constify VMState in machine.c
Date: Sun,  5 Nov 2023 22:57:29 -0800
Message-Id: <20231106065827.543129-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
 target/openrisc/machine.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/openrisc/machine.c b/target/openrisc/machine.c
index b7d7388640..3574e571cb 100644
--- a/target/openrisc/machine.c
+++ b/target/openrisc/machine.c
@@ -25,7 +25,7 @@ static const VMStateDescription vmstate_tlb_entry = {
     .name = "tlb_entry",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(mr, OpenRISCTLBEntry),
         VMSTATE_UINTTL(tr, OpenRISCTLBEntry),
         VMSTATE_END_OF_LIST()
@@ -36,7 +36,7 @@ static const VMStateDescription vmstate_cpu_tlb = {
     .name = "cpu_tlb",
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT_ARRAY(itlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
                              vmstate_tlb_entry, OpenRISCTLBEntry),
         VMSTATE_STRUCT_ARRAY(dtlb, CPUOpenRISCTLBContext, TLB_SIZE, 0,
@@ -71,7 +71,7 @@ static const VMStateDescription vmstate_env = {
     .name = "env",
     .version_id = 6,
     .minimum_version_id = 6,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL_2DARRAY(shadow_gpr, CPUOpenRISCState, 16, 32),
         VMSTATE_UINTTL(pc, CPUOpenRISCState),
         VMSTATE_UINTTL(ppc, CPUOpenRISCState),
@@ -135,7 +135,7 @@ const VMStateDescription vmstate_openrisc_cpu = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = cpu_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_CPU(),
         VMSTATE_STRUCT(env, OpenRISCCPU, 1, vmstate_env, CPUOpenRISCState),
         VMSTATE_END_OF_LIST()
-- 
2.34.1


