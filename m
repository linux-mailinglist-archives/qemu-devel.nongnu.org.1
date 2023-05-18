Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3617081DC
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:54:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd6S-0004Cg-Qx; Thu, 18 May 2023 08:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6I-00049d-Fc
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:22 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzd6B-0007xa-FV
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:51:19 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3063891d61aso1896310f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414271; x=1687006271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wxd+FoSXQR+gX/AlQoxBlHelx6+D0GgmomOiDV1+MQM=;
 b=dnXuYJP8GK77Bnlf4puDdjYjqiAbABXc/3oAcuQG5fWlsI0CCLiZd8uGAw4pDfSoXf
 UMOtASyPwH8TzwriFJjyBf0ZE5BU8rI+BJD6xtroiEWKe1PyljWBBlaXwLcrHNRfqyaX
 VXSBelWwyUmo76wBwxGw2i/MnYl06/F+hIIQtfSijlMcFzv9bUCty2Fguw6lWfBkCMVo
 Zfa2uWkNUBITpvXyYYk+lCaEUEECX1eEDCebmLfJV3O0IubV6QOsN7JH6RM2c5hr7qYd
 /w2eXjV7WiMM43HAirl1rBFDaE0E39jXAMQBfnzmML2y5BXS5LAPJObLuepNNbnI9KX/
 8fLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414271; x=1687006271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxd+FoSXQR+gX/AlQoxBlHelx6+D0GgmomOiDV1+MQM=;
 b=QvbPvM+1jytXSeySadrMZZlmaTspcMfsEiBqZ/16Spi/Kw2X9lXcPI59+xkC06UpeD
 icgnSwZeK0l2FcKg6e5qJTjqi3gZWPuDfrTcZU6StMa+MwyUD39JQzKGWyjCUtiSnCp2
 QBaLKPGMsWo7tNrVP4Wg3QUVQn4Got4bQXClswqq50mqgYrGDZNh/P+X6z/PHW5nN3Sv
 Gy/uzmOoHusM2jUAyBKmJXKHQ497Eh/DeRXxUqUqn2/2Gm1p9A3wLWFPTjvk+g3b0ZZY
 nk5/J+TMKw2dgj1BD9OOiAV/SvPXHMEbzSqSqNeQZj5sn3CoOnAM9DpY5hxY+Cl1KkuR
 PX3w==
X-Gm-Message-State: AC+VfDzZV1E4mNZ+8EVqJ1UehLaKP3rnyiUcSHT5FbsXbZQAckEDWXn3
 0uFel3D7609ziD3CoNCoOk0OFok5NQS8I3JpsTQ=
X-Google-Smtp-Source: ACHHUZ5ETFOsSyyzaqlqitISg9gKM4HsUxs3feDLTwSHOVLrZoAlsqWtdFbHKoKzpvA3pozvvxnAtw==
X-Received: by 2002:adf:e90b:0:b0:306:3911:dff0 with SMTP id
 f11-20020adfe90b000000b003063911dff0mr1532970wrm.4.1684414271163; 
 Thu, 18 May 2023 05:51:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z21-20020a1c4c15000000b003f42d2f4531sm5201321wmf.48.2023.05.18.05.51.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 05:51:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/29] target/arm: add RAZ/WI handling for DBGDTR[TX|RX]
Date: Thu, 18 May 2023 13:50:43 +0100
Message-Id: <20230518125107.146421-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230518125107.146421-1-peter.maydell@linaro.org>
References: <20230518125107.146421-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

The commit b3aa2f2128 (target/arm: provide stubs for more external
debug registers) was added to handle HyperV's unconditional usage of
Debug Communications Channel. It turns out that Linux will similarly
break if you enable CONFIG_HVC_DCC "ARM JTAG DCC console".

Extend the registers we RAZ/WI set to avoid this.

Cc: Anders Roxell <anders.roxell@linaro.org>
Cc: Evgeny Iakovlev <eiakovlev@linux.microsoft.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230516104420.407912-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/debug_helper.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index dfc8b2a1a5d..d41cc643b1b 100644
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
2.34.1


