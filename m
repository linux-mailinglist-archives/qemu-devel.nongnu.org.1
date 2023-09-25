Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140AC7AD6E3
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 13:22:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkjfV-0007Wa-SX; Mon, 25 Sep 2023 07:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qkjfU-0007Vi-5Y
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:22:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qkjfS-00019L-KQ
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 07:22:23 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso61785575e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 04:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695640941; x=1696245741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=KjTSXQ7FvnDgO3VZ62RhJ890kSaoi49kAiFaYhyCFgA=;
 b=Tk76PgAKJ7uirUmUgQa50KFdpjcnAw4PbCZ+UhK7EGexsRNPpMGYNseRUWwjOQg09W
 wyF2P0x4vGRnYrjafrlX2wNhJes65ArHfBsDwFTo38gikFcrWs0+EmkxuYcWguYReSFo
 rh47drYc+fJJ4VBjtoTSEVklTNVwL5OcU9054m25zOTmW8xwFNqhSMvSEQwIYfWg3qwU
 lxpXvUfzaKmpLoVIGDqxV7AiWHXu7FSvQQwUOBIo34It3SBcerOqaRJ569lBbFWa1puy
 tgCEYSJ+97RNYxRvGlUsO1R7BN6+cE5OUXPjbQ0d4ZFqVkpu2kUgAKLWKUqRRnWsbcTo
 ThMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695640941; x=1696245741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KjTSXQ7FvnDgO3VZ62RhJ890kSaoi49kAiFaYhyCFgA=;
 b=ZZILScBLVBG6CFtyLXJIIx0kCQtTWfpL5jkOFkdJRkgJ2zWRRRBOnN91/H8Z+tMT5j
 +X0KVrqb1gNQkPiH2duILD4Knnfc4Ew8rgXTjoMzPOcMfX5Kvd46TOSQW0iaZSkyeREb
 PYwpvQED2mN0jxF24bL/CEzksbqxO11VUxL6+iL0UfjPm9mj/Nt829TAANjjREKexzIu
 Mtk2S0a0fLa0pQdscgjLnWWG+EtamMpCaNTjxUNXQO8/AoQARJybSxH9nrfpEIO/lb6I
 OJ7mjntHtBodBMCMJ6D9fYFrWprPTPmnwMdTZw3PyWJoWuFQ6uIeE+D2gBT/rp9TuMPl
 vCQQ==
X-Gm-Message-State: AOJu0YzQSkIMK8aykEsEhva9vy/YiNgDLJoP3TFZQCdAbp8G0Ih0h03Z
 AgYc+AQLv1Y3r68kI7bYbMN7XqMvSmdqZcVxjeU=
X-Google-Smtp-Source: AGHT+IElHeGfiBNCzVHXq7uta6da3SrT0PDgF9ifa3M+NvkDclT0FXy4DO6TmbWaVGQXKtDaMPiyLw==
X-Received: by 2002:a7b:c38e:0:b0:3fe:238e:b23b with SMTP id
 s14-20020a7bc38e000000b003fe238eb23bmr5906587wmj.36.1695640940691; 
 Mon, 25 Sep 2023 04:22:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 k22-20020a05600c0b5600b003fe601a7d46sm14881425wmr.45.2023.09.25.04.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 04:22:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/common-semi-target.h: Remove unnecessary boot.h
 include
Date: Mon, 25 Sep 2023 12:22:19 +0100
Message-Id: <20230925112219.3919261-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
---
 target/arm/common-semi-target.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/arm/common-semi-target.h b/target/arm/common-semi-target.h
index 629d75ca5a7..fa00c7fabb6 100644
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


