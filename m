Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF8A7CEB51
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:31:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzY-00087E-Ek; Wed, 18 Oct 2023 18:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzV-00086p-79
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:13 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzT-0002UC-Fd
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:12 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1ca6809fb8aso27744435ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667970; x=1698272770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Sq2XuaUgq1WVJLtCb9vCiBQv+e4IAv+CN8pWqHj0rc=;
 b=SqzXI9+UUb2Rze/ebis/iA75UB8tihXJeJ4lPnNRlepEbW3aFn6Zi3Gs2D1lN2MTAe
 y3HP35tzfZ9lR2IWNkro3ooAOvTh1f/p/259viZVw2hoc8M0eQJyWlQovlwSNHIfW/Wy
 ZbIAhU/vpLbObZUoXIPa8dulfDf0huXFvCwswp9YYPwf39ru6kikgOGDoe9Pf1C0Y7Pf
 8agHo82RHIdZK2b2I7mPm3gPmqy8AFXemHaL7ZjC+99G66sjWRdw2jP2pIqOizoeuYUF
 nrf7tiPWhvXtgCoYSCk84aZY0dhUqOkXgosGeTqxpPCF9OZzcbkB1qY5p0t95hDaE08c
 GQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667970; x=1698272770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Sq2XuaUgq1WVJLtCb9vCiBQv+e4IAv+CN8pWqHj0rc=;
 b=NizfELo7YZFTZ1dE669VqtihVEDy2X7k7Lzf/7HO2RLMpKPxZDsxGd88/m5G5ktYm7
 neNzCp3pxtDItwRN9P8jIIPO7DQYa/iAhijW8LhWte31we1LRD8hYbNXWfmhyLp8/Z84
 MUtSRGvDSrs9lMlSaVSIOkjvd/EccRkDWiUxfpHZcC2z8B6i0QYvxUNPnO4IlhYyjRY3
 wwVb8uHUwdLwHY6QiaKZJyINucjZoI8aTNj6QW2WpxB6Kmr67wQY8XJsSyJLlH0VsiIN
 wQd5BGbGNKciQf43xEaKvd2VFr6rkZcyloukYS1CvTtOff+HWvoMDTD84avRY2Ze1ES0
 bejg==
X-Gm-Message-State: AOJu0YwetoHhdtIXxbJ3s02mbvsl28/flW5MvJVMHcBIXmq/8Eh2L9vN
 2HnjT0HcIiToY8DzOUpY5oe6YJZN8bS8zj6HNok=
X-Google-Smtp-Source: AGHT+IHKlYiVfA3Mkx3muVTCf9/Z2EKAcLH8/XX/wOWqY4j85bf/mqyT/mv8e9sC94MFN21PvYNYrQ==
X-Received: by 2002:a17:902:ce91:b0:1c6:2acc:62ea with SMTP id
 f17-20020a170902ce9100b001c62acc62eamr824307plg.57.1697667970315; 
 Wed, 18 Oct 2023 15:26:10 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/29] tcg/ppc: Use PLD in tcg_out_goto_tb
Date: Wed, 18 Oct 2023 15:25:40 -0700
Message-Id: <20231018222557.1562065-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index db3212083b..6496f76e41 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -2753,6 +2753,9 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
     if (USE_REG_TB) {
         ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
+    } else if (have_isa_3_10) {
+        ptrdiff_t offset = tcg_pcrel_diff_for_prefix(s, (void *)ptr);
+        tcg_out_8ls_d(s, PLD, TCG_REG_TMP1, 0, offset, 1);
     } else if (have_isa_3_00) {
         ptrdiff_t offset = tcg_pcrel_diff(s, (void *)ptr) - 4;
         lo = offset;
-- 
2.34.1


