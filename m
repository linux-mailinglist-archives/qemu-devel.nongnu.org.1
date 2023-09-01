Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D357902F1
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 22:45:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcAz2-0006yW-FE; Fri, 01 Sep 2023 16:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyr-0006xv-TH
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qcAyp-0001xK-EN
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 16:43:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-68a42d06d02so2060523b3a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693600978; x=1694205778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll7Fcerm+Jswr+2aKJK47stIuMjiaUzk13pA9L+5+w4=;
 b=mTuoqtqHphL1rODik5Se1W8KUGmaWNZhfI1X3w/A1JXLJrjlnURoVV8JjWX2EoCe9m
 iE5E5x8pDhm2HJf6400WiRC/tWaJPM22jLDE1mLtV4nLb1fesO9gE5lznoXm1ijAMDAQ
 C+QiCYHO3KQgyj6u/T24Fd5FYwBLmDxTktuWupQMjPW1aEfmK/Lx0moEkpNoUdC9snQn
 MaOdUqaXPVzB/xCNdWk8hHvJX7FxUmO04c0H5vT165YKAj9x+uq7OhEijXPnFjDe6l0x
 qmXZ0rFJn8HOykKt7y/PCIvjT4kSZS/7zQ5tXsPHjrNk5Rp60pR/fhZzOvkkdBoY3If4
 xOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693600978; x=1694205778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ll7Fcerm+Jswr+2aKJK47stIuMjiaUzk13pA9L+5+w4=;
 b=gsDLDW822ZRfNE6cjDihDujIJREnResSE3O0I2TXV3fxShcYBZiqqaBpi01nd8F+mf
 7U29BHdqt4JU2fPG4j5YZas2MlVNEPZj47L0JYbcRQXA6IY6H6i3pM2WSUsGfdOIDpJg
 IqY6jsUijN3ZWmiNGDFVHR7BBxUSBDmM2VQLqYK/M5QmkiOSFJpGmJdEOoJR4m411o3i
 x9ifcBS79Ett5wHZQkjR7fExGNyWjrsnNZsAMt00NAxAHK+MnGp1G6KPMRkVZhT7D314
 mkKaAxP7iCjKI+L/R7ikIC1vhBKdGAqKxr48G/a0MIz8XezwqVGtR//Uf18MwQy6lWrt
 rsiw==
X-Gm-Message-State: AOJu0Yym0/qvCf0asabgt99o1R5RqesnskLVFhLpx0tx5FarWh9Wsvze
 WtUjdgxORn/JGvCP1lf6NSHTfSPEQdOmcnFkQrU=
X-Google-Smtp-Source: AGHT+IGgQMn9byzk5q5MreeTo/qxLM8KOMPfY74qXf5SJz5KhohxjEVP0vrkwCD3sg/9M1HdkLH9DQ==
X-Received: by 2002:a05:6a00:1587:b0:68c:42:d3d7 with SMTP id
 u7-20020a056a00158700b0068c0042d3d7mr4219861pfk.25.1693600978168; 
 Fri, 01 Sep 2023 13:42:58 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 j15-20020aa78d0f000000b0068c97a4eb0dsm3320666pfe.191.2023.09.01.13.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 13:42:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Helge Deller <deller@gmx.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/13] linux-user: Adjust brk for load_bias
Date: Fri,  1 Sep 2023 13:42:44 -0700
Message-Id: <20230901204251.137307-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901204251.137307-1-richard.henderson@linaro.org>
References: <20230901204251.137307-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

PIE executables are usually linked at offset 0 and are
relocated somewhere during load.  The hiaddr needs to
be adjusted to keep the brk next to the executable.

Cc: qemu-stable@nongnu.org
Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to executable")
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 7c95098e3e..d52d47c5c3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3327,7 +3327,7 @@ static void load_elf_image(const char *image_name, int image_fd,
     info->start_data = -1;
     info->end_data = 0;
     /* Usual start for brk is after all sections of the main executable. */
-    info->brk = TARGET_PAGE_ALIGN(hiaddr);
+    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
     info->elf_flags = ehdr->e_flags;
 
     prot_exec = PROT_EXEC;
-- 
2.34.1


