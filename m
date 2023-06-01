Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F15719ECD
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 15:50:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4igd-0007SD-Tf; Thu, 01 Jun 2023 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igZ-0007MM-Kh
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:51 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4igX-0000Vb-SL
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 09:49:51 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-25690e009c8so283020a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 06:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627388; x=1688219388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ued2PGntEbVyYE+XZjWv3o98NO0iI/oUAsMZR1ODtOU=;
 b=jpbBdm5NaymKbTXrDOe34bCxP+rLD/wWS1rqnPHVmir6Ziw0Qp+z8BPK6ZTA+BudCw
 pY/Sb4WQOQkgkFj+mxSIGRPe/igtQHN2l7zAkIrqeDfTb/qy3Hc7CF8w6ZCVFHYoJIsQ
 2zdnUBOfTPOqJLBpEbOU63yGVQRIVaHN5hTUlUHrzCXLbEDHpSqGTT/zatsn1TIskGLV
 OcYGY2+X2cooicP97iEuYOlUSKJVu6/SDil4Uwr78O19ItIupFaqRkY0INEnihiu9NWS
 CxjL54aDvrjAwHw5/L7mHgWrU995LYsckHBLnEkx7QSf2EkqxEQqFY3e1i6ggGRqwBtt
 63RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627388; x=1688219388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ued2PGntEbVyYE+XZjWv3o98NO0iI/oUAsMZR1ODtOU=;
 b=KFGaj0YAEo8uXVobztU0SldiYs53j4qvYYpPq6Tdb/f4AChy8A+Ec8zFsrLdOwO3LV
 6ZvGlVpyZN1rPKQmFANqHqgTs3P+o43SEjEXvpn+ALTrprmksLQphMwmCEPKqaEDFqm7
 tgieYtBglcycEHc+FFSpxQ9/5y3Oz8qI49Z/6u89qZdGC6nhhCFbkLRbzAjZyyVIpMo5
 GrHezSv+Hrllk/94tCeKkoJLWPzTU/HhjnG8JHIwxJ9K0tAOyyP21phICS8FWF9ESMY5
 oUIfMwmd0eJN7E/euFGKvP/JECvCRijX1QTCupjb6SwQy3Fg9q7xqgpcxCHGZodjNPM6
 axXA==
X-Gm-Message-State: AC+VfDyAOfrUV0NweHuzeZVv9jwKOqB+y9VKi6ob9Ns7HlXxFPc/zQ0G
 QCJ8zmdOrbVmt+5cG2fI/GK+AflXsgFKg4H7
X-Google-Smtp-Source: ACHHUZ7HYajNynxUxWYDmWKN877OX+iIS9R3KTXDbSqPwOlC3efoEh8B9P43IAdoNKwXkT2FsnkoOQ==
X-Received: by 2002:a17:90b:190:b0:253:87e5:384a with SMTP id
 t16-20020a17090b019000b0025387e5384amr5839884pjs.42.1685627388173; 
 Thu, 01 Jun 2023 06:49:48 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 hf4-20020a17090aff8400b0024e33c69ee5sm1436700pjb.5.2023.06.01.06.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 06:49:47 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH v3 5/6] vdpa: Add vhost_vdpa_net_load_offloads()
Date: Thu,  1 Jun 2023 21:48:24 +0800
Message-Id: <afa2e25ae333dba5867e3d839fba785d5d3508c0.1685623090.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
References: <cover.1685623090.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102c.google.com
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

This patch introduces vhost_vdpa_net_load_offloads() to
restore offloads state at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index e907a3c792..0e647886d1 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -678,6 +678,40 @@ static int vhost_vdpa_net_load_mq(VhostVDPAState *s,
     return *s->status != VIRTIO_NET_OK;
 }
 
+static int vhost_vdpa_net_load_offloads(VhostVDPAState *s,
+                                        const VirtIONet *n)
+{
+    uint64_t offloads;
+    ssize_t dev_written;
+
+    if (!virtio_vdev_has_feature(&n->parent_obj,
+                                 VIRTIO_NET_F_CTRL_GUEST_OFFLOADS)) {
+        return 0;
+    }
+
+    offloads = cpu_to_le64(n->curr_guest_offloads);
+
+    if (offloads == virtio_net_supported_guest_offloads(n)) {
+        /*
+         * According to VirtIO standard, "Upon feature negotiation
+         * corresponding offload gets enabled to preserve
+         * backward compatibility."
+         * So we do not need to send this CVQ command if the guest
+         * also enables all supported offloads.
+         */
+        return 0;
+    }
+
+    dev_written = vhost_vdpa_net_load_cmd(s, VIRTIO_NET_CTRL_GUEST_OFFLOADS,
+                                          VIRTIO_NET_CTRL_GUEST_OFFLOADS_SET,
+                                          &offloads, sizeof(offloads));
+    if (unlikely(dev_written < 0)) {
+        return dev_written;
+    }
+
+    return *s->status != VIRTIO_NET_OK;
+}
+
 static int vhost_vdpa_net_load(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
@@ -700,6 +734,10 @@ static int vhost_vdpa_net_load(NetClientState *nc)
     if (unlikely(r)) {
         return r;
     }
+    r = vhost_vdpa_net_load_offloads(s, n);
+    if (unlikely(r)) {
+        return r;
+    }
 
     return 0;
 }
-- 
2.25.1


