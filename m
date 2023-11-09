Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4287E79C5
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 08:34:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1M12-0005Qj-JB; Fri, 10 Nov 2023 02:33:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M10-0005NB-37
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:18 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1r1M0v-0007CT-Ss
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 02:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699601594; x=1731137594;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=PpG4IDDHZqxdROsvtlPIkaJfK9w2uoO/QTtfxBKqcRE=;
 b=oAVXmUPSH9WyWL3ah7RyLVzUKxPrTDk6UdPFm3onpfd0nM2+EUGvk2zE
 i1orip3KyvyRIK7MS+wPqq62jv12bvdZli+Z8iH3lK6zB9GhSNXTHUX5N
 G6JSnn7qC/sG+GN4vuwDDHQOscJsKE+Che1vMSskdPnbiex8eJpmqOSTb
 ZbVyhdh1gTN+w5kthThg1vCHhxeVTFDMRptTimFdM5NYwUa+pfEPgWjC0
 nhwdUy2CU05b+qtyeoytNNjW6LIbzrJMgX/Euh4lK4hnq8V4OCPsu9oxS
 vK8xd9Wlk05HNV1fFB9+D3PfJHoAlRsg/0jr4adm9iHbo8zmBxkQ0JDMV g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="11694824"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="11694824"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2023 23:33:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1010886532"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; d="scan'208";a="1010886532"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 09 Nov 2023 23:33:05 -0800
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH v2 0/4] Live Migration Acceleration with IAA Compression
Date: Thu,  9 Nov 2023 23:46:34 +0800
Message-Id: <20231109154638.488213-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

In the previous version, there was some discussion about whether to
introduce a new compression algorithm for IAA. Because the compression
algorithm of IAA hardware is based on deflate, and QPL already supports
Zlib, so in this version, I implemented IAA as an accelerator for the
Zlib compression method. However, due to some reasons, QPL is currently
not compatible with the existing Zlib method that Zlib compressed data
can be decompressed by QPl and vice versa, I am still working on
resolving compatibility issues.

I have some concerns about the existing Zlib compression
  1. Will you consider supporting one channel to support multi-stream
     compression? Of course, this may lead to a reduction in compression
     ratio, but it will allow the hardware to process each stream
     concurrently. We can have each stream process multiple pages,
     reducing the loss of compression ratio. For example, 128 pages are
     divided into 16 streams for independent compression.

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

Yuan Liu (4):
  migration: Introduce multifd-compression-accel parameter
  multifd: Implement multifd compression accelerator
  configure: add qpl option
  multifd: Introduce QPL compression accelerator

 hw/core/qdev-properties-system.c    |  11 +
 include/hw/qdev-properties-system.h |   4 +
 meson.build                         |   7 +
 meson_options.txt                   |   2 +
 migration/meson.build               |   1 +
 migration/migration-hmp-cmds.c      |  10 +
 migration/multifd-qpl.c             | 326 ++++++++++++++++++++++++++++
 migration/multifd.c                 |  38 +++-
 migration/multifd.h                 |   8 +
 migration/options.c                 |  24 ++
 migration/options.h                 |   1 +
 qapi/migration.json                 |  26 ++-
 scripts/meson-buildoptions.sh       |   3 +
 13 files changed, 458 insertions(+), 3 deletions(-)
 create mode 100644 migration/multifd-qpl.c

--
2.39.3


