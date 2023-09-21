Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B79C17A92A0
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:36:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjFA9-0006W1-Bk; Thu, 21 Sep 2023 04:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9x-00069Z-9G; Thu, 21 Sep 2023 04:35:41 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qjF9v-0001KL-IT; Thu, 21 Sep 2023 04:35:41 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 124CC23DAC;
 Thu, 21 Sep 2023 11:35:35 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B3D9B29A06;
 Thu, 21 Sep 2023 11:35:13 +0300 (MSK)
Received: (nullmailer pid 509109 invoked by uid 1000);
 Thu, 21 Sep 2023 08:35:11 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-trivial@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 09/17] hw/i386/pc: fix code comment on cumulative flash size
Date: Thu, 21 Sep 2023 11:34:58 +0300
Message-Id: <20230921083506.509032-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230921083506.509032-1-mjt@tls.msk.ru>
References: <20230921083506.509032-1-mjt@tls.msk.ru>
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

From: Laszlo Ersek <lersek@redhat.com>

- The comment is incorrectly indented / formatted.

- The comment states a 8MB limit, even though the code enforces a 16MB
  limit.

Both of these warts come from commit 0657c657eb37 ("hw/i386/pc: add max
combined fw size as machine configuration option", 2020-12-09); clean them
up.

Arguably, it's also better to be consistent with the binary units (such as
"MiB") that QEMU uses nowadays.

Cc: "Michael S. Tsirkin" <mst@redhat.com> (supporter:PC)
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com> (supporter:PC)
Cc: Paolo Bonzini <pbonzini@redhat.com> (maintainer:X86 TCG CPUs)
Cc: Richard Henderson <richard.henderson@linaro.org> (maintainer:X86 TCG CPUs)
Cc: Eduardo Habkost <eduardo@habkost.net> (maintainer:X86 TCG CPUs)
Cc: qemu-trivial@nongnu.org
Fixes: 0657c657eb37
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/pc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2872f60cdf..3db0743f31 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1746,12 +1746,12 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
     }
 
     /*
-    * We don't have a theoretically justifiable exact lower bound on the base
-    * address of any flash mapping. In practice, the IO-APIC MMIO range is
-    * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
-    * only 18MB-4KB below 4G. For now, restrict the cumulative mapping to 8MB in
-    * size.
-    */
+     * We don't have a theoretically justifiable exact lower bound on the base
+     * address of any flash mapping. In practice, the IO-APIC MMIO range is
+     * [0xFEE00000..0xFEE01000] -- see IO_APIC_DEFAULT_ADDRESS --, leaving free
+     * only 18MiB-4KiB below 4GiB. For now, restrict the cumulative mapping to
+     * 16MiB in size.
+     */
     if (value > 16 * MiB) {
         error_setg(errp,
                    "User specified max allowed firmware size %" PRIu64 " is "
-- 
2.39.2


