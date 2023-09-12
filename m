Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3679D341
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:08:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg413-0008Rx-Io; Tue, 12 Sep 2023 10:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40r-0008GV-2c
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg40l-0003sA-G9
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:05:08 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-403004a96eeso36435985e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527489; x=1695132289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=NBpl5OQT8V8up5SSNxC1qRnSWwtVuHHFrqIRM+FlQ/o=;
 b=wRRpQhVEsOwHrfcF90v6yf93EISi82i6/OnDn1k6ffrV97wOiOU62WrFRXtubclH4h
 bU0KySoxmYl3J6oJMoP0wXSlKfIyHbmZqqhUeZ4vO7DGU9Un6F2WK+oLB31bIs9LjhlO
 EjVyBw5wkxrJGwNKr+gWkrT6a8k+ruHDfVZgl1Mb8q/v5Du7fNIH+5SQ6ch6MbblDpwv
 JnkvQUgnEdcG+lTnPJ4pi7ntx99VjuSI0I6WlvJ77bhbrgkEY/cfdpxaZ9z0wJLoXUVQ
 twcyEhJV43H51jWtSAI2iXjP+6E8lKWvJEDwxFKx45XiMJrqRvqrD8NbQUe2UydE4+wk
 qhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527489; x=1695132289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBpl5OQT8V8up5SSNxC1qRnSWwtVuHHFrqIRM+FlQ/o=;
 b=LKxYAqautbwO5lhv9OmHFno+nArHfki1bWnpC49aGarYVGZVjCiIs0N7aMexLR7JdJ
 31urdsJqWwh6xTr0eIVRJe6zRPacVPn1vXTWAq3vodWP9wUMrmskqGL1iIYyOxT0IRAY
 JosWm3ebT3q4dn69IwmO82n/AEAM1oTY4+skkVH29j+FGN7qAG8AmkmhnlXYwvMaP26X
 vnNVaYqS4Xj+nl6nRTyCDrmqDSyXACcl6aPA+HNAjQk4baX952GUQzvN1TEbkIc9ieRv
 MV5V26Joc6sAfkbJei/LHneDlvcrdWi0yf5idlcf7bQJ8ysN+1+4y1vinSiY6c3WB6QI
 uCiQ==
X-Gm-Message-State: AOJu0Yx2DccJES+1kcV0pqe3hprzA6qky5LVqSe//Y65f+BzXTaZpb/H
 1ODqQuXXaVqLAGlWFATgWRrvwQ==
X-Google-Smtp-Source: AGHT+IEUPChWGNFg36FBtIqiTWgv8P8u7qI261dlwTy8Ur4FRKTRiofoxuyEMbeNeO5NlHxkSuztpQ==
X-Received: by 2002:a05:600c:5120:b0:402:f517:9c07 with SMTP id
 o32-20020a05600c512000b00402f5179c07mr10297024wms.0.1694527489134; 
 Tue, 12 Sep 2023 07:04:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 r3-20020a5d4983000000b00317ab75748bsm12892672wrq.49.2023.09.12.07.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 07:04:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] target/arm: Enable FEAT_MOPS for CPU 'max'
Date: Tue, 12 Sep 2023 15:04:34 +0100
Message-Id: <20230912140434.1333369-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912140434.1333369-1-peter.maydell@linaro.org>
References: <20230912140434.1333369-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Enable FEAT_MOPS on the AArch64 'max' CPU, and add it to
the list of features we implement.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
v2: Now sets the hwcap bit
---
 docs/system/arm/emulation.rst | 1 +
 linux-user/elfload.c          | 1 +
 target/arm/tcg/cpu64.c        | 1 +
 3 files changed, 3 insertions(+)

diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
index 1fb6a2e8c3e..965cbf84c51 100644
--- a/docs/system/arm/emulation.rst
+++ b/docs/system/arm/emulation.rst
@@ -58,6 +58,7 @@ the following architecture extensions:
 - FEAT_LSE (Large System Extensions)
 - FEAT_LSE2 (Large System Extensions v2)
 - FEAT_LVA (Large Virtual Address space)
+- FEAT_MOPS (Standardization of memory operations)
 - FEAT_MTE (Memory Tagging Extension)
 - FEAT_MTE2 (Memory Tagging Extension)
 - FEAT_MTE3 (MTE Asymmetric Fault Handling)
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 203a2b790d5..db75cd4b33f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -816,6 +816,7 @@ uint32_t get_elf_hwcap2(void)
     GET_FEATURE_ID(aa64_sme_i16i64, ARM_HWCAP2_A64_SME_I16I64);
     GET_FEATURE_ID(aa64_sme_fa64, ARM_HWCAP2_A64_SME_FA64);
     GET_FEATURE_ID(aa64_hbc, ARM_HWCAP2_A64_HBC);
+    GET_FEATURE_ID(aa64_mops, ARM_HWCAP2_A64_MOPS);
 
     return hwcaps;
 }
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 57abaea00cd..68928e51272 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1028,6 +1028,7 @@ void aarch64_max_tcg_initfn(Object *obj)
     cpu->isar.id_aa64isar1 = t;
 
     t = cpu->isar.id_aa64isar2;
+    t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
     t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
     cpu->isar.id_aa64isar2 = t;
 
-- 
2.34.1


