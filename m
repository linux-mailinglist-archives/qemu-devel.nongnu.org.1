Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D01B27CCB51
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qspDJ-0001Jd-5b; Tue, 17 Oct 2023 14:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspDH-0001JQ-1B
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:54:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qspDF-00073C-JU
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:54:42 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1ca3a54d2c4so27128025ad.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697568880; x=1698173680;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=SjJkf1eXCLJtutmLcwcd0Z05Q8PhJPz50CwP5G+x0EH+zvUg57Itgvi3d7b/n+WG6h
 bL2T0iFMAYviP2Pkf4s3Z3vVH3pJHm291/bsz9Ckhhg2sOz9nmRwsxuJnocS+vYXJnef
 aP1oRFzpopmlEgz062/yMIr6ETauf9IJbVB51/dy+9FLW+OKH7ch5WtlYqOTUnb9X92A
 4pIzAlYJOAv9gnwhIO0foIaa7lU4gR3vNo+Qp+PjuZJrwkPxHBj/Lhor90nxFe4WBB/q
 aEJh8fgiAIn80d1aBbMV9klQi2E6llyImWAQ6KK+7I2MYDMmE0O8OASriyrEX7Ey8o3p
 3lOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697568880; x=1698173680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=le/Hha/YvNRjP6pMyL1xk/fGIczU0hHg0zj9oINmVC9CogtQhnPZnXST/0XvcR+JZl
 Lk2Ng9OO1xGOr+0nlN6W7WYE6cFWwC7wYTBLoBLFpxpudE8g/VTGjXvgQ4MsgNfmrTuE
 V/8JSFO11B6W12/XyLZnZVB0Z6mKnIIvoZD4csIKN8a4089FprtGZAetOBkpt76JjO1u
 DDGOkaBw0TbAjrsLpzx1JlbnR6HxK16lQnkvA8vFYZZbZ366H6TLF4gUR6V+lk5qdxmF
 jCt8JSwuGFkTVQKliKu2ZKdncxtfN9yew7/I8iwKyhC774Y0B9JcKRdRBhQIP9tbUVZM
 LvgA==
X-Gm-Message-State: AOJu0Yxx9AqhDsVMMwoJ6YeQXRqaEZOEjNv/c7N9aqHS3wJO7usA8Eyh
 jr0EHBj+b4LfJ5SnCvJc+lhMoA==
X-Google-Smtp-Source: AGHT+IHgQvVmJXGe1R7E8zQmXdofaVO3FoWXWum62jmVhj6zQzjam3VZdQFUiiLWq92Kx3n88mHZVg==
X-Received: by 2002:a17:902:e80a:b0:1c9:ff46:163d with SMTP id
 u10-20020a170902e80a00b001c9ff46163dmr3908278plg.38.1697568880368; 
 Tue, 17 Oct 2023 11:54:40 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 p12-20020a170902bd0c00b001b850c9d7b3sm1922162pls.249.2023.10.17.11.54.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 11:54:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 5/5] plugins: Remove an extra parameter
Date: Wed, 18 Oct 2023 03:54:00 +0900
Message-ID: <20231017185406.13381-6-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017185406.13381-1-akihiko.odaki@daynix.com>
References: <20231017185406.13381-1-akihiko.odaki@daynix.com>
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


