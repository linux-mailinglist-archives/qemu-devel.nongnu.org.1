Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D470D54F
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 09:38:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1MYj-0006on-Rc; Tue, 23 May 2023 03:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MYC-0005Vz-1D
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1q1MYA-0004i5-6T
 for qemu-devel@nongnu.org; Tue, 23 May 2023 03:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684827317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e21rZRbx8pJgrRt3A4Dh3C/IFR9RCG+pyxQmVlRn/UQ=;
 b=EGNg0jpibRNduxo6ltrg3CAHLePrlCH0JevgBjVK/eq4Ij65G0jRMSu7CMm6ATjem+mrZ2
 9jmNAuW9RGBgzimdkI0y3V0UCGXssGsJ8/+YaL4lJihfiwAekGxxUL+lj766z3kQ5MZxxM
 vZ9aMKADmp1kOomC/KACWZKMOdzT7Ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-kfMlFs4yPNaLg38EEmOJ8A-1; Tue, 23 May 2023 03:35:14 -0400
X-MC-Unique: kfMlFs4yPNaLg38EEmOJ8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D582E185A797;
 Tue, 23 May 2023 07:35:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-45.pek2.redhat.com [10.72.12.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BE83A2166B25;
 Tue, 23 May 2023 07:35:10 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 50/50] rtl8139: fix large_send_mss divide-by-zero
Date: Tue, 23 May 2023 15:32:38 +0800
Message-Id: <20230523073238.54236-51-jasowang@redhat.com>
In-Reply-To: <20230523073238.54236-1-jasowang@redhat.com>
References: <20230523073238.54236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
---
 hw/net/rtl8139.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 5a5aaf8..5f1a4d3 100644
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
2.7.4


