Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E33823B0E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 04:17:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLEDG-0005Vw-Tb; Wed, 03 Jan 2024 22:16:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLEDB-0005V3-B4
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:16:02 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rLED5-00038q-W7
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 22:15:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704338156; x=1735874156;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=sI83GF3EdwvabcR3ysQC+Och72IOJDbtGUkII8TEtCk=;
 b=a0zQa77vZ4TGwqvXAlFCu0wVEGD4MrMLukLSUuUSf+j9+7kXAZ56g0Z9
 TGCeJJb4fEJj5qu5CoFjUz2BS8Fp26dK3AQt6j8FSFUYWiDu89APy/vFE
 yho0y/VixiwFi3avUcRGxaMhPsv29O1Mxy5XlqfF/BFq3ufDI37ssrUs0
 E26JpbmYLbdvCTOiGoaI8OulDUdWdQ/US0Dya8qiuoIH1dxKkdQQliNNP
 l1cQ1qmR4iOg+N6VC1DMwT+0sM8GdU+bFvIlp5cVuC9skvR/CBXUZiGjq
 VEG5yA4QYgGXMsbM8S0p7VNmRrvpNQycbulS0y2hB1+qxYYEmG9lSef4d Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="376610402"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="376610402"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2024 19:15:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; d="scan'208";a="28613640"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by orviesa001.jf.intel.com with ESMTP; 03 Jan 2024 19:15:42 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v3 0/4] Live Migration Acceleration with IAA Compression
Date: Wed,  3 Jan 2024 19:28:47 +0800
Message-Id: <20240103112851.908082-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-2.601, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

I am writing to submit a code change aimed at enhancing live migration
acceleration by leveraging the compression capability of the Intel
In-Memory Analytics Accelerator (IAA).

The implementation of the IAA (de)compression code is based on Intel Query
Processing Library (QPL), an open-source software project designed for
IAA high-level software programming. https://github.com/intel/qpl

In the last version, there was some discussion about whether to
introduce a new compression algorithm for IAA. Because the compression
algorithm of IAA hardware is based on deflate, and QPL already supports
Zlib, so in this version, I implemented IAA as an accelerator for the
Zlib compression method. However, due to some reasons, QPL is currently
not compatible with the existing Zlib method that Zlib compressed data
can be decompressed by QPl and vice versa.

I have some concerns about the existing Zlib compression
  1. Will you consider supporting one channel to support multi-stream
     compression? Of course, this may lead to a reduction in compression
     ratio, but it will allow the hardware to process each stream 
     concurrently. We can have each stream process multiple pages,
     reducing the loss of compression ratio. For example, 128 pages are
     divided into 16 streams for independent compression. I will provide
     the a early performance data in the next version(v4).

  2. Will you consider using QPL/IAA as an independent compression
     algorithm instead of an accelerator? In this way, we can better
     utilize hardware performance and some features, such as IAA's
     canned mode, which can be dynamically generated by some statistics
     of data. A huffman table to improve the compression ratio.

Test condition:
  1. Host CPUs are based on Sapphire Rapids, and frequency locked to 3.4G
  2. VM type, 16 vCPU and 64G memory
  3. The Idle workload means no workload is running in the VM 
  4. The Redis workload means YCSB workloadb + Redis Server are running
     in the VM, about 20G or more memory will be used.
  5. Source side migartion configuration commands
     a. migrate_set_capability multifd on
     b. migrate_set_parameter multifd-channels 2/4/8
     c. migrate_set_parameter downtime-limit 300
     d. migrate_set_parameter multifd-compression zlib
     e. migrate_set_parameter multifd-compression-accel none/qpl
     f. migrate_set_parameter max-bandwidth 100G
  6. Desitination side migration configuration commands
     a. migrate_set_capability multifd on
     b. migrate_set_parameter multifd-channels 2/4/8
     c. migrate_set_parameter multifd-compression zlib
     d. migrate_set_parameter multifd-compression-accel none/qpl
     e. migrate_set_parameter max-bandwidth 100G

Early migration result, each result is the average of three tests
 +--------+-------------+--------+--------+---------+----+-----+
 |        | The number  |total   |downtime|network  |pages per |
 |        | of channels |time(ms)|(ms)    |bandwidth|second    |
 |        | and mode    |        |        |(mbps)   |          |
 |        +-------------+-----------------+---------+----------+
 |        | 2 chl, Zlib | 20647  | 22     | 195     | 137767   |
 |        +-------------+--------+--------+---------+----------+
 | Idle   | 2 chl, IAA  | 17022  | 36     | 286     | 460289   |
 |workload+-------------+--------+--------+---------+----------+
 |        | 4 chl, Zlib | 18835  | 29     | 241     | 299028   |
 |        +-------------+--------+--------+---------+----------+
 |        | 4 chl, IAA  | 16280  | 32     | 298     | 652456   |
 |        +-------------+--------+--------+---------+----------+
 |        | 8 chl, Zlib | 17379  | 32     | 275     | 470591   |
 |        +-------------+--------+--------+---------+----------+
 |        | 8 chl, IAA  | 15551  | 46     | 313     | 1315784  |
 +--------+-------------+--------+--------+---------+----------+

 +--------+-------------+--------+--------+---------+----+-----+
 |        | The number  |total   |downtime|network  |pages per |
 |        | of channels |time(ms)|(ms)    |bandwidth|second    |
 |        | and mode    |        |        |(mbps)   |          |
 |        +-------------+-----------------+---------+----------+
 |        | 2 chl, Zlib | 100% failure, timeout is 120s        |
 |        +-------------+--------+--------+---------+----------+
 | Redis  | 2 chl, IAA  | 62737  | 115    | 4547    | 387911   |
 |workload+-------------+--------+--------+---------+----------+
 |        | 4 chl, Zlib | 30% failure, timeout is 120s         |
 |        +-------------+--------+--------+---------+----------+
 |        | 4 chl, IAA  | 54645  | 177    | 5382    | 656865   |
 |        +-------------+--------+--------+---------+----------+
 |        | 8 chl, Zlib | 93488  | 74     | 1264    | 129486   |
 |        +-------------+--------+--------+---------+----------+
 |        | 8 chl, IAA  | 24367  | 303    | 6901    | 964380   |
 +--------+-------------+--------+--------+---------+----------+

v2:       
  - add support for multifd compression accelerator
  - add support for the QPL accelerator in the multifd
    compression accelerator
  - fixed the issue that QPL was compiled into the migration
    module by default

v3:
  - use Meson instead of pkg-config to resolve QPL build
    dependency issue
  - fix coding style
  - fix a CI issue for get_multifd_ops function in multifd.c file

Yuan Liu (4):
  migration: Introduce multifd-compression-accel parameter
  multifd: Implement multifd compression accelerator
  configure: add qpl option
  multifd: Introduce QPL compression accelerator

 hw/core/qdev-properties-system.c    |  11 +
 include/hw/qdev-properties-system.h |   4 +
 meson.build                         |  18 ++
 meson_options.txt                   |   2 +
 migration/meson.build               |   1 +
 migration/migration-hmp-cmds.c      |  10 +
 migration/multifd-qpl.c             | 323 ++++++++++++++++++++++++++++
 migration/multifd.c                 |  40 +++-
 migration/multifd.h                 |   8 +
 migration/options.c                 |  28 +++
 migration/options.h                 |   1 +
 qapi/migration.json                 |  31 ++-
 scripts/meson-buildoptions.sh       |   3 +
 13 files changed, 477 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qpl.c

-- 
2.39.3


