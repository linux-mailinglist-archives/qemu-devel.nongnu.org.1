Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C88F931D0B
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jul 2024 00:14:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTTwg-00057f-29; Mon, 15 Jul 2024 18:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sTTwV-00051v-O3
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:13:12 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1sTTwS-0006Iv-MX
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 18:13:11 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7037c464792so2525756a34.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 15:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1721081582; x=1721686382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+MGC2Kn8K5/OSwfmUdmDEoAYSPqg+YzbcoDs108eAWs=;
 b=BcxaWn73RNZ2NWRa4T60RBB44v0n5uh5irI4Y6bIk6Z4BrBDiuAw8nv+9mcSvweTXB
 clVGlniv5G+01qkfVr85T+tOhlTP5qSO5cl0oXk3fELu/3P9ez/7SaRUbUtVxEOS7NTi
 ESdfSecE1kvmOwTlQBij+GSLU8vHyd2j4NKPCHQyGgevULcCkd1Eo4daldBSh5KZwx+p
 bGyHySGhlLLJIayvZjO4AT+m1qCo1Z921jvetMHb5DbaplaV4wugJGETb68Ko8C7esFO
 zXJHUr+w5ljCQQERS2vg19ed8b5bfcoKgBEKJj9ShMeUiIdZBRqSMYAepPR8FtDz9/8L
 L40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721081582; x=1721686382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+MGC2Kn8K5/OSwfmUdmDEoAYSPqg+YzbcoDs108eAWs=;
 b=SolQn4l6ANA63z7UdYSU67aJsRNgOdXOy7aRtBHNWYIMZ5yxRXxFdS/eEwPGiQYzuR
 tIbQbHy5P4isJ3WPjXyBImxuuSt95KZmORwql3lRCyRSJLiNQwtkrhYLltG/W3KXOC8i
 Kmd9/CGPBlZAXRhC8LI684OwLqCLXD3d54AVbP82C7HhQwVaww/hjx8q3Qui7v5H4vam
 xqm7jorIKFQZTNfqU+4xnBzmPpsEPZg7iNvEi5wtefpFmTHIKCStqVTCEvlv2MOCjRtF
 AcZHYiJ2ulv8kK3A2BDISHckZQTXER6gSe4knh/8Y9j3XTe5ondTRT2Jd5M0d3dAnzKa
 hDsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8cS5gF+THMIQCZF0KT/S+PcHO/+8v3c2vUR4DnrqiMRn+4EB+q9x5gr3Ie/TBZEQh1WDcwwKwbkY0cEWduVVwiE9kK0I=
X-Gm-Message-State: AOJu0YxBRyHREW+jN/YeqQAqTBMpQlfpjYhTMCtLJGW5WjtngUejYypo
 9dMAyS6uNJUl/uVF5G29INVfsV2seS+OZLnDcQVaCqqR/hiynqXNkxh+Oypd0bc=
X-Google-Smtp-Source: AGHT+IGBDp/SkftPlG8ZLmvJDUsGTyFmuXj1B4ma65WFB+fpkZ8GL0d/n0Ia/wmu1oItGg5ABZl39g==
X-Received: by 2002:a05:6830:6d19:b0:703:6496:b9ab with SMTP id
 46e09a7af769-708d990b3femr619532a34.7.1721081581874; 
 Mon, 15 Jul 2024 15:13:01 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net
 (ec2-52-8-182-0.us-west-1.compute.amazonaws.com. [52.8.182.0])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b76198aca3sm25398326d6.51.2024.07.15.15.13.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 15 Jul 2024 15:13:01 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v6 1/5] docs/migration: add qatzip compression feature
Date: Mon, 15 Jul 2024 15:12:41 -0700
Message-Id: <20240715221245.12435-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715221245.12435-1-yichen.wang@bytedance.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=yichen.wang@bytedance.com; helo=mail-ot1-x32e.google.com
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

From: Yuan Liu <yuan1.liu@intel.com>

add Intel QATzip compression method introduction

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Yichen Wang <yichen.wang@bytedance.com>
---
 docs/devel/migration/features.rst           |   1 +
 docs/devel/migration/qatzip-compression.rst | 251 ++++++++++++++++++++
 2 files changed, 252 insertions(+)
 create mode 100644 docs/devel/migration/qatzip-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 58f8fd9e16..8f431d52f9 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -14,3 +14,4 @@ Migration has plenty of features to support different use cases.
    CPR
    qpl-compression
    uadk-compression
