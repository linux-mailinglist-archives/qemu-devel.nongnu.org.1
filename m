Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A077E875
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:16:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWL2f-0002Ld-9n; Wed, 16 Aug 2023 14:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2c-0002Kx-Vd
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWL2a-0003gb-JI
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:14:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1bdaeb0f29aso39059465ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209682; x=1692814482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ALV9YoDASQh3INUMqfrZ/39T3j4UWNqGdyGzg6ZT7es=;
 b=XqGZnj0+813xTIZc5J1fYjjgVKDKyL8mEikF6j0n+FswP53tFYFH3HXVSdC4L/YUz2
 t6z0AVSm1DMrVqe5bI6woeAU0AkXGDEC35JnvKHQA5j4+D7oisi3BeB2FSAhpihI3EsL
 bYQnKAjLM1fB7Ln834NwRZ9yCxV6VMC9PtcNnU612hW9arkOd8QfIFAzf+0rXSlgP/IA
 NFSes4aRwrNG3IFOKV7MGXiSPtto4YvIFnDS4FJaIaQst39tsrrmEUz+8Cr+3W1a1ScU
 ZQMSyz3f6ySGM+iiaea3wtFZ/vVsVCvLXidzQn3Nhs5DMZvbqTfwN846kfxDZD7tL8a+
 9LMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209682; x=1692814482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ALV9YoDASQh3INUMqfrZ/39T3j4UWNqGdyGzg6ZT7es=;
 b=YcHA+FfvSwOd5g/pehCMDdTHsFwPSgp1KRu4cBcP84IuUS8aljusPVWmN/P1gujZmC
 R6DiVdlry/jxfB7BwEPUgnynsFMmZ/1+48QqTM37BdPrPEk92A/HCpLn5+kiKqV922AB
 /Wo4TV4o+3NKeV9nW0ilD45Dz3lgDkPfpJzJr/mIa7aXaPn6dAJ+tPdzqs6W8Lt8qAFW
 yQXhQ5F7d4sC4rebvKkxmHoL5PiWvOjMXxCd+WDWCQqlo/M+nkDGUicolPKKLP42bj0f
 rb/4jlNSb5zxolh0Lq3HdjDs1Al3p7EoEi9D4khwx9j20LOn0TPfUKffJVby+0fBwqPM
 kCSA==
X-Gm-Message-State: AOJu0YxgfEa8gHygyeib9lZbs7MQ3ZUFsmm6sDtKOvvkCpH6kRSYreFm
 nj6CrIUZ3FVrw4+Dsmyu/borhRKvUf6F+ElG32U=
X-Google-Smtp-Source: AGHT+IHC60lKM2Jcz3gvD2VfbPuiZUrj6OfUyLUsY2+ptmgnoF5xbFqH+GfPyrvFBCHp7pDga9OY8g==
X-Received: by 2002:a17:902:7e83:b0:1bc:8748:8bbf with SMTP id
 z3-20020a1709027e8300b001bc87488bbfmr2262512pla.52.1692209682381; 
 Wed, 16 Aug 2023 11:14:42 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001b9dab0397bsm13423563plo.29.2023.08.16.11.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:14:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: iii@linux.ibm.com,
	deller@gmx.de,
	qemu-stable@nongnu.org
Subject: [PATCH 3/6] linux-user: Adjust brk for load_bias
Date: Wed, 16 Aug 2023 11:14:34 -0700
Message-Id: <20230816181437.572997-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816181437.572997-1-richard.henderson@linaro.org>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index ccfbf82836..ab11f141c3 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3278,7 +3278,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     info->start_data = -1;
     info->end_data = 0;
     /* Usual start for brk is after all sections of the main executable. */
-    info->brk = TARGET_PAGE_ALIGN(hiaddr);
+    info->brk = TARGET_PAGE_ALIGN(hiaddr + load_bias);
     info->elf_flags = ehdr->e_flags;
 
     prot_exec = PROT_EXEC;
-- 
2.34.1


