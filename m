Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D84784805
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:51:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUb1-00033E-Re; Tue, 22 Aug 2023 12:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUaz-00032Y-0Z
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:51:09 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYUaw-0008GA-T9
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:51:08 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31969580797so4220507f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692723065; x=1693327865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qvFTzvIqEB4aU+iZkunqaVrUT+ErHPbxknUSbQolqaM=;
 b=W1fXDhV3UQwmLbvdk45fIaIUC6pjGMTMJgChTFrQkwC+C7ktPwN+Qyy5JTK+bXkyT3
 5LPYuqoGfw3XwoiYsJ7cgl8IB/Hs5OZtCHEcm8MDPExXZZovMxs6EAU0QOmKyUeUh6aC
 NC7K0YvhRKUly71ZYr0JeAAgInR5Bm8SROruBF9iwU+JVxD6WSFP/bpI/DTYEg5w2jZr
 s7Be5sam1kdfT33qbhAQNhgzn66tuDXSOMQuxAEFaJYCrQh7v1bw9s9NvR6hWj4+dLUT
 VpUgWWtg2CzWbqSfwlQFpOOC6goEsvda2L0KHGpy/v4dqgOZQj6D1DqZQJcXQMd+GbAb
 ly9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723065; x=1693327865;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qvFTzvIqEB4aU+iZkunqaVrUT+ErHPbxknUSbQolqaM=;
 b=je6Mrb3u8Xvlzzf5JDZPRm/PavfOAysi5Id2oyDkIpPg17Bi2yoQ20dvEn2p/Pxw7Y
 OAkVGbZ6gKnn6c9lfhwfXExPj6W64CyXvnUOQ2Ix6kzF25h4zqsrsvvj+6m8Av2l3eGZ
 Gd1Flc4ZX/QOLpYOub7rj0YASkya/UCspntnp8A05UHbGu+ZZp2OlS5nmGoYGuXs/GK4
 XFDTLXkJRJL4UZl/EMZJaWxDQZ39TMXhs58zE5/hw5cNnao7FsebYSLhN5xucLT2vHEf
 txWxldqK1LdyM/IwIYRiqIA8kUkZZVaYWM+3MeBGEle2uyWEkq0zn7jIjf2qTFWCnpEC
 uMaA==
X-Gm-Message-State: AOJu0YzyGa0ZmengogusENGLyh5XQhsp2fvIq7GPPo3th878WrkENaBp
 +wPZ2CrsS40Dxzd89AMCg68UyqGf/b3T8AETOm2E2A==
X-Google-Smtp-Source: AGHT+IGuD0xjeVkKV3IT2+x0pYldtHcPI7AWDVKLjOSixxpszyRZwDwXkFi6Xq5jpD2QwRDzdZuwjA==
X-Received: by 2002:adf:fa43:0:b0:319:71be:9241 with SMTP id
 y3-20020adffa43000000b0031971be9241mr8104379wrr.25.1692723064896; 
 Tue, 22 Aug 2023 09:51:04 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a5d49ca000000b0031ad2f9269dsm16285107wrs.40.2023.08.22.09.51.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 09:51:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tcg: Prohibit incomplete extr[lh]_i64_i32() implementation
Date: Tue, 22 Aug 2023 18:51:01 +0200
Message-ID: <20230822165101.72695-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

extrl_i64_i32() and extrh_i64_i32() work in pair. Backends
can not implement one without the other. Enforce that
assumption.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 0875971719..a6f51130aa 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -172,6 +172,9 @@ typedef uint64_t TCGRegSet;
 #define TCG_TARGET_HAS_v256             0
 #endif
 
+QEMU_BUILD_BUG_MSG(TCG_TARGET_HAS_extrl_i64_i32 != TCG_TARGET_HAS_extrh_i64_i32,
+                   "Both extrl_i64_i32()/extrh_i64_i32() must exist");
+
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
 #include "tcg/tcg-opc.h"
-- 
2.41.0


