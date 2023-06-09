Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D001F72A0E8
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 19:09:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7fan-0005kW-BX; Fri, 09 Jun 2023 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7fak-0005j4-FV
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 13:08:02 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1q7fai-00027Q-RS
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 13:08:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0407065A2D;
 Fri,  9 Jun 2023 17:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB91C433D2;
 Fri,  9 Jun 2023 17:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686330479;
 bh=jKc0b6sy+IFEfw+yFW7LpMqgHJ7m2Y1PxUl/wPKlBuQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gf+HANx6b+D39TwMWZvyhCp5ytThtYupLF9mjzI+rJokzYQeW8chqQDX3TRqjAdSt
 AZjGk6A8Sas6emaiqxOgE6VX5Ix1umuF6bffpJGax7Y/CJY27XgW7XV4L3DQq8i3Np
 NQiQp5+RNVLMVny/rrBdXpyj24L7XEZuXd8mNfnJfB2ADuTMMtpwbMQr7ELp99UxFj
 PVE+3YcLPr3tKHGn+lggCKOuROzzeBbSARC15pKHSBQiXKlq9znO9cYUD0ecQh/VV7
 YZg5fI7wYlq+zZsFvBfelX0dyKL6WwJXzbnNaWjq5oSz8/kUD3toWYvlVPh62Pk/LU
 9seLSyy2HSWYw==
From: Stefano Stabellini <sstabellini@kernel.org>
To: peter.maydell@linaro.org
Cc: sstabellini@kernel.org, qemu-devel@nongnu.org, vikram.garhwal@amd.com,
 richard.henderson@linaro.org,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 Paul Durrant <paul@xen.org>
Subject: [PULL v4 05/10] include/hw/xen/xen_common: return error from
 xen_create_ioreq_server
Date: Fri,  9 Jun 2023 10:07:46 -0700
Message-Id: <20230609170751.4059054-5-sstabellini@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.22.394.2306091007210.3803068@ubuntu-linux-20-04-desktop>
References: <alpine.DEB.2.22.394.2306091007210.3803068@ubuntu-linux-20-04-desktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.178.84.217;
 envelope-from=sstabellini@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Stefano Stabellini <stefano.stabellini@amd.com>

From: Stefano Stabellini <stefano.stabellini@amd.com>

This is done to prepare for enabling xenpv support for ARM architecture.
On ARM it is possible to have a functioning xenpv machine with only the
PV backends and no IOREQ server. If the IOREQ server creation fails,
continue to the PV backends initialization.

Signed-off-by: Stefano Stabellini <stefano.stabellini@amd.com>
Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Paul Durrant <paul@xen.org>
---
 include/hw/xen/xen_native.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/xen/xen_native.h b/include/hw/xen/xen_native.h
index f11eb423e3..4dce905fde 100644
--- a/include/hw/xen/xen_native.h
+++ b/include/hw/xen/xen_native.h
@@ -463,8 +463,8 @@ static inline void xen_unmap_pcidev(domid_t dom,
                                                   PCI_FUNC(pci_dev->devfn));
 }
 
-static inline void xen_create_ioreq_server(domid_t dom,
-                                           ioservid_t *ioservid)
+static inline int xen_create_ioreq_server(domid_t dom,
+                                          ioservid_t *ioservid)
 {
     int rc = xendevicemodel_create_ioreq_server(xen_dmod, dom,
                                                 HVM_IOREQSRV_BUFIOREQ_ATOMIC,
@@ -472,12 +472,14 @@ static inline void xen_create_ioreq_server(domid_t dom,
 
     if (rc == 0) {
         trace_xen_ioreq_server_create(*ioservid);
-        return;
+        return rc;
     }
 
     *ioservid = 0;
     use_default_ioreq_server = true;
     trace_xen_default_ioreq_server();
+
+    return rc;
 }
 
 static inline void xen_destroy_ioreq_server(domid_t dom,
-- 
2.25.1


