Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A57EB55C
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 18:07:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2wl6-0006p4-O7; Tue, 14 Nov 2023 11:59:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkh-0006h6-9F; Tue, 14 Nov 2023 11:59:06 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r2wkd-0004qB-JP; Tue, 14 Nov 2023 11:59:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D52C33269;
 Tue, 14 Nov 2023 19:59:00 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 5CB27351F0;
 Tue, 14 Nov 2023 19:58:42 +0300 (MSK)
Received: (nullmailer pid 2949081 invoked by uid 1000);
 Tue, 14 Nov 2023 16:58:42 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH trivial 03/21] hw/cxl: spelling fixes: limitaions, potentialy,
 intialized
Date: Tue, 14 Nov 2023 19:58:16 +0300
Message-Id: <20231114165834.2949011-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114165834.2949011-1-mjt@tls.msk.ru>
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fixes: 388d6b574e28 "hw/cxl: Use switch statements for read and write of cachemem registers"
Fixes: 3314efd276ad "hw/cxl/mbox: Add Physical Switch Identify command."
Fixes: 004e3a93b814 "hw/cxl: Add tunneled command support to mailbox for switch cci."
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/cxl/cxl-component-utils.c | 4 ++--
 hw/cxl/cxl-mailbox-utils.c   | 2 +-
 include/hw/cxl/cxl_device.h  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
index d0245cc55d..29d477492b 100644
--- a/hw/cxl/cxl-component-utils.c
+++ b/hw/cxl/cxl-component-utils.c
@@ -81,7 +81,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
         return 0;
     default:
         /*
-         * In line with specifiction limitaions on access sizes, this
+         * In line with specification limitaions on access sizes, this
          * routine is not called with other sizes.
          */
         g_assert_not_reached();
@@ -152,7 +152,7 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
         return;
     default:
         /*
-         * In line with specifiction limitaions on access sizes, this
+         * In line with specification limitaions on access sizes, this
          * routine is not called with other sizes.
          */
         g_assert_not_reached();
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b365575097..6eff56fb1b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -431,7 +431,7 @@ static CXLRetCode cmd_identify_switch_device(const struct cxl_cmd *cmd,
     out = (struct cxl_fmapi_ident_switch_dev_resp_pl *)payload_out;
     *out = (struct cxl_fmapi_ident_switch_dev_resp_pl) {
         .num_physical_ports = num_phys_ports + 1, /* 1 USP */
-        .num_vcss = 1, /* Not yet support multiple VCS - potentialy tricky */
+        .num_vcss = 1, /* Not yet support multiple VCS - potentially tricky */
         .active_vcs_bitmask[0] = 0x1,
         .total_vppbs = num_phys_ports + 1,
         .bound_vppbs = num_phys_ports + 1,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 61b7f897f7..befb5f884b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -403,7 +403,7 @@ struct CXLType3Dev {
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
     CXLCCI cci; /* Primary PCI mailbox CCI */
-    /* Always intialized as no way to know if a VDM might show up */
+    /* Always initialized as no way to know if a VDM might show up */
     CXLCCI vdm_fm_owned_ld_mctp_cci;
     CXLCCI ld0_cci;
 
-- 
2.39.2


