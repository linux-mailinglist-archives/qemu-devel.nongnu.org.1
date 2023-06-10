Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E3572A999
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 09:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7sYj-0002mN-Fv; Sat, 10 Jun 2023 02:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sYF-0002lP-OS; Sat, 10 Jun 2023 02:58:20 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7sYE-0005wv-AH; Sat, 10 Jun 2023 02:58:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11BC4BE29;
 Sat, 10 Jun 2023 09:58:01 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 9B253B296;
 Sat, 10 Jun 2023 09:58:00 +0300 (MSK)
Received: (nullmailer pid 1107520 invoked by uid 1000);
 Sat, 10 Jun 2023 06:57:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Sergio Lopez <slp@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 09/16] hw/i386/microvm: Simplify using object_dynamic_cast()
Date: Sat, 10 Jun 2023 09:57:47 +0300
Message-Id: <a5c80ab847dada26137461e534f75bb9bcb85a89.1686379708.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1686379708.git.mjt@tls.msk.ru>
References: <cover.1686379708.git.mjt@tls.msk.ru>
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

Use object_dynamic_cast() to determine if 'dev' is a TYPE_VIRTIO_MMIO.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Sergio Lopez <slp@redhat.com>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/i386/microvm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 3d606a20b4..7227a2156c 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -389,9 +389,8 @@ static void microvm_fix_kernel_cmdline(MachineState *machine)
     bus = sysbus_get_default();
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
         DeviceState *dev = kid->child;
-        ObjectClass *class = object_get_class(OBJECT(dev));
 
-        if (class == object_class_by_name(TYPE_VIRTIO_MMIO)) {
+        if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MMIO)) {
             VirtIOMMIOProxy *mmio = VIRTIO_MMIO(OBJECT(dev));
             VirtioBusState *mmio_virtio_bus = &mmio->bus;
             BusState *mmio_bus = &mmio_virtio_bus->parent_obj;
-- 
2.39.2


