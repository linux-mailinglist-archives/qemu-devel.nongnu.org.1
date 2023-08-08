Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7C773771
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:14:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8g-0000hK-MS; Mon, 07 Aug 2023 23:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8d-0000R6-8k; Mon, 07 Aug 2023 23:12:03 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8T-0000C8-LC; Mon, 07 Aug 2023 23:12:02 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-686b643df5dso3542108b3a.1; 
 Mon, 07 Aug 2023 20:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464312; x=1692069112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXoNaDMEIb16Of1z+9cYJroeocVZ6F6dzNKf9wLt4a8=;
 b=dDEKvxkUHvFwcuhC2e1u4F19bxYR3bGDiaTPAWV6/HdMUBd1g28M9Kb8avbhbKUBko
 MOLL08FLMRTlmcqfJfR79vLiB/7Qkw7wrgwX/ibDdlqa4sVmu3XZT7P3mS2Qe+MLK645
 Cza54tjG258mFeU+2RMlPvebycr0XHY5uhptXCtwlBUtJt24S2k6m0wYTTfUpS6wsJsy
 MXQVF8ildWZFVT10n3pjootLr/5NEOGRcy++vldQCwjQbb+2vrUztO5ElqUv4pSiQvwI
 kDpeBPJ05pq4ZzLQ/Ek2Q2IgJJeE+Q0lWoMkNtBZ3WohqKW3icK1fT5SYTGn/1WYIPXy
 XAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464312; x=1692069112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EXoNaDMEIb16Of1z+9cYJroeocVZ6F6dzNKf9wLt4a8=;
 b=kloEuYnrB+06mysdsBQT+lYAADn2k+Yu7Jj1Sz+B/KMda0S/KYKfPa89ZfU+Gyv3jk
 3gaEhdLu2+fPOWNDTcpjXvfJZMVm4+A02nNL0sAqrcpIT6OGxMzV8uHxvrZOz+RjszyA
 AZ5MmR9eaR1/NrVM0Hj7LKmZGj1Eg4tbpXoU8m2+klGVjbFt0xTbrRqQYGHzsHMjSar/
 f82gkiQwdsSDVqe1TrFngkaES7ZhsGrgrDKu5Ndk8VtXnIVNKRDze8b0NGBgiJoi0z66
 FdwkxneInLX92LndSo8je/WtKIlVWe5SM0HsmV/UW4DgkNSD0CqWfPPLickZHkQhG79o
 YI9w==
X-Gm-Message-State: AOJu0YymzY6ZL8Gl39dLuccnaSiapsV3PuCYu/Z9qoyg36zZVLLplYBC
 sNqaBUNgfd1VSAU6hTI9WXyZ+fImNPY=
X-Google-Smtp-Source: AGHT+IFjwmj+sRni1CyvSSVUX3oab5G1rxwYphtMGjlvUPIbcr1VsLiAMC1EuGoq8wSrw0rXATjxtg==
X-Received: by 2002:a05:6a00:1810:b0:686:25fe:d575 with SMTP id
 y16-20020a056a00181000b0068625fed575mr10134947pfa.11.1691464311982; 
 Mon, 07 Aug 2023 20:11:51 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 6/6] spapr: implement H_SET_MODE debug facilities
Date: Tue,  8 Aug 2023 13:11:16 +1000
Message-Id: <20230808031116.398205-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
References: <20230808031116.398205-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Wire up the H_SET_MODE debug resources to the CIABR and DAWR0 debug
facilities in TCG.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9b1f225d4a..b7dc388f2f 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -3,6 +3,7 @@
 #include "qapi/error.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
+#include "sysemu/tcg.h"
 #include "qemu/log.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
@@ -789,6 +790,54 @@ static target_ulong h_logical_dcbf(PowerPCCPU *cpu, SpaprMachineState *spapr,
     return H_SUCCESS;
 }
 
+static target_ulong h_set_mode_resource_set_ciabr(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong mflags,
+                                                  target_ulong value1,
+                                                  target_ulong value2)
+{
+    CPUPPCState *env = &cpu->env;
+
+    assert(tcg_enabled()); /* KVM will have handled this */
+
+    if (mflags) {
+        return H_UNSUPPORTED_FLAG;
+    }
+    if (value2) {
+        return H_P4;
+    }
+    if ((value1 & PPC_BITMASK(62, 63)) == 0x3) {
+        return H_P3;
+    }
+
+    ppc_store_ciabr(env, value1);
+
+    return H_SUCCESS;
+}
+
+static target_ulong h_set_mode_resource_set_dawr0(PowerPCCPU *cpu,
+                                                  SpaprMachineState *spapr,
+                                                  target_ulong mflags,
+                                                  target_ulong value1,
+                                                  target_ulong value2)
+{
+    CPUPPCState *env = &cpu->env;
+
+    assert(tcg_enabled()); /* KVM will have handled this */
+
+    if (mflags) {
+        return H_UNSUPPORTED_FLAG;
+    }
+    if (value2 & PPC_BIT(61)) {
+        return H_P4;
+    }
+
+    ppc_store_dawr0(env, value1);
+    ppc_store_dawrx0(env, value2);
+
+    return H_SUCCESS;
+}
+
 static target_ulong h_set_mode_resource_le(PowerPCCPU *cpu,
                                            SpaprMachineState *spapr,
                                            target_ulong mflags,
@@ -858,6 +907,14 @@ static target_ulong h_set_mode(PowerPCCPU *cpu, SpaprMachineState *spapr,
     target_ulong ret = H_P2;
 
     switch (resource) {
+    case H_SET_MODE_RESOURCE_SET_CIABR:
+        ret = h_set_mode_resource_set_ciabr(cpu, spapr, args[0], args[2],
+                                            args[3]);
+        break;
+    case H_SET_MODE_RESOURCE_SET_DAWR0:
+        ret = h_set_mode_resource_set_dawr0(cpu, spapr, args[0], args[2],
+                                            args[3]);
+        break;
     case H_SET_MODE_RESOURCE_LE:
         ret = h_set_mode_resource_le(cpu, spapr, args[0], args[2], args[3]);
         break;
-- 
2.40.1


