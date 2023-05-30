Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 159FE716D4F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:17:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44ou-0007iU-RR; Tue, 30 May 2023 15:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44oM-0007fn-7q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:14 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44o4-0004kh-Cj
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:15:13 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d604cc0aaso3847580b3a.2
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685474095; x=1688066095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmTrzaAymfCp1fyYj9R9fztmY/GgYJekROiEVCv4rCU=;
 b=wYJNpFf/g6xQBTZGHrO3bP1/F1g1sE1/U0qAsIDjkuKgyD7sBgFpxh6NO2djJoLL2z
 zS+L3GMUTRaTi/0MdQULRwaL7MkEwU0W26R+Q1wvKg+bCNDIzAJQkTlHlKY926P0gnI1
 az0XCX1NuqkEPcWX7JfRjvx8z43JgYHp44UMbzWAGeMhSWThTzVlsOw7IU2XE3G4L6AL
 agkdQcPEm6rb+ICPWROP1G18F3NuAPgoO6lYQ/EGXmRvxHXLQ06fbpw4RY3RHQfdbkI6
 6c2+clAsEOHGHWjqCU44awCBpJHgRH2wptq0E3wYtcFVLfJgLZy/e8FE14XRw3xReURa
 MGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685474095; x=1688066095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmTrzaAymfCp1fyYj9R9fztmY/GgYJekROiEVCv4rCU=;
 b=S4gOakj8ea8Od9ViasxciaUBBrf9w+e7l/y4iEvwHYOh+dtxdnDX8aDXLxKJMCJwMP
 m1OsNXzc+5fIEgC7eUPTKOqUemaUgNq5ov0J/a6fqPG3f8OhL62wmwjaHfJjAFhKQbOb
 qFhctpanXzRV9LvtZKI1EEh02fCon378Bm5fqRuZcjVAbX0nznK1Hw6AeDSTCqa+X3sg
 E3dC9uK3goQinJS0gaInYmnZ4jTS9UIY5HTPu8klWgQ9Jd7QzK9A50OO/J0XEfTmuEBW
 TkOglPfZLT0XfV5QqGYx6eK1ztF2YEWC4NHPMDwkFG633vg8iNkuK0diQqVO3TL1cMlk
 cKCw==
X-Gm-Message-State: AC+VfDz7ZjNsxo+c3ooY8Qrtt8eBltpLCGmC3veuA3hpM8AxnAbzE3D6
 BpSDxQX1qwsAT1lvjaVJW2nEEi5/jDgLBPVARwQ=
X-Google-Smtp-Source: ACHHUZ69zeAns1MxpGZJnG2k1NVKFfNBf3tMxBgiWBed4kjTfPpuKxEtVfCoG9+O5PGS3gQQBbCJBQ==
X-Received: by 2002:a05:6a00:21cc:b0:64d:41d5:d160 with SMTP id
 t12-20020a056a0021cc00b0064d41d5d160mr3837074pfj.20.1685474095169; 
 Tue, 30 May 2023 12:14:55 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 10-20020a63104a000000b0051806da5cd6sm8926757pgq.60.2023.05.30.12.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:14:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 19/20] tests/tcg/multiarch: Adjust sigbus.c
Date: Tue, 30 May 2023 12:14:37 -0700
Message-Id: <20230530191438.411344-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530191438.411344-1-richard.henderson@linaro.org>
References: <20230530191438.411344-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

With -cpu max and FEAT_LSE2, the __aarch64__ section will only raise
an alignment exception when the load crosses a 16-byte boundary.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/sigbus.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/multiarch/sigbus.c b/tests/tcg/multiarch/sigbus.c
index 8134c5fd56..f47c7390e7 100644
--- a/tests/tcg/multiarch/sigbus.c
+++ b/tests/tcg/multiarch/sigbus.c
@@ -6,8 +6,13 @@
 #include <endian.h>
 
 
-unsigned long long x = 0x8877665544332211ull;
-void * volatile p = (void *)&x + 1;
+char x[32] __attribute__((aligned(16))) = {
+  0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+  0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+  0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+  0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20,
+};
+void * volatile p = (void *)&x + 15;
 
 void sigbus(int sig, siginfo_t *info, void *uc)
 {
@@ -60,9 +65,9 @@ int main()
      * We might as well validate the unaligned load worked.
      */
     if (BYTE_ORDER == LITTLE_ENDIAN) {
-        assert(tmp == 0x55443322);
+        assert(tmp == 0x13121110);
     } else {
-        assert(tmp == 0x77665544);
+        assert(tmp == 0x10111213);
     }
     return EXIT_SUCCESS;
 }
-- 
2.34.1


