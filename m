Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B877FBBCC
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 14:39:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7yIJ-00024L-Lb; Tue, 28 Nov 2023 08:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yIF-000243-Cj
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:27 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r7yID-00088X-Re
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 08:38:27 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a08e4352992so554380066b.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701178704; x=1701783504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LowDtlS1mSCv15/zQIclQz5ifQEKy3t4KP1QtlXYuNc=;
 b=Ic8Jx5gBdLpLFwk8K5/m32WrfvWWpx2tq5HB4776TdzvkELJzgc2vcz2lqg0kDzYuP
 06DoBMKe/R+yONxhXn4TF/HhfsNlxsV4Kk5i9o5Vo3yQl6X8BGf3A7zuUTTuwz+cTtTk
 SrM/67kVXj55uFjnYZSXF5JkNDyoLj1QQIaWsfE5ojrarcgGfwfSq91AEUPFmW38fU8N
 Nf7rkC0vt5V+ldOPSA0nxBfunTOvf6lnKpEvhcJMdxf+oh7bmM0pwrRbCLiXhpe+mekC
 pTNtXPaSd5x8Ljxhwek9tLKobChyWQYgywgXntM3QurWm3U43BsfH/PN6prtI+aeNpnP
 FUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701178704; x=1701783504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LowDtlS1mSCv15/zQIclQz5ifQEKy3t4KP1QtlXYuNc=;
 b=W/8GittJEifOySR8KYW9htYAJVpo2uvmvfxeSw388HkT4YxM94LT79JzMCdz/lQJv9
 jWUDrABbvOoPie/ZnMIP96+wq3WIrnwACfRKlP0YTkujNmsN1sB4l9cU4Vr83wZScsbj
 Vv6NmuDnVwD+DfWdXNdbDYSS9AjJnooMSEYf2ck5WhVEy101q/hpPi0QV4VK2vwclbKk
 TPhVZ2C4bwyN1aHY4ckqnS4Qpwbteph35EJSzQTQRaRJTye7Vy1IGSRate4YmoMNuLfl
 prP4V+biSTZMaxQGbdg8z8npWOXUBMCselS7MLq9DOkG61qvtFVjt+qKLklud9mC/jyl
 SnOQ==
X-Gm-Message-State: AOJu0YygccMav8WAxte6+QyzYQpRuE6P79TnQcYKq2JFQ1i7LpYL4d0M
 wmK+IfHOInb8UsnHdJVFMT68oPhK7suJSDFGKZs=
X-Google-Smtp-Source: AGHT+IEgsDJu1zAqCRu+2E4RSrYBIN+Yh7UntyOaZPNBSJ+gvUvpQzWbxybYhDblWriXhuGmIhs5yA==
X-Received: by 2002:a17:906:224c:b0:a0c:fd56:c30 with SMTP id
 12-20020a170906224c00b00a0cfd560c30mr5957986ejr.70.1701178704292; 
 Tue, 28 Nov 2023 05:38:24 -0800 (PST)
Received: from m1x-phil.lan (crb44-h02-176-184-13-61.dsl.sta.abo.bbox.fr.
 [176.184.13.61]) by smtp.gmail.com with ESMTPSA id
 hg12-20020a1709072ccc00b009fe1dd221a3sm6848556ejc.92.2023.11.28.05.38.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Nov 2023 05:38:23 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Zhao Liu <zhao1.liu@intel.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 7/7] docs/s390: Fix wrong command example in
 s390-cpu-topology.rst
Date: Tue, 28 Nov 2023 14:37:40 +0100
Message-ID: <20231128133740.64525-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231128133740.64525-1-philmd@linaro.org>
References: <20231128133740.64525-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

From: Zhao Liu <zhao1.liu@intel.com>

From s390_possible_cpu_arch_ids() in hw/s390x/s390-virtio-ccw.c, the
"core-id" is the index of possible_cpus->cpus[], so it should only be
less than possible_cpus->len, which is equal to ms->smp.max_cpus.

Fix the wrong "core-id" 112, because it isn't less than maxcpus (36) in
-smp, and the valid core ids are 0-35 inclusive.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Message-ID: <20231127134917.568552-1-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/s390-cpu-topology.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/s390-cpu-topology.rst b/docs/devel/s390-cpu-topology.rst
index 9eab28d5e5..48313b92d4 100644
--- a/docs/devel/s390-cpu-topology.rst
+++ b/docs/devel/s390-cpu-topology.rst
@@ -15,7 +15,7 @@ have default values:
     -smp 1,drawers=3,books=3,sockets=2,cores=2,maxcpus=36 \
     -device z14-s390x-cpu,core-id=19,entitlement=high \
     -device z14-s390x-cpu,core-id=11,entitlement=low \
-    -device z14-s390x-cpu,core-id=112,entitlement=high \
+    -device z14-s390x-cpu,core-id=12,entitlement=high \
    ...
 
 Additions to query-cpus-fast
@@ -78,7 +78,7 @@ modifiers for all configured vCPUs.
       "dedicated": true,
       "thread-id": 537005,
       "props": {
-        "core-id": 112,
+        "core-id": 12,
         "socket-id": 0,
         "drawer-id": 3,
         "book-id": 2
@@ -86,7 +86,7 @@ modifiers for all configured vCPUs.
       "cpu-state": "operating",
       "entitlement": "high",
       "qom-path": "/machine/peripheral-anon/device[2]",
-      "cpu-index": 112,
+      "cpu-index": 12,
       "target": "s390x"
     }
   ]
-- 
2.41.0


