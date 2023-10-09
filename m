Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B7A7BD65C
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:10:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmH2-0001jE-Lh; Mon, 09 Oct 2023 05:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmH0-0001iJ-2Y
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:09:58 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmGy-0007PO-Lo
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:09:57 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso750774566b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696842595; x=1697447395; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zDyH1gKuZJCM1RphwPpjmEjyYLrUqVd//97ztF5U5xs=;
 b=uoLTNra4SNhNVazNoDc6anpcRjmhiS10f6Wl5tAAMlE8w3MZ8WmHH50xGju2U/Vi3N
 hkeNd/pOjvxpL1ca+JLMJr+BEgJz9pak2OL4V+urszStkhJGj+by/Gqn4zSfmY9yF/Qo
 7/le4Q0cuna+o94Fik16PegiYSe7JRYWh8tYRz7M15DwuW2PVsfCu7koJsG+s15pds5s
 PxMa/pRaX43vnNwprOkeGEApOidufFzGAFdn8RurZMZSIRu0jIah7c2eQRR0rgSIePcE
 J0rrNNt8/crPX/9xqJs8imapkR/+5vSP32hk7BfLisfmyu0riJks+L1Oq7bnZCKdwHki
 Zdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696842595; x=1697447395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zDyH1gKuZJCM1RphwPpjmEjyYLrUqVd//97ztF5U5xs=;
 b=f6n1YPz6vwOM4CLRkEeWbwiCln5rveGRtXq54JNfYl3AuE2e6ElgV/Kbqk8+Md6VwV
 a1K2b5DTlsUjRpWHpiJ5xVuf+I4FnrrxGDlejDsJ/O+ey+ICp8CSOM1jEBQSycJh13yH
 SeskuOuqI4PexCZBoZAeDPmnV6LnyQS6EL5hVhtcAxFD9kulYj7qnrz39C3PKD6Dz+X7
 iMcbZQ3+7abd1ogILvwyNyfLyx++iTdYJ7W/V1GC18xfHvtZM584R4hEk/SUmhLyndcd
 LDzfGmRXqDCulJNAPClSmf0iFGqNzOGjvKNf8Aq8sGmtR8Pm3aB3o46ASNZLubJaoZrk
 H5cQ==
X-Gm-Message-State: AOJu0YzN4fEQtslj0efNpHH3//JfVOR9YMRtLiSB6XYIuAsONVJQSTHY
 VH7uyR/K6TEVrDzzz/yKwXf4F3ZdZoGk+WHWtIE=
X-Google-Smtp-Source: AGHT+IHLpm0YUtvULY4qLlhf3SyegjYEGJcLOX1OQsvecCpmvkolRm32YwlSUpUyZXIALM4aVqaBJA==
X-Received: by 2002:a17:906:5341:b0:9b8:7709:6360 with SMTP id
 j1-20020a170906534100b009b877096360mr14960773ejo.40.1696842594752; 
 Mon, 09 Oct 2023 02:09:54 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 p8-20020a170906b20800b009a1b857e3a5sm6469180ejz.54.2023.10.09.02.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:09:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org,
 Like Xu <like.xu@linux.intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] cpus: Remove unused smp_cores/smp_threads declarations
Date: Mon,  9 Oct 2023 11:09:52 +0200
Message-ID: <20231009090952.48207-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

Commit a5e0b33119 ("vl.c: Replace smp global variables
with smp machine properties") removed the last uses of
the smp_cores / smp_threads variables but forgot to
remove their declarations. Do it now.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/cpus.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index 0535a4c68a..b4a566cfe7 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -50,11 +50,4 @@ void cpu_synchronize_all_post_reset(void);
 void cpu_synchronize_all_post_init(void);
 void cpu_synchronize_all_pre_loadvm(void);
 
-#ifndef CONFIG_USER_ONLY
-/* vl.c */
-/* *-user doesn't have configurable SMP topology */
-extern int smp_cores;
-extern int smp_threads;
-#endif
-
 #endif
-- 
2.41.0


