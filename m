Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DDB7D794C
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 02:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvo2p-00073d-DQ; Wed, 25 Oct 2023 20:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2l-00070v-GE
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:12 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvo2e-0004q9-Ur
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 20:16:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cac925732fso2239585ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 17:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698279351; x=1698884151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yydutm4GC4YL//fMbFA0uGJAc/KbeYkkAz+lArCCg2s=;
 b=OLg3jWhCXXwFU7UCxL9P47+pazgnuoxU71LfZg3C90HE5gRLV6FmAzYImSLdokK+wj
 mAb/k7W67B+g9kby74HQwhUg/1u5tHjJXfA9VRifEG3mKVu9DZ6WFQrh3jDJEdjt/PnX
 KBpyYCWhYM2yPeQL2eFIoaZ9lqXiooFCnmCX6CC9ylvojglEnWkrR3ScmwswRh01aWiW
 X/dCUdoikgwB/o++1uKFUEm/5DqEILz+3eD/6k5R4EZWtd+75oRJmUFbiS0uDdVDjLnn
 37E14xEtdza6UDgGIqjIg/K31E886vmml3VMeZXZy9l3/3k0HtuiahN6VmooN1gu/ud+
 nr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698279351; x=1698884151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yydutm4GC4YL//fMbFA0uGJAc/KbeYkkAz+lArCCg2s=;
 b=pYLFN/ubecOq/9GykwC11W+TaLwd+CttkiXn1D68ncCLOuZoHEqK1kwjcW5XCpCGoD
 iQiO2mRr6mX+QcUq1WcMchWXwg7KJzSZRiJ0Bay0JHQpG67+G6jSuQOr0z3M+DTIUF78
 +FwojKQWZFOLcpiAeeHgegeO4QXxgrPR8iIC+DGxjtJdJtEpHt2BRSB+j4Ck5DuMbhlm
 Sqh90RcDEj3s9vjaGq/1JnOwCY88hpM8os6VTeJ2w6/SEBzPq3QImI1Gm3jMdcOTdewb
 A4LdRongjmAdW1vM8ictUGlG+IBIPcOJUd1O2v+DifeB+0LqirqW4TYDgkB3E9cyFkHa
 E3Cw==
X-Gm-Message-State: AOJu0Yzb82kwf2cCwaFphJcFxQtbZTitwJKzsmyZQSBfTaNZxI59w1n/
 IyFLs3ND0n5gMk9SlrvRqFyJgCBEJhPGU9pJiGw=
X-Google-Smtp-Source: AGHT+IFI8jKJRIH3V2MXC3tpYWbfuB4oMi3nFl7mXnTOX/fq6DqEBQyu9sPkNgHD8N/H0rOZ7BR2wg==
X-Received: by 2002:a17:903:246:b0:1c5:bc83:557b with SMTP id
 j6-20020a170903024600b001c5bc83557bmr16248766plh.51.1698279351643; 
 Wed, 25 Oct 2023 17:15:51 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ij23-20020a170902ab5700b001c582de968dsm10038433plb.72.2023.10.25.17.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 17:15:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 05/94] configs: Enable MTTCG for sparc, sparc64
Date: Wed, 25 Oct 2023 17:13:48 -0700
Message-Id: <20231026001542.1141412-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026001542.1141412-1-richard.henderson@linaro.org>
References: <20231026001542.1141412-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This will be of small comfort to sparc64, because both
sun4u and sun4v board models force max_cpus = 1.
But it does enable actual smp for sparc32 sun4m.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/sparc-softmmu.mak   | 1 +
 configs/targets/sparc64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 454eb35499..a5d9200382 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d3f8a3b710..36ca64ec41 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
-- 
2.34.1


