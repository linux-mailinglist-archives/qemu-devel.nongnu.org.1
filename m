Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89026831B77
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:36:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTUM-0000k6-7i; Thu, 18 Jan 2024 09:35:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUK-0000jf-Ib; Thu, 18 Jan 2024 09:35:24 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rQTUI-0002jy-2W; Thu, 18 Jan 2024 09:35:23 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d542701796so71715815ad.1; 
 Thu, 18 Jan 2024 06:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705588520; x=1706193320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzJXeQ+PvoT8R5v1TQeEmYDb1fPyOsrjHcJXrlSHSmA=;
 b=d2uAW/h+93zd26fXdGQYCzrmDRZfoHBrDdbBhze6ehIbZ6C/M++a53b/BiI+F6bpae
 47c2u/t/i3TdHivRq2whlYZwW/shCikdFyXOmHQ7p2I8LhY1wwUrjY9G607L7UQjAKEa
 2hXIt8BlN3nYuUHDMrhy0JD49gjYVsvgheAU4/2giarO4wp309QZ9kPLx813l7eo5/fU
 1pTCaGA8lMbSohjfgqhEnrUdKL4s0sPWsBJWI1rN6FKgdNOnHdTdYF7t+H7RsJLVeAR3
 DDsuMoa8DuM6FhceYQdqHeXv3RYEDlDWsZ/wfxqnI95qnnm2rg28oDrsU6pQ5QcLViaa
 fEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705588520; x=1706193320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JzJXeQ+PvoT8R5v1TQeEmYDb1fPyOsrjHcJXrlSHSmA=;
 b=IMwdAfUwaZBrvTKTYwe6HGC9aAss5tQvkVDy9ttwKgFjHFT2ub1mnirz92hVKm6z5w
 RZt+DkBDPBCYbe0ExNQLoCR3hJbFAIhuFs53y1ommTmoJRQt7qROPKrTPKyWTNNm1WuU
 eG25CsaAy2EgWsxUwkwv9lg29iqRB6DRzz5CKvK2Nq8eylImZVf3m6z1Cgm7OzjT37I8
 5Jneium3ThjrHkciBe+CZjsRd7s3j1z/WN3nVU9Q4eai4zkGFVgoCqtKW643RifAnIoh
 LcmjIfEEZ2opco06dJdqlzZCCr2E+Eb8AtXNdpptRZKjM30tJBHhn1C01LEcsRgaHffQ
 G/6w==
X-Gm-Message-State: AOJu0YxQ3KAARmo9bsZntQl85TUS7rRL2nn2cCmLinbqdTLRayQd6saU
 w+yOgjNp1clZA5QjxbWbhBuB8yeOOxaWWeuDUhmvUbZb+bR92i9PN3f2znQl
X-Google-Smtp-Source: AGHT+IHuWxmaXV21z3OygcGZgWiecPNVCw+iKtaylSbpyOMcJBYwqgnIB15dRu9cGDDofjzBHqRt7A==
X-Received: by 2002:a17:903:258b:b0:1d5:aeee:e756 with SMTP id
 jb11-20020a170903258b00b001d5aeeee756mr784084plb.26.1705588519752; 
 Thu, 18 Jan 2024 06:35:19 -0800 (PST)
Received: from wheely.local0.net (124-171-76-150.tpgi.com.au. [124.171.76.150])
 by smtp.gmail.com with ESMTPSA id
 la11-20020a170902fa0b00b001d4ac461a6fsm1484371plb.86.2024.01.18.06.35.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 06:35:19 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 3/4] target/ppc: Add machine check interrupt injection helper
Date: Fri, 19 Jan 2024 00:34:58 +1000
Message-ID: <20240118143459.166994-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240118143459.166994-1-npiggin@gmail.com>
References: <20240118143459.166994-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This matches the NMI injection helper function.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_events.c    | 3 +--
 target/ppc/excp_helper.c | 7 +++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index cb0eeee587..4be9a5ba3a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -875,8 +875,7 @@ void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 
     if (spapr->fwnmi_machine_check_addr == -1) {
         /* Non-FWNMI case, deliver it like an architected CPU interrupt. */
-        cs->exception_index = POWERPC_EXCP_MCHECK;
-        ppc_cpu_do_interrupt(cs);
+        ppc_cpu_do_machine_check(cs);
         return;
     }
 
diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 58fd08729a..133477acba 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2601,6 +2601,13 @@ void ppc_cpu_do_system_reset(CPUState *cs)
     powerpc_excp(cpu, POWERPC_EXCP_RESET);
 }
 
+void ppc_cpu_do_machine_check(CPUState *cs)
+{
+    PowerPCCPU *cpu = POWERPC_CPU(cs);
+
+    powerpc_excp(cpu, POWERPC_EXCP_MCHECK);
+}
+
 void ppc_cpu_do_fwnmi_machine_check(CPUState *cs, target_ulong vector)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
-- 
2.42.0


