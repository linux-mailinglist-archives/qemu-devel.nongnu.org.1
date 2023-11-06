Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3397E1FC9
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:19:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxTT-00079P-Tv; Mon, 06 Nov 2023 06:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTL-0006qm-4S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:48 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxTG-0005EC-Np
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:08:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40850b244beso33467785e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268920; x=1699873720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Osm9Rqk6Yz1bOcmZt0pCvMMd/TH5Mg1H8su36lKkY04=;
 b=iGOp2Xdk1tthX06puboF0TV6fXxR9rnvi8beeiJLPhtr7rOhs5S1rlQgj5fk5LWrvu
 evULh7nUr5c9XrdQTYOl1VO4LDoAXfSXDPvZEKt9pZSL16f3hrNKHE4zmtjyPcNgJXGF
 bT3TZuTImvCfRrL0vyQUjS93vzZWmzvsphxNky3eY73le2M0k93eFKSvDX60wEbLikQ3
 XM/etALwfjwp3i/Vocg7Xa2Tgp3KPWM7IlhRsvUI/f0NtKXD6IPx6+YzJz5JFVYV6TdX
 qa4bZyuq1nZJKjmZUf5wst00vL6lSDIBTlJE1GXHAGuRF9BC0eBDqSoVLswDP2Id0mtU
 tMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268920; x=1699873720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Osm9Rqk6Yz1bOcmZt0pCvMMd/TH5Mg1H8su36lKkY04=;
 b=piyEvR+SsEwKuQZShioPSRno7JOrgN/QyjprUivoh0A4wySY7qwaG9CcKIvqsZvxcD
 HRuCc578NMJ9kY3fkq2FtjpEpnmB6M8t3t3Xt+8skmxYoUKUe/myeJaPiFt1o863g89C
 Y1q+vWKBL9aEtWcKmNH8oAQhbGrQSELsq87lSC5DlAC4u2V/zlfUyINFm053i6cBF9lB
 9czBAG32+KTu+x2nRhu4I7MnGi2RYt9JCuGB7Tqt7M4umhPELm/MnFVZo748lAEy/1NI
 R7hl/u9csY17UTV83W6bTuN9DihqD8uumzcJPxXwcVuJklExgQI3I3diLriieSLYnnTV
 FHHg==
X-Gm-Message-State: AOJu0YxWyWVxafDU/cFZKTPrMa3NQHY5Q8Z0YPH4eKqvmphKjvYGwtj3
 J7oT/2FSmpAYGVDCbftD1cnkDhbiNzsKdBF2Z/A=
X-Google-Smtp-Source: AGHT+IHIITTvF4Y+jrJz9D5TuAQ3Knz2Wjt7KmB7cmFWsBNyX7xRA/cGFJD9S7rrHgbBoEXWQAJLpw==
X-Received: by 2002:a05:600c:4693:b0:409:5a92:471d with SMTP id
 p19-20020a05600c469300b004095a92471dmr12443033wmo.22.1699268920324; 
 Mon, 06 Nov 2023 03:08:40 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a05600c138700b0040836519dd9sm11912962wmf.25.2023.11.06.03.08.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:08:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 44/60] tests/unit: Rename test-x86-cpuid.c to test-x86-topo.c
Date: Mon,  6 Nov 2023 12:03:16 +0100
Message-ID: <20231106110336.358-45-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The tests in this file actually test the APIC ID combinations.
Rename to test-x86-topo.c to make its name more in line with its
actual content.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20231024090323.1859210-3-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                      | 2 +-
 tests/unit/{test-x86-cpuid.c => test-x86-topo.c} | 2 +-
 tests/unit/meson.build                           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename tests/unit/{test-x86-cpuid.c => test-x86-topo.c} (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8e8a7d5be5..126cddd285 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1772,7 +1772,7 @@ F: include/hw/southbridge/ich9.h
 F: include/hw/southbridge/piix.h
 F: hw/isa/apm.c
 F: include/hw/isa/apm.h
-F: tests/unit/test-x86-cpuid.c
+F: tests/unit/test-x86-topo.c
 F: tests/qtest/test-x86-cpuid-compat.c
 
 PC Chipset
diff --git a/tests/unit/test-x86-cpuid.c b/tests/unit/test-x86-topo.c
similarity index 99%
rename from tests/unit/test-x86-cpuid.c
rename to tests/unit/test-x86-topo.c
index bfabc0403a..2b104f86d7 100644
--- a/tests/unit/test-x86-cpuid.c
+++ b/tests/unit/test-x86-topo.c
@@ -1,5 +1,5 @@
 /*
- *  Test code for x86 CPUID and Topology functions
+ *  Test code for x86 APIC ID and Topology functions
  *
  *  Copyright (c) 2012 Red Hat Inc.
  *
diff --git a/tests/unit/meson.build b/tests/unit/meson.build
index f33ae64b8d..0dbe32ba9b 100644
--- a/tests/unit/meson.build
+++ b/tests/unit/meson.build
@@ -21,8 +21,8 @@ tests = {
   'test-opts-visitor': [testqapi],
   'test-visitor-serialization': [testqapi],
   'test-bitmap': [],
-  # all code tested by test-x86-cpuid is inside topology.h
-  'test-x86-cpuid': [],
+  # all code tested by test-x86-topo is inside topology.h
+  'test-x86-topo': [],
   'test-cutils': [],
   'test-div128': [],
   'test-shift128': [],
-- 
2.41.0


