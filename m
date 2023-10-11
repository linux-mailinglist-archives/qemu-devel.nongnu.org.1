Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E7D7C4B34
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 09:07:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqTHQ-0001PN-3Q; Wed, 11 Oct 2023 03:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHO-0001MU-1K
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:14 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqTHM-00061a-FA
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 03:05:13 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1c9b70b9656so10769655ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 00:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697007911; x=1697612711;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=q7f6/lgFUwtiMhyCKZpSkft70O6xL8rFeS0AIKguWAicUGK2zfNcwFugG84uWjsDI/
 H6YNxp/dQV4/DXYmXmcWb/sNcLURsXN6cAP4IqYgfoZ3wYo4f1jvSLXTGK91KDgRat+j
 wOAa7cYavofIhx37XQQoqKSRPpSWZ/PH9dOUMgFnPA1uxuV7ZR7TNbhEBziSz8jNrW1/
 2MsXpxJu9RCGh9MehudsQDD8PBFr5FXqhr1IH4oBEb89DrgdkoQjJjBlB2KXGak1W5C4
 G4rbyxTyGP4ZkIZXgvBliIJmy7iZCmDSg3GxYqC4ey4tRL/GXu4xk5UnQLPIkLERbOrO
 4FPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697007911; x=1697612711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=smr56Pl52Yx0NcwC6vv8WVnaILWf09S++exZaWw0IZAqRDxiA/pzoh6oUv9CC1fwH/
 12Pq444+7AUxlwTQZIDoC3MWo62U6UwkW5vLFD0QrWCY1uM8tq9AdIGjZzRCkGgOq6+O
 s3PCAkCbk8xLS2JcVWq58fJKCgP3VOxmrvLyC4AJSKg5nWBtTp7pjpjvz0I0KbIGKqfK
 j6iCyoolue3N+ToVQdIo+cKK88qlCO3R6nCDbMTAHoHZ/mEnACgP6Hior9hCZ519YvrO
 QtO8XFU4lzFfZbP0IYTVmZN++PxFvzI8M9wAvFdpjjcXioAEe8qw3wp0qdHSFg4CmQ/d
 FLxg==
X-Gm-Message-State: AOJu0YwQLr4XrsF7CIykIM20bSUcstQ94I1Dnm/oubSY7h/cEIh9kx07
 X7ZNUU9cANXZhJ6ueWvOxtBqZQ==
X-Google-Smtp-Source: AGHT+IFQ2h6HNZ4sP55TSx43ogj7wrgttm8jzHWEg/2psT1O4isywPAeS+CY+ePT9odKSkZFARYvkw==
X-Received: by 2002:a17:903:18a:b0:1c8:91d8:d5ca with SMTP id
 z10-20020a170903018a00b001c891d8d5camr11750239plg.42.1697007911204; 
 Wed, 11 Oct 2023 00:05:11 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 iw11-20020a170903044b00b001bc930d4517sm13098117plb.42.2023.10.11.00.05.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 00:05:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v9 19/23] plugins: Remove an extra parameter
Date: Wed, 11 Oct 2023 16:03:05 +0900
Message-ID: <20231011070335.14398-20-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011070335.14398-1-akihiko.odaki@daynix.com>
References: <20231011070335.14398-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

copy_call() has an unused parameter so remove it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/tcg/plugin-gen.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

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
2.42.0


