Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCA274C705
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:31:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZAp-0008U9-W0; Sun, 09 Jul 2023 14:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAi-0008Ry-KU
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZAg-00013C-Gn
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:30:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbea14706eso37892875e9.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927409; x=1691519409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GmJTDSEgSrtTohr1MbVZJalsJuXSKLY93/s3bemsL1U=;
 b=AfhCl+Yk3w2R2+3deLfpYUF2wrww1AVyLtpx7r30hKyeue/kX7bjY8Be+hXa6umU+V
 8vfkSbZ9V+KTcoIOu4YoVuQdaTbr/GhwkQ8JH+toIRv4uE0WEiAQ+AaDh5ZYmDFvU2ph
 LCmJ5x5sx1yKx3O5694IAnVk/okCElzVvIzNkZQzfrVqhyYkgGiFp8HdHuACQThTFp6h
 3t/3y0blv/G4nJ7/0Sf8HqhApdR/6fDtp0wFRjC8goAj/GA5Iv0CGyULXCp+dGzOOOBO
 v5yK1UYoNgPYob4yxiiyBZjsf1Vbx8PLTN23ocbvt3sD81RDTYMJE4iv+Ccu2EoNGksS
 /K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927409; x=1691519409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GmJTDSEgSrtTohr1MbVZJalsJuXSKLY93/s3bemsL1U=;
 b=kM/xGapwzYpLQ1HRn2rMIf9YKEg659Evaue3+3xCtWRukG/MNCPofuGAzfMQXWXd3p
 flSu873sKuNMrs71MLMgNko2P+A06yWN+k4NId2IxpAjrl+4QsL0h23Z0siD/cZwKrNf
 tZHmfcKXxnU3ooEaPVQiMU63KnK5A98jJk8kNcbwKv+1+4VgznT8mu8PJYR92fVvDdk9
 0KgTBvu8NpqpxS1pVa7b/XlH4zDYliGYrOEh02GWvSu1Nxmf7/s0AvQ8+x4PTA25Tzsu
 Ajf7Y8SYQdnlrDdkv75RxTyLljcuk3amM1/CX5yvHWMQPbdIdJS2e+mSLtRtwo4VoNzP
 XaUg==
X-Gm-Message-State: ABy/qLar8PyBltuqMdui0IuabBai8z5pQIjNrd6UPgCUfj1POCD+FGdH
 LFkKVeDjtxGwJ1TzWu+PYDd/iQUD28AI6StKua5I3Q==
X-Google-Smtp-Source: APBJJlGCLvmZfLEZ1MmFZ+Denr+ji0XfLUR5gzfmoEHr+zBXstLAVhreERvpS+y51mshLokTKxYavw==
X-Received: by 2002:a1c:7404:0:b0:3f9:82f:bad5 with SMTP id
 p4-20020a1c7404000000b003f9082fbad5mr9589536wmc.35.1688927409224; 
 Sun, 09 Jul 2023 11:30:09 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 q15-20020a7bce8f000000b003fbe791a0e8sm8317108wmj.0.2023.07.09.11.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:30:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 19/45] tcg: Fix info_in_idx increment in layout_arg_by_ref
Date: Sun,  9 Jul 2023 19:28:50 +0100
Message-Id: <20230709182934.309468-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Off by one error, failing to take into account that layout_arg_1
already incremented info_in_idx for the first piece.  We only
need care for the n-1 TCG_CALL_ARG_BY_REF_N pieces here.

Cc: qemu-stable@nongnu.org
Fixes: 313bdea84d2 ("tcg: Add TCG_CALL_{RET,ARG}_BY_REF")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1751
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index a0628fe424..652e8ea6b9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1083,7 +1083,7 @@ static void layout_arg_by_ref(TCGCumulativeArgs *cum, TCGHelperInfo *info)
             .ref_slot = cum->ref_slot + i,
         };
     }
-    cum->info_in_idx += n;
+    cum->info_in_idx += n - 1;  /* i=0 accounted for in layout_arg_1 */
     cum->ref_slot += n;
 }
 
-- 
2.34.1


