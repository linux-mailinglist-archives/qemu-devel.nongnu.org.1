Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D607CFB6C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:41:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTCe-00038N-TG; Thu, 19 Oct 2023 09:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBw-00021i-I8
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:02 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtTBr-0001Ei-Fx
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 09:36:00 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32d849cc152so7012087f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 06:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697722548; x=1698327348; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Y0fdYuZ/itTuCs4C9nQ/nu3aGMsyGS4D2cdzozItBYw=;
 b=ckdpjNORJQs2G4XiwGOsB1k9dCu+cSVTqJdVr7lx9hl2Q+aHsXrGhmqPy00BhRH4DY
 Sd9XPq228nRYzHyomQ935QLjJrp3G/oBIKyUysVB++Ah+FMUZMorZ5lNMUrjVTm5Kc/g
 g4aYXdEeaYfK8kuFBG8w4pwiUSMWdNyOnQ/SLSHy0JcDs48KnjtLkzHssYKU1IOyzG7R
 WTjQb2aP76H0U1S2/pOfhpVUw9mk6ZxvXbe/N4Lyx0Um8+9xoYF9CIU9SolnQiva+z51
 ijE0Ux3ysD0jazO4728ndEiGNGatsGK1pDnSxybt008cm843Iw1V9G1fFC2mvQxgo9r8
 Xo4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722548; x=1698327348;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0fdYuZ/itTuCs4C9nQ/nu3aGMsyGS4D2cdzozItBYw=;
 b=drwRQ51PonwNig04+yWMCYdlpCMDM3/Zw7M5DSEj9e9L9w6t6qkh48+ypKfixVGS1G
 hI673zAVOfoC0ZoXQvWmHL3sEaMF6TkBPTe2GPgp0QI7frjjC7fp8rlVcf7andJ8YYep
 v4OyAq9bJFCoc1UA/zFu3WHBY9W0D6Xu9lFVU8CJ8d6PxOONFas5nXSZPvnZa5ZD7Ry8
 HNbrcEBqqa29KpbGu9ZUZ2ASIaIAlbbUDuRDZ9zn4hpFlxr6q9lX0SmR4WR6gulHOPfl
 jNaB1HIywNvX1F7TkpyE78mC8WGN93zKwRICKTNfVxnC1AhPJydF0YgaHcpMMtDf5YD6
 zO4A==
X-Gm-Message-State: AOJu0YxuHlr9AS1OrsHNanOqfcAVZlAKFFggZIjIWaqb74YpG/dzCnlo
 A54rwgWSUx9bVFAjgkqIu2cYskV1Rgy5O7tB7ZI=
X-Google-Smtp-Source: AGHT+IFGkU1ZyQv2mBfsA8de4YXOBNKd0srFv9mSGqtSW6TEwL7fDeHGrGpJ5uBQi0+QysWMEfmQxQ==
X-Received: by 2002:a5d:6dc4:0:b0:32d:82b4:1957 with SMTP id
 d4-20020a5d6dc4000000b0032d82b41957mr1480529wrz.40.1697722548353; 
 Thu, 19 Oct 2023 06:35:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d28-20020adf9b9c000000b0031f3ad17b2csm4512690wrc.52.2023.10.19.06.35.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:35:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/24] target/arm/common-semi-target.h: Remove unnecessary
 boot.h include
Date: Thu, 19 Oct 2023 14:35:34 +0100
Message-Id: <20231019133537.2114929-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019133537.2114929-1-peter.maydell@linaro.org>
References: <20231019133537.2114929-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The hw/arm/boot.h include in common-semi-target.h is not actually
needed, and it's a bit odd because it pulls a hw/arm header into a
target/arm file.

This include was originally needed because the semihosting code used
the arm_boot_info struct to get the base address of the RAM in system
emulation, to use in a (bad) heuristic for the return values for the
SYS_HEAPINFO semihosting call.  We've since overhauled how we
calculate the HEAPINFO values in system emulation, and the code no
longer uses the arm_boot_info struct.

Remove the now-redundant include line, and instead directly include
the cpu-qom.h header that we were previously getting via boot.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230925112219.3919261-1-peter.maydell@linaro.org
---
 target/arm/common-semi-target.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index 19438ed8cd3..da51f2d7f54 100644
--- a/target/arm/common-semi-target.h
+++ b/target/arm/common-semi-target.h
@@ -10,9 +10,7 @@
 #ifndef TARGET_ARM_COMMON_SEMI_TARGET_H
 #define TARGET_ARM_COMMON_SEMI_TARGET_H
 
-#ifndef CONFIG_USER_ONLY
-#include "hw/arm/boot.h"
-#endif
+#include "target/arm/cpu-qom.h"
 
 static inline target_ulong common_semi_arg(CPUState *cs, int argno)
 {
-- 
2.34.1


