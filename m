Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CB779248
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:56:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTYy-00017Y-UI; Fri, 11 Aug 2023 10:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qUTYn-00015V-Ar
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:56:18 -0400
Received: from smtpnm6-03.21cn.com ([182.42.153.190] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qUTYk-0003Fj-Kk
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:56:17 -0400
HMM_SOURCE_IP: 192.168.138.117:40850.2116495281
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-125.70.176.234 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id CF1B19BF45;
 Fri, 11 Aug 2023 22:46:57 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([125.70.176.234])
 by gateway-ssl-dep-6579475f45-vz9rh with ESMTP id
 f52e264d011d41c6b6c6e10ebff2be28 for mst@redhat.com; 
 Fri, 11 Aug 2023 22:47:00 CST
X-Transaction-ID: f52e264d011d41c6b6c6e10ebff2be28
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 125.70.176.234
X-MEDUSA-Status: 0
Message-ID: <ce2d0437-8faa-4d61-b536-4668f645a959@chinatelecom.cn>
Date: Fri, 11 Aug 2023 22:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org,
 =?UTF-8?B?6KKB5piO5rWp?= <yuanmh12@chinatelecom.cn>
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
From: Guoyi Tu <tugy@chinatelecom.cn>
Subject: pci: Fix the update of interrupt disable bit in PCI_COMMAND register
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=182.42.153.190; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The PCI_COMMAND register is located at offset 4 within
the PCI configuration space and occupies 2 bytes. The
interrupt disable bit is at the 10th bit, which corresponds
to the byte at offset 5 in the PCI configuration space.

In our testing environment, the guest driver may directly
updates the byte at offset 5 in the PCI configuration space.
The backtrace looks like as following:
#0  pci_default_write_config (d=0x5580bbfc6230, addr=5, val_in=5, l=1)
     at hw/pci/pci.c:1442
#1  0x00005580b8f3156a in virtio_write_config (pci_dev=0x5580bbfc6230, 
address=5, val=5, len=1)
     at hw/virtio/virtio-pci.c:605
#2  0x00005580b8ed2f3b in pci_host_config_write_common 
(pci_dev=0x5580bbfc6230, addr=5, limit=256,
     val=5, len=1) at hw/pci/pci_host.c:81

In this situation, the range_covers_byte function called
by the pci_default_write_config function will return false,
resulting in the inability to handle the interrupt disable
update event.

To fix this issue, we can use the ranges_overlap function
instead of range_covers_byte to determine whether the interrupt
bit has been updated.

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
Signed-off-by: yuanminghao <yuanmh12@chinatelecom.cn>
---
  hw/pci/pci.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b8d22e2e74..881d774fb6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1613,7 +1613,7 @@ void pci_default_write_config(PCIDevice *d, 
uint32_t addr, uint32_t val_in, int
          range_covers_byte(addr, l, PCI_COMMAND))
          pci_update_mappings(d);

-    if (range_covers_byte(addr, l, PCI_COMMAND)) {
+    if (ranges_overlap(addr, l, PCI_COMMAND, 2)) {
          pci_update_irq_disabled(d, was_irq_disabled);
          memory_region_set_enabled(&d->bus_master_enable_region,
                                    (pci_get_word(d->config + PCI_COMMAND)
-- 
2.27.0

--
Guoyi

