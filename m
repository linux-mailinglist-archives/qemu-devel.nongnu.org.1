Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B80CC826260
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 00:20:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMFwk-0000Im-DC; Sat, 06 Jan 2024 18:19:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1rMFH3-0004QX-HQ
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 17:36:15 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1rMFGw-0006PO-NZ
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 17:36:11 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28c2b8d6f2aso343951a91.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 14:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1704580563; x=1705185363;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B6Q5MOy4DMeVVshmwcGbg6b5JPiFTITcvztdl5Ea+1U=;
 b=fG+pwGoGVcakUChMR2D+dlQ8nwuKmEDbripMOb5HI81G+DdihWiHzUoQCBFzwlHNXu
 wXfhh8FideWgFAWLI4qOy8/Dn98TgyP2MKGU11q+XnQBz9drLmrOwqb4gc1M6+PUK5Zm
 S68ABDNBadShpBqQTSgIQZd+c+HEGGTFE2Dy4JX7FuBNHrr3di2iKEKRdEPXhJkgBIMV
 xQTScOIjc2B+lUx6PfdqFKrGBied90Dv8VubNYaXn6eQCAc+3LCJpVSwwJpq29XDOH2q
 6C1kPiXxe+k4ztAWBYdQZhX7SbIw28SYsGRwPthIUf18KBSck0s0+5yzHdtInwMlXsk2
 yzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704580563; x=1705185363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6Q5MOy4DMeVVshmwcGbg6b5JPiFTITcvztdl5Ea+1U=;
 b=D233+v9eH7DB8wrZb4FbIVBWOuZhSUPe34FOcKwfA1xlvoCFshg+b8Eq8kWr1JlHya
 xhXx2g4D/r5F88EYFk+Ymtk427NS6quTXkMVVVoUeLTawpUisGuTA+u9UlvCLYlwHp6m
 l6YBAOvV6389SNc0EPNv+RV+3JaV6fMkuFns/S7faVa+LmTKSflISIj/mALl9t+vwPn7
 oLQVJIB+unlpZbFzSysMWjbLOCbxAKrmhEQA29WTLAMDlCwXzUEJKI+CXEr6iqnTYsaj
 7Fjy1mhylDhmcBIP9Rc75R8W4iafaMy4nZAEJ8tl4uqGF3JXlRbf9nshOXnLOiHvj476
 lg0w==
X-Gm-Message-State: AOJu0YzOgbtn65RZG96+8qvRGQdRMZNRTUyY7iwGIGE88tcWYT8MQ1Hw
 5ZLWsADUmUX2yXazQSEHmSdOZU1VIE0GwoE/x7UoAu7pRz/hFS0n
X-Google-Smtp-Source: AGHT+IE2AQq/JDPR88vfUIAxJy870P6ayRYyrHzpQCgyPl/PiJ9P7e63sCe37uzOX701p+8h4mYj1Q==
X-Received: by 2002:a05:6a20:54a7:b0:199:7b5e:f8c0 with SMTP id
 i39-20020a056a2054a700b001997b5ef8c0mr318450pzk.66.1704580562696; 
 Sat, 06 Jan 2024 14:36:02 -0800 (PST)
Received: from localhost.localdomain (076-081-243-074.biz.spectrum.com.
 [76.81.243.74]) by smtp.gmail.com with ESMTPSA id
 l10-20020a17090270ca00b001d4526d0039sm3510845plt.169.2024.01.06.14.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 14:36:02 -0800 (PST)
From: William Hooper <wsh@wshooper.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
	William Hooper <wsh@wshooper.org>
Subject: [PATCH] net/vmnet: Pad short Ethernet frames
Date: Sat,  6 Jan 2024 14:35:46 -0800
Message-Id: <20240106223546.44460-1-wsh@wshooper.org>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102d;
 envelope-from=wsh@wshooper.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 06 Jan 2024 18:19:16 -0500
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

At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
host's ARP replies, to the minimum size (60 bytes before the frame check
sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
drivers may drop them with "frame too short" errors.

This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
and net/slirp.c.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
Signed-off-by: William Hooper <wsh@wshooper.org>
---
 net/vmnet-common.m | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 2958283485..f8f7163226 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "sysemu/runstate.h"
+#include "net/eth.h"
 
 #include <vmnet/vmnet.h>
 #include <dispatch/dispatch.h>
@@ -150,10 +151,23 @@ static int vmnet_read_packets(VmnetState *s)
  */
 static void vmnet_write_packets_to_qemu(VmnetState *s)
 {
+    uint8_t *pkt;
+    size_t pktsz;
+    uint8_t min_pkt[ETH_ZLEN];
+    size_t min_pktsz = sizeof(min_pkt);
+
     while (s->packets_send_current_pos < s->packets_send_end_pos) {
-        ssize_t size = qemu_send_packet_async(&s->nc,
-                                      s->iov_buf[s->packets_send_current_pos].iov_base,
-                                      s->packets_buf[s->packets_send_current_pos].vm_pkt_size,
+        pkt = s->iov_buf[s->packets_send_current_pos].iov_base;
+        pktsz = s->packets_buf[s->packets_send_current_pos].vm_pkt_size;
+
+        if (net_peer_needs_padding(&s->nc)) {
+            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
+                pkt = min_pkt;
+                pktsz = min_pktsz;
+            }
+        }
+
+        ssize_t size = qemu_send_packet_async(&s->nc, pkt, pktsz,
                                       vmnet_send_completed);
 
         if (size == 0) {
-- 
2.37.1


