Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560929526D5
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Aug 2024 02:22:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seOFK-000551-JI; Wed, 14 Aug 2024 20:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1seOFH-0004x3-PG
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:21:39 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yichen.wang@bytedance.com>)
 id 1seOFB-0004GQ-De
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 20:21:39 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201d6ac1426so3584715ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 17:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1723681290; x=1724286090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HmK5TfyzY33ZDiQRuyZXJNi/WWVL1YCFzt6nYT2pdjg=;
 b=KKZfbfH3BczfZ+zjc4T68q76WqRRffxYxyUlzKtg83XpGVDdq2HZdBTf40Vttf2tP9
 Vk0zcdeHpBcxKPFWJ1rZHHRarH0+yxtgVuo4S5zCkIc3CErgL0MAWFkGWXPxN2HFQnBd
 CIgRAxY7xx0g+HQdzR+VX0mgeDfMULXAOtrOqbk/oiDBI/FxkTz0KvGv/GIpQ67cw/s1
 sM4DpVSbRTWgQ1SlCtDV/gJgTiH4/OuTiXemqkuYD8Oa9gcbbAPoQoXt5wSjQKgRFEeu
 JopINRCxfL/fJYLZ9VI4CbML1Sr+aGvAWYBNjDjojXUw5HHJ4nASqGwK7l2TfqZxqBgE
 4ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723681290; x=1724286090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HmK5TfyzY33ZDiQRuyZXJNi/WWVL1YCFzt6nYT2pdjg=;
 b=L4a2rLn3SsPBHD2bsd+T82hUplRUTrFpy3vXUgYy0Rmk27o1mjstXGSbjbOhqAq0G5
 UNG37KJYraO2cjeGqrkr7xBtFzk8ahQ9ZrplpCG9neMhQjeeoOCeKKnGzZlblpKSjRcd
 GMes1zvbZkEcR8l8fZcSblXq5hlUQLBn8ZQDBR1o/+wziZTtygoIghD9/r9bLU7tBbOg
 J6BSrWhzZjBaSa+LZRWYsxksSP9E2xuxSmdcpdqtOL2IJs7IEsU1ISVwgAA/n7VaX02O
 5oCNvrBb/H7r8bowJelvL559hXtgvknBlPjb4XA4VuI2TQvXR5wlEamCFnLqGYMqw7n1
 wurw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZdTTfGi/Z3gf4EcgGtIUVfFsjQS0hxNThO2fUlfLHwC1EwGa+Q3uSwQrQxX+nC+oVaZao+lqozTHrwsY90lrdN5LLjUg=
X-Gm-Message-State: AOJu0YwgcwZEJFcMD8LZaqUVtmU1osDvhnzo5VhxOSAqNkXnuSw/uObB
 xHPh6nggFCpnvtK+6BYkRrPogh5QBibUN86cG7NfJgmv5uEYGAyyrHC/3gyQ3I0=
X-Google-Smtp-Source: AGHT+IFb2DCwe69SlQCgwvHfSEHhTESIz0otyIVLzPm1ArFTxy6MDYD5ke/O/8awxmTUVcRO8gXlVQ==
X-Received: by 2002:a17:902:c949:b0:1fd:a5a2:5817 with SMTP id
 d9443c01a7336-201d63c73f1mr51410245ad.31.1723681289519; 
 Wed, 14 Aug 2024 17:21:29 -0700 (PDT)
Received: from DY4X0N7X05.bytedance.net ([72.29.204.230])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02faa03sm1961185ad.19.2024.08.14.17.21.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Aug 2024 17:21:29 -0700 (PDT)
From: Yichen Wang <yichen.wang@bytedance.com>
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Hao Xiang" <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Yichen Wang" <yichen.wang@bytedance.com>
Subject: [PATCH v7 1/5] docs/migration: add qatzip compression feature
Date: Wed, 14 Aug 2024 17:21:20 -0700
Message-Id: <20240815002124.65384-2-yichen.wang@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240815002124.65384-1-yichen.wang@bytedance.com>
References: <20240815002124.65384-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=yichen.wang@bytedance.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 docs/devel/migration/qatzip-compression.rst | 165 ++++++++++++++++++++
 2 files changed, 166 insertions(+)
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
index 0000000000..a7f755eb7f
--- /dev/null
+++ b/docs/devel/migration/qatzip-compression.rst
@@ -0,0 +1,165 @@
+==================
+QATzip Compression
+==================
+In scenarios with limited network bandwidth, the ``QATzip`` solution can help
+users save a lot of host CPU resources by accelerating compression and
+decompression through the Intel QuickAssist Technology(``QAT``) hardware.
+
+
+The following test was conducted using 8 multifd channels and 10Gbps network
+bandwidth. The results show that, compared to zstd, ``QATzip`` significantly
+saves CPU resources on the sender and reduces migration time. Compared to the
+uncompressed solution, ``QATzip`` greatly improves the dirty page processing
+capability, indicated by the Pages per Second metric, and also reduces the
+total migration time.
+
+::
+
+   VM Configuration: 16 vCPU and 64G memory
+   VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
+   QAT Devices: 4
+   |-----------|--------|---------|----------|----------|------|------|
+   |8 Channels |Total   |down     |throughput|pages per | send | recv |
+   |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
+   |-----------|--------|---------|----------|----------|------|------|
+   |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
+   |-----------|--------|---------|----------|----------|------|------|
+   |zstd       |   20165|       24|      8579|   2391465|   810|   340|
+   |-----------|--------|---------|----------|----------|------|------|
+   |none       |   46063|       40|     10848|    330240|    45|    85|
+   |-----------|--------|---------|----------|----------|------|------|
+
+
+QATzip Compression Framework
+============================
+
+``QATzip`` is a user space library which builds on top of the Intel QuickAssist
+Technology user space library, to provide extended accelerated compression and
+decompression services.
+
+For more ``QATzip`` introduction, please refer to `QATzip Introduction
+<https://github.com/intel/QATzip?tab=readme-ov-file#introductionl>`_
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
+QAT Memory Requirements
+=======================
+
+The user needs to reserve system memory for the QAT memory management to
+allocate DMA memory. The size of the reserved system memory depends on the
+number of devices used for migration and the number of multifd channels.
+
+Because memory usage depends on QAT configuration, please refer to `QAT Memory
+Driver Queires
+<https://intel.github.io/quickassist/PG/infrastructure_debugability.html?highlight=memory>`_
+for memory usage calculation.
+
+.. list-table:: An example of a PF used for migration
+  :header-rows: 1
+
+  * - Number of channels
+    - Sender memory usage
+    - Receiver memory usage
+  * - 2
+    - 10M
+    - 10M
+  * - 4
+    - 12M
+    - 14M
+  * - 8
+    - 16M
+    - 20M
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


