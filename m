Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2AA7C9286
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 05:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrVS8-0007bl-2v; Fri, 13 Oct 2023 23:36:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVS2-0007b0-98
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:36:31 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qrVS0-00045A-Ru
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 23:36:30 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-58e119bb28eso3010594a12.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 20:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697254587; x=1697859387;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=2u5zZzb8rW5NBD8zNkIgh20iajxbQjz0zlEo8j3U++Itwdrl7Cxx649k5Pz5V5fm/m
 Rfs7hhPggfPncQ1aLKxjAIEDR0m3dmiarJyeLXrCLgvlWYubf+/gkzkjjKRb8eC21URE
 QoRZgqng6NRdGTt2fmfRKdLdkIQEJ2V/F6GKIbv8I07eiI97ny/1XtxAyD8iAmEqjCmR
 WMJxEf7EXbzI8ZQQEiZHaR+ADEk5BhxxYjt0M7I4DPTSfMEI5EMWEetyIFLtM9GHVgER
 T1kPpYoXrWQDdPdidX08vCmAFf4AHhzHEcQI61yJMXirQyFUGf2LtotGGJBKFzQSAnPX
 KiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697254587; x=1697859387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVVhU7FVBGv/xT5QVrpV2Z6/BYaCzW+7Ey07YWq/aa8=;
 b=Z7akoVOTY8M45Pofy8XMWA53ZKfnWzWwmeBw5Vs6WECoyG/ZhFYdwpsfBg6AIBOz+d
 i5fmW17mnZxJe5uSkRNAznE0Rs8RbOwPuk1fXh8ANn2ZQMwHans9Ux0uyPg3vB/S6ip5
 MC8Xym2EP0paJZiq9NEs9m+hLeyF/kcpr2qRvXTGyKzVv1bSd3brk6S3Uc5CaOssFOsd
 Rl8j9SeQ7lB80i3rSSfZHSBmYz8PSy00oU7Wsw5qhT7YtUczm7jbQAE2DJTBdK8OBxKm
 mFkQ34y0YhSocZgbSPTeTRkjwNI/D91pa1yhkBJpESxNJV37DomWvgcsqldxAoKtxFeB
 8zaQ==
X-Gm-Message-State: AOJu0YysjLPR/XNDmIwRjEB5rT7yH3LZI6dl709DHHveJSIJo16Zrfx/
 5yZK2Ji1Zv82eWMrRsCHCB8ZFA==
X-Google-Smtp-Source: AGHT+IHNieiowgvn07Aw6voEv632Vr1ECyoTfAD1W6BI5o9VKNaOnUg3FpBKjfrKV1Vf5y+L1dxpaA==
X-Received: by 2002:a17:90a:8a18:b0:27d:c5b:747c with SMTP id
 w24-20020a17090a8a1800b0027d0c5b747cmr2822186pjn.2.1697254587370; 
 Fri, 13 Oct 2023 20:36:27 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 l5-20020a17090ad10500b0027b436159afsm796077pju.40.2023.10.13.20.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 20:36:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 3/3] plugins: Remove an extra parameter
Date: Sat, 14 Oct 2023 12:35:41 +0900
Message-ID: <20231014033545.15220-4-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231014033545.15220-1-akihiko.odaki@daynix.com>
References: <20231014033545.15220-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
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


