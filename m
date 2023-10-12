Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B52AD7C64B4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 07:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqoTe-0003HZ-Ph; Thu, 12 Oct 2023 01:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoTR-0003EF-2x
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:43:08 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qqoTO-0005VU-UK
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 01:43:04 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c9daca2b85so4362675ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 22:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697089381; x=1697694181;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=Yo27ie5SkIHd8xjsep+ICeEzQTYDeHeih7KP/LDLvnIsKq6umK87hJnLzqZZgkOCZj
 nyO7vVSI5GroYNiAZynVcxLSlCsl/Ta9wqyrZkt9+dVst7GDajGlzpkCQ8N4b6ndWVnG
 4J+pg7xZFrhgDAlWElsZjSHjbJfJqFjtNC/+S7HBAF70D/B2U7fC0g7JYYPzm3u01vBm
 r1bKvm1dL47ugv2YtVqJOjEmmN+dhU/k9l2a+S6R83uXq2LxwdKNE+JimKwnMJxUh6ij
 W7AlmdFn4pBXhSo9OkBvPUmk1GNc6slJSNOOzl+Jr0uDXS8cftjyVHziq8lXWpV+8fbh
 7L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697089381; x=1697694181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=ryEp2xlAQTovuo3Y3hZ7qhSE0LRKHsI1p4NOyWKUFWFb5avPniNbMuYq8JtXD29uh+
 +CZaIl2I/lc3DIziTZ5Y8DqT0RmBs80Ir2MmcQtfUUY/diD62PPmChpeL4HAeVUZAzc1
 Cti1k+JV5Giniu2MKgduq0BEuNFLGmv4rx2VCwbn8jbwxRstnoxGP5jmAzTmYh4wXVTV
 wGBKLv175N2MhpHbvQNVT2ji4S9HuJkSj3LWW/7vf81PJ2zB0hnX2YUvD/3w8XzBx8Za
 r0ICduI0igfGYBjRIbDef3/hAlkBrVgF+0eNpIGQA8cDmjlikdt4TLLPzB2mr9IJWsMu
 uh7w==
X-Gm-Message-State: AOJu0YyuNSUV25b/5dyHNWwLPmHC1U2CH/r1xsglHT7hVtY7ZVQIOBKy
 pCI4wICIk4FMXwLG52IYHSLT8g==
X-Google-Smtp-Source: AGHT+IG5skQ0VUg5pdJtI975IaJ0CcGWIX/vPnuQClgFA1lk87NyOQ2ifgwyGTm2QuYGf2oibNlfmw==
X-Received: by 2002:a17:902:d490:b0:1c6:de7:add9 with SMTP id
 c16-20020a170902d49000b001c60de7add9mr34552716plg.19.1697089380680; 
 Wed, 11 Oct 2023 22:43:00 -0700 (PDT)
Received: from localhost ([157.82.206.10]) by smtp.gmail.com with UTF8SMTPSA id
 jg13-20020a17090326cd00b001bf044dc1a6sm922996plb.39.2023.10.11.22.42.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 22:43:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4/4] plugins: Remove an extra parameter
Date: Thu, 12 Oct 2023 14:42:19 +0900
Message-ID: <20231012054223.37870-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012054223.37870-1-akihiko.odaki@daynix.com>
References: <20231012054223.37870-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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


