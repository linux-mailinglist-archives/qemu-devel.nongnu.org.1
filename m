Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 324CB843EFE
	for <lists+qemu-devel@lfdr.de>; Wed, 31 Jan 2024 13:00:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV9EW-0002wr-Fm; Wed, 31 Jan 2024 06:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9DP-0002S5-Cg; Wed, 31 Jan 2024 06:57:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rV9DN-00043j-Pl; Wed, 31 Jan 2024 06:57:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0CD27490D3;
 Wed, 31 Jan 2024 14:56:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 42EEE7027C;
 Wed, 31 Jan 2024 14:55:51 +0300 (MSK)
Received: (nullmailer pid 2263976 invoked by uid 1000);
 Wed, 31 Jan 2024 11:55:49 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 21/21] hw/hyperv: Include missing headers
Date: Wed, 31 Jan 2024 14:55:49 +0300
Message-Id: <20240131115549.2263854-22-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131115549.2263854-1-mjt@tls.msk.ru>
References: <20240131115549.2263854-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Include missing headers in order to avoid when refactoring
unrelated headers:

  hw/hyperv/hyperv.c:33:18: error: field ‘msg_page_mr’ has incomplete type
    33 |     MemoryRegion msg_page_mr;
       |                  ^~~~~~~~~~~
  hw/hyperv/hyperv.c: In function ‘synic_update’:
  hw/hyperv/hyperv.c:64:13: error: implicit declaration of function ‘memory_region_del_subregion’ [-Werror=implicit-function-declaration]
    64 |             memory_region_del_subregion(get_system_memory(),
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
  hw/hyperv/hyperv.c: In function ‘hyperv_hcall_signal_event’:
  hw/hyperv/hyperv.c:683:17: error: implicit declaration of function ‘ldq_phys’; did you mean ‘ldub_phys’? [-Werror=implicit-function-declaration]
   683 |         param = ldq_phys(&address_space_memory, addr);
       |                 ^~~~~~~~
       |                 ldub_phys
  hw/hyperv/hyperv.c:683:17: error: nested extern declaration of ‘ldq_phys’ [-Werror=nested-externs]
  hw/hyperv/hyperv.c: In function ‘hyperv_hcall_retreive_dbg_data’:
  hw/hyperv/hyperv.c:792:24: error: ‘TARGET_PAGE_SIZE’ undeclared (first use in this function); did you mean ‘TARGET_PAGE_BITS’?
   792 |     msg.u.recv.count = TARGET_PAGE_SIZE - sizeof(*debug_data_out);
       |                        ^~~~~~~~~~~~~~~~
       |                        TARGET_PAGE_BITS
  hw/hyperv/hyperv.c: In function ‘hyperv_syndbg_send’:
  hw/hyperv/hyperv.c:885:16: error: ‘HV_SYNDBG_STATUS_INVALID’ undeclared (first use in this function)
   885 |         return HV_SYNDBG_STATUS_INVALID;
       |                ^~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/hyperv/hyperv.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 57b402b956..6c4a18dd0e 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -12,6 +12,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "exec/address-spaces.h"
+#include "exec/memory.h"
 #include "sysemu/kvm.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
@@ -21,6 +22,9 @@
 #include "qemu/rcu_queue.h"
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
+#include "target/i386/kvm/hyperv-proto.h"
+#include "target/i386/cpu.h"
+#include "exec/cpu-all.h"
 
 struct SynICState {
     DeviceState parent_obj;
-- 
2.39.2


