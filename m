Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8B2821BAC
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 13:33:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKdwh-0003Kr-6W; Tue, 02 Jan 2024 07:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sWZB=IM=redhat.com=clg@ozlabs.org>)
 id 1rKdwe-0003KG-Rb
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:32:32 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=sWZB=IM=redhat.com=clg@ozlabs.org>)
 id 1rKdwb-0006Pf-K5
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 07:32:32 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T4C0h3vY8z4x5h;
 Tue,  2 Jan 2024 23:32:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4C0f5TrWz4x2P;
 Tue,  2 Jan 2024 23:32:18 +1100 (AEDT)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 1/2] backends/iommufd: Remove check on number of backend users
Date: Tue,  2 Jan 2024 13:32:09 +0100
Message-ID: <20240102123210.1184293-2-clg@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240102123210.1184293-1-clg@redhat.com>
References: <20240102123210.1184293-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=sWZB=IM=redhat.com=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

QOM already has a ref count on objects and it will assert much
earlier, when INT_MAX is reached.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 backends/iommufd.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/backends/iommufd.c b/backends/iommufd.c
index ba58a0eb0d0ba9aae625c987eb728547543dba66..393c0d9a3719e3de1a6b51a8ff2e75e184badc82 100644
--- a/backends/iommufd.c
+++ b/backends/iommufd.c
@@ -80,11 +80,6 @@ int iommufd_backend_connect(IOMMUFDBackend *be, Error **errp)
     int fd, ret = 0;
 
     qemu_mutex_lock(&be->lock);
-    if (be->users == UINT32_MAX) {
-        error_setg(errp, "too many connections");
-        ret = -E2BIG;
-        goto out;
-    }
     if (be->owned && !be->users) {
         fd = qemu_open_old("/dev/iommu", O_RDWR);
         if (fd < 0) {
-- 
2.43.0


