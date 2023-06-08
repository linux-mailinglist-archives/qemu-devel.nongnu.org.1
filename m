Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C00F9728482
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 18:03:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7I4M-00017j-JB; Thu, 08 Jun 2023 12:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f6b0de53fb87ddefed348a39284c8e2f28dc4eda@lizzy.crudebyte.com>)
 id 1q7I3U-0000on-7d
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:00:08 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f6b0de53fb87ddefed348a39284c8e2f28dc4eda@lizzy.crudebyte.com>)
 id 1q7I3S-0000qW-Ft
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 12:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=b3VIiTQYJeTOVM9mF20WIkOVRe41JnS9LWO5SoftLRQ=; b=pEUUq
 9Xls1EzpXoOzBKfg2Z74tH2PIvd9/NfvszgSCP1dlrKUiPFI4t6l54jS1ypCZU8JpclwIFP9D7iga
 4lwnd5tdCLY67OfnEcdCxy+tQxPxQs7Dbxx2Vc3UMcEBlABUNPTTws+xHHFXR8JguiqJ/wacMiwl8
 Znc2WmAlQRYfBN6L9o0pxZFVdl4vnLkcQm5a2rKLZGs7QpTz56aTnge7sUkYI/G22wOciPBk1jNJo
 1dhaB06cYLGHROrez6okSCOMkqEaWAy4y2CIrEzZkJ6m0shBZA48SBGjo2D7mJs2WvTq11vRt8hD6
 tT7yQtUzfynK2fnf7phNqmFOVN4SA==;
Message-Id: <cover.1686236977.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 08 Jun 2023 17:09:37 +0200
Subject: [PULL 0/1] 9p security fix 2023-06-08
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: Greg Kurz <groug@kaod.org>, Yanwu Shen <ywsPlz@gmail.com>,
 Jietao Xiao <shawtao1125@gmail.com>, Jinku Li <jkli@xidian.edu.cn>,
 Wenbo Shen <shenwenbo@zju.edu.cn>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=f6b0de53fb87ddefed348a39284c8e2f28dc4eda@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The following changes since commit 45ae97993a75f975f1a01d25564724c7e10a543f:

  Merge tag 'pull-tricore-20230607' of https://github.com/bkoppelmann/qemu into staging (2023-06-07 11:45:22 -0700)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20230608

for you to fetch changes up to f6b0de53fb87ddefed348a39284c8e2f28dc4eda:

  9pfs: prevent opening special files (CVE-2023-2861) (2023-06-08 17:04:58 +0200)

----------------------------------------------------------------
* Fix for CVE-2023-2861.

----------------------------------------------------------------
Christian Schoenebeck (1):
      9pfs: prevent opening special files (CVE-2023-2861)

 fsdev/virtfs-proxy-helper.c | 27 +++++++++++++++++++++++++--
 hw/9pfs/9p-util.h           | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

