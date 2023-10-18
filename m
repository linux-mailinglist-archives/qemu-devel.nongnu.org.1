Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 551207CFB61
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 15:40:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtTF4-0001da-KU; Thu, 19 Oct 2023 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyg-0003AY-GE
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:02:01 -0400
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1qtNyc-0006LE-TL
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 04:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697702514; x=1729238514;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BtsQp0GMQw3Wdc9yYOMOdGLzo4kbbL5vpVyS7e2vxN0=;
 b=aqvSTembmEs6BAprZogcynAsBBwuELI9aTxyST9KG72TW2N2Vtem55rp
 ct7UrzIW+5mu2yYKlX9RrhQYdxj8OGNFJdDIif/v8BqzYFZbBMhtuYZHK
 VRg8+LlAr7qxyCgTKUcMPKIhzx14eUwDmUai/H9liYHUW+WJbGa3SYTB5
 H/CP58Icc1hMGSPMTOezyr/32ZRDiREfQtTAsF8dgiLN6kMV8b1qvsPcg
 1SAbcQ4eWNvvqHeU3pyy/wVnpcOtghBKlB14Y4VIb40HfeqJP/G/IFYrZ
 3Qp/n3BDJlg2U9dSIIjL8k31WR+x0zYAJiqRSLu7wpVflSEJAbh9G46Qb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="383418448"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="383418448"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2023 01:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="1004134833"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; d="scan'208";a="1004134833"
Received: from sae-gw02.sh.intel.com (HELO localhost) ([10.239.45.110])
 by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2023 01:01:47 -0700
From: Yuan Liu <yuan1.liu@intel.com>
To: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Cc: qemu-devel@nongnu.org,
	yuan1.liu@intel.com,
	nanhai.zou@intel.com
Subject: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Date: Thu, 19 Oct 2023 06:12:19 +0800
Message-Id: <20231018221224.599065-1-yuan1.liu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.93; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Oct 2023 09:38:33 -0400
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

Enabling compression functionality during the live migration process can
enhance performance, thereby reducing downtime and network bandwidth
requirements. However, this improvement comes at the cost of additional
CPU resources, posing a challenge for cloud service providers in terms of
resource allocation. To address this challenge, I have focused on offloading
the compression overhead to the IAA hardware, resulting in performance gains.

The implementation of the IAA (de)compression code is based on Intel Query
Processing Library (QPL), an open-source software project designed for
IAA high-level software programming.

Best regards,
Yuan Liu

Yuan Liu (5):
  configure: add qpl meson option
  qapi/migration: Introduce compress-with-iaa migration parameter
  ram compress: Refactor ram compression interfaces
  migration iaa-compress: Add IAA initialization and deinitialization
  migration iaa-compress: Implement IAA compression

 meson.build                    |   9 +-
 meson_options.txt              |   2 +
 migration/iaa-ram-compress.c   | 319 +++++++++++++++++++++++++++++++++
 migration/iaa-ram-compress.h   |  27 +++
 migration/meson.build          |   1 +
 migration/migration-hmp-cmds.c |   8 +
 migration/migration.c          |   6 +-
 migration/options.c            |  20 +++
 migration/options.h            |   1 +
 migration/ram-compress.c       |  96 ++++++++--
 migration/ram-compress.h       |  10 +-
 migration/ram.c                |  68 ++++++-
 qapi/migration.json            |   4 +-
 scripts/meson-buildoptions.sh  |   3 +
 14 files changed, 541 insertions(+), 33 deletions(-)
 create mode 100644 migration/iaa-ram-compress.c
 create mode 100644 migration/iaa-ram-compress.h

-- 
2.39.3


