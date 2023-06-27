Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E973FDEF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 16:35:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE9mk-0006ZH-Ad; Tue, 27 Jun 2023 10:35:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qE9mf-0006YM-Ov; Tue, 27 Jun 2023 10:35:10 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qE9md-0004Hc-SJ; Tue, 27 Jun 2023 10:35:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b7fdc66e30so14099145ad.2; 
 Tue, 27 Jun 2023 07:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687876505; x=1690468505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NRKoYto0a2xN5SJ+PQkslp9GwnRk/S2p6DoaKuEwdv4=;
 b=NzP1o08fCcLKadBEmg42/T9eFgf/YaOR/0rep8urDaEeLmFWoMwr2liA6Dp0AfoOWo
 2SlLLmIHMODaK87KW0dtl0erw24flcGU3SgeXI9MERwW4B92WhhYIjd1FIgQL8uNYB5o
 CA29wIeB7YzGVA1Df3GL96ZuOryyWvZzch+HnzCh/j8lafGRL/99MiSEtuaTKMLk5CEA
 Nyamcmc/w+hEw6PUVFaFZo+erAp6bSggVEh8+2CBjup2RX5KmH8hHxVkkJqWXXC/1Yom
 jntiJMWh8TWJ01rtJ8ksbQGUhM1tngJO8M45B533FThBhlWIV/Qt5eOZ8yGJ6EvT6kYq
 8Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687876505; x=1690468505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRKoYto0a2xN5SJ+PQkslp9GwnRk/S2p6DoaKuEwdv4=;
 b=lyAX6S6YEkHXSSDqt1UJvBcbyk3+HHUdb38ci0y01Q3f1IGYa9RXBXXXTQZguu5rip
 vVs+UKYYObP442pYsG4jqezACXnCK7wotl6AbemzDGFiIW+cGpionYbfXimE1qk6JSNN
 685Wu2Dsy9Ws6KZmodiSSTeAqT2R8N4C7UvrXqOg7f1xE+1Iwl0A9SRX/zjeAAGkGRMG
 Bgb7h21PmwqokTKw5Hz1mCie/K4fTVhGL3QEtR2/+p8fG5rrttIx5nt2smf+Us5pJub1
 Jg1tliU0m4E835ml8Rgq2vcEkLF+hAW/nfolFIwnyG0/SkoUVqTU35bXR+MuKpjR356C
 51uA==
X-Gm-Message-State: AC+VfDwu1zGoqbLngFQcGnow8wfSXLEPG1Sxt+Xbdofhi1APmr3BxiD+
 JWygJ1q+xK+W1/VzBcBQV7I=
X-Google-Smtp-Source: ACHHUZ4YInG7Kz8yvRdaQZAvhtw9gWur7Qw0wiDKBs6+YLeKWOW8E5GtlbWfxXSF5Ucuz1qa56xkJQ==
X-Received: by 2002:a17:903:24d:b0:1b1:99c9:8ce1 with SMTP id
 j13-20020a170903024d00b001b199c98ce1mr7105231plh.51.1687876504906; 
 Tue, 27 Jun 2023 07:35:04 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001b050df0a93sm6062567plh.93.2023.06.27.07.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 07:35:04 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, yin31149@gmail.com,
 18801353760@163.com
Subject: [PATCH v2] vdpa: Return -EINVAL if device ack is VIRTIO_NET_ERR
Date: Tue, 27 Jun 2023 22:35:01 +0800
Message-Id: <69010e9ebb5e3729aef595ed92840f43e48e53e5.1687875592.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=yin31149@gmail.com; helo=mail-pl1-x635.google.com
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

According to VirtIO standard, "The class, command and
command-specific-data are set by the driver,
and the device sets the ack byte.
There is little it can do except issue a diagnostic
if ack is not VIRTIO_NET_OK."

Therefore, QEMU should stop sending the queued SVQ commands and
cancel the device startup if the device's ack is not VIRTIO_NET_OK.

Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
`*s->status != VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ERR.
As a result, net->nc->info->load() also returns 1, this makes
vhost_net_start_one() incorrectly assume the device state is
successfully loaded by vhost_vdpa_net_load() and return 0, instead of
goto `fail` label to cancel the device startup, as vhost_net_start_one()
only cancels the device startup when net->nc->info->load() returns a
negative value.

This patch fixes this problem by returning -EINVAL when the device's
ack is not VIRTIO_NET_OK.

Fixes: f73c0c43ac ("vdpa: extract vhost_vdpa_net_load_mac from vhost_vdpa_net_load")
Fixes: f64c7cda69 ("vdpa: Add vhost_vdpa_net_load_mq")
Fixes: 0b58d3686a ("vdpa: Add vhost_vdpa_net_load_offloads()")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v2:
 - fix the same bug in vhost_vdpa_net_load_offloads()

v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.com/

 net/vhost-vdpa.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e19ab063fa..6f6a5c6df6 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -646,8 +646,9 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState *s, const VirtIONet *n)
         if (unlikely(dev_written < 0)) {
             return dev_written;
         }
-
-        return *s->status != VIRTIO_NET_OK;
+        if (*s->status != VIRTIO_NET_OK) {
+            return -EINVAL;
+        }
     }
 
     return 0;
@@ -670,8 +671,11 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EINVAL;
+    }
 
-    return *s->status != VIRTIO_NET_OK;
+    return 0;
 }
 
 static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
@@ -708,8 +712,11 @@ static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
     if (unlikely(dev_written < 0)) {
         return dev_written;
     }
+    if (*s->status != VIRTIO_NET_OK) {
+        return -EINVAL;
+    }
 
-    return *s->status != VIRTIO_NET_OK;
+    return 0;
 }
 
 static int vhost_vdpa_net_load(NetClientState *nc)
-- 
2.25.1


