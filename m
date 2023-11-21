Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D37F32EF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:58:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T7l-0004Xs-PM; Tue, 21 Nov 2023 10:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5T7i-0004WX-JM
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:57:14 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r5T7e-0002ea-VC
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:57:12 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d7e6df999fso258060a34.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700582229; x=1701187029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CTjER+jT+9VVHqyYdg2i5cJ66ptGMsZM63IndAeZ5lQ=;
 b=X8Raq6adkF8U8A/h2PaFMKHTO2IGSfI3DLjKFv0gwunkMSeLH8DBYvnoTnaEc7HzBN
 usw58tznUSjKeS2aSJJR0/fJATviCbQaQvZziFXJWpu+guGNCtaOOq1o+VtuAUZ/HRR+
 ieJXUHe5A1etZH9Lfs+yLFtBiO3OS+/zK27m6txnSAz8UFwAgD1WtvrUDyYpbjhhvU6C
 aKRm+uSGzTmcwIDgBSHxDfprNHE7arl0CHLHU1D9aet5dWejlR5KyKSU0z0sUuyXrhdY
 CzRFRzUAsten+HxQsC5OahZoMELy/id9SotgxgmulAMXmdAR7nUL9eXdIe4Gsq4B/SIh
 z3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700582229; x=1701187029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CTjER+jT+9VVHqyYdg2i5cJ66ptGMsZM63IndAeZ5lQ=;
 b=a5MttXxQ/7RVHYEykBC1oa6ncWrR9BHmO3XEjRbekk7AzS0Vlcz896WI5EEJtSAZQQ
 ik0Ui9m+ux8/PaUkwucUTEolxgeoaiRuTVirIxcwFxumvsArdkSOZvzIbpq9qFaPZmol
 IvRlVdVazhbw85qkPTbzTD+k/RptMc7S1J1YeMQ6gAF54L0n1JC/6myk4GMWJr0JLM2F
 Uo8faZua84sm3vP5F/4lslott0Qa86Z7G93s463mcFn/vl3KqZTVoh/+MDLCdpl7i1cb
 6emggMihtJw4d26HwoKicgZQALhr5+CUt1nvFE1iBpKMUlR5Aef3eRxraFmIO2b8xeYz
 2cuw==
X-Gm-Message-State: AOJu0YytbCx4JLc7AbkzYTXjRs8ox1E8NkbVvI8zrldYlVSAgsBhq9g/
 q6OxFzSEyvD5LZSxS/k4kw+ozSnCH3lJsqRW6LcnFg==
X-Google-Smtp-Source: AGHT+IHOMnM/KhH9+1CaQh8XHDmsAls9GaDVNgY0XaW1+qUjBnRK/NpyCM7amq3s3HUWxcCtU1rMmg==
X-Received: by 2002:a05:6830:6b81:b0:6d3:132a:5350 with SMTP id
 dd1-20020a0568306b8100b006d3132a5350mr11149313otb.11.1700582229667; 
 Tue, 21 Nov 2023 07:57:09 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 n22-20020a9d4d16000000b006cd0a04b56esm1543574otf.56.2023.11.21.07.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:57:09 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 1/1] linux-user: Fix loaddr computation for some elf files
Date: Tue, 21 Nov 2023 09:56:57 -0600
Message-Id: <20231121155657.798505-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121155657.798505-1-richard.henderson@linaro.org>
References: <20231121155657.798505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The file offset of the load segment is not relevant to the
low address, only the beginning of the virtual address page.

Cc: qemu-stable@nongnu.org
Fixes: a93934fecd4 ("elf: take phdr offset into account when calculating the program load address")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1952
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
---
 linux-user/elfload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4cd6891d7b..cf9e74468b 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3308,7 +3308,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
     for (i = 0; i < ehdr->e_phnum; ++i) {
         struct elf_phdr *eppnt = phdr + i;
         if (eppnt->p_type == PT_LOAD) {
-            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
+            abi_ulong a = eppnt->p_vaddr & TARGET_PAGE_MASK;
             if (a < loaddr) {
                 loaddr = a;
             }
-- 
2.34.1


