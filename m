Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABBA909145
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jun 2024 19:19:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAZB-000124-HH; Fri, 14 Jun 2024 13:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZA-00011m-36
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:20 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sIAZ7-00043Q-Ik
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:18:19 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BA4C20727;
 Fri, 14 Jun 2024 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hUPgvDKyi/wtpUXOmTf8v57I6UfGLNlrkJdxsx0ACY=;
 b=NqWzXQffxN07XsbXp5hOF9g2IFVQ2zdhXXSi3r9lnzDl+0GfN7wKozwrvaJ7ZFX7B7bc4+
 obUY1OwisDAM2l8rxV8CRtmnaQDZUFUBrbCBgQoFFPPW4PwFk+gRFGaOYzBwFDf/KpbUKh
 +KgQ7B4z+vWNfwJ8l39o+EfVWAqEr3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hUPgvDKyi/wtpUXOmTf8v57I6UfGLNlrkJdxsx0ACY=;
 b=dmKK6DFQevoEiVwknMTSdDF+JTrSMOpFX+tzgMv/r1dWtTyJUMD0obUWoOJy7FhVzk2lQz
 LY44ZSa61XamSTAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718385496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hUPgvDKyi/wtpUXOmTf8v57I6UfGLNlrkJdxsx0ACY=;
 b=NqWzXQffxN07XsbXp5hOF9g2IFVQ2zdhXXSi3r9lnzDl+0GfN7wKozwrvaJ7ZFX7B7bc4+
 obUY1OwisDAM2l8rxV8CRtmnaQDZUFUBrbCBgQoFFPPW4PwFk+gRFGaOYzBwFDf/KpbUKh
 +KgQ7B4z+vWNfwJ8l39o+EfVWAqEr3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718385496;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4hUPgvDKyi/wtpUXOmTf8v57I6UfGLNlrkJdxsx0ACY=;
 b=dmKK6DFQevoEiVwknMTSdDF+JTrSMOpFX+tzgMv/r1dWtTyJUMD0obUWoOJy7FhVzk2lQz
 LY44ZSa61XamSTAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9883213AB1;
 Fri, 14 Jun 2024 17:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GBy+F1Z7bGaVAgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Jun 2024 17:18:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yuan Liu <yuan1.liu@intel.com>, Nanhai Zou <nanhai.zou@intel.com>
Subject: [PULL 05/18] docs/migration: add qpl compression feature
Date: Fri, 14 Jun 2024 14:17:49 -0300
Message-Id: <20240614171802.28451-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240614171802.28451-1-farosas@suse.de>
References: <20240614171802.28451-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:url,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yuan Liu <yuan1.liu@intel.com>

add Intel Query Processing Library (QPL) compression method
introduction

Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 docs/devel/migration/features.rst        |   1 +
 docs/devel/migration/qpl-compression.rst | 260 +++++++++++++++++++++++
 2 files changed, 261 insertions(+)
 create mode 100644 docs/devel/migration/qpl-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index d5ca7b86d5..bc98b65075 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -12,3 +12,4 @@ Migration has plenty of features to support different use cases.
    virtio
    mapped-ram
    CPR
