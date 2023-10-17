Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C988A7CC197
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsi0E-000177-UF; Tue, 17 Oct 2023 07:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsi0B-00016h-Q5
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:12:43 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qsi07-0004fS-30
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:12:43 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c9b95943beso46263915ad.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697541158; x=1698145958;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=ELLeHm4kHYEnXo4vCzqf5Sc62hAUSKZvyE3ONBPwY672oVaXtBeOZoRJqwV/Nrt4Yi
 3/h8U5hJTQ5c1flQQJPkKfzTTNwtaCTZ1BAlq7d1qhDSV4g/igGIYcCkMiZGmmForBNo
 /HM9bNi8K58kKglPWKIvUmggJqFmhh8+cotVU3hfMe/4nIL7cn6o3wd3tnUfustQVCTg
 9OzOfUd7o1ImhvHvUxS3Tea/GBoES+HZ6WrdWIx1vXC6RgLTdhPHIGlcjs7umCaAHkDc
 Amw6bTr3/j3c5fCaBAH4Gm77TEdh98ENnCW9+b699KdUAD5wPxU5UZdCNhJ/yyisQjJn
 uarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697541158; x=1698145958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=GMlo7WrNnLqPP9PiD/16mcOcWLaHG6JUIbJICEGkfIwW67Ktayr1UGm8FK76cXVGhl
 8G0DwEI7EJ/HYeO5GIdB4ORdJmcoPQrPBdAmrQa5tIMTs4wVmpz+kGEbfcF51oLbFUMx
 UI1f3iR7rKd6vHbF+2x7yfYhNwEGyWT6rzOsYa39fJpKiZ0G2Hq/2jlBa964Ga/SF+P/
 3joh9KH11rAjUlYkujqLWQpKfDy6CH50Sftp8oYw38WYzlBSLkb3Na2ig4EuYKMTcYW5
 YijO/cSW4McL8alFMts2cIuyYeuWcc9KdLevddZ/xAuna6mm52HTHlCdPF/pHWQOFI3T
 nhJQ==
X-Gm-Message-State: AOJu0Yx4if5eUkxSS7plcdEY0HGDYCYOg4RWxhzPxOXT9qUF5cykgxuq
 9uhfJaRnJZlH3weWU+nHkBMbxA==
X-Google-Smtp-Source: AGHT+IEEgAA2JqIHDEVagcufkP7DUjqnX9jcTLNZotlEt29RRSJ5lI1TMUQsZIAfBnP5RqpP9c+Mmg==
X-Received: by 2002:a17:902:c643:b0:1c3:a215:a9ba with SMTP id
 s3-20020a170902c64300b001c3a215a9bamr1843326pls.33.1697541157798; 
 Tue, 17 Oct 2023 04:12:37 -0700 (PDT)
Received: from localhost ([157.82.206.156])
 by smtp.gmail.com with UTF8SMTPSA id
 e6-20020a170902cf4600b001c72d5e16acsm1264640plg.57.2023.10.17.04.12.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 04:12:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 4/4] plugins: Remove an extra parameter
Date: Tue, 17 Oct 2023 20:12:13 +0900
Message-ID: <20231017111215.42209-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231017111215.42209-1-akihiko.odaki@daynix.com>
References: <20231017111215.42209-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
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


