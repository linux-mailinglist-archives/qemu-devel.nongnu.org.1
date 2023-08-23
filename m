Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1DA784FEC
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:18:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEF-0004vf-UP; Wed, 23 Aug 2023 01:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgED-0004uz-4g
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:25 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEA-0000sU-RR
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:24 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bc83a96067so31822365ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767781; x=1693372581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn4m/BUkUlHqvAP+qKbf9mRxMLOIUsCoPFyrQpA+ZgA=;
 b=tfL8+yP7JXoUx4JsArTpdnOZb39LLyARNAWcOAgVJpcN83Mifc+RfioBe0EFQUjZ8k
 tawhjMtBZDHZwBGABM9NuX7JjvpLVwE0LgkUOn174Tw1fzNogTjuwrVtyFyxSqogtKp6
 DV/rDp8oyvEXZ3Dh6U11k0wSwjIwA/5UmYsQIKWO9lnNrt78/k2OrWyTzgIkFuo3RoHT
 RwIEL9W3rTgqfHQj/XzmP5FQ1n1T3tzW7OQM4ZmVyUg6XzrGhl6uzayf2yZniFg2LJSD
 YcFstcmQ59+dIdHAVwx1syewOIgRqk9tYY1b3bD5RUumE138k6dToE9/Pq6jiSewO0dN
 +t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767781; x=1693372581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rn4m/BUkUlHqvAP+qKbf9mRxMLOIUsCoPFyrQpA+ZgA=;
 b=DdW6IXUnASLNvi26OEZ1QUoYOc90KRdLlkm9S03XF9VOvc/KIqdTegtmgD10xlp/Zu
 t01CTw2JbuAAGCJguv2Czi+6EEKnXRMbubg52tiHyBLoi1Y51JHAHKYS+dSSMZZ8GpPf
 oTJHK7a5NVci+e6WIAliTan+IYFsqyJT1LhFiUKfZDMKH5MvnLHe2m+VNw4q26UY1HiO
 vGH8Og2qCrK1f7tpQV8MuV7r8Nf1un345g9e3syB7dVOCQEZVpL6dKwAieWDMGdrreua
 sW7QzqpaM0yhONmrrZXJvU299VXQ9FfUVwuY6mG9g5eRRJLFJv4gG1k3SRUYByt0ReGU
 2QOQ==
X-Gm-Message-State: AOJu0YynDp3O8HyU95uB9kN6QUvewffc08RgTpfLhQJVPw7m8SX8IxnS
 nzoYgU3t+uqZI0w7raggpnEUaCe0bWXLFvcN290=
X-Google-Smtp-Source: AGHT+IHKwlIFJPDa6AKmYeLB3QnwfCR4qrDRqj+E4Ex4gngKhG6krHf+5gwKs1gJoS3b1BAG4eqdqg==
X-Received: by 2002:a17:902:f546:b0:1b6:af1a:7dd3 with SMTP id
 h6-20020a170902f54600b001b6af1a7dd3mr10881380plf.23.1692767781506; 
 Tue, 22 Aug 2023 22:16:21 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 03/10] linux-user: Use die_with_signal with abort
Date: Tue, 22 Aug 2023 22:16:08 -0700
Message-Id: <20230823051615.1297706-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Describe the convoluted way by which we can see

ERROR:../alt/accel/tcg/cpu-exec.c:532:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)
Bail out! ERROR:../alt/accel/tcg/cpu-exec.c:532:cpu_exec_longjmp_cleanup: assertion failed: (cpu == current_cpu)

for encountering an an abort() in qemu source.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 57fbf2f58b..a77d003de6 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -721,6 +721,18 @@ void die_with_signal(int sig)
     _exit(EXIT_FAILURE);
 }
 
+/*
+ * The system abort() will raise SIGABRT, which will get caught and deferred
+ * by host_signal_handler.  Returning into system abort will try harder.
+ * Eventually, on x86, it will execute HLT, which raises SIGSEGV.  This goes
+ * back into host_signal_handler, through a different path which may longjmp
+ * back to the main loop.  This often explodes.
+ */
+void abort(void)
+{
+    die_with_signal(SIGABRT);
+}
+
 static G_NORETURN
 void dump_core_and_abort(CPUArchState *cpu_env, int target_sig)
 {
-- 
2.34.1