+   qpl-compression
diff --git a/docs/devel/migration/qpl-compression.rst b/docs/devel/migration/qpl-compression.rst
new file mode 100644
index 0000000000..990992d786
--- /dev/null
+++ b/docs/devel/migration/qpl-compression.rst
@@ -0,0 +1,260 @@
+===============
+QPL Compression
+===============
+The Intel Query Processing Library (Intel ``QPL``) is an open-source library to
+provide compression and decompression features and it is based on deflate
+compression algorithm (RFC 1951).
+
+The ``QPL`` compression relies on Intel In-Memory Analytics Accelerator(``IAA``)
+and Shared Virtual Memory(``SVM``) technology, they are new features supported
+from Intel 4th Gen Intel Xeon Scalable processors, codenamed Sapphire Rapids
+processor(``SPR``).
+
+For more ``QPL`` introduction, please refer to `QPL Introduction
+<https://intel.github.io/qpl/documentation/introduction_docs/introduction.html>`_
+
+QPL Compression Framework
+=========================
+
+::
+
+  +----------------+       +------------------+
+  | MultiFD Thread |       |accel-config tool |
+  +-------+--------+       +--------+---------+
+          |                         |
+          |                         |
+          |compress/decompress      |
+  +-------+--------+                | Setup IAA
+  |  QPL library   |                | Resources
+  +-------+---+----+                |
+          |   |                     |
+          |   +-------------+-------+
+          |   Open IAA      |
+          |   Devices +-----+-----+
+          |           |idxd driver|
+          |           +-----+-----+
+          |                 |
+          |                 |
+          |           +-----+-----+
+          +-----------+IAA Devices|
+      Submit jobs     +-----------+
+      via enqcmd
+
+
+QPL Build And Installation
+--------------------------
+
+.. code-block:: shell
+
+  $git clone --recursive https://github.com/intel/qpl.git qpl
+  $mkdir qpl/build
+  $cd qpl/build
+  $cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DQPL_LIBRARY_TYPE=SHARED ..
+  $sudo cmake --build . --target install
+
+For more details about ``QPL`` installation, please refer to `QPL Installation
+<https://intel.github.io/qpl/documentation/get_started_docs/installation.html>`_
+
+IAA Device Management
+---------------------
+
+The number of ``IAA`` devices will vary depending on the Xeon product model.
+On a ``SPR`` server, there can be a maximum of 8 ``IAA`` devices, with up to
+4 devices per socket.
+
+By default, all ``IAA`` devices are disabled and need to be configured and
+enabled by users manually.
+
+Check the number of devices through the following command
+
+.. code-block:: shell
+
+  #lspci -d 8086:0cfe
+  6a:02.0 System peripheral: Intel Corporation Device 0cfe
+  6f:02.0 System peripheral: Intel Corporation Device 0cfe
+  74:02.0 System peripheral: Intel Corporation Device 0cfe
+  79:02.0 System peripheral: Intel Corporation Device 0cfe
+  e7:02.0 System peripheral: Intel Corporation Device 0cfe
+  ec:02.0 System peripheral: Intel Corporation Device 0cfe
+  f1:02.0 System peripheral: Intel Corporation Device 0cfe
+  f6:02.0 System peripheral: Intel Corporation Device 0cfe
+
+IAA Device Configuration And Enabling
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``accel-config`` tool is used to enable ``IAA`` devices and configure
+``IAA`` hardware resources(work queues and engines). One ``IAA`` device
+has 8 work queues and 8 processing engines, multiple engines can be assigned
+to a work queue via ``group`` attribute.
+
+For ``accel-config`` installation, please refer to `accel-config installation
+<https://github.com/intel/idxd-config>`_
+
+One example of configuring and enabling an ``IAA`` device.
+
+.. code-block:: shell
+
+  #accel-config config-engine iax1/engine1.0 -g 0
+  #accel-config config-engine iax1/engine1.1 -g 0
+  #accel-config config-engine iax1/engine1.2 -g 0
+  #accel-config config-engine iax1/engine1.3 -g 0
+  #accel-config config-engine iax1/engine1.4 -g 0
+  #accel-config config-engine iax1/engine1.5 -g 0
+  #accel-config config-engine iax1/engine1.6 -g 0
+  #accel-config config-engine iax1/engine1.7 -g 0
+  #accel-config config-wq iax1/wq1.0 -g 0 -s 128 -p 10 -b 1 -t 128 -m shared -y user -n app1 -d user
+  #accel-config enable-device iax1
+  #accel-config enable-wq iax1/wq1.0
+
+.. note::
+   IAX is an early name for IAA
+
+- The ``IAA`` device index is 1, use ``ls -lh /sys/bus/dsa/devices/iax*``
+  command to query the ``IAA`` device index.
+
+- 8 engines and 1 work queue are configured in group 0, so all compression jobs
+  submitted to this work queue can be processed by all engines at the same time.
+
+- Set work queue attributes including the work mode, work queue size and so on.
+
+- Enable the ``IAA1`` device and work queue 1.0
+
+.. note::
+
+  Set work queue mode to shared mode, since ``QPL`` library only supports
+  shared mode
+
+For more detailed configuration, please refer to `IAA Configuration Samples
+<https://github.com/intel/idxd-config/tree/stable/Documentation/accfg>`_
+
+IAA Unit Test
+^^^^^^^^^^^^^
+
+- Enabling ``IAA`` devices for Xeon platform, please refer to `IAA User Guide
+  <https://www.intel.com/content/www/us/en/content-details/780887/intel-in-memory-analytics-accelerator-intel-iaa.html>`_
+
+- ``IAA`` device driver is Intel Data Accelerator Driver (idxd), it is
+  recommended that the minimum version of Linux kernel is 5.18.
+
+- Add ``"intel_iommu=on,sm_on"`` parameter to kernel command line
+  for ``SVM`` feature enabling.
+
+Here is an easy way to verify ``IAA`` device driver and ``SVM`` with `iaa_test
+<https://github.com/intel/idxd-config/tree/stable/test>`_
+
+.. code-block:: shell
+
+  #./test/iaa_test
+   [ info] alloc wq 0 shared size 128 addr 0x7f26cebe5000 batch sz 0xfffffffe xfer sz 0x80000000
+   [ info] test noop: tflags 0x1 num_desc 1
+   [ info] preparing descriptor for noop
+   [ info] Submitted all noop jobs
+   [ info] verifying task result for 0x16f7e20
+   [ info] test with op 0 passed
+
+
+IAA Resources Allocation For Migration
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+There is no ``IAA`` resource configuration parameters for migration and
+``accel-config`` tool configuration cannot directly specify the ``IAA``
+resources used for migration.
+
+The multifd migration with ``QPL`` compression method  will use all work
+queues that are enabled and shared mode.
+
+.. note::
+
+  Accessing IAA resources requires ``sudo`` command or ``root`` privileges
+  by default. Administrators can modify the IAA device node ownership
+  so that QEMU can use IAA with specified user permissions.
+
+  For example
+
+  #chown -R qemu /dev/iax
+
+Shared Virtual Memory(SVM) Introduction
+=======================================
+
+An ability for an accelerator I/O device to operate in the same virtual
+memory space of applications on host processors. It also implies the
+ability to operate from pageable memory, avoiding functional requirements
+to pin memory for DMA operations.
+
+When using ``SVM`` technology, users do not need to reserve memory for the
+``IAA`` device and perform pin memory operation. The ``IAA`` device can
+directly access data using the virtual address of the process.
+
+For more ``SVM`` technology, please refer to
+`Shared Virtual Addressing (SVA) with ENQCMD
+<https://docs.kernel.org/next/x86/sva.html>`_
+
+
+How To Use QPL Compression In Migration
+=======================================
+
+1 - Installation of ``QPL`` library and ``accel-config`` library if using IAA
+
+2 - Configure and enable ``IAA`` devices and work queues via ``accel-config``
+
+3 - Build ``QEMU`` with ``--enable-qpl`` parameter
+
+  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qpl``
+
+4 - Enable ``QPL`` compression during migration
+
+  Set ``migrate_set_parameter multifd-compression qpl`` when migrating, the
+  ``QPL`` compression does not support configuring the compression level, it
+  only supports one compression level.
+
+The Difference Between QPL And ZLIB
+===================================
+
+Although both ``QPL`` and ``ZLIB`` are based on the deflate compression
+algorithm, and ``QPL`` can support the header and tail of ``ZLIB``, ``QPL``
+is still not fully compatible with the ``ZLIB`` compression in the migration.
+
+``QPL`` only supports 4K history buffer, and ``ZLIB`` is 32K by default.
+``ZLIB`` compresses data that ``QPL`` may not decompress correctly and
+vice versa.
+
+``QPL`` does not support the ``Z_SYNC_FLUSH`` operation in ``ZLIB`` streaming
+compression, current ``ZLIB`` implementation uses ``Z_SYNC_FLUSH``, so each
+``multifd`` thread has a ``ZLIB`` streaming context, and all page compression
+and decompression are based on this stream. ``QPL`` cannot decompress such data
+and vice versa.
+
+The introduction for ``Z_SYNC_FLUSH``, please refer to `Zlib Manual
+<https://www.zlib.net/manual.html>`_
+
+The Best Practices
+==================
+When user enables the IAA device for ``QPL`` compression, it is recommended
+to add ``-mem-prealloc`` parameter to the destination boot parameters. This
+parameter can avoid the occurrence of I/O page fault and reduce the overhead
+of IAA compression and decompression.
+
+The example of booting with ``-mem-prealloc`` parameter
+
+.. code-block:: shell
+
+   $qemu-system-x86_64 --enable-kvm -cpu host --mem-prealloc ...
+
+
+An example about I/O page fault measurement of destination without
+``-mem-prealloc``, the ``svm_prq`` indicates the number of I/O page fault
+occurrences and processing time.
+
+.. code-block:: shell
+
+  #echo 1 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #echo 2 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #echo 3 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #echo 4 > /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  #cat /sys/kernel/debug/iommu/intel/dmar_perf_latency
+  IOMMU: dmar18 Register Base Address: c87fc000
+                  <0.1us   0.1us-1us    1us-10us  10us-100us   100us-1ms    1ms-10ms      >=10ms     min(us)     max(us) average(us)
+   inv_iotlb           0         286         123           0           0           0           0           0           1           0
+  inv_devtlb           0         276         133           0           0           0           0           0           2           0
+     inv_iec           0           0           0           0           0           0           0           0           0           0
+     svm_prq           0           0       25206         364         395           0           0           1         556           9
-- 
2.35.3


