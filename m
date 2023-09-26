Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A19FB7AF4E3
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:17:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETg-0000ZO-AK; Tue, 26 Sep 2023 16:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETY-0000X9-Gm
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:08 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETT-0002hU-Bx
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 0951760B97;
 Tue, 26 Sep 2023 23:15:59 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-7te6I8Sr; Tue, 26 Sep 2023 23:15:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759358;
 bh=3bfRsX2bcaRNysuZopQT1GUhW00NrecV1SjNahVWt/I=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Uvq89eCVs2AlGuqW58Q5O5sBr+wyhPW8wK2SIlegWEQW5GH5Oqt4iythFeRZ4qrj6
 e3MPIh2GmUHYa5mxqhr77EHPgWNrq09dxznlyziC/heoNkflZETVke7w49h2LfdFgv
 paZr0BAs3BfEKhDYwYapHxJ97DZFaa4lmLk3SFLs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 5/8] pcie_sriov: unregister_vfs(): fix error path
Date: Tue, 26 Sep 2023 23:15:29 +0300
Message-Id: <20230926201532.221152-6-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

local_err must be NULL before calling object_property_set_bool(), so we
must clear it on each iteration. Let's also use more convenient
error_reportf_err().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/pcie_sriov.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 76a3b6917e..5ef8950940 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -196,19 +196,16 @@ static void register_vfs(PCIDevice *dev)
 
 static void unregister_vfs(PCIDevice *dev)
 {
-    Error *local_err = NULL;
     uint16_t num_vfs = dev->exp.sriov_pf.num_vfs;
     uint16_t i;
 
     trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
                                PCI_FUNC(dev->devfn), num_vfs);
     for (i = 0; i < num_vfs; i++) {
+        Error *err = NULL;
         PCIDevice *vf = dev->exp.sriov_pf.vf[i];
-        object_property_set_bool(OBJECT(vf), "realized", false, &local_err);
-        if (local_err) {
-            fprintf(stderr, "Failed to unplug: %s\n",
-                    error_get_pretty(local_err));
-            error_free(local_err);
+        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
+            error_reportf_err(err, "Failed to unplug: ");
         }
         object_unparent(OBJECT(vf));
         object_unref(OBJECT(vf));
-- 
2.34.1


