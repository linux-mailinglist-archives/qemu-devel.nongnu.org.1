Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 310887174CF
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:08:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D7J-0003ez-Ox; Wed, 31 May 2023 00:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D77-000386-S9
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:10 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D74-0006uo-Ka
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:07:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-5144a9c11c7so4716943a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685506023; x=1688098023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5OmjOrE/P0VU5UgUG9OCCxhc4dLq9WZZ40K8T/sgGq8=;
 b=MPjM0MBDhbDPr3/Uy1165mRiKcI80ZorRPhBRSfjhUpsJO2YCeIW/k730bgsVinA/Z
 PzkGwZ8IblA6FPTibCmp7gZZLkRArW4Fys++OBXz+FYZu03PEWbcIVeAA+HBopfGjGAf
 dKl149+YyqsYju4bvQ6JRqud1V8UMcYnz0E6CXzMxH1vPEBrJiqWRoyOUK+AY+tlVe8A
 DXPFxB4R66ec4DlO0V5Z/ZeDm+rS52XJDDrw/iNgUNShXb9WTFEMhD8M3FJJ5i6OI/vx
 aWmCZTp0lBrV87E6KFMwohR1/7w8IDoZEygbWkJF+JIbcG2+Z/OlrIiN+TDb1qD9JIYO
 48Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685506023; x=1688098023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5OmjOrE/P0VU5UgUG9OCCxhc4dLq9WZZ40K8T/sgGq8=;
 b=JTbN0dg6rzZSEAttEMpgSg3pmIZ1LhWrznqyMGp0Kqucb7BNDoQ6Zb2cA9YW9bSP5k
 FC9JEiMWcCiPkE2lqxeUzpuGfhm6cUu1X6jQe2ks1X0+w7fNBw2HfeCaoOWKf7P+4B5+
 1Btw5xOYtg1+WAlcqIdTrTLo9w6xBOGqtrDitrGxf0FfFAsieP06neDLOlYAGfiQ+pki
 aS/lVSgTs5Jef6kfyNK0qp6kZeOWtGt3lBTRpENCH07ifmA7jr9Wzx0baRrHb7mhgAr8
 B1jkByNQEhRLLPmmgTIDDLII6CsnplQ44wY65O73GQHBUoxV5zhNo445WG44+IXpM/Wb
 khYA==
X-Gm-Message-State: AC+VfDx/8L0dDKPZgj8OBjPQgqFMb5HcJc4qnRpG3wlJmMtN3WiEHuIw
 bZ/X0+WeJmmd/f8h2/57BOmKGGd2gzIU9tpp8RI=
X-Google-Smtp-Source: ACHHUZ4hrUwCeKNtnReCoj5mLtPZZ5uEZ6Y+G4Nf5B2Cs0pVVIHJV83Sjb2OoTFl3KbM6CY1uQWkAA==
X-Received: by 2002:a05:6a20:9f45:b0:10b:91c5:45b5 with SMTP id
 ml5-20020a056a209f4500b0010b91c545b5mr4619132pzb.31.1685506023037; 
 Tue, 30 May 2023 21:07:03 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 h13-20020a170902f7cd00b001aadd0d7364sm151797plw.83.2023.05.30.21.07.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:07:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 40/48] *: Add missing includes of exec/exec-all.h
Date: Tue, 30 May 2023 21:03:22 -0700
Message-Id: <20230531040330.8950-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

This had been pulled in via exec/translator.h,
but the include of exec-all.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 5b53b6215d..4d88197715 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -4,6 +4,7 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
+#include "exec/exec-all.h"
 #include "exec/translator.h"
 #include "exec/helper-gen.h"
 #include "internals.h"
-- 
2.34.1


