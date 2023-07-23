Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F33275E1B5
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 14:10:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNXuG-0006gD-Nw; Sun, 23 Jul 2023 08:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXuE-0006ft-8A
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:46 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qNXuC-00089y-N9
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 08:09:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1b852785a65so22626245ad.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690114182; x=1690718982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OQXPMit78wxXOLwUXAdy/5EGNJNucIHi6SIpfnSqqAI=;
 b=MqsQKxcwpuSUr8ohfL5g+CRqiIme5kXIcr27cwvgTi/EfR96jA+kBv2rWuxTxjqAK9
 9yyH9FFACjAQLqdi1v6AuJKPjqL8aySoWLZExQqiriCCLH2qe+AFsvoYGDiwAwD8JZcU
 bo0lycNZm3ltf3xBTx6aoJ7qc54sW5XIt00SJsasOhduYzZtfUwOYLsKNdjK3jJgZk4w
 BzjOmTfgcKgBoj+Uo/BzeSmdoVjL+c2bLdaZFg1jxI3pEMdDC4b553TpDgGijlgavm6D
 +2RtdU8M/OrM5CZf2tId2hqWwO3Dcv6302o16n8jx7L/pkMn6ZxrKl3xT2VyyiIzIHRq
 9hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690114182; x=1690718982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OQXPMit78wxXOLwUXAdy/5EGNJNucIHi6SIpfnSqqAI=;
 b=CZ1MVY052aczjne5s441aSwlz6Kw0EIMH57t6D53gF2Wl+W9T/WdSU3Kv9fXziuYn2
 OioJ5c91q9Ebut5m9d5aR4zMikvwPnzXSoPTdqbArvmMFAnIBX74O8/wujy/iJfW0WHG
 VWYnXIDyE9azU++L/s/4q5CKAmXTdQt4JmKw2dQ1KT0GEKugNreLRFirq0rS7EVRgirM
 G7ZLV21XHIEgzKFE1oJnS71cayFg+5KjabJzJLJGRtE8OW1QQNOEIHz4R2admWbmuT2z
 ZPELJLXWeO4G/qdCZq2LPWxS1Row3SWbT1iHOrGxHUuGLsK+Rl2FxkMryjWl8bNgbjEC
 isNg==
X-Gm-Message-State: ABy/qLawpV0urlaHNLwIdLmr40YEXHqA6ft5yX/0CFHHFUlAjAknqmX7
 y4WlzITtSnhmo5j7wnZz5mY=
X-Google-Smtp-Source: APBJJlEjpcDCcNJTgNU6Nnqe/WF3xvqdSCv4HDFoiU8t1Z6XAOLLwtksU80qg907pDWnCj8xF9udVQ==
X-Received: by 2002:a17:902:ea0a:b0:1b9:c61c:4c01 with SMTP id
 s10-20020a170902ea0a00b001b9c61c4c01mr10406876plg.9.1690114182233; 
 Sun, 23 Jul 2023 05:09:42 -0700 (PDT)
Received: from localhost ([223.104.38.215]) by smtp.gmail.com with ESMTPSA id
 j6-20020a170902690600b001b86e17ecacsm6730617plk.131.2023.07.23.05.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 05:09:41 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 2/4] virtio-net: Expose MAX_VLAN
Date: Sun, 23 Jul 2023 20:09:12 +0800
Message-Id: <ca03403319c6405ea7c400836a572255bbc9ceba.1690106284.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690106284.git.yin31149@gmail.com>
References: <cover.1690106284.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x62e.google.com
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