+   qatzip-compression
diff --git a/docs/devel/migration/qatzip-compression.rst b/docs/devel/migration/qatzip-compression.rst
new file mode 100644
index 0000000000..72fa3e2826
--- /dev/null
+++ b/docs/devel/migration/qatzip-compression.rst
@@ -0,0 +1,251 @@
+==================
+QATzip Compression
+==================
+In scenarios with limited network bandwidth, the ``QATzip`` solution can help
+users save a lot of host CPU resources by accelerating compression and
+decompression through the Intel QuickAssist Technology(``QAT``) hardware.
+
+``QATzip`` is a user space library which builds on top of the Intel QuickAssist
+Technology user space library, to provide extended accelerated compression and
+decompression services.
+
+For more ``QATzip`` introduction, please refer to `QATzip Introduction
+<https://github.com/intel/QATzip?tab=readme-ov-file#introductionl>`_
+
+QATzip Compression Framework
+============================
+
+::
+
+  +----------------+
+  | MultiFd Thread |
+  +-------+--------+
+          |
+          | compress/decompress
+  +-------+--------+
+  | QATzip library |
+  +-------+--------+
+          |
+  +-------+--------+
+  |  QAT library   |
+  +-------+--------+
+          |         user space
+  --------+---------------------
+          |         kernel space
+   +------+-------+
+   |  QAT  Driver |
+   +------+-------+
+          |
+   +------+-------+
+   | QAT Devices  |
+   +--------------+
+
+
+QATzip Installation
+-------------------
+
+The ``QATzip`` installation package has been integrated into some Linux
+distributions and can be installed directly. For example, the Ubuntu Server
+24.04 LTS system can be installed using below command
+
+.. code-block:: shell
+
+   #apt search qatzip
+   libqatzip-dev/noble 1.2.0-0ubuntu3 amd64
+     Intel QuickAssist user space library development files
+
+   libqatzip3/noble 1.2.0-0ubuntu3 amd64
+     Intel QuickAssist user space library
+
+   qatzip/noble,now 1.2.0-0ubuntu3 amd64 [installed]
+     Compression user-space tool for Intel QuickAssist Technology
+
+   #sudo apt install libqatzip-dev libqatzip3 qatzip
+
+If your system does not support the ``QATzip`` installation package, you can
+use the source code to build and install, please refer to `QATzip source code installation
+<https://github.com/intel/QATzip?tab=readme-ov-file#build-intel-quickassist-technology-driver>`_
+
+QAT Hardware Deployment
+-----------------------
+
+``QAT`` supports physical functions(PFs) and virtual functions(VFs) for
+deployment, and users can configure ``QAT`` resources for migration according
+to actual needs. For more details about ``QAT`` deployment, please refer to
+`Intel QuickAssist Technology Documentation
+<https://intel.github.io/quickassist/index.html>`_
+
+For more ``QAT`` hardware introduction, please refer to `intel-quick-assist-technology-overview
+<https://www.intel.com/content/www/us/en/architecture-and-technology/intel-quick-assist-technology-overview.html>`_
+
+How To Use QATzip Compression
+=============================
+
+1 - Install ``QATzip`` library
+
+2 - Build ``QEMU`` with ``--enable-qatzip`` parameter
+
+  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qatzip``
+
+3 - Set ``migrate_set_parameter multifd-compression qatzip``
+
+4 - Set ``migrate_set_parameter multifd-qatzip-level comp_level``, the default
+comp_level value is 1, and it supports levels from 1 to 9
+
+
+Performance Testing with QATzip
+===============================
+
+Testing environment is being set as below:
+
+VM configuration:16 vCPU, 64G memory;
+
+VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data;
+
+QAT Devices: 4;
+
+Sender migration parameters:
+
+.. code-block:: shell
+
+    migrate_set_capability multifd on
+    migrate_set_parameter multifd-channels 2/4/8
+    migrate_set_parameter max-bandwidth 1G/10G
+    migrate_set_parameter multifd-compression qatzip/zstd
+
+Receiver migration parameters:
+
+.. code-block:: shell
+
+    migrate_set_capability multifd on
+    migrate_set_parameter multifd-channels 2
+    migrate_set_parameter multifd-compression qatzip/zstd
+
+max-bandwidth: 1 GBps (Gbytes/sec)
+
+.. code-block:: text
+
+    |-----------|--------|---------|----------|------|------|
+    |2 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   21607|       77|      8051|    88|   125|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   78351|       96|      2199|   204|    80|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |4 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   20336|       25|      8557|   110|   190|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   39324|       31|      4389|   406|   160|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |8 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   20208|       22|      8613|   125|   300|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   20515|       22|      8438|   800|   340|
+    |-----------|--------|---------|----------|------|------|
+
+max-bandwidth: 10 GBps (Gbytes/sec)
+
+.. code-block:: text
+
+    |-----------|--------|---------|----------|------|------|
+    |2 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   22450|       77|      7748|    80|   125|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   78339|       76|      2199|   204|    80|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |4 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   13017|       24|     13401|   180|   285|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   39466|       21|      4373|   406|   160|
+    |-----------|--------|---------|----------|------|------|
+
+    |-----------|--------|---------|----------|------|------|
+    |8 Channels |Total   |down     |throughput| send | recv |
+    |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
+    |-----------|--------|---------|----------|------|------|
+    |qatzip     |   10255|       22|     17037|   280|   590|
+    |-----------|--------|---------|----------|------|------|
+    |zstd       |   20126|       77|      8595|   810|   340|
+    |-----------|--------|---------|----------|------|------|
+
+max-bandwidth: 1.25 GBps (Gbytes/sec)
+
+.. code-block:: text
+
+    |-----------|--------|---------|----------|----------|------|------|
+    |8 Channels |Total   |down     |throughput|pages per | send | recv |
+    |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
+    |-----------|--------|---------|----------|----------|------|------|
+    |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
+    |-----------|--------|---------|----------|----------|------|------|
+    |zstd       |   20165|       24|      8579|   2391465|   810|   340|
+    |-----------|--------|---------|----------|----------|------|------|
+    |none       |   46063|       40|     10848|    330240|    45|    85|
+    |-----------|--------|---------|----------|----------|------|------|
+
+If the user has enabled compression in live migration, using QAT can save the
+host CPU resources.
+
+When compression is enabled, the bottleneck of migration is usually the
+compression throughput on the sender side, since CPU decompression throughput
+is higher than compression, some reference data
+https://github.com/inikep/lzbench, so more CPU resources need to be allocated
+to the sender side.
+
+Summary:
+
+1. In the 1GBps case, QAT only uses 88% CPU utilization to reach 1GBps, but
+   ZSTD needs 800%.
+
+2. In the 10Gbps case, QAT uses 180% CPU utilization to reach 10GBps. but ZSTD
+   still cannot reach 10Gbps even if it uses 810%.
+
+3. The QAT decompression CPU utilization is higher than compression and ZSTD,
+   because:
+
+   a. When using QAT compression, the data needs to be copied to the QAT memory
+   (for DMA operations), and the same for decompression. However,
+   do_user_addr_fault will be triggered during decompression because the QAT
+   decompressed data is copied to the VM address space for the first time, in
+   addition, both compression and decompression are processed by QAT and do not
+   consume CPU resources, so the CPU utilization of the receiver is slightly
+   higher than the sender.
+
+   b. Since zstd decompression decompresses data directly into the VM address
+   space, there is one less memory copy than QAT, so the CPU utilization on the
+   receiver is better than QAT. For the 1GBps case, the receiver CPU
+   utilization is 125%, and the memory copy occupies ~80% of CPU utilization.
+
+How To Choose Between QATzip and QPL
+====================================
+Starting from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire
+Rapids processor(``SPR``), it supports multiple build-in accelerators including
+``QAT`` and ``IAA``, the former can accelerate ``QATzip``, and the latter is
+used to accelerate ``QPL``.
+
+Here are some suggestions:
+
+1 - If your live migration scenario is limited network bandwidth and ``QAT``
+hardware resources exceed ``IAA``, then use the ``QATzip`` method, which
+can save a lot of host CPU resources for compression.
+
+2 - If your system cannot support shared virtual memory(SVM) technology, please
+use ``QATzip`` method because ``QPL`` performance is not good without SVM
+support.
+
+3 - For other scenarios, please use the ``QPL`` method first.
-- 
Yichen Wang


