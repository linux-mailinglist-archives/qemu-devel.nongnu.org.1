Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8747E200D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:31:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxTi-0007c6-AB; Mon, 06 Nov 2023 06:09:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTf-0007aI-UM
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:09:07 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTT-0005HP-KH
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:09:07 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c5b7764016so58453861fa.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268933; x=1699873733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GYvSXfF+xbSSjVZB+VdYev9ZdU+Lgrd51drrmwgB968=;
 b=kEqzA5vUbqqNnqb4gtNslxYTXtRtOC+YU6KblT1ik0ESGiq+77dwnmxd193+cZhs6K
 kQMLqskfhRR9O2elgVWqQj7NYxujnMjjGAV8LtVxUXrDQSJoTEowyx2bsVQ0N6+uxHpa
 mj6OE6LumGqFDlk3fkL4keuvPfw5YJ2vaRznEpU3Ps6/pXRttzfR1D618CiNGXeaQ/uh
 mxSTiLaBYAfMyqOL2oj9Jn7VvtKowruwyOuqerbu9GCctULXbK2hEy9imW508+d6Avgm
 seXvAFh8R5OQu8hmU1FptQVnPcceIs9g6l1LPFehNpT+6lCcRw4ecxgZId9P/t7bnIbR
 XHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268933; x=1699873733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GYvSXfF+xbSSjVZB+VdYev9ZdU+Lgrd51drrmwgB968=;
 b=rnX5q1pjbYqxUcSvW8Wo4hXLaKUo+XIn2+8H2PygNY5QDuIDFMB6qesOC3rwkXQs2T
 xKpeEelMNhCIxd0LLyZQn56w2YuPAPBNPgUrpOaVvpABbJnlie9t1cmnH6nrKt8aCPsj
 FVjXxL56OhbcwLD05VPu3rFbgKREOGlMyhgrnqfDO12tQBBuV7oneXSiIzLeWripfTg0
 gc9FNNH553cJkBLNKqBVx5xKP9A2KbZhZfbAO+iOEQD/G6zd7qPBjjXUTCE+L/kn92Bo
 wMGSRzEoOW9/ZsQ4GT4NMWtTDhVGbeF/G85PVwSgEZwoHrBVX3z9CbdjAKF7KSSUyyFJ
 v6qg==
X-Gm-Message-State: AOJu0Yy4ki70bi/0aEsJf8GbzWr2Dg0MIvtQgf/J24rFGpFkGNJZ6yQR
 rimK2Q/A9TstAeIvpWH06ajkDJF886/DpOqKHwc=
X-Google-Smtp-Source: AGHT+IF/xZcrKq/LJLj9ohahw7rIxBUK2ed8EiXaUmWnZkVh+fy3szTtE+BCuI465Mb1P6JS3uEWwQ==
X-Received: by 2002:a2e:7a17:0:b0:2c2:a337:5ea with SMTP id
 v23-20020a2e7a17000000b002c2a33705eamr22917103ljc.27.1699268933639; 
 Mon, 06 Nov 2023 03:08:53 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a5d688f000000b0032f9688ea48sm9121553wru.10.2023.11.06.03.08.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:08:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 46/60] hw/cpu: Update the comments of nr_cores and nr_dies
Date: Mon,  6 Nov 2023 12:03:18 +0100
Message-ID: <20231106110336.358-47-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

In the nr_threads' comment, specify it represents the
number of threads in the "core" to avoid confusion.

Also add comment for nr_dies in CPUX86State.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20231024090323.1859210-5-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 target/i386/cpu.h     | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 77893d7b81..c0c8320413 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -408,7 +408,7 @@ struct qemu_work_item;
  *   See TranslationBlock::TCG CF_CLUSTER_MASK.
  * @tcg_cflags: Pre-computed cflags for this cpu.
  * @nr_cores: Number of cores within this CPU package.
- * @nr_threads: Number of threads within this CPU.
+ * @nr_threads: Number of threads within this CPU core.
  * @running: #true if CPU is currently running (lockless).
  * @has_waiter: #true if a CPU is currently waiting for the cpu_exec_end;
  * valid under cpu_list_lock.
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 6c6b066986..b60a417074 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1882,6 +1882,7 @@ typedef struct CPUArchState {
 
     TPRAccess tpr_access_type;
 
+    /* Number of dies within this CPU package. */
     unsigned nr_dies;
 } CPUX86State;
 
-- 
2.41.0


