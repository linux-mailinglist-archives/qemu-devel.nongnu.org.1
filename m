Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA7C7D3EDC
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:17:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQx-0005Wp-Ci; Mon, 23 Oct 2023 14:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQw-0005WP-Am
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:46 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQt-00088I-4Z
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:46 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-581b6b93bd1so2157588eaf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084821; x=1698689621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6Sq2XuaUgq1WVJLtCb9vCiBQv+e4IAv+CN8pWqHj0rc=;
 b=tt3QZt7CI+2BW59gM8id5UbnrfraBt9KnC6AIfrHCZyhh/eEa09tL8LkRtiHuTgaEH
 XrjoGfH2N7puWXKrGrmmQPsvVU85YGYLwr3VuVqwGoVTd3FgtHxkMWJuhqnGzuTHZFbI
 +xW1wycHFPpJsBu7atQu4cQDnnByKRsOKZUqASE6kfmS8K+CyjNJF+55LKqCZQBkQl2o
 6GqmNlL9IxgW6kdSz8VJ2t890TeybloAwXzFh7UQevM/t/YvCQZQHQbNBGpWEreF6S6g
 0ufnR7UepzToRtFadLYSt6o1oRH3Krz/qaUwsiopWvqUObOQebvR9dPDNnRU97/GUr1c
 WJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084821; x=1698689621;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Sq2XuaUgq1WVJLtCb9vCiBQv+e4IAv+CN8pWqHj0rc=;
 b=POzj/7zlLUpHsLCTS4ZzhfPqPIMFjH5vNQwFJQ0yKb0WYB5Rbn0exqE6pJQgeXXI8H
 19u22bvmRDBZa9f8qa+iUllTNaZ6iAizLVC8N2W+c5MubzvX8wUkgrRIKE7vtn+lZLAe
 hDmCnxWWeZ7BCltQRNSK6gEpN2F+xgIHcFBraZusmKVxqUgiDbvJz+U42kP0JyqLOE8A
 DM1G7ZOUnSZgiOOwr+Rwh7WwE5bmb+MUNQZBxIEMdpnaYeM1ISMYvACsK6KwP9bL2f0v
 l/jdO8GEwexhaszIw6AaQCgYBuDszMFqk6oEwcrYy2sZ3QlPmm2zS0muaKwmu/HrMdSK
 Glbw==
X-Gm-Message-State: AOJu0YyadwMzefvEtPnPeoMvw+vz85uKxqTGjBk+9Qx+Anu2TJz7u8NR
 V1tmIYmoUCRPu9j+oiJS7SeW1wQOV3ongvpu7nI=
X-Google-Smtp-Source: AGHT+IExhdH2AvhUuAZtmAz3qFuADD7f+Prz0DpTIue1B5OT5RZyzU/aQUK4Bz1dBxLvyvNkly0+YA==
X-Received: by 2002:a05:6359:28c5:b0:168:cf01:8232 with SMTP id
 qb5-20020a05635928c500b00168cf018232mr5227032rwb.9.1698084821254; 
 Mon, 23 Oct 2023 11:13:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 12/38] tcg/ppc: Use PLD in tcg_out_goto_tb
Date: Mon, 23 Oct 2023 11:13:03 -0700
Message-Id: <20231023181329.171490-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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


