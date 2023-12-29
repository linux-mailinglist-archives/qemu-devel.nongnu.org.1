Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6FE82019E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:25:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLG-0006xz-0B; Fri, 29 Dec 2023 16:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLE-0006xo-An
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:28 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLC-0006de-Rw
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:28 -0500
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6dc02ab3cc9so1977064a34.3
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885065; x=1704489865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=D1wtmagA20UyDQGh/RhpJV+m3qRJC3+9KhhosTNeN7E=;
 b=PPxxqXkbIqfCNQ0ji9JmuN5itT9f5q1QVh1EOWls28yz/qQiH0WsAdjIoICaTYMD19
 LqUsnM6quF+Z3jpGGcreJz43nzS+UVmTdBx4T9FuohZ46cXddVFv7voLgz102rP6UPUw
 y3JD2PbGAa3RALuH2sIASauhrZK7etEHbD9B7BRXHG8mf4KvmbJ7MdcHk+CVFMWyKXok
 8zaU5cC8nRsnkIwJ1zTPEY2ReY67Am5zX037mzy0p51J6/Q650T3DpJbYQK+rV6mjF6i
 N0dxamnGwjAQbye6hOJnX/0h1G8BKFsu+oWKNn0CUqVAdawnxfCo+3d84m8oi7YLGqZz
 t0kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885065; x=1704489865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D1wtmagA20UyDQGh/RhpJV+m3qRJC3+9KhhosTNeN7E=;
 b=LgHO6RBIg0dE97gWyx+ozGYcxQHsfxS5lvx1t9zllR58gGJfOvi9ONzsDH+cWfMx15
 Mq4Ts4U/tGzdxYlhUFcpSglh9P1Y9tVQWsVCYsZ0YDECoQFTkdjh87cjMJdTMpB4CbvR
 QORC/avbTq90JuoK6ZIe6rHuzx0OU/46jaHSCQG4Yo1rNDdxBlrIRkopBak2P1kFcRxz
 CTN8DDZjntz911izoP/su035q/GsAGq8VsyN8z7ilsp8dmGODUAQ7mxDfyhlEATFw3as
 9fde/5n9XUpaT30Y/RBTZ2/E3IqGEcu6VpqNTCm9rVlEEyCsS4yWF/lpxfaQo2XnJ2OI
 AvKQ==
X-Gm-Message-State: AOJu0YzNf4U6NzDit/lf7tNiCY1nhQdISzpu3Nr8Y77/jJ+iVueUJ/jZ
 t+v1uyo5PwpDrzKXOh1SgvzN3vcQPOVBYPmPy1EgVU3h21QjLQ==
X-Google-Smtp-Source: AGHT+IEIJ3MwtCVjRM1LMCcGrk5rwap8SL5TyNlerqDGqzC0bzeWf1bpmlPlELilKAUg0IJTKncclg==
X-Received: by 2002:a9d:7c88:0:b0:6d8:74e2:c09a with SMTP id
 q8-20020a9d7c88000000b006d874e2c09amr11349202otn.76.1703885064991; 
 Fri, 29 Dec 2023 13:24:24 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/71] target/openrisc: Constify VMState in machine.c
Date: Sat, 30 Dec 2023 08:22:48 +1100
Message-Id: <20231229212346.147149-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
Message-Id: <20231221031652.119827-14-richard.henderson@linaro.org>
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


