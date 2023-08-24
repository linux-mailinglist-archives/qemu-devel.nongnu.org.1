Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA7878744D
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCKH-0001RK-Bu; Thu, 24 Aug 2023 11:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCK0-0001QP-F9
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCJw-0003RS-G6
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:32:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c5a2e8501so3584360f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692891146; x=1693495946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1qWg8feJuZrRJWeFrFVBID4g6bufzzYTzjbonZExcE=;
 b=nzLFcD71715APsNfj4FDqp0XQORAQxZRmM4ruAmVHK3M+p2dx+pkXGCkExSL9ZkNoM
 8bBZ/21U19yIunr5KQC7RQbqx/v5srt0lhvhkaPIiO8ga/szHvjT2Ram5mY8QZEWqaCK
 AmplR7PrpE7fTJeWLszBgsPxwCO268okt8PS69aGLk4MmXyAhnVauCtDLzgFy02E3AGo
 DWc/paU2ry7sU5M2b9N0pwbgRJCwkNHja6cTrpRDrPdkmM6H6cJTyALWJhp4Ixyoqy4T
 7vSDJsiOmXjAwrqJ6v1AFc6S2eFruSUopnDTahJzxIECNf47J7MdqIG2kkmR0lSPziyO
 kzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692891146; x=1693495946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1qWg8feJuZrRJWeFrFVBID4g6bufzzYTzjbonZExcE=;
 b=kKBSoUwrznUFJs3P7YXbatThF4OEor+gOxuYMwqHJU3wTPpYhZlvxqmU4tw+AtcXE6
 RbvQbScGuHDLCeZn5kHFYjocxqCGhoJFFdG0dtwj73dPfE/MrUoP9yJF5rq69Uqyk7ZE
 lo5qHcvq/JKddUHAyUUWXmRqigX/eETRTL1o/maaxW3y70zQ/b2djsjdEgoKHYJ+P9Lh
 XiEiuQe/0nPbgRMhVm2AlMPkwqo2N/svLHyydUd9ceGU66i/pdCoguTxOryFlXw7257x
 i4ypa5Yq2rBwyQI4DfF5g0Qf5fKScmab1FHgx4ZGztnHJs8xwFXXR3lkI3jJ0/DMJHpK
 fQNg==
X-Gm-Message-State: AOJu0YzuzzI1632B3rHsu/qUjmhEm7NzuGW+ZG9FdLrMG9/FUswxldLV
 t08TjVyb0/ut0QN10gbN7Npa3j082k8wUClOmTk=
X-Google-Smtp-Source: AGHT+IF3H6zt7aKWfTx1R02/3hQrzXZKDOKkla9yJIRkicWcKMtghZSiN+vMMEKoD3WsCrqiP65yCQ==
X-Received: by 2002:a5d:574d:0:b0:319:6ec3:79c7 with SMTP id
 q13-20020a5d574d000000b003196ec379c7mr11862725wrw.36.1692891146821; 
 Thu, 24 Aug 2023 08:32:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 x4-20020adff0c4000000b003180fdf5589sm22918640wro.6.2023.08.24.08.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:32:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 qemu-ppc@nongnu.org
Subject: [PATCH 2/4] hw/net/rocker: Avoid variable length array
Date: Thu, 24 Aug 2023 16:32:22 +0100
Message-Id: <20230824153224.2517486-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824153224.2517486-1-peter.maydell@linaro.org>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Replace an on-stack variable length array in of_dpa_ig() with
a g_autofree heap allocation.

The codebase has very few VLAs, and if we can get rid of them all we
can make the compiler error on new additions.  This is a defensive
measure against security bugs where an on-stack dynamic allocation
isn't correctly size-checked (e.g.  CVE-2021-3527).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/rocker/rocker_of_dpa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/rocker/rocker_of_dpa.c b/hw/net/rocker/rocker_of_dpa.c
index dfe47544694..5e16056be66 100644
--- a/hw/net/rocker/rocker_of_dpa.c
+++ b/hw/net/rocker/rocker_of_dpa.c
@@ -1043,7 +1043,7 @@ static void of_dpa_flow_ig_tbl(OfDpaFlowContext *fc, uint32_t tbl_id)
 static ssize_t of_dpa_ig(World *world, uint32_t pport,
                          const struct iovec *iov, int iovcnt)
 {
-    struct iovec iov_copy[iovcnt + 2];
+    g_autofree struct iovec *iov_copy = g_new(struct iovec, iovcnt + 2);
     OfDpaFlowContext fc = {
         .of_dpa = world_private(world),
         .in_pport = pport,
-- 
2.34.1


