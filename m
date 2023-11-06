Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 643547E1FD3
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:22:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxSX-0005FO-VS; Mon, 06 Nov 2023 06:07:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxSW-0005C0-7u
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:56 -0500
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxSU-0004t8-Kw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:07:55 -0500
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-507d1cc0538so5745068e87.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268871; x=1699873671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pDLz44pMnS6BY17PlhPlXPTDOUKf2M5E2FKcksHeUks=;
 b=kslP9F7ork8t6NxZHid0VrmFSQ9tHMOuZ4zNqElHvUWScGsiOrvcWPtP8uYyvXc8Eb
 NxeoShDmG94h6fFVHjwt1bdLBU1FEFYQ9ZiGq6K9Af7Za9BnYVnycNvTfjgFHp4kITaU
 OjyM3Sl72yA2KJFe7Mxegvqhq5Kb2mZlbG+ekmve05pE/PkJzv317OB03ug+Dg8KHk6f
 7oTlg2SJCqRBVWQRJtNHdnyzEgn981IkVJjsaceE2mDy9yyKyp1h7b0uuzpwn/Lglf8p
 hMCDoQzkNHR9xkBGCAuxQW26zhfdUae+IYvkLGK5gn2LunFFo47GFonC0ad5rHIIjKkY
 tFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268871; x=1699873671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDLz44pMnS6BY17PlhPlXPTDOUKf2M5E2FKcksHeUks=;
 b=nkgdDkvxLgiReVFUrRMg0gTptCxu9D8wFgUHguHNJxBHyDyQlfdVrujqCM4uJKsY83
 tiMyY/nnrMKiwoNyezgBC2CDH2QLpsB8SbaXG0runKt1SRHfR6faBgyrGF8I/SPxrlDC
 HLfvH22qN0iq4a9hVwNx3cXNJplTEwk+8vZ3dA3ATGSw7IJvMAL9BjAoNW0NWKo+z1xM
 GRunmDBCTjLFqe9EzdgDlon21Zl4b7+sPic7ltoxniXa0Lz89+o5nZAm96XLuCJRwNA1
 d2stqnq1g/aSPx+G9gW8XurR7e4ZMP6mCqaCMUuZQ/U33uDTMovnMcv1PW0sqXrPGZ6B
 FzzQ==
X-Gm-Message-State: AOJu0YzvqUCKu93/MaxITzjdNV6WVmeTh1HA8CYszR6nHjEQ3g3x55eh
 /kGwrVVMPZQDMBdOleRDFNWEyG6Yfy6WNq1hM9o=
X-Google-Smtp-Source: AGHT+IHcdyLqApBzrM1UIl1rL4HV5Kt/MnTQib7GE9Ti6YP9IhDYtQPkYZQNlydR2XL1DbF6EVXSWA==
X-Received: by 2002:ac2:44ae:0:b0:503:38f2:6e1 with SMTP id
 c14-20020ac244ae000000b0050338f206e1mr18200122lfm.5.1699268871711; 
 Mon, 06 Nov 2023 03:07:51 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a5d6d52000000b0032da4f70756sm9122296wri.5.2023.11.06.03.07.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:07:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gavin Shan <gshan@redhat.com>
Subject: [PULL 37/60] target/alpha: Tidy up alpha_cpu_class_by_name()
Date: Mon,  6 Nov 2023 12:03:09 +0100
Message-ID: <20231106110336.358-38-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Message-Id: <20230908112235.75914-2-philmd@linaro.org>
---
 target/alpha/cpu.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index 51b7d8d1bf..fae2cb6ec7 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -142,13 +142,10 @@ static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
     typename = g_strdup_printf(ALPHA_CPU_TYPE_NAME("%s"), cpu_model);
     oc = object_class_by_name(typename);
     g_free(typename);
-    if (oc != NULL && object_class_is_abstract(oc)) {
-        oc = NULL;
-    }
 
     /* TODO: remove match everything nonsense */
-    /* Default to ev67; no reason not to emulate insns by default. */
-    if (!oc) {
+    if (!oc || object_class_is_abstract(oc)) {
+        /* Default to ev67; no reason not to emulate insns by default. */
         oc = object_class_by_name(ALPHA_CPU_TYPE_NAME("ev67"));
     }
 
-- 
2.41.0


