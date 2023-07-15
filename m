Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEF7548EF
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfj3-0004YD-3h; Sat, 15 Jul 2023 09:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiM-00045E-Rc
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:40 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiK-0001H1-Pb
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:38 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-316eabffaa6so2378501f8f.2
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429215; x=1692021215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzyDMcbYQjI8gvZN9VCzZxgmLv/k9AezEb13MRPeL3k=;
 b=Fmcyln+ZV6z4yTSqqk0nZ7i+ji8JuvQzRcnLaGEtGvk/z3R0xhffEqwITyGBGBrGp2
 ESFPM5Zpa3YnysJTGviEBXgxKrQlbDTXAslXvxqlLrNt7lmFObAw/8YBTwkK+q+Rvi8K
 Mvb9sfCMGu64gdr1oztj+UEfiQOiNZKzdzq7wIkwr903ZYdjR3V80QROK4EvdquXm+pf
 vZ77EPB0qJ4DKvQ53TrjaJ18wGXad3mA6Hb1KWX8gFkoZj+7FXbLWczKipfK9gP8gZIO
 yKMbVBNlahgVli9IeuHaoY4mTUfu98olmxh9zmnAUR3fP1It9lPpnEWtJhqoDA9jYS28
 rXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429215; x=1692021215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzyDMcbYQjI8gvZN9VCzZxgmLv/k9AezEb13MRPeL3k=;
 b=k7Ub6rFEJHGVVLSWT407oYggR+xrjeNC09KFPj4cWy6Pm80Xvw2zz12okbdP3GDeBS
 9dBR181tRfrGU22kNqSjzHuJhzaVkgIrtKxvp2nPlt15oDw8/++RYoBAV6HD8q+1FtO3
 vc+umLe+QOXfRXsiqBCs6u5BQQ9nVZJFAXK0CjapAqMhvkmUvJ4PlkViMUTDVReo6wOH
 u2igKHcSKsfk2L5j81vNv+BGT0V2bsFDohMQ/XKYMJ4trE9WE7Br9BDPa8chdcXjVrtU
 pHy871pvZGJIFORsCLdO9NGQvKhje6u5RvvM1w0v/fYakmwv5+nQZ3h//2zAdje0wBhE
 18wg==
X-Gm-Message-State: ABy/qLYX03GQjWUAt4BvzvPmfXrZ5tSyk3o+mMHVhvpRq4l92o6eVKs7
 i1NEtAkoq4eVb/RSPIU4oY8PYqjqWckTpRINbeF/1g==
X-Google-Smtp-Source: APBJJlECIOfqfGfLSSA4iIohKKxR3C205RYMCiFOtP2LchuSopAZKWyuAJlXXCYA3k3DWIecFGDRTQ==
X-Received: by 2002:a5d:4d02:0:b0:314:17cc:31d0 with SMTP id
 z2-20020a5d4d02000000b0031417cc31d0mr5713624wrt.34.1689429215149; 
 Sat, 15 Jul 2023 06:53:35 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 19/47] tcg: Fix info_in_idx increment in layout_arg_by_ref
Date: Sat, 15 Jul 2023 14:52:49 +0100
Message-Id: <20230715135317.7219-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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
Tested-by: Peter Maydell <peter.maydell@linaro.org>
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


