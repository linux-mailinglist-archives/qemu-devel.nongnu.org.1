Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A6F7230FC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:17:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Gd9-000278-JN; Mon, 05 Jun 2023 16:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcp-0001xK-Gh
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gcm-00048V-Cm
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:16:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d24136685so3817935b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996179; x=1688588179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DOw547N7yM8bTiNoT1okAN1BhhlZBz/7YQeuKCCYwGE=;
 b=xc4aDQ262Pc47vKf2z0ffe3qqINGb1vtxL79bpeKsphk5E7k81xFK6BFXr8bQotaUU
 7uX3H2V6WwHV5efDx6EReMD/QNJOPbT7TMkWkOM2yh3FPfd+zJy6L5F+dmg+ceXr8i3Z
 5/lXi0mWLrbBVM50o+9ZtZPC0QpuHiMmlDKfqucr4RolExo4me2yoe7wwMRQBLJTuvMq
 DZa71EJq9pj8mH0645iM/fMOS+JWwba8eHDBw3zEzqQ76+nIzEKy9jhrQLzCT/NRRZad
 +YrJGlfflxpI23acCAR08K6zmwGUgQuc8vIHn5246W1LDAQhm99+eEv82jMonx3QLuwd
 LbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996179; x=1688588179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DOw547N7yM8bTiNoT1okAN1BhhlZBz/7YQeuKCCYwGE=;
 b=bpxCSC+a4khUg5jyMSn0ETeWvLAx3YOWjZZDonOLgsLSaeiJJPVsWuE/0yn90EJkav
 k7EenOETe5NDm/cQH4b45xGEPiBZ+CHSpScEWCeXxM/WZ111Vv/mazxId2tHfQSKyR7x
 iEKt+CrJ9N6xn6F8Na/da3PFlUWgO749detFO70lHCaj2UOkRe+omgsYz1TkOwXztO4T
 ZN/5hZxxzYAKeGFkp/FkPsRcIGop/OPn3vs258jqED+Af9t5yMmCODo7bzio4kaCXadB
 mWN4ANV4hNxrv6Ekid7coCc0TZqognam2oZdk1XQW2hJPOS7hT6H+MhxxItOeJajTS1r
 ruAw==
X-Gm-Message-State: AC+VfDwsYMzP1z+Ai1Z1uP6/PSWptnIrMPxIPprYJN6h+E5F9aNiX2w+
 is+SOWI6fvX8MgeClpZJz0du/f0xOPKMc6kikYw=
X-Google-Smtp-Source: ACHHUZ7hX4hgbqIlPStdoTDQFt66llgc9eflprdGIfoUVhwVppTxR0X+d6Js3xNHjNk3SxkoxTcjMg==
X-Received: by 2002:a05:6a00:4403:b0:659:14c8:1f0b with SMTP id
 br3-20020a056a00440300b0065914c81f0bmr650609pfb.4.1685996179058; 
 Mon, 05 Jun 2023 13:16:19 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 f18-20020aa78b12000000b0064d32771fa8sm5552924pfd.134.2023.06.05.13.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:16:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/52] include/exec: Remove CODE_GEN_AVG_BLOCK_SIZE
Date: Mon,  5 Jun 2023 13:15:30 -0700
Message-Id: <20230605201548.1596865-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
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

The last use was removed with 2ac01d6dafab.

Fixes: 2ac01d6dafab ("translate-all: use a binary search tree to track TBs in TBContext")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index f01c7d57e8..698943d58f 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -467,16 +467,6 @@ int probe_access_full(CPUArchState *env, target_ulong addr, int size,
                       CPUTLBEntryFull **pfull, uintptr_t retaddr);
 #endif
 
-/* Estimated block size for TB allocation.  */
-/* ??? The following is based on a 2015 survey of x86_64 host output.
-   Better would seem to be some sort of dynamically sized TB array,
-   adapting to the block sizes actually being produced.  */
-#if defined(CONFIG_SOFTMMU)
-#define CODE_GEN_AVG_BLOCK_SIZE 400
-#else
-#define CODE_GEN_AVG_BLOCK_SIZE 150
-#endif
-
 /* Hide the qatomic_read to make code a little easier on the eyes */
 static inline uint32_t tb_cflags(const TranslationBlock *tb)
 {
-- 
2.34.1


