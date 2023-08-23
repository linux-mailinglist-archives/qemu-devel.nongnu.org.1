Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88168784FE8
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:17:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEJ-0004xU-Uy; Wed, 23 Aug 2023 01:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEG-0004wa-Uu
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:29 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEE-0000tF-Md
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:28 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68a56401b9aso1962804b3a.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767785; x=1693372585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MF9qpDyL1+Jx07it/Adc348RqrT40R2QZvOOKU6UpHk=;
 b=MfpiO4YKCTuzTwiXQH96DPVy+i7PG0zMdcQjNJuBJ07BfE746EEE81fGnWTl1fDyhB
 qUCnLojJIw+4QCNWSrX9sFIexkr5JfXOoSgcVEZ+YHZHM+C7/N5+8ff8pacVzZNsxpNy
 H/qssMS7UQMxcyigs18JHD+c5d9NnHBHzlKAKTPaciLf3gPc5LDqxV2/MTacpv00SfmX
 nDz1/ogc6gczBsRfXCWHTGp/hDwFFZgsck9cdcehLoabkKBZ+/cP33nM38CHMbnY+ZAQ
 DzLteF13pUVnXrrAYRVVT98Jno9OgflTtBsN06Yr+hwkLscI6VkI1YB8G6HB8blFrHoa
 eY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767785; x=1693372585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MF9qpDyL1+Jx07it/Adc348RqrT40R2QZvOOKU6UpHk=;
 b=E5sOw/ZGa6n8xYuqIPaRW7/DhTAzf7dClDDp3nEo7lQhJNtJpdcg7OrDZxXx7vV4ax
 0sSoDOM81gh6zlzYykuk3auQkPuWIGevBzEl9x9IvWD3u5E1Cl/itIrLR5ID8if3cZpV
 86/r0GlyyvmP4llmcGRGOM11M5PZ1MRkTr7VCSX4xgXMEMsw0ukBOKalVslr3k0sxaV7
 n6XOJR7eE+VciFUkEBF0FSePGa45bfyb2cqsmqiC3GJoDZp3701W3m/eNOfqhnGc5hml
 HKUoWkYxfZ9pjE5fwzEoif3B+xuE9R0tlIThz8bYqSSD5Q4coGlM4A6eBOg0XGCpwdTh
 7umQ==
X-Gm-Message-State: AOJu0Yw/1rPY7la3fBxnlI/Q/FeB0Bwz/Jsx8yT/W14xW1bIIOvo8Fa3
 GjXXDFr5ZWoiUIhfSV0rJCsCW2oBZRK4JhnxnSM=
X-Google-Smtp-Source: AGHT+IGBA7XsPzlw7Kxx/nGMMK5e/NNQfi0oos6rg3HeST9w8vdd6e3k/fI6szHy9qrJL3IFy+y6sg==
X-Received: by 2002:a05:6a20:9148:b0:118:e70:6f7d with SMTP id
 x8-20020a056a20914800b001180e706f7dmr11353660pzc.10.1692767785351; 
 Tue, 22 Aug 2023 22:16:25 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 07/10] linux-user: Remap SIGPROF when CONFIG_GPROF
Date: Tue, 22 Aug 2023 22:16:12 -0700
Message-Id: <20230823051615.1297706-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Protect the host's use of SIGPROF by remapping TARGET_SIGPROF
to one of the RT signals.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 9d16e3c8c5..b8913968cc 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -523,8 +523,15 @@ static void signal_table_init(void)
      * multiplexed over a single host signal.
      * Attempts for configure "missing" signals via sigaction will be
      * silently ignored.
+     *
+     * If the host is using gprof, treat SIGPROF the same way.
      */
-    for (hsig = SIGRTMIN; hsig <= SIGRTMAX; hsig++) {
+    hsig = SIGRTMIN;
+#ifdef CONFIG_GPROF
+    host_to_target_signal_table[SIGPROF] = 0;
+    host_to_target_signal_table[hsig++] = TARGET_SIGPROF;
+#endif
+    for (; hsig <= SIGRTMAX; hsig++) {
         tsig = hsig - SIGRTMIN + TARGET_SIGRTMIN;
         if (tsig <= TARGET_NSIG) {
             host_to_target_signal_table[hsig] = tsig;
-- 
2.34.1


