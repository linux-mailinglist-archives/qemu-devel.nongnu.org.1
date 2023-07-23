Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4925B75E0E7
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 11:28:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNVNT-0001gM-0t; Sun, 23 Jul 2023 05:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNR-0001fv-Cs
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:45 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNVNP-0001W9-RZ
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 05:27:45 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-268128a0105so118433a91.3
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 02:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690104461; x=1690709261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQXPMit78wxXOLwUXAdy/5EGNJNucIHi6SIpfnSqqAI=;
 b=fmsVIb/LLMqQcE65C4gdI7s+e/Eo6sNFzRCuqQsXsy5bTogLvOatSaKCY4eaDd0F5O
 26tQOatnwXaR76fKpUX10DxhUzNqJivo1hagcQWSIKrhxk7vC/nF0px8RXxRLjCwwiZE
 3wZuAjXU50c0SZvILXKhxPgI4spd7f+znlgfogpK8BMnYNEjqrJiNFgYfOeJNO6dQWEr
 /hPdaXAegTjmXeiHHgKFy7cz+bvB/l1GV/V7f1nViVO+Xja0g/TnDwtEUCiy2GSBaxnX
 PhvZuO7suZ6Bxs32bCqJTXfhcTwejyAt0JBctCW8+oQBFwW0ptoZcVYjAFGYZbTl5B4X
 Xcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690104461; x=1690709261;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQXPMit78wxXOLwUXAdy/5EGNJNucIHi6SIpfnSqqAI=;
 b=N856XWQNkgQgMVWwmBNLEr4kTnrc6o/usGxD/ubwypCDJVSKXEwYwCB1rzKDoc8Mja
 uwXIUc0SB5EruqOp0RRMHiG+rVcPgdx2M7gx1IErlr1Vt0bvJXqRX2BhG06zCjcnqhYd
 8BvK9kzFhkgPxQgumgBy2zxET7EXmEgHMvbJhS4RoqEAbnpkdtSv6dXTtn5/G2fZJ7Q4
 Jmo3o0/TUuI1L77ghce5NPf+va8aDcEKkfJwkEfvlGrCCQ0suhhMp0AwpsNa8xusPDHo
 7hHoWVCF7TcMHZ+/smw2qf5H5/FA+4wbBs8pSb9QKFPagTsBdcot/423aZorWrBj5bEf
 d7JA==
X-Gm-Message-State: ABy/qLbllOcBvWHQiS+of+a4we30nVXqBxZLqIt2VSmTqgmwnMZtnwU5
 Cp5a4je79nwkrH4mXvHFplg=
X-Google-Smtp-Source: APBJJlHtoGaxTKWHTyVEgE0gTN5eCCPwFRiT19gibR4kPLThh7sefQHsbY0Wrv3lzkZiXIUGK9G9fw==
X-Received: by 2002:a17:90b:4c11:b0:263:bc7b:a76d with SMTP id
 na17-20020a17090b4c1100b00263bc7ba76dmr7129705pjb.4.1690104461430; 
 Sun, 23 Jul 2023 02:27:41 -0700 (PDT)
Received: from localhost ([123.117.183.65]) by smtp.gmail.com with ESMTPSA id
 m8-20020a17090a4d8800b00267c49d74e8sm5610345pjh.42.2023.07.23.02.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 02:27:41 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v2 2/4] virtio-net: Expose MAX_VLAN
Date: Sun, 23 Jul 2023 17:26:35 +0800
Message-Id: <ca03403319c6405ea7c400836a572255bbc9ceba.1690100802.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690100802.git.yin31149@gmail.com>
References: <cover.1690100802.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102d.google.com
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

vhost-vdpa shadowed CVQ needs to know the maximum number of
vlans supported by the virtio-net device, so QEMU can restore
the VLAN state in a migration.

Co-developed-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c            | 2 --
 include/hw/virtio/virtio-net.h | 6 ++++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index d20d5a63cd..a32672039d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -49,8 +49,6 @@
 
 #define VIRTIO_NET_VM_VERSION    11
 
-#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
-
 /* previously fixed value */
 #define VIRTIO_NET_RX_QUEUE_DEFAULT_SIZE 256
 #define VIRTIO_NET_TX_QUEUE_DEFAULT_SIZE 256
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5f5dcb4572..93f3bb5d97 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -38,6 +38,12 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)
 /* Maximum VIRTIO_NET_CTRL_MAC_TABLE_SET unicast + multicast entries. */
 #define MAC_TABLE_ENTRIES    64
 
+/*
+ * The maximum number of VLANs in the VLAN filter table
+ * added by VIRTIO_NET_CTRL_VLAN_ADD
+ */
+#define MAX_VLAN    (1 << 12)   /* Per 802.1Q definition */
+
 typedef struct virtio_net_conf
 {
     uint32_t txtimer;
-- 
2.25.1


