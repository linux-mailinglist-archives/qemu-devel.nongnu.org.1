Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDFC91D2DD
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jun 2024 18:55:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNxoJ-0005fs-4l; Sun, 30 Jun 2024 12:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxoD-0005cI-1o; Sun, 30 Jun 2024 12:53:49 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sNxoB-0005J4-9z; Sun, 30 Jun 2024 12:53:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8C78075762;
 Sun, 30 Jun 2024 19:53:20 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 61058FAD5F;
 Sun, 30 Jun 2024 19:53:27 +0300 (MSK)
Received: (nullmailer pid 38215 invoked by uid 1000);
 Sun, 30 Jun 2024 16:53:27 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 05/16] monitor: Remove obsolete stubs
Date: Sun, 30 Jun 2024 19:53:15 +0300
Message-Id: <20240630165327.38153-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240630165327.38153-1-mjt@tls.msk.ru>
References: <20240630165327.38153-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

hmp_info_roms() was removed in commit dd98234c05 ("qapi:
introduce x-query-roms QMP command"),

hmp_info_numa() in commit 1b8ae799d8 ("qapi: introduce
x-query-numa QMP command"),

hmp_info_ramblock() in commit ca411b7c8a ("qapi: introduce
x-query-ramblock QMP command")

and hmp_info_irq() in commit 91f2fa7045 ("qapi: introduce
x-query-irq QMP command").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/loader.h   | 1 -
 include/monitor/hmp.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index 8685e27334..9844c5e3cf 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -338,7 +338,6 @@ void *rom_ptr(hwaddr addr, size_t size);
  * rom_ptr().
  */
 void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
-void hmp_info_roms(Monitor *mon, const QDict *qdict);
 
 #define rom_add_file_fixed(_f, _a, _i)          \
     rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 954f3c83ad..ae116d9804 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -35,7 +35,6 @@ void hmp_info_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vnc(Monitor *mon, const QDict *qdict);
 void hmp_info_spice(Monitor *mon, const QDict *qdict);
 void hmp_info_balloon(Monitor *mon, const QDict *qdict);
-void hmp_info_irq(Monitor *mon, const QDict *qdict);
 void hmp_info_pic(Monitor *mon, const QDict *qdict);
 void hmp_info_pci(Monitor *mon, const QDict *qdict);
 void hmp_info_tpm(Monitor *mon, const QDict *qdict);
@@ -102,7 +101,6 @@ void hmp_chardev_send_break(Monitor *mon, const QDict *qdict);
 void hmp_object_add(Monitor *mon, const QDict *qdict);
 void hmp_object_del(Monitor *mon, const QDict *qdict);
 void hmp_info_memdev(Monitor *mon, const QDict *qdict);
-void hmp_info_numa(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict);
 void hmp_qom_list(Monitor *mon, const QDict *qdict);
 void hmp_qom_get(Monitor *mon, const QDict *qdict);
@@ -141,7 +139,6 @@ void hmp_rocker_ports(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_flows(Monitor *mon, const QDict *qdict);
 void hmp_rocker_of_dpa_groups(Monitor *mon, const QDict *qdict);
 void hmp_info_dump(Monitor *mon, const QDict *qdict);
-void hmp_info_ramblock(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
-- 
2.39.2


