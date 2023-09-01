Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E727478F71E
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:27:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpc-0007MQ-6d; Thu, 31 Aug 2023 22:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpZ-0007Au-M7
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:17 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpI-0001TD-UR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:11 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-565e387000fso1084723a12.2
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535038; x=1694139838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sLGhrncusZ++ow/925hmU4zhHqvG6lKeFI4gVIL5/yk=;
 b=MC9RrsQhoxf7zK5tuJ/orKfao4N0GffyQT1rTK4416+08fqoufUVxRtrHsbwPV7lWe
 Z8rtEFT1DYixQgq2J4LB5IDxWsiBWyXSFSo7xauZ7qto4qXPBdXfc8ju0TSLrA6AC2QT
 mRPHK6YBJ7tX3NfhyRr5gw19lOEYfuMRcvn+kp5GkSnkoH4UIKebwsvRMdRfG8U0O2an
 HIGEpuIE2yZnfyS1hd6Qu0KkU79Hiqh3hfsiCHVYQnkaHurEIUVgwyKhPV5y/7Yq/jOw
 Mmj00U4CKRTfStbQyM/+NBVXGLLldMv4Sr8T5H9/6wWwj0J0LyFrW4hKvdW4cHidtc5C
 S01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535038; x=1694139838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sLGhrncusZ++ow/925hmU4zhHqvG6lKeFI4gVIL5/yk=;
 b=cJzvYPlRx0Jf7LPk1dZacBLANdXkd98WHIDvFjrjM1uNxmS5RMsQuxZaZfWJKypCrl
 cZkuDd1GVBSnMGqnJV5inwyFPrmPZQ3ak5RWPo87w7dGiomdUavOhoui56SjIB89LC1N
 LLVV/lGGopSYeIKTE72stLphe16JR0AEgmBQWFQSpIMthmg5uHZfYQPwqrTbUyK14ieH
 tU4OJrljA8fRM/FspXvOcky6lv7R1u1gqlFF/17Dx78rRvcO0xA427sOwbC7H0vCIb8S
 p3Kn6EQqOfpJrP2z3RFcO4tCv2VqRo/HOrse0zc8Us17xNCRbbmRhvDLlL4o/ocNT0OY
 +RSw==
X-Gm-Message-State: AOJu0Yyi++SObs4i0lVBUGw4A48OtcEtkF5hlUKRN/qvOBovMUjwlFRn
 a2Uzwbd5Aepwxw5IZ+ay+07YMto8QMcCqhH0XEM=
X-Google-Smtp-Source: AGHT+IG5f33apizct2iN6SYH/DfNN4L4x0OFoCn77zQ4AG8Y4rw71nC1XqPwXnBPaIaMd4j81MCAsA==
X-Received: by 2002:a05:6a21:3b49:b0:14c:d494:77d0 with SMTP id
 zy9-20020a056a213b4900b0014cd49477d0mr1392208pzb.26.1693535037741; 
 Thu, 31 Aug 2023 19:23:57 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	alex.bennee@linaro.org
Subject: [PATCH v2 31/33] linux-user: Bound mmap_min_addr by host page size
Date: Thu, 31 Aug 2023 19:23:29 -0700
Message-Id: <20230901022331.115247-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Bizzarely, it is possible to set /proc/sys/vm/mmap_min_addr
to a value below the host page size.  Fix that.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2334d7cc67..1925c275ed 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -904,7 +904,7 @@ int main(int argc, char **argv, char **envp)
         if ((fp = fopen("/proc/sys/vm/mmap_min_addr", "r")) != NULL) {
             unsigned long tmp;
             if (fscanf(fp, "%lu", &tmp) == 1 && tmp != 0) {
-                mmap_min_addr = tmp;
+                mmap_min_addr = MAX(tmp, host_page_size);
                 qemu_log_mask(CPU_LOG_PAGE, "host mmap_min_addr=0x%lx\n",
                               mmap_min_addr);
             }
-- 
2.34.1


