Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 824BD8D527F
	for <lists+qemu-devel@lfdr.de>; Thu, 30 May 2024 21:44:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sClfz-0005da-KH; Thu, 30 May 2024 15:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClfw-0005bo-0J
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:43:00 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sClft-0006HX-1a
 for qemu-devel@nongnu.org; Thu, 30 May 2024 15:42:59 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe6392eso1177179a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 12:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717098174; x=1717702974; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fPCSTF6BhpGl/BOGWj8t6sMDRxBkBVgL05/HycPv784=;
 b=Cpr15LOX3D6CRbGYnptBxBZx07KYsY8FhPeQXNXTvuJAedeA5iL8KqBe/gYmn9P0Ra
 GywApjV6hl5szGirleSwljmgAdf/PUm6aO1wN8HQaP8+yZqTCB8Hnyfus/H5vS5OxSAT
 KHRJVywwd13mq0H8endRpFu8Xs9gc0QhBXi/N8SgSmgNKwLtzJhZRVueDoZaBdLSEzrS
 /cCgj8Al4Wp5AvcMtSwtQXiV+VUFOJrdZcwmQEILL7fGuxNRQvpWo5JGIlFf6QGf65lP
 IWiHpCt2rMZX34vRt+/rBDdyzRNAA18JRLQTLmtZqUZHYuH5hYbp/GX3OjUGvel0Ol1K
 mL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717098174; x=1717702974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fPCSTF6BhpGl/BOGWj8t6sMDRxBkBVgL05/HycPv784=;
 b=tAPftSMohLf0yFYMQSTOme59OKsu6hlGJxLGM0tNPGBwz3DqhmsUOr4baOOB3r8v62
 Is1SIAO5oEkjaKcvcWmTeZKs9/lcA0gSu2hKUZ9kPsvCu/PystzogdMYG9h3/JQPHkat
 sGXHTNHAhWUqrm872E39nOLeysb2Yel7wEQgizqT1t7KjS1+YD5UcR6OPTwF318lQH7z
 cJ9oWkl2U2TRaTh0JyQcUFLJ1lM4GCGAA6Ab5IFv0pLGgsqAuDwS+gz6wjZZchZEFdip
 4cniQrjsMMKFEo9RyE9AmtVpu6/6I5a485eORYh+RmjuhrwD94kCavDMNXs4AluqiKs0
 2rWA==
X-Gm-Message-State: AOJu0Yz/5YF6/pBvDuZkmjZbA8WaN5FLsXizzTqMbQZhiWKVx7Pn9nrR
 w9S7/DD+FNeS9uMYrqSSKZaxG8qjhtLTREGW3AyY6suZPhJwoqXwsIl1p4ixwKQ=
X-Google-Smtp-Source: AGHT+IE6R76QAmiPveib3Be1Nxuw357LnoAEk7dKHLZ8AdvRVSDfuYn+KOWdz8CdSrBFOQdmXMpLAA==
X-Received: by 2002:a17:906:7714:b0:a67:da88:149a with SMTP id
 a640c23a62f3a-a67da881f76mr21672966b.55.1717098173884; 
 Thu, 30 May 2024 12:42:53 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab85c8fsm7754766b.183.2024.05.30.12.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 12:42:53 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16D015F8E9;
 Thu, 30 May 2024 20:42:51 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH 5/5] core/cpu-common: initialise plugin state before thread
 creation
Date: Thu, 30 May 2024 20:42:50 +0100
Message-Id: <20240530194250.1801701-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240530194250.1801701-1-alex.bennee@linaro.org>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52c.google.com
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

Originally I tried to move where vCPU thread initialisation to later
in realize. However pulling that thread (sic) got gnarly really
quickly. It turns out some steps of CPU realization need values that
can only be determined from the running vCPU thread.

However having moved enough out of the thread creation we can now
queue work before the thread starts (at least for TCG guests) and
avoid the race between vcpu_init and other vcpu states a plugin might
subscribe to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/cpu-common.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 6cfc01593a..bf1a7b8892 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -222,14 +222,6 @@ static void cpu_common_realizefn(DeviceState *dev, Error **errp)
         cpu_resume(cpu);
     }
 
-    /* Plugin initialization must wait until the cpu start executing code */
-#ifdef CONFIG_PLUGIN
-    if (tcg_enabled()) {
-        cpu->plugin_state = qemu_plugin_create_vcpu_state();
-        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
-    }
-#endif
-
     /* NOTE: latest generic point where the cpu is fully realized */
 }
 
@@ -273,6 +265,18 @@ static void cpu_common_initfn(Object *obj)
     QTAILQ_INIT(&cpu->watchpoints);
 
     cpu_exec_initfn(cpu);
+
+    /*
+     * Plugin initialization must wait until the cpu start executing
+     * code, but we must queue this work before the threads are
+     * created to ensure we don't race.
+     */
+#ifdef CONFIG_PLUGIN
+    if (tcg_enabled()) {
+        cpu->plugin_state = qemu_plugin_create_vcpu_state();
+        async_run_on_cpu(cpu, qemu_plugin_vcpu_init__async, RUN_ON_CPU_NULL);
+    }
+#endif
 }
 
 static void cpu_common_finalize(Object *obj)
-- 
2.39.2


