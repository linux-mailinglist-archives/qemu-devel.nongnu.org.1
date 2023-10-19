Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 754EA7CF4D3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:12:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtPzu-0006EK-LJ; Thu, 19 Oct 2023 06:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPzf-00065h-Ps
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:11:08 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qtPze-00086b-A9
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:11:07 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so445061a12.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697710265; x=1698315065;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=CHvgD0aZGsyV9GEJ5k2iXhncfXIHgRo8jrP0oZizRj8OANtCd9kyKRLNpP+rms9YzB
 IhnXB+DuqvBSSg8JF6pWW5nd0qVXJt9pCZzTHurTuRCYhGxnq/IGuwv01wZFM4simqIx
 e7CAfXviy5ON+K7de5y8oCEmODo6zkM6Ef8jkjn9zoWu3zBh1OGN0EqBk0OC2TOjkHwZ
 ODBvWQyxW8XyzU1TWkDa6m4ZHR9VsCfctx7H8rMfVNWFcaelvNq+nbVSynzPzl+Imcx+
 3YUz73PJun1DGK6cqUbf/dh0ftTueoTdC79fENBxRmlYKap4U+49CmlxGnBfbgKEQPTT
 Natg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697710265; x=1698315065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=F2m4AaZs66JjVtBWuY5qLPpZ8//uVHd5pOHJyG56DVGpqsM8Sy610v/udOwblIMUys
 XciQOMKjpeGffKXjAVkM0juTIsoI9msoTedH8uPqHRZe4MJd+uhl1uvtW8Ih3h86kKZh
 nsWca88Fhb90my9xUTdJio8+ZipNUU5zq5mhDHKcR8+4FOsuMtggM9kDAX+k9rsfWrnK
 3QI2FrI0DbmS66GuSS4S/zlN3/QeY95bKvwl8qCBVYuO4Gm+Nk1jRudG0kFVLjw83vFo
 0GDwJ/cZ9i0Jyx0TZnAqjTTHoz3+Ih8I9Vo/MxwgllwkFsovzL55ZmQ3Fb2QCjaMXTLl
 jURA==
X-Gm-Message-State: AOJu0YyaeARJaHOkLGmwLbQYER2+laH8sn1wGjZSxtgtE7s5HGCfdrjG
 RTGN+frXZoqmk2qHIH5SrDbA8w==
X-Google-Smtp-Source: AGHT+IH3LRMhIF3HWV3XT4vVTjK4/nZCjnDS+/sDGjnZsmyNM/c2ZHzKhS1om+Jg3kOXJdjixRmITA==
X-Received: by 2002:a17:90b:3ec7:b0:27d:5568:e867 with SMTP id
 rm7-20020a17090b3ec700b0027d5568e867mr2291545pjb.9.1697710265099; 
 Thu, 19 Oct 2023 03:11:05 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 d30-20020a630e1e000000b0057ab7d42a4dsm1658544pgl.86.2023.10.19.03.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 03:11:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v5 6/6] plugins: Remove an extra parameter
Date: Thu, 19 Oct 2023 19:10:28 +0900
Message-ID: <20231019101030.128431-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019101030.128431-1-akihiko.odaki@daynix.com>
References: <20231019101030.128431-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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


