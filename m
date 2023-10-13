Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 457167C8031
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:27:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDFQ-00075d-Cm; Fri, 13 Oct 2023 04:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFE-0006qO-Ii
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:06 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qrDFB-0001Y3-VN
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:10:03 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c8a1541233so14438375ad.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697184600; x=1697789400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM7/Invm03p5i3YtKczc/E5ZspKqc8+FVx1FNwc5f2Q=;
 b=BvRakcRhjOrcPNYtpmOWQ6ziEGxqK4Z0s9B3MpZg4CGRHnGYMavy4UKKaZrWzXtHXD
 QR+XcNoQD6Lt8G9m9xL2JArFjKPpHWU923/G1azossRF0VSzPVrOf3YpPjioNT7BT9t1
 uLYYOR7OCci2s4UktoqyX43uSlHa+fUDcsJoJPC7CM+fppWWh8sTmRLG/KZ55O64efNq
 B60m9zmaXfhSmNVDpPIBUHeMQd0eyn6pAqKqIUB0hXMFnnKE/vgKNVDQ955KXLz74df0
 AR2tahZ7PLsD5ftRm4l7VJBqss7zuXNoYnREUJDpKQgIz96DL+n00WNGeF2hMjhqgVab
 Mmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184600; x=1697789400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fM7/Invm03p5i3YtKczc/E5ZspKqc8+FVx1FNwc5f2Q=;
 b=sJX8nXsUfEpHQWhV705OuQ2VT/7lxTjHeTK65QTGeAxfmRqW+hFFBIO3g6ujJowzVP
 NMcLtvEm10Uq2K3x8n1Z+ee6wyk//4b2rlIJpBiUIUATfEmBNquORzsUHIjw26APaEcK
 b7YcAPUr92IxV6Qnsu5gz6OGjcTlJBFwL1wsuCVEjlHvMsGKCqrm4erl4+LRYSA31EaO
 iEwPKnlxNrUr/UZqOxN/Bc2feFZzxFrdVe5qvhoerLOLLRzU1k9fIoHX905YFOVTgGqp
 GHdlUG8IkrKJVoEHm2TLeOZsRT5YUFeTp+k+g9UpcsEo7og8t09opCtO7npeNrvMJstf
 /DbQ==
X-Gm-Message-State: AOJu0YwZYfxtgJDg/Sx7BTLa09AV3nuZwE82WOj0v9sxgaLFjVEyQ/mr
 OKmOIn/A6Tn+WTPUsBeuBH0=
X-Google-Smtp-Source: AGHT+IHKZ/yQ3CM1GEHeBPbgCTrHgsxzgNwBzPPLefc38ti515n2bFrUrEjxktxskhnTYdR3xsOsxg==
X-Received: by 2002:a17:902:e550:b0:1b9:e937:9763 with SMTP id
 n16-20020a170902e55000b001b9e9379763mr27955703plf.12.1697184600029; 
 Fri, 13 Oct 2023 01:10:00 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 x19-20020a170902ea9300b001c0a414695bsm3268886plb.43.2023.10.13.01.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:09:59 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v5 2/7] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
Date: Fri, 13 Oct 2023 16:09:37 +0800
Message-Id: <254f0618efde7af7229ba4fdada667bb9d318991.1697165821.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1697165821.git.yin31149@gmail.com>
References: <cover.1697165821.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Next patches in this series will refactor vhost_vdpa_net_load_cmd()
to iterate through the control commands shadow buffers, allowing QEMU
to send CVQ state load commands in parallel at device startup.

Considering that QEMU always forwards the CVQ command serialized
outside of vhost_vdpa_net_load(), it is more elegant to send the
CVQ commands directly without invoking vhost_vdpa_net_load_*() helpers.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
---
v5:
  - remove redundant initialization statement suggested by Eugenio
  - remove assertion suggested by Eugenio

v4: https://lore.kernel.org/all/a56d91c3cc2ab46f9be1770074c920f5375ddb5e.1693287885.git.yin31149@gmail.com/
  - pack CVQ command by iov_from_buf() instead of accessing
`out` directly suggested by Eugenio

v3: https://lore.kernel.org/all/428a8fac2a29b37757fa15ca747be93c0226cb1f.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 618758596a..86b8d31244 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1114,12 +1114,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
  */
 static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
                                                        VirtQueueElement *elem,
-                                                       struct iovec *out)
+                                                       struct iovec *out,
+                                                       const struct iovec *in)
 {
     struct virtio_net_ctrl_mac mac_data, *mac_ptr;
     struct virtio_net_ctrl_hdr *hdr_ptr;
     uint32_t cursor;
     ssize_t r;
+    uint8_t on = 1;
 
     /* parse the non-multicast MAC address entries from CVQ command */
     cursor = sizeof(*hdr_ptr);
@@ -1167,7 +1169,13 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * filter table to the vdpa device, it should send the
      * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
      */
-    r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
+    hdr_ptr = out->iov_base;
+    out->iov_len = sizeof(*hdr_ptr) + sizeof(on);
+
+    hdr_ptr->class = VIRTIO_NET_CTRL_RX;
+    hdr_ptr->cmd = VIRTIO_NET_CTRL_RX_PROMISC;
+    iov_from_buf(out, 1, sizeof(*hdr_ptr), &on, sizeof(on));
+    r = vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
     if (unlikely(r < 0)) {
         return r;
     }
@@ -1285,7 +1293,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * the CVQ command directly.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
-                                                                  &out);
+                                                            &out, &vdpa_in);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
-- 
2.25.1


