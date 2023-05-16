Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D29704B02
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:45:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pysAU-0003Ke-Jj; Tue, 16 May 2023 06:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pysAQ-0003JJ-68
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:44:31 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pysAO-0004gd-GT
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:44:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3f4249b7badso99130225e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684233867; x=1686825867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lXWfMZ/av4U9Bkl4i4+asgu1kTL2cD21X4pX4BS7V0k=;
 b=ZEsOC5Y9VDlQZrt8InJdRitnAxU24LUNYOF7MwrWMIPEqyM+5rGIWJb9eeO+sewUBP
 RfIYGVidjhUulyaqrnD3K/DitOegi5CRcl5Y49dmvP1maZpXAewuaKJcIeVgzcmfOLwf
 RSaTZ2IJnyQacrsEgb9CF9DP1m7vJdTk8RQgzEAsa5j9OMZM1XnydSxntY/Hp2jg5QwG
 UDNFca5CmXYGi3THGldFZACWLHbHmMjmNRpJhcceeaacYW5cxTFwwql4M7AYQaE8sTeM
 UBAbIgHsODAxjC71IrKEQOQ+IeShFKrpkfqQPW3M/v3oMYBqi2r1EabBcSWkdKBL5qen
 NMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684233867; x=1686825867;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lXWfMZ/av4U9Bkl4i4+asgu1kTL2cD21X4pX4BS7V0k=;
 b=Li5WGvYq/er3fKzm++f+AL6J+IabKm4QAcnfFh/QW6DVMMIV4bUJB8fOTrKWGHeWEB
 2K3Ca+LOqfskCZu7K7pxH//Z6/txg8JNlWe6UnDS2YKlblZGFxVVjs3ZmBINrd6M+OTH
 p1Z2AV24jlzAwGiL7vet/M6cWqyvl7trVF7B8EA/EFlTX/jp93mqJSEjYHaheHsnLI0+
 nmyOvD+bbs2b6oZeanfORRP1KptViCbnyw4ubbBkIVY6Coz+Rk8NNDU58EGW+3GUqDPd
 NkmfmoAqaYkOVY3u+oTK6phXAGllXl+LbVubQonZfXLBqFVemPIS6z3kvULJ7++xGIlG
 Hqrg==
X-Gm-Message-State: AC+VfDzv9/nCl2caYDMmh+q+vjvw09MD90bsIuPdI+USm0XUwmWaLfZz
 SyveBXCxyNoDYIwyt7zSqCcRRezIw245ix+XOZm5Bw==
X-Google-Smtp-Source: ACHHUZ7VOuEmTv/geC2Kuh2N2prYemfwua45q/hk5vPuVc28tjGRm1e+Jmu16qLtdDn0iIRGHGbpaw==
X-Received: by 2002:a7b:cb90:0:b0:3f4:f8f9:bce7 with SMTP id
 m16-20020a7bcb90000000b003f4f8f9bce7mr8560399wmi.32.1684233866907; 
 Tue, 16 May 2023 03:44:26 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f508115b25sm1947019wmf.4.2023.05.16.03.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 03:44:26 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D3D691FFBB;
 Tue, 16 May 2023 11:44:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH] target/arm: add RAZ/WI handling for DBGDTR[TX|RX]
Date: Tue, 16 May 2023 11:44:20 +0100
Message-Id: <20230516104420.407912-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

The commit b3aa2f2128 (target/arm: provide stubs for more external
debug registers) was added to handle HyperV's unconditional usage of
Debug Communications Channel. It turns out that Linux will similarly
break if you enable CONFIG_HVC_DCC "ARM JTAG DCC console".

Extend the registers we RAZ/WI set to avoid this.

Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/debug_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index dfc8b2a1a5..d41cc643b1 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -949,8 +949,10 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .access = PL0_R, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
-     * OSDTRRX_EL1/OSDTRTX_EL1 are used for save and restore of DBGDTRRX_EL0.
-     * It is a component of the Debug Communications Channel, which is not implemented.
+     * These registers belong to the Debug Communications Channel,
+     * which is not implemented. However we implement RAZ/WI behaviour
+     * with trapping to prevent spurious SIGILLs if the guest OS does
+     * access them as the support cannot be probed for.
      */
     { .name = "OSDTRRX_EL1", .state = ARM_CP_STATE_BOTH, .cp = 14,
       .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 0, .opc2 = 2,
@@ -960,6 +962,11 @@ static const ARMCPRegInfo debug_cp_reginfo[] = {
       .opc0 = 2, .opc1 = 0, .crn = 0, .crm = 3, .opc2 = 2,
       .access = PL1_RW, .accessfn = access_tdcc,
       .type = ARM_CP_CONST, .resetvalue = 0 },
+    /* DBGDTRTX_EL0/DBGDTRRX_EL0 depend on direction */
+    { .name = "DBGDTR_EL0", .state = ARM_CP_STATE_BOTH, .cp = 14,
+      .opc0 = 2, .opc1 = 3, .crn = 0, .crm = 5, .opc2 = 0,
+      .access = PL0_RW, .accessfn = access_tdcc,
+      .type = ARM_CP_CONST, .resetvalue = 0 },
     /*
      * OSECCR_EL1 provides a mechanism for an operating system
      * to access the contents of EDECCR. EDECCR is not implemented though,
-- 
2.39.2


