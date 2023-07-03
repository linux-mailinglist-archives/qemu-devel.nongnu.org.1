Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCCA87455B1
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 09:01:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGDYT-00079l-29; Mon, 03 Jul 2023 03:01:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGDYH-00079A-HS
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:00:56 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qGDYE-0007Gw-Go
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 03:00:49 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-1b0605d4d11so3417440fac.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 00:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688367645; x=1690959645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/z6RpcImb1+2EgwzyD3jgXXi1S5FfTucd+yIKYsBng=;
 b=UpQhWiPA5PFkBzl64jmhvcYc8QuKVguY0odijNr1XXLYWCwlt/T7CSfyf5EGtQezlm
 8fTvJTEej4oq9HUJziT04nueALuVJq6C2Uqf8J3kHncaTLmPiuHhsOEcuHXTrd+WoXvi
 vvPncqC7Vt2kdPHbtPg4owXHl7wKj0xiw9Ql/Few76xctAI98PfNvwNfIN4VugwzxGBv
 TO/TCQ3UKOt+WplnP9vaeMOGVnrTRH6qE/mNTxjAhELy2cTqLOwWn5170eCVNAIBQdvR
 R8qgmJ+c/7oYom9P36R0U3qPX4ij5eYTa+hmFMrpBS4NvhfsJYNxPDal5kEs0K/EN2HV
 4VkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688367645; x=1690959645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/z6RpcImb1+2EgwzyD3jgXXi1S5FfTucd+yIKYsBng=;
 b=avFwuGJsh+718gaEtsvjiIiQB7N46N0jGDjkUVHw5KTMvQklu5h4yfm2FUJALQDZAD
 tTnzcLorC98aiWF9RLUZeqweRYhSdQDieNW0COMd2l3TETRQJhbQhVEQ96TrUkt7JKpQ
 qROWysCDBe3ExKi+8qHyL+StvYJ8nXqO/eaNeIex+Rs/610ykahN/Jz5Afpi390qK+dX
 lmmjmWcJ9eafEB9PJ9mRJWaSIpP2MOircLwnuWZvDMBAnbZJodcNlcSc4E86kPPRjG9Y
 XnAtACnjoRCewNRAcw9fC9AOR/Kpp75IEeWWeyMUE8xU1Go7z98ywHkw/R6tMuKBO8SN
 kASg==
X-Gm-Message-State: AC+VfDyLDEWQTU3C27RJa+wdxZLZG8e7IKUyLmhsod8Z81we8/RgpHQv
 8zH1i8PiMBEEs2D8K8SNdtk=
X-Google-Smtp-Source: ACHHUZ45y/hASFeJwQDhIdFEs7v5WYkkFTjMg961WEQE1FnvUpJ+105kKxRi8tdSNdfmOGaid2uTog==
X-Received: by 2002:a05:6870:fba9:b0:1a6:5403:eaae with SMTP id
 kv41-20020a056870fba900b001a65403eaaemr11159703oab.5.1688367644999; 
 Mon, 03 Jul 2023 00:00:44 -0700 (PDT)
Received: from localhost ([159.226.94.115]) by smtp.gmail.com with ESMTPSA id
 sk15-20020a17090b2dcf00b0025eb5aafd3csm14548932pjb.32.2023.07.03.00.00.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 00:00:44 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com,
	18801353760@163.com
Subject: [PATCH RFC v2 1/2] vdpa: Restore packet receive filtering state
 relative with _F_CTRL_RX_EXTRA feature
Date: Mon,  3 Jul 2023 14:59:52 +0800
Message-Id: <66ec4d7e3a680de645043d0331ab65940154f2b8.1688365324.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688365324.git.yin31149@gmail.com>
References: <cover.1688365324.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=yin31149@gmail.com; helo=mail-oa1-x31.google.com
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

This patch refactors vhost_vdpa_net_load_rx() to
restore the packet receive filtering state in relation to
VIRTIO_NET_F_CTRL_RX_EXTRA feature at device's startup.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
v2:
  - avoid sending CVQ command in default state suggested by Eugenio

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg04957.html

 net/vhost-vdpa.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 0410a52043..4919e18208 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -890,6 +890,88 @@ static int vhost_vdpa_net_load_rx(VhostVDPAState *s,
         }
     }
 
+    if (virtio_vdev_has_feature(&n->parent_obj, VIRTIO_NET_F_CTRL_RX_EXTRA)) {
+        /* Load the all-unicast mode */
+        on = n->alluni;
+        if (on != 0) {
+            /*
+             * According to virtio_net_reset(), device turns all-unicast mode
+             * off by default.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets all-unicast mode off, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_ALLUNI, on);
+            if (r < 0) {
+                return r;
+            }
+        }
+
+        /* Load the non-multicast mode */
+        on = n->nomulti;
+        if (on != 0) {
+            /*
+             * According to virtio_net_reset(), device turns non-multicast mode
+             * off by default.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets non-multicast mode off, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOMULTI, on);
+            if (r < 0) {
+                return r;
+            }
+        }
+
+        /* Load the non-unicast mode */
+        on = n->nouni;
+        if (on != 0) {
+            /*
+             * According to virtio_net_reset(), device turns non-unicast mode
+             * off by default.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets non-unicast mode off, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOUNI, on);
+            if (r < 0) {
+                return r;
+            }
+        }
+
+        /* Load the non-broadcast mode */
+        on = n->nobcast;
+        if (on != 0) {
+            /*
+             * According to virtio_net_reset(), device turns non-broadcast mode
+             * off by default.
+             *
+             * Therefore, there is no need to send this CVQ command if the
+             * driver also sets non-broadcast mode off, which aligns with
+             * the device's defaults.
+             *
+             * Note that the device's defaults can mismatch the driver's
+             * configuration only at live migration.
+             */
+            r = vhost_vdpa_net_load_rx_mode(s, VIRTIO_NET_CTRL_RX_NOBCAST, on);
+            if (r < 0) {
+                return r;
+            }
+        }
+    }
+
     return 0;
 }
 
-- 
2.25.1


