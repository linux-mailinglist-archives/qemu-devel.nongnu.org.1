Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF14784FEB
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 07:17:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYgEO-0004yr-4k; Wed, 23 Aug 2023 01:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEJ-0004y3-QK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:31 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYgEH-0000u1-KY
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 01:16:31 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bdbf10333bso41523605ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 22:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692767788; x=1693372588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ONpVouFAHtBaoT5On3cpK1SzlinIIZiyWi2CcqB3oSk=;
 b=ss8u766f+o5EzqsSmtj8hJaYEymENBSIs2870Ow/WUjnu5HXxuCxSecokV1Wah7Izx
 F70tZN8+Vw06tfhV7RM+ea4qiPHPJe+Ziwr/hq6VT55A2O9VsAnn4QS76EJce67c5X/2
 yKXHm4tnJKbvGqFOD1+P+DZZfPbKK7IBLK9JuaapiEVMaXpzlsVgA/s3GsW9BBkRWvhi
 85mW9NSps3q+h8ftG+4r9W2uI3202Sw4FgUZ+L43Nl6HszJ0vV4zDkLGIcgBaSYwCX47
 kZcl/8jJjaSWm62U6/afQ8PmXnDovDnFsFPakY6GSCPy+hyKp1UyGU3tfyXqtZMro3f/
 RLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692767788; x=1693372588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONpVouFAHtBaoT5On3cpK1SzlinIIZiyWi2CcqB3oSk=;
 b=B4Dm+Y6QmpggxGiMS0Lr/3ZXUsj0U1Zth9bt/mGzb0Gl0g6b5yMHiPxXYwcclQSHoD
 tURFcGM96nxMjM937SGS8THfDlcNKBzfNj/M/F0STvWmcxOfL9+GMaF+5D+CIGMG+1tG
 pHZoVjY5jQrEitQ8qIk+38trayZI51nO4oQVK2uFi9UlONtqrxQ5dNFlc6ExjqAukYqX
 WxzCcnrlz6GwVlu5I4u3RlrCLUON0C30aLVEeRfsehITE1634Xlt0yBPmTH87zSoGCG1
 8jA1BolZSoJP1NMNrglKGOeEDaAEaspXk5XE2RtVGpQ8atT4kSbEBtAwDep650huf8zn
 k0aw==
X-Gm-Message-State: AOJu0YwXoz2I/RbC00jhT1Kkp+leaAaaG59eDheWgA84bQysqw+8rfpY
 /V+cHnHFnzl+xt7YSudMLwuIyLOX2cnEHpcA2K8=
X-Google-Smtp-Source: AGHT+IEFtVmk5VxxL0ATNmLp8/bvdzCpGv9+P0VSzhCgiwatyWeuWZYIn+MrK48qp+Z6cat/r2AEQg==
X-Received: by 2002:a17:903:2344:b0:1bc:8394:daf with SMTP id
 c4-20020a170903234400b001bc83940dafmr15272526plh.19.1692767788392; 
 Tue, 22 Aug 2023 22:16:28 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:4e3c:f4a4:b92a:b5ab])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001bf044dc1a6sm9969402plg.39.2023.08.22.22.16.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Aug 2023 22:16:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v4 10/10] linux-user: Detect and report host SIGILL, SIGFPE,
 SIGTRAP
Date: Tue, 22 Aug 2023 22:16:15 -0700
Message-Id: <20230823051615.1297706-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823051615.1297706-1-richard.henderson@linaro.org>
References: <20230823051615.1297706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

These signals, when not spoofed via kill(), are always bugs.
Use die_with_backtrace to report this sensibly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/signal.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 68ceb2e4bd..6d13b5c210 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -904,7 +904,8 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
 
     /*
      * Non-spoofed SIGSEGV and SIGBUS are synchronous, and need special
-     * handling wrt signal blocking and unwinding.
+     * handling wrt signal blocking and unwinding.  Non-spoofed SIGILL,
+     * SIGFPE, SIGTRAP are always host bugs.
      */
     if (info->si_code > 0) {
         switch (host_sig) {
@@ -916,6 +917,10 @@ static void host_signal_handler(int host_sig, siginfo_t *info, void *puc)
             host_sigbus_handler(cpu, info, uc);
             sync_sig = true;
             break;
+        case SIGILL:
+        case SIGFPE:
+        case SIGTRAP:
+            die_with_backtrace(info);
         }
     }
 
-- 
2.34.1


