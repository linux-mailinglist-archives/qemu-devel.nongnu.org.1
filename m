Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4287A768740
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 20:57:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQAlp-0004nm-Nf; Sun, 30 Jul 2023 14:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1qQAlg-0004lo-27; Sun, 30 Jul 2023 14:03:48 -0400
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1qQAlc-0001Aj-IA; Sun, 30 Jul 2023 14:03:46 -0400
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id C379EDA02B6;
 Sun, 30 Jul 2023 20:03:38 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 6E7064668B4; Sun, 30 Jul 2023 20:03:38 +0200 (CEST)
To: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: libvir-list@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] Fix some typos in documentation and comments
Date: Sun, 30 Jul 2023 20:03:29 +0200
Message-Id: <20230730180329.851576-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---

This patch was triggered by a spelling check for the generated
QEMU documentation using codespell. It does not try to fix all
typos which still exist in the QEMU code, but has a focus on
those required to fix the documentation. Nevertheless some code
comments with the same typos were fixed, too.

I think the patch is trivial, so maybe it can still be included
in the upcoming release, but that's not strictly necessary.

Stefan

 docs/about/deprecated.rst    | 2 +-
 docs/devel/qom.rst           | 2 +-
 docs/system/devices/nvme.rst | 2 +-
 hw/core/loader.c             | 4 ++--
 include/exec/memory.h        | 2 +-
 ui/vnc-enc-tight.c           | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1c35f55666..92a2bafd2b 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -369,7 +369,7 @@ mapping permissions et al by using its 'mapped' security model option.
 Nowadays it would make sense to reimplement the ``proxy`` backend by using
 QEMU's ``vhost`` feature, which would eliminate the high latency costs under
 which the 9p ``proxy`` backend currently suffers. However as of to date nobody
-has indicated plans for such kind of reimplemention unfortunately.
+has indicated plans for such kind of reimplementation unfortunately.
 
 
 Block device options
diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
index 0b506426d7..9918fac7f2 100644
--- a/docs/devel/qom.rst
+++ b/docs/devel/qom.rst
@@ -30,7 +30,7 @@ user configuration.
 Creating a QOM class
 ====================
 
-A simple minimal device implementation may look something like bellow:
+A simple minimal device implementation may look something like below:
 
 .. code-block:: c
    :caption: Creating a minimal type
diff --git a/docs/system/devices/nvme.rst b/docs/system/devices/nvme.rst
index a8bb8d729c..2a3af268f7 100644
--- a/docs/system/devices/nvme.rst
+++ b/docs/system/devices/nvme.rst
@@ -232,7 +232,7 @@ parameters:
   Set the number of Reclaim Groups.
 
 ``fdp.nruh`` (default: ``0``)
-  Set the number of Reclaim Unit Handles. This is a mandatory paramater and
+  Set the number of Reclaim Unit Handles. This is a mandatory parameter and
   must be non-zero.
 
 ``fdp.runs`` (default: ``96M``)
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 8b7fd9e9e5..4dd5a71fb7 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -863,7 +863,7 @@ ssize_t load_image_gzipped(const char *filename, hwaddr addr, uint64_t max_sz)
 
 /*
  * The Linux header magic number for a EFI PE/COFF
- * image targetting an unspecified architecture.
+ * image targeting an unspecified architecture.
  */
 #define EFI_PE_LINUX_MAGIC        "\xcd\x23\x82\x81"
 
@@ -1492,7 +1492,7 @@ RomGap rom_find_largest_gap_between(hwaddr base, size_t size)
         if (rom->mr || rom->fw_file) {
             continue;
         }
-        /* ignore anything finishing bellow base */
+        /* ignore anything finishing below base */
         if (rom->addr + rom->romsize <= base) {
             continue;
         }
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 7f5c11a0cc..68284428f8 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -942,7 +942,7 @@ struct MemoryListener {
      *
      * @listener: The #MemoryListener.
      * @last_stage: The last stage to synchronize the log during migration.
-     * The caller should gurantee that the synchronization with true for
+     * The caller should guarantee that the synchronization with true for
      * @last_stage is triggered for once after all VCPUs have been stopped.
      */
     void (*log_sync_global)(MemoryListener *listener, bool last_stage);
diff --git a/ui/vnc-enc-tight.c b/ui/vnc-enc-tight.c
index 09200d71b8..ee853dcfcb 100644
--- a/ui/vnc-enc-tight.c
+++ b/ui/vnc-enc-tight.c
@@ -77,7 +77,7 @@ static int tight_send_framebuffer_update(VncState *vs, int x, int y,
 
 #ifdef CONFIG_VNC_JPEG
 static const struct {
-    double jpeg_freq_min;       /* Don't send JPEG if the freq is bellow */
+    double jpeg_freq_min;       /* Don't send JPEG if the freq is below */
     double jpeg_freq_threshold; /* Always send JPEG if the freq is above */
     int jpeg_idx;               /* Allow indexed JPEG */
     int jpeg_full;              /* Allow full color JPEG */
-- 
2.39.2


