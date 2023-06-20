Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD948736A1B
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:59:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBZ3a-0007FU-Aa; Tue, 20 Jun 2023 06:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBZ3Y-0007ET-KZ; Tue, 20 Jun 2023 06:57:52 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBZ3X-0000hz-0p; Tue, 20 Jun 2023 06:57:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6682909acadso1351387b3a.3; 
 Tue, 20 Jun 2023 03:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687258669; x=1689850669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+doDSOWQ/yYEapg3XaTRgcOqrIoUXvANsMUQVhLDyMA=;
 b=RuWDoeE2SRjM73rbyhd6QEMqM9I+3QFYSwcVvF6B85HWv1tlKcn+Td8bImi6Rcz+sD
 KBXq5NckO74hkl77LR9/Ork7yfbSUJS77ukV0TPgOZ2tOVgcbKRHjOw4SE1aU3xCYr1P
 OnEP2KEzSKYIFR2TWOL5dSmD+iqnzk0eJvEjRJZGbHwTv9NcY5/bhIW5yGbpz8wQSp+X
 nMsrEWdFCejTdoXTL/A6dhgOCgXhUdMnO98hAXAVAJD2cLAFKz6FFezcZgL9yC90OEAz
 a5YxG6v04IbB4Vfuddjzcz8IisiQU4htznl8GxCViMczPGs3wCmllYny/HSLZJaaiKR+
 gVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687258669; x=1689850669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+doDSOWQ/yYEapg3XaTRgcOqrIoUXvANsMUQVhLDyMA=;
 b=Nq0DKQJN8xKqdgSdPz0GU3Lv0hkXXMCF1Oj7SDIET0m6uwfmrYc3nkH9FeNw4rqSg1
 vZeXG/cAk8zkQfvje1aCL2NtjsppV2avDNxPlHAOECcEvnvJg/Dm2cD6GkIfcp33ZF7t
 YufhvRHgWfjveG9RpdzVhTILFPYl6z08Au4AIHXPb/GMZiLeWi9YN8bx4WUs5jMX3d6Y
 J2Q30YOYrDgf/0gvKruG658kO2pE42iVKIEqVv+Y9PmgAm0ER0zYx2JaHQ7y6Yjn+nE8
 fJsco/DQCxItn1FQwop6200GGLcxDlWeoAYUwFdGGf4IH29uD59ntqiHF1O3jOiH6pOK
 HCEg==
X-Gm-Message-State: AC+VfDwPH3DR4skjjq7ZjGIv18s73l5zcAXBpKek90Te1U30hHCfgx3D
 gch+3FFnVoJFLHLKUYlL7LRqDEkDWtc=
X-Google-Smtp-Source: ACHHUZ5LSp4jZWtmh7mHwn7OWSY27v/HyqWbLFQzznfYRDAHN0r/MCkdDlmkpcKeOq/DoNu5td4WjA==
X-Received: by 2002:a05:6a00:1407:b0:668:94a2:2ec7 with SMTP id
 l7-20020a056a00140700b0066894a22ec7mr1947562pfu.25.1687258669141; 
 Tue, 20 Jun 2023 03:57:49 -0700 (PDT)
Received: from wheely.local0.net ([124.170.190.103])
 by smtp.gmail.com with ESMTPSA id
 n13-20020aa78a4d000000b0064fabbc047dsm1126412pfa.55.2023.06.20.03.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 03:57:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: [PATCH v2 1/4] ppc/spapr: H_ENTER_NESTED should restore host XER ca
 field
Date: Tue, 20 Jun 2023 20:57:34 +1000
Message-Id: <20230620105737.160451-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620105737.160451-1-npiggin@gmail.com>
References: <20230620105737.160451-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Fix missing env->ca restore when going from L2 back to the host.

Fixes: 120f738a467 ("spapr: implement nested-hv capability for the virtual hypervisor")
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr_hcall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index b904755575..0582b524d1 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1773,6 +1773,7 @@ out_restore_l1:
     env->cfar = spapr_cpu->nested_host_state->cfar;
     env->xer = spapr_cpu->nested_host_state->xer;
     env->so = spapr_cpu->nested_host_state->so;
+    env->ca = spapr_cpu->nested_host_state->ca;
     env->ov = spapr_cpu->nested_host_state->ov;
     env->ov32 = spapr_cpu->nested_host_state->ov32;
     env->ca32 = spapr_cpu->nested_host_state->ca32;
-- 
2.40.1


