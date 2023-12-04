Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3218A802CFB
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:18:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA49M-0003w2-Jx; Mon, 04 Dec 2023 03:17:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rA49D-0003vU-U0; Mon, 04 Dec 2023 03:17:50 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rA49A-0008Lb-K5; Mon, 04 Dec 2023 03:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1701677865; x=1733213865;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=fgqReLiT5MRdh1pP14uxXP6tSQIlVVEKPXkQ99Q4N+k=;
 b=Kj3Rbh7svsf8EkFlaAn1oETtxAJH3HwEcR9CakfLZs9/uRvG9jPyIaMs
 Up4PVaafy64/Fd1lp8raqtpQOEo6TqljT0VglRrDBbjBV0YURwlSsWAlV
 na/heMCS9VzoOKkjbBXjUq1le6lnsvhoILE6LWTKQfQzOxgXJtXupmo7J
 jlweCNTzsHVDeLbPlsK5a/keEGPaC8z9Py3+GYOmoZugb6GHz/dm2LCM3
 ARxwVseiBwVrr8HpdImHd8vt5XVITzV9qfFB3SVp1ljh9qqkDw3/R7hWy
 aUGKGA7Z1TT61fsRqPMQEr9b8plalay3oTV7NzzyHdaN2QLZ6x1aMFdE4 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="581543"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="581543"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2023 00:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="804829684"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; d="scan'208";a="804829684"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 04 Dec 2023 00:17:07 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 0/3] scripts/checkpatch: Add code spelling check
Date: Mon,  4 Dec 2023 16:29:14 +0800
Message-Id: <20231204082917.2430223-1-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=198.175.65.11;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Inspired by Linux's spelling check, QEMU could also add the similar
support in checkpatch.pl to help ease the burden on trivial's
maintainers ;-).

QEMU's checkpatch.pl is mainly based on an older version of Linux's
checkpatch.pl, so this RFC ports Linux's codespell-related functionality
to QEMU.

This RFC contains mainly the following work:
* Added default typo dictionary "selling.text". When using checkpatch.pl,
  it will be based on selling.txt for typo checking.
* Added "--codespell" and "--codespellfile" options for enhanced spell
  checking. The former will use either the system dictionary or a python
  dictionary for spell checking, while the latter allows the user to use
  a customized dictionary.
* Based on the QEMU typo statistics from v7.0.0 to v8.2.0-rc2, updated
  the default dictionary "selling.txt" to be more in line with QEMU
  developers' "typo habits".

Thanks and Best Regards,
Zhao
---
Zhao Liu (3):
  scripts/checkpatch: Check common spelling be default
  scripts/checkpatch: Add --codespell and --codespellfile options
  scripts/spelling: Add common spelling mistakes in default spelling.txt

 scripts/checkpatch.pl |  110 ++-
 scripts/spelling.txt  | 1729 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1838 insertions(+), 1 deletion(-)
 create mode 100644 scripts/spelling.txt

-- 
2.34.1


