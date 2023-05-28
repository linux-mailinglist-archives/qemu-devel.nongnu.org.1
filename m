Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B18713838
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 09:02:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3AOb-0005IM-PK; Sun, 28 May 2023 03:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANa-0004I1-H3; Sun, 28 May 2023 02:59:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q3ANY-0001qa-Qb; Sun, 28 May 2023 02:59:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4DFD18E20;
 Sun, 28 May 2023 09:59:41 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id CF0957E2A;
 Sun, 28 May 2023 09:59:40 +0300 (MSK)
Received: (nullmailer pid 42625 invoked by uid 1000);
 Sun, 28 May 2023 06:59:40 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.3 49/53] rtl8139: fix large_send_mss divide-by-zero
Date: Sun, 28 May 2023 09:59:22 +0300
Message-Id: <20230528065940.42582-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
References: <qemu-stable-7.2.3-20230528095720@cover.tls.msk.ru>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

If the driver sets large_send_mss to 0 then a divide-by-zero occurs.
Even if the division wasn't a problem, the for loop that emits MSS-sized
packets would never terminate.

Solve these issues by skipping offloading when large_send_mss=0.

This issue was found by OSS-Fuzz as part of Alexander Bulekov's device
fuzzing work. The reproducer is:

  $ cat << EOF | ./qemu-system-i386 -display none -machine accel=qtest, -m \
  512M,slots=1,maxmem=0xffff000000000000 -machine q35 -nodefaults -device \
  rtl8139,netdev=net0 -netdev user,id=net0 -device \
  pc-dimm,id=nv1,memdev=mem1,addr=0xb800a64602800000 -object \
  memory-backend-ram,id=mem1,size=2M  -qtest stdio
  outl 0xcf8 0x80000814
  outl 0xcfc 0xe0000000
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  write 0xe0000037 0x1 0x04
  write 0xe00000e0 0x2 0x01
  write 0x1 0x1 0x04
  write 0x3 0x1 0x98
  write 0xa 0x1 0x8c
  write 0xb 0x1 0x02
  write 0xc 0x1 0x46
  write 0xd 0x1 0xa6
  write 0xf 0x1 0xb8
  write 0xb800a646028c000c 0x1 0x08
  write 0xb800a646028c000e 0x1 0x47
  write 0xb800a646028c0010 0x1 0x02
  write 0xb800a646028c0017 0x1 0x06
  write 0xb800a646028c0036 0x1 0x80
  write 0xe00000d9 0x1 0x40
  EOF

Buglink: https://gitlab.com/qemu-project/qemu/-/issues/1582
Closes: https://gitlab.com/qemu-project/qemu/-/issues/1582
Cc: qemu-stable@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 6d71357a3b65 ("rtl8139: honor large send MSS value")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 792676c165159c11412346870fd58fd243ab2166)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 700b1b66b6..eb679d7c40 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2154,6 +2154,9 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
 
                 int large_send_mss = (txdw0 >> CP_TC_LGSEN_MSS_SHIFT) &
                                      CP_TC_LGSEN_MSS_MASK;
+                if (large_send_mss == 0) {
+                    goto skip_offload;
+                }
 
                 DPRINTF("+++ C+ mode offloaded task TSO IP data %d "
                     "frame data %d specified MSS=%d\n",
-- 
2.39.2


