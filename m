Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511578BE13
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 07:57:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qarhs-00057V-7i; Tue, 29 Aug 2023 01:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhW-00051N-7d
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qarhP-0002ef-7b
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 01:55:40 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bf11b1c7d0so33081635ad.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 22:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693288532; x=1693893332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AqIf40N9Em1rTjkkVTG0yLz/IMb5us0GaRvR7oGVp4s=;
 b=bf8d3CtognJPZPzjJIkOcVpmxVkl6t1/PC4cUCu/J0MqzIPuSCdXQqsbunKeJpbdsw
 CvTZ+Q7Kd5LGYOoQusPO9YsybiTnrV94llHxi6FD5W8czDSRO3JXY4ezg2e+CsmQYck+
 r0h6Oxmd4aHeNedpB48GuPL7J8CKxudmBJl+rTV3PrqhYSvyb13pVM/oGqtXyCbAiAwr
 MwZGarXLZtTEBaxkeSLIwrzsnknlT2c8NBx3dCO3GnvHjeS0n5BQd6wnWbR4+K8otUnd
 1NcrzIFGf3ivqYm8FWWqZCtyDdQScSKV6hjgaYh7iidf9SJ0BlRBs69Fe8aNNgO1iDBQ
 JM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693288532; x=1693893332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqIf40N9Em1rTjkkVTG0yLz/IMb5us0GaRvR7oGVp4s=;
 b=LQw53nhHsCRFvBjjnKs/AGR7XHtPzlhk+dCa17a5TKCogb6KaOJWhJecsf0L3mc6Xl
 gvRiUZF8V7oBYVJgsDoTGaz1a9GqNtw8VhOSjcvMC7ClJJrI/Ysypxr9NfhxjilcZjmj
 pLa50npwr5wlZJBpGjDWGLR24nMn/XpNOVh/L/6zZT1Eklj7GlM/QjgZkTIeVkFcXORH
 W5aeWDf52rpioMxeK9fSSrS/hZlsLYCd4SBUk43gY8F6lTZTeNPmXdPixDbsmWA6qPG+
 dPVlXBpkiHilvmPzRtWoztdCtCwfXSMknOVWXj5P9tbp4jt+25lpq578iZj40x/IUs1W
 I0vw==
X-Gm-Message-State: AOJu0YxyuEEUwhSfBIWp7Z647bGwD/VX3HDOMLw8Zwh5yx1z6i1euOU1
 iT9VjsYS8hyP5/Qvfd4zTHQ=
X-Google-Smtp-Source: AGHT+IH+XqOlr8121hsoaVIlflGj+t80qutG+5Z1D58YJbc3MXjTE3qD164hJIKVXvIQ9Am9b05+og==
X-Received: by 2002:a17:903:244e:b0:1c0:8a05:f32e with SMTP id
 l14-20020a170903244e00b001c08a05f32emr2509767pls.23.1693288531992; 
 Mon, 28 Aug 2023 22:55:31 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 u15-20020a17090341cf00b001bdc9daadc9sm8533012ple.89.2023.08.28.22.55.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 22:55:31 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, leiyang@redhat.com,
 18801353760@163.com
Subject: [PATCH v4 4/8] vdpa: Avoid using vhost_vdpa_net_load_*() outside
 vhost_vdpa_net_load()
Date: Tue, 29 Aug 2023 13:54:46 +0800
Message-Id: <a56d91c3cc2ab46f9be1770074c920f5375ddb5e.1693287885.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x632.google.com
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
---
v4:
  - pack CVQ command by iov_from_buf() instead of accessing
`out` directly suggested by Eugenio

v3: https://lore.kernel.org/all/428a8fac2a29b37757fa15ca747be93c0226cb1f.1689748694.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e6342b213f..7c67063469 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -1097,12 +1097,14 @@ static NetClientInfo net_vhost_vdpa_cvq_info = {
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
@@ -1150,7 +1152,15 @@ static int vhost_vdpa_net_excessive_mac_filter_cvq_add(VhostVDPAState *s,
      * filter table to the vdpa device, it should send the
      * VIRTIO_NET_CTRL_RX_PROMISC CVQ command to enable promiscuous mode
      */
-    r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_PROMISC, 1);
+    cursor = 0;
+    hdr_ptr = out->iov_base;
+    out->iov_len = sizeof(*hdr_ptr) + sizeof(on);
+    assert(out->iov_len < vhost_vdpa_net_cvq_cmd_page_len());
+
+    hdr_ptr->class = VIRTIO_NET_CTRL_RX;
+    hdr_ptr->cmd = VIRTIO_NET_CTRL_RX_PROMISC;
+    iov_from_buf(out, 1, sizeof(*hdr_ptr), &on, sizeof(on));
+    r = vhost_vdpa_net_cvq_add(s, out, 1, in, 1);
     if (unlikely(r < 0)) {
         return r;
     }
@@ -1268,7 +1278,7 @@ static int vhost_vdpa_net_handle_ctrl_avail(VhostShadowVirtqueue *svq,
          * the CVQ command direclty.
          */
         dev_written = vhost_vdpa_net_excessive_mac_filter_cvq_add(s, elem,
-                                                                  &out);
+                                                            &out, &vdpa_in);
         if (unlikely(dev_written < 0)) {
             goto out;
         }
-- 
2.25.1


