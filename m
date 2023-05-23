Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3397A70D1B9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:49:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I13-0003ND-Dk; Mon, 22 May 2023 22:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0k-0003Du-8a
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:31 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0i-00048C-Qi
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:30 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-25372604818so3280857a91.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809867; x=1687401867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uzBTwMbkzdelIsGHu0YnzewsnGRa5PYyyMzELebwons=;
 b=fFSkozBxPhIno9alAs73TOpni/E+XAVOiAozgzYArP14BzaKjrJCI9ll1ju+FP6Lsr
 tnPxHo/6FciZnUQaFEVj4gw2KztqFVzVOv4ygu/2s3mmxjN4tBun8ShEcuEGdAcwAVZ0
 9raCj7gEwZlW/1R7AMyoqazQkTyvw/laHvVVY2ZmGZ0FnPCFfHCGQCw7Qx3NqiAthY55
 nBnkRn9jZzVZYp5IE7xAL6bFf8kf6sacBAjuO9GFonzJDjqoxnpMfwyuy4oRdWfgOTb7
 cjIcO/PL+YHflKO2zoTN8AkTNr6E2B5S/sK6lPbz+CIslrjweQ/v4jlCifKOHnRJC6mi
 4cSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809867; x=1687401867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uzBTwMbkzdelIsGHu0YnzewsnGRa5PYyyMzELebwons=;
 b=h6Qhx1ZYDuoly2+twZs3zleIQRK1eTwV1+Knre0KDeilza+uwX3x2y2dEDbY9BjI2e
 zH2dliryCCnhpI/mA6C8/wpn12agh1BKMGxNfRFGchnHjv3loGjPAPliLON1zKBalqwF
 YQfLuIV9P68BFv0d/mtu3fCK3an5evXR2Suz2T4U4bCztiXgv2CBY8wUyDXvcRg+vZV7
 4vCYqUQMrzagAahN50CBIU4xkc8IGvD7itjdekS1zqJm2TFoZ4YBLLuGWfXuBnkbDUZ3
 N9AqBKYgqG8VWJZGNKmBq+ksTJOuedy+Uu+9e5CT5ohdnEgR7vCgHkw7uUpFQSKUxtRp
 gWsA==
X-Gm-Message-State: AC+VfDyqI0YFBOC5/UNOzVfJc2KXGdkZ39sI5x6FhYGeFirjoR99Ig7l
 3P2bpCAobMAe2zGi2EdoCBPbVg==
X-Google-Smtp-Source: ACHHUZ77/VhldOCvzflJPNFy7mLeaITWGhRZcVUm+yIucuCcL+kIpqRmedprRHx7eCrl4z6wqARrIw==
X-Received: by 2002:a17:90a:f48a:b0:255:9f03:c94c with SMTP id
 bx10-20020a17090af48a00b002559f03c94cmr1457826pjb.4.1684809867676; 
 Mon, 22 May 2023 19:44:27 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 10/48] Fix references to igb Avocado test
Date: Tue, 23 May 2023 11:43:01 +0900
Message-Id: <20230523024339.50875-11-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1032;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Fixes: 9f95111474 ("tests/avocado: re-factor igb test to avoid timeouts")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                        | 2 +-
 docs/system/devices/igb.rst                        | 2 +-
 scripts/ci/org.centos/stream/8/x86_64/test-avocado | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef45b5e71e..c31d2279ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2256,7 +2256,7 @@ R: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
 S: Maintained
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
-F: tests/avocado/igb.py
+F: tests/avocado/netdev-ethtool.py
 F: tests/qtest/igb-test.c
 F: tests/qtest/libqos/igb.c
 
diff --git a/docs/system/devices/igb.rst b/docs/system/devices/igb.rst
index 70edadd574..afe036dad2 100644
--- a/docs/system/devices/igb.rst
+++ b/docs/system/devices/igb.rst
@@ -60,7 +60,7 @@ Avocado test and can be ran with the following command:
 
 .. code:: shell
 
-  make check-avocado AVOCADO_TESTS=tests/avocado/igb.py
+  make check-avocado AVOCADO_TESTS=tests/avocado/netdev-ethtool.py
 
 References
 ==========
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
index d2c0e5fb4c..a1aa601ee3 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/test-avocado
+++ b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
@@ -30,7 +30,7 @@ make get-vm-images
     tests/avocado/cpu_queries.py:QueryCPUModelExpansion.test \
     tests/avocado/empty_cpu_model.py:EmptyCPUModel.test \
     tests/avocado/hotplug_cpu.py:HotPlugCPU.test \
-    tests/avocado/igb.py:IGB.test \
+    tests/avocado/netdev-ethtool.py:NetDevEthtool.test_igb_nomsi \
     tests/avocado/info_usernet.py:InfoUsernet.test_hostfwd \
     tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu \
     tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt \
-- 
2.40.1


