Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C667B7B67
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:12:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxqg-0001Qy-KE; Wed, 04 Oct 2023 05:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqP-0000IB-Vo
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:02 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqG-0007Na-3t
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9b2cee55056so349660766b.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410409; x=1697015209; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exSuT9/NnjvYPrvMnYoWAEzddFkaInk4+sF0o57vHQY=;
 b=QFtTkXr39MXhGql1oowRP/XgYpTTlL9cv9BKNOehi6x+T8wtXBPN4p7cUPqSyh1LRp
 LtBFtI29VRRYAfprAmQTxGP7iIbMC1QPJW3jqD1oXtPn5Eowl0RnMBR4CxJfd6ItaS56
 Z0r6IEJfhPoIU2PBWjMLgrf+ehiqAweUgjzaHlR8/u/DYCHRDVt0gmg/QeZxFfXqnMJz
 NI4TdtfJ62yDJnSdoPdxyRxYiSc6z50AQHjS8Y6odHngU76m2yryiGSTX7et93SKC6XO
 vdJj2BxEsAPKocLcY5vVBMh2RsyBlQ4B3lRQTq3HSVsHRcoWIGyVT4OlWZesgcog75dt
 l5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410409; x=1697015209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exSuT9/NnjvYPrvMnYoWAEzddFkaInk4+sF0o57vHQY=;
 b=fP9BjesFrMC8k5t1oAunwJxpWjKsTQnlGe6bB/Lc1VCLw4rWXKb3sbgrLLykSJf/c0
 QR5uC2rQhkPj4oNZiim7s9De5PGoBdnosJ1PeHOGvmO/IZ7aOBvOjpssi83SHcDy2haD
 jM2MDBAwVYdn8ulFQhh//pdZrZJmdWXh76hpqyYu/ZG1UL7wScduqjWVqBuhrAK2m6MJ
 l8MaXsWTmGU1JcA2L+jjATc3FGzksB48KCvTRMRAKMP8O/awMmAKpigRu5y18McYyvn1
 eqB9DXwWi2Pxmok5g85Rz0poi74TgzEt2BcEUaNML0tn3/gYn2AWmL3epbfxxzeelfj7
 nuWQ==
X-Gm-Message-State: AOJu0YzgCish+qSya7HeqivhrUtMF0iTjFDUqhqwDNSCPO4QROv1+4ky
 vEV/HaXr6v3oE6WeTYABKWj3PjEJRoCSotAHZyo=
X-Google-Smtp-Source: AGHT+IHk/MNCNP1hSn2wP1C4tfXybRQGCpaPc50YEr2384IeglMQ0LyoObxoYLaU7hOwZaigDollCA==
X-Received: by 2002:a17:906:518e:b0:9ad:8a29:f26a with SMTP id
 y14-20020a170906518e00b009ad8a29f26amr1556091ejk.63.1696410409209; 
 Wed, 04 Oct 2023 02:06:49 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 k1-20020a05600c0b4100b00405442edc69sm977268wmr.14.2023.10.04.02.06.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:06:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 03/13] cpu: Correct invalid mentions of 'softmmu' by
 'system-mode'
Date: Wed,  4 Oct 2023 11:06:18 +0200
Message-ID: <20231004090629.37473-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 cpu.c                | 2 +-
 hw/core/cpu-common.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu.c b/cpu.c
index 0769b0b153..8cb6790142 100644
--- a/cpu.c
+++ b/cpu.c
@@ -209,7 +209,7 @@ static Property cpu_common_props[] = {
                      prctl_unalign_sigbus, false),
 #else
     /*
-     * Create a memory property for softmmu CPU object, so users can
+     * Create a memory property for system CPU object, so users can
      * wire up its memory.  The default if no link is set up is to use
      * the system address space.
      */
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index ced66c2b34..f04d59c8d5 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -228,8 +228,8 @@ static void cpu_common_initfn(Object *obj)
     cpu->cpu_index = UNASSIGNED_CPU_INDEX;
     cpu->cluster_index = UNASSIGNED_CLUSTER_INDEX;
     cpu->gdb_num_regs = cpu->gdb_num_g_regs = cc->gdb_num_core_regs;
-    /* *-user doesn't have configurable SMP topology */
-    /* the default value is changed by qemu_init_vcpu() for softmmu */
+    /* user-mode doesn't have configurable SMP topology */
+    /* the default value is changed by qemu_init_vcpu() for system-mode */
     cpu->nr_cores = 1;
     cpu->nr_threads = 1;
     cpu->cflags_next_tb = -1;
-- 
2.41.0


