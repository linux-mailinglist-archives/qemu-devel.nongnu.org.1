Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 289F6742991
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 17:26:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEtXT-0001sZ-2n; Thu, 29 Jun 2023 11:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWs-0001ju-Q0
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:58 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qEtWq-0007Qz-PW
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 11:25:54 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1b7db2e162cso4587515ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688052351; x=1690644351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yOB12PIn0FZFsRHdFv6Q5mXPK3RoN/QgEsk0BguCeX0=;
 b=svTvaLqshpChqmdsQxnlQ0+lX+Atox15FGzElMOzlAUoYSAu+imhyZme1GNelhRxDh
 mRrFlC6+5Yq4JQvd6dkU/18tNXySV/bJtHDnRgOXDuHunyCESsjyEXF3rHtKAakP8DJD
 ftIoaHl15bpzN8rlK04iYwTBKmh6aUvBpQn8tB4ZeizrkMYxehc90KoW5oilcbcew3wz
 f/pDgNg1Vpsl3oqQ18a3KR8sltiGjzRQbDWa+ydsvjE/XMCTIiQC2LjWobAmH8aay26g
 iJZ8Mf9qCd2/7WiYB0OqRxc6vbZqiTdjGVJyKPmp3PtUjMoryMKL3aS86HZYcIX+vSYE
 0BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688052351; x=1690644351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yOB12PIn0FZFsRHdFv6Q5mXPK3RoN/QgEsk0BguCeX0=;
 b=Vurc0swSuNkA7vX3TQVTebAQHB3/uP6k5Q9kq8dXKZ4e7SA0PWO81xUfFxC5x1B9IW
 jWVuzrxgjPgNU3Wlx97liYIrTo4hCTYJ6a29QpMCBy1392+EqIj0B0HGuxkfLrJ2qnd+
 L4bhVLbYxDl3BUmW+qH5o40S/3CYr/ESsk177MuyZWZlgOQmAENPO5HRHCDC5B5J/VDh
 isczUCly2j1l8HwopVS5lCSVJ38OsjMa2vq5yahaWeAGWXSLrqcvhw1x6eFHpGLugMd3
 oBojKKyNKbjJud+DBZQIog5YW1KmNZWDVsFtr0FamLKAFDZ2oADqBP+QZZ4IMoun9/+1
 MLBw==
X-Gm-Message-State: AC+VfDyf1qTH6OPQGzucuwSA699xVLf+di2vYE64ns0RPvX9GMpT/OP2
 3JEK/YVVbrAKtTCgE3CPx0M=
X-Google-Smtp-Source: ACHHUZ6zXEpuMEUZ5GHxkapxRqmA6+J/kxgxDfXjXEFvyOosQ0e7ayCZE3VMnA8PMUWDt1L2AoFg4Q==
X-Received: by 2002:a17:90a:590e:b0:262:a6f7:1946 with SMTP id
 k14-20020a17090a590e00b00262a6f71946mr12996398pji.9.1688052350922; 
 Thu, 29 Jun 2023 08:25:50 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 s18-20020a17090a881200b0024e05b7ba8bsm9417000pjn.25.2023.06.29.08.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 08:25:50 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 2/4] vdpa: Restore MAC address filtering state
Date: Thu, 29 Jun 2023 23:25:33 +0800
Message-Id: <2f2560f749186c0eb1055f9926f464587e419eeb.1688051252.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688051252.git.yin31149@gmail.com>
References: <cover.1688051252.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch refactors vhost_vdpa_net_load_mac() to
restore the MAC address filtering state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v2:
  - use iovec suggested by Eugenio
  - avoid sending CVQ command in default state

v1: https://lore.kernel.org/all/00f72fe154a882fd6dc15bc39e3a1ac63f9dadce.1687402580.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0bd1c7817c..cb45c84c88 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -665,6 +665,57 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         }
     }
 
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX)) {
+        if (n->mac_table.in_use != 0) {
+            /*
+             * According to virtio_net_reset(), device uses an empty MAC filter
+             * table as its default state.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets an empty MAC filter table, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            uint32_t uni_entries = n->mac_table.first_multi,
+                     uni_macs_size = uni_entries * ETH_ALEN,
+                     mul_entries = n->mac_table.in_use - uni_entries,
+                     mul_macs_size = mul_entries * ETH_ALEN;
+            struct virtio_net_ctrl_mac uni = {
+                .entries = cpu_to_le32(uni_entries),
+            };
+            struct virtio_net_ctrl_mac mul = {
+                .entries = cpu_to_le32(mul_entries),
+            };
+            const struct iovec data[] = {
+                {
+                    .iov_base = &uni,
+                    .iov_len = sizeof(uni),
+                }, {
+                    .iov_base = n->mac_table.macs,
+                    .iov_len = uni_macs_size,
+                }, {
+                    .iov_base = &mul,
+                    .iov_len = sizeof(mul),
+                }, {
+                    .iov_base = &n->mac_table.macs[uni_macs_size],
+                    .iov_len = mul_macs_size,
+                },
+            };
+            ssize_t dev_written = vhost_vdpa_net_load_cmd(s,
+                                        VIRTIO_NET_CTRL_MAC,
+                                        VIRTIO_NET_CTRL_MAC_TABLE_SET,
+                                        data, ARRAY_SIZE(data));
+            if (unlikely(dev_written < 0)) {
+                return dev_written;
+            }
+            if (*s->status != VIRTIO_NET_OK) {
+                return -EINVAL;
+            }
+        }
+    }
+
     return 0;
 }
 
-- 
2.25.1


