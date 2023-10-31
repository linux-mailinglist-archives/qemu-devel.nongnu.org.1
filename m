Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 016457DCFA4
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 15:51:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxq4y-0003GC-Pr; Tue, 31 Oct 2023 10:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxq4w-0003FT-I3
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:50:50 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qxq4u-0003QA-Mv
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 10:50:50 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40906fc54fdso45307105e9.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698763847; x=1699368647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxHSMYBWiTSk5NVD1xEg3KSvT3Ex+9zHygSFCiZHI5I=;
 b=zfOvebfEq2gjqh6KxCvhcxjECJZOoGUaLx4eDySJyc+zILBmWswMfrOENJonsHfDRX
 EXBUlYi7+r0/EMoyQ4yaT2cs/ZkpjjU0G8htZ04ROt7LVwohHdA+pPD/oMl2Qt4DihLR
 U5AOsGvjOwVmQm0ORNnzerty+yb3rtSJ52iJ8S1UkutB+wBEyeaH1o+3tcK2RHoyEQDq
 K2UAkyxNLkAiDnWyMwLJr9tZKl1vxBf+56p3wn9t/PDZdXGuFteHIyw6kEZxcCghImwy
 axHP4LvjyAlhb6ECZNcNPTPndTu/ggnM+R5EH3xsfHdX2U/YnXqZYDKYNONjjGrTl/T1
 3+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698763847; x=1699368647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fxHSMYBWiTSk5NVD1xEg3KSvT3Ex+9zHygSFCiZHI5I=;
 b=DyQ85zZpZJwEXNbwJZS1ea515qSD7JaRnQj4ufOdpq5wwhSQB1YXWpzs7os6BOI+9y
 k1IaEBuGan/VtVN6rtzobq/3yXyS6qO7MiNm0kywAkezo+2HL6zJxqB9zhHTUAeHreSI
 0s/MPGHwqfmPsFkISAdXCxOHtklrYBAPC39v5IvqxavEqfbS/4RAGX0l6tPmm0uNcDyT
 Ooi3xW184OwEWLfPSjUfltNqRhFzLPLaSWZCs+6UOl6/qIgl30YwEFgZmKs8/99RSPiz
 abdmxybzSzXCtR8bmlZV4bmuetdsZmt0MNoU7E4DYh5bcg5zQyitofZeZtoMLCzHHOSo
 29Ow==
X-Gm-Message-State: AOJu0YwIqRMGZt9jw+B1ys3XmMOJEpZbitQJc+eGp/D8VXfA39plEjsw
 W1Wa75NGQlr38+ifQt73SbDvGw==
X-Google-Smtp-Source: AGHT+IGJYeXBlMT0ouxPQPmaowUliheDGR9wmOw31OQJzzZDSG85OBYDdG0t7KKU/hdVRNCVvF295Q==
X-Received: by 2002:a05:600c:1d07:b0:407:8317:ad81 with SMTP id
 l7-20020a05600c1d0700b004078317ad81mr11622791wms.1.1698763846831; 
 Tue, 31 Oct 2023 07:50:46 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n12-20020adfe78c000000b0032f7eaa6e43sm1662612wrm.79.2023.10.31.07.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 07:50:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 79EBA65731;
 Tue, 31 Oct 2023 14:44:03 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 18/19] plugins: Remove an extra parameter
Date: Tue, 31 Oct 2023 14:44:00 +0000
Message-Id: <20231031144401.1238210-19-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231031144401.1238210-1-alex.bennee@linaro.org>
References: <20231031144401.1238210-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

copy_call() has an unused parameter so remove it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20231019101030.128431-7-akihiko.odaki@daynix.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029145033.592566-19-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 39b3c9351f..78b331b251 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -327,8 +327,7 @@ static TCGOp *copy_st_ptr(TCGOp **begin_op, TCGOp *op)
     return op;
 }
 
-static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *empty_func,
-                        void *func, int *cb_idx)
+static TCGOp *copy_call(TCGOp **begin_op, TCGOp *op, void *func, int *cb_idx)
 {
     TCGOp *old_op;
     int func_idx;
@@ -372,8 +371,7 @@ static TCGOp *append_udata_cb(const struct qemu_plugin_dyn_cb *cb,
     }
 
     /* call */
-    op = copy_call(&begin_op, op, HELPER(plugin_vcpu_udata_cb),
-                   cb->f.vcpu_udata, cb_idx);
+    op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
 
     return op;
 }
@@ -420,8 +418,7 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
 
     if (type == PLUGIN_GEN_CB_MEM) {
         /* call */
-        op = copy_call(&begin_op, op, HELPER(plugin_vcpu_mem_cb),
-                       cb->f.vcpu_udata, cb_idx);
+        op = copy_call(&begin_op, op, cb->f.vcpu_udata, cb_idx);
     }
 
     return op;
-- 
2.39.2


