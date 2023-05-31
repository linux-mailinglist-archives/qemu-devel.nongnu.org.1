Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F27174D9
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:09:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4D-0007aE-HG; Wed, 31 May 2023 00:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D41-0007L5-Qj
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:57 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D3z-0006AL-KW
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:03:56 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-75afeacb5e4so619916485a.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505834; x=1688097834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=npDBi4WZFRnfsN/k7Ysdf+OgYCG2e10tpnh/1pv3zg4=;
 b=bGK5PrY41lja4oDi+9XibaF7Xj+EsR2fW6tnyCi/+uOFhdNx1CCXNcfF7IWkm0zIfX
 bxlvAUXxiuUbYTDSa4zRWjeIhYvAKwE4PZ4ctzpHT1I6/sUJ+gX5J8p09J+IH4IV4oGx
 5i/CpLuqqwtmXEb6E1O6a0Iw3fBIt1HAkXxj6MFJZ5VohB74YoOIMGCqWQAOdojH2fgG
 BQI2tBM7q1L/sQPaWwgsn7qRyLtLUq8gBsm+85PhVw1cS1TSXcRImGR++V20lIJ+k64y
 Vm+0UEQ8ryu2S/uRmhh/UMjvSX9nbWQ/yYvSiyztcKAxr1xQ8NUoMKJcslcE+7f3swSY
 kDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505834; x=1688097834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=npDBi4WZFRnfsN/k7Ysdf+OgYCG2e10tpnh/1pv3zg4=;
 b=BdmB7XqOFNRosvQm/p7X5PRXsm/wSAmt3obldGkpMQbvO+AyYuBu4jvz2zwSwpjUxD
 hMvc8GvzBUt1JeO3OJ/F3HjZ2j2llqJrkTNnTe+0k/DZXNB4AVjNetBwWcRpI2XQC1xs
 fkE9avNUtOxUeVK7rVRTVswCwMcnu3XDFFb2etxGvqBnvcYUypXfw9llBbJ5G0kjpoP/
 dVMogQX64Nq7t6v6Ee9t9+sgRL4cRHVRMSOQFIX4oNHgYYH+gwIFiVREHiZyR6/wC8+2
 N7OKVFBlY/wT4ilm/8+/8FKB6fg2AMisO8FN2cPDrzyuT+ZXNjeiQss6NHG/MLNujbWj
 tr4A==
X-Gm-Message-State: AC+VfDwEayiYlRDDSDz+R6S1zOkn+e9Un3i8Ltd6KMSAG74MZoucNuCm
 Lpf6Qgf/7uzZttlKMOjPONkOYfX88CgteQ069aE=
X-Google-Smtp-Source: ACHHUZ7PWRhhEu2jw6KPyaFJD++8d4yTrPw8dmBty7zg28BrlNwJ2hzklsLGajloRdKguwoTjGoEhg==
X-Received: by 2002:a05:620a:4516:b0:75b:23a1:35f8 with SMTP id
 t22-20020a05620a451600b0075b23a135f8mr5889548qkp.9.1685505834465; 
 Tue, 30 May 2023 21:03:54 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.03.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:03:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/48] exec-all: Widen tb_page_addr_t for user-only
Date: Tue, 30 May 2023 21:03:12 -0700
Message-Id: <20230531040330.8950-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x734.google.com
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

This is a step toward making TranslationBlock agnostic
to the address size of the guest.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 4d2b151986..0d00541aca 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -31,8 +31,8 @@
    addresses in userspace mode.  Define tb_page_addr_t to be an appropriate
    type.  */
 #if defined(CONFIG_USER_ONLY)
-typedef abi_ulong tb_page_addr_t;
-#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
+typedef vaddr tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT "%" VADDR_PRIx
 #else
 typedef ram_addr_t tb_page_addr_t;
 #define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
-- 
2.34.1


