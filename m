Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5F7C5032
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWXI-0001Xm-0Z; Wed, 11 Oct 2023 06:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX5-0001Ku-MQ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqWX2-0005BM-8w
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:33:39 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4066692ad35so62488245e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697020414; x=1697625214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tXtc55X9ZMWnLYaJ7rtH4hZORRpdhmNZnt+nFsO0Mb4=;
 b=OwSNGSroQ/SYg4FQJi0KsND0GwFE3rVu00zA3JPaM4h28oKvsO578klV8VMyEAgF6y
 bmosV9vyXMSoJZ5cn68DkJq3OYf194UlzdESClr3c1N338/jECa2eexDcU+tQXFFF2s7
 JcQk781bbIjqQgQmcRZ24iUTRXCn2ZmsHP0v5DBJdIr4kGqg9U++vsrpb0aeL6IIate7
 v08dBOzt/wamyFON4vSpgVKzUsjFLlzAAZwwU8Szi9zXu6JwFtTx2tf9DjRpL0qSqnYV
 W3Ai7DZyFrR6YdNF+oMMCSPGk/6lz5ltyedctFkBq7Jm87G8eCPA9V/vzfZNXTmWDDx/
 mdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697020414; x=1697625214;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tXtc55X9ZMWnLYaJ7rtH4hZORRpdhmNZnt+nFsO0Mb4=;
 b=e2eLKPqtK05a0UubmwNOWk3w6l3CiKUdWoFehXkXbyeXjzIBIc/xOJwE2JDu/0Jits
 90jzpPX2r1I/uSAb5q/Nd9uykJ472jF8T1Wxl5+bFZgVcR/uGR1w2Iloq2bCTnhfdd7G
 kJsfrB91aLZeiwFeG6GXhDbPomeuH/AXDcyGxL/aRWYkpfEOp8H7e8vqRKUxermz18Vf
 zt4O3kRM9VdyU7G+fB9jk5RCibRtDUH5oYwYajxnt43bZ4tUMvLrFTRvZmfnSc9a/Bpj
 iVVSlR/ckqys7YoB7I0ldxF+os0tgV3bWng2+OIGglQ5ulBcr/ALpj2JPuJwFfcq8Lb8
 +JeA==
X-Gm-Message-State: AOJu0YzeyOZhmRcH9B/u7EwU97f2MxxH8l0rnXpwib5RQYTqTVOSthAt
 i1cgEAv0QOkxsA3qiv6OxR626g==
X-Google-Smtp-Source: AGHT+IHvh45bFG36ODYSOlybfFcbv+UXlU8u3Kba5s/Lmmk+et8vANSxZNiU1SDpRBG/Re/SaiYu7Q==
X-Received: by 2002:a05:6000:24d:b0:32d:84a3:f3fe with SMTP id
 m13-20020a056000024d00b0032d84a3f3femr1147488wrz.41.1697020414270; 
 Wed, 11 Oct 2023 03:33:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s13-20020adfeccd000000b003198a9d758dsm15094918wro.78.2023.10.11.03.33.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:33:32 -0700 (PDT)
Received: from zen.linaroharston (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 367431FFBB;
 Wed, 11 Oct 2023 11:33:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 10/25] plugins: Check if vCPU is realized
Date: Wed, 11 Oct 2023 11:33:14 +0100
Message-Id: <20231011103329.670525-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231011103329.670525-1-alex.bennee@linaro.org>
References: <20231011103329.670525-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

The created member of CPUState tells if the vCPU thread is started, and
will be always false for the user space emulation that manages threads
independently. Use the realized member of DeviceState, which is valid
for both of the system and user space emulation.

Fixes: 54cb65d858 ("plugin: add core code")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230912224107.29669-4-akihiko.odaki@daynix.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231009164104.369749-11-alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index 3c4e26c7ed..fcd33a2bff 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -64,7 +64,7 @@ static void plugin_cpu_update__locked(gpointer k, gpointer v, gpointer udata)
     CPUState *cpu = container_of(k, CPUState, cpu_index);
     run_on_cpu_data mask = RUN_ON_CPU_HOST_ULONG(*plugin.mask);
 
-    if (cpu->created) {
+    if (DEVICE(cpu)->realized) {
         async_run_on_cpu(cpu, plugin_cpu_update__async, mask);
     } else {
         plugin_cpu_update__async(cpu, mask);
-- 
2.39.2


