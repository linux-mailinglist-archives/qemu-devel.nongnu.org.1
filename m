Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB87D144E
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 18:43:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtsVf-0003eZ-Jz; Fri, 20 Oct 2023 12:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVK-0003C5-Mq
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:47 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtsVG-0002UN-JX
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 12:37:41 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso158840866b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697819856; x=1698424656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z4zSU56YOB/kPm9j9X/WOBopNqbVDhMN21ij6wb+YZU=;
 b=nC4nxVkmIUF/RiOdg6XFUMMai707JJJLRu29GsLiUhzMoFyb6cAJw6nm7Cf3yCufYm
 WhzpuAaZt9mIRI0gCuL2fUUS4YTOfhbzsbiFRLB9WcYVkFUS5xILE7B0a84c3EN+f4tI
 GdEvnwtrhqkCo9EoJj6z3jeZCxVWbnlzmtV/8jG8cVzAKQ4IjmnZeymAY1FngTq1qyOY
 x0qLHD1If9ePbPnXv3735cHjl/ol+iigzDXGKqxAUtns0+GD2Iuvs7X3zuD+V8bopvBc
 sF7tvQQGJOqgsL9/7DG6CO3CMO7IvuSdIimez9Hw0XiCktpZSHuoR0c5NdnOy2i6T49j
 umCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697819856; x=1698424656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4zSU56YOB/kPm9j9X/WOBopNqbVDhMN21ij6wb+YZU=;
 b=AzJGrwdVpBFCYvweXKkkD1j5e+ikALBOTcz0l68TxATr03gPIOkrs4Lj088tOhUuN5
 JiFV2b+ybQXE1kmgXcDcid4IrgdwbP3FvC1OZkqyTCqRn0Ewh2SXwpVZaej5rHS3Cin/
 huVYbUwCrUQceMv94CKzV5E+tsIkfjlb8mrofH6sxBLS54Lyz+Xb+Z3CBRNRwHGicR4/
 uG8zUGQEmAEuw8XwoIydIzbQTFKDhn//35oZe8upOhED3SVvuAnK6TtbMucCU6S5bdLB
 WDpbZ1e+7+c4aDuVVYD6Y0DfcDFDzJklWdXyyz/9UpJM4V/koUXN/YJ8K/zMx36gwJoo
 +uWw==
X-Gm-Message-State: AOJu0YxJ0OXPBxMtFOXUX3fHY+nHC0DTI9oIvHDdxFxO42yYZD6dRBtY
 mYBdLPk+C91MTUtLs96SMphyODziijoPVbblB98=
X-Google-Smtp-Source: AGHT+IFzE8rRAYRNGkxdtIkU8F15D+clgt+fZzmt2nFT9O/jx8yWn16j3wmMgA1YAJA0Zxgs4hb2Aw==
X-Received: by 2002:a17:907:97c2:b0:9c5:45f8:c529 with SMTP id
 js2-20020a17090797c200b009c545f8c529mr1549786ejc.20.1697819855974; 
 Fri, 20 Oct 2023 09:37:35 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 z15-20020a17090655cf00b0099bc038eb2bsm1782737ejp.58.2023.10.20.09.37.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 09:37:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 06/19] cpus: Filter for target specific CPU (s390x)
Date: Fri, 20 Oct 2023 18:36:28 +0200
Message-ID: <20231020163643.86105-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020163643.86105-1-philmd@linaro.org>
References: <20231020163643.86105-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Enforce qemu_get_cpu() to return S390X CPUs in S390X specific files.

Mechanical change using the following coccinelle script:

  @@ expression index; @@
  -   qemu_get_cpu(index, NULL)
  +   qemu_get_cpu(index, TYPE_S390_CPU)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/ipl.c             | 2 +-
 hw/s390x/s390-virtio-ccw.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 14cd0a1f7b..377f43416c 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -671,7 +671,7 @@ void s390_ipl_get_reset_request(CPUState **cs, enum s390_reset *reset_type)
 {
     S390IPLState *ipl = get_ipl_device();
 
-    *cs = qemu_get_cpu(ipl->reset_cpu_index, NULL);
+    *cs = qemu_get_cpu(ipl->reset_cpu_index, TYPE_S390_CPU);
     if (!*cs) {
         /* use any CPU */
         *cs = first_cpu;
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 7628b746a8..3bb4b13c5e 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -583,7 +583,7 @@ static HotplugHandler *s390_get_hotplug_handler(MachineState *machine,
 
 static void s390_nmi(NMIState *n, int cpu_index, Error **errp)
 {
-    CPUState *cs = qemu_get_cpu(cpu_index, NULL);
+    CPUState *cs = qemu_get_cpu(cpu_index, TYPE_S390_CPU);
 
     s390_cpu_restart(S390_CPU(cs));
 }
-- 
2.41.0


