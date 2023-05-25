Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5AE711A1B
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 00:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2JJs-000258-3X; Thu, 25 May 2023 18:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Jt9vZAgKCs0Ct4D5utDz77z4x.v759x5D-wxEx4676z6D.7Az@flex--talumbau.bounces.google.com>)
 id 1q2JJp-00024b-K5
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:25 -0400
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Jt9vZAgKCs0Ct4D5utDz77z4x.v759x5D-wxEx4676z6D.7Az@flex--talumbau.bounces.google.com>)
 id 1q2JJn-0004QV-SO
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:25 -0400
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5659a7d4c38so4626317b3.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685053222; x=1687645222;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Dv9d85KFKaQHX4RsIMVaW+2xqVbQVw6mV3FxWbA0cOI=;
 b=4VAvlwLwju1iK8+pH/BjOZVytzAUejA/Y7wzk8/SqP1YvIRTE1J4SIU3Z1741/by0/
 Uch/dGmtH3Lqu6mlPl5wmldvu2UHdkahzh+cbBSyOV/twy6bOHlU59JFxEpm63bPXfWr
 oZuO13139A/zw+GMBHAZ50XSrzPAyq+bdJnOZ41urgvUcU8bloGxxN8R0Oz5noxWbebn
 dNWWeJXcy/GGtzypHBEkcM29ZXmV8kEyHhwrHCswwQDygSvxsQrDvnX36EVJHRz7PMFR
 0XJpYY5qoLTrWEbD5NhPf1W+aII5TpqZIQDFQGlHuRC6Z5+SN7XiN9kQ0/F8n+w09v82
 yAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685053222; x=1687645222;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dv9d85KFKaQHX4RsIMVaW+2xqVbQVw6mV3FxWbA0cOI=;
 b=caM5sI63B/8NqHWYkr5RCJF/rD9ibSI5rnT86QBKa6l2gnB4XGluJTC/mAROMcbdGn
 /rW3h8gQVQvmgX3rHKlXxjBAvHMctWqIi66ccY4FbluHsTeGwMTEYkfxQ/XrzAbtrYj2
 Z3TeqvovT441AzT6vgc/6OxFXoHzmbOiqNnATvLGTI+R9vzIjWTKjqM0IRZqZ+0xJ8Ar
 5HXawEqMYjpmBQpj8kitqFFb+WR1Ps4e5IKpZ9M8Fi51RwSpwd1K1cFLLoCstnNPZESL
 RhfTEZPb9MJYKOYs+gmq53ruyWUHwvQaulOegSIU2t/QxNABitIu441D32Rt7rxAmqaj
 b5jA==
X-Gm-Message-State: AC+VfDyOvrNZ4Fifi4T0msrNMM/JV4pfPf7/g23tAdNB3Hw8R1tAXe/1
 3ukd2ysaH9632obGwOrVOTHWMc+otHbZ54SdNKyl7PiWSSEOPWMz7q2R+ztv2T2slVIgoZDcTqw
 6ERKCgQAmOfMwSAhsXrx0skXuL3WSMFlBUP3jG2vinoUW+4kIBXeEGhMfWNu+ju6sOQ==
X-Google-Smtp-Source: ACHHUZ5xQOY1D/rxFcpqnJbIaXfAtG2/DP2sd0Ssl5UCe77ZCGfu12X4Dg2cZ9ER8kYUcQbc4ORlwqhkJ8TZKQ==
X-Received: from talumbau.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a81:b615:0:b0:565:ab37:33a1 with SMTP id
 u21-20020a81b615000000b00565ab3733a1mr8100ywh.3.1685053222001; Thu, 25 May
 2023 15:20:22 -0700 (PDT)
Date: Thu, 25 May 2023 22:20:12 +0000
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230525222016.35333-1-talumbau@google.com>
Message-ID: <20230525222016.35333-2-talumbau@google.com>
Subject: [RFC PATCH v2 1/5] virtio-balloon: Add Working Set Reporting feature
From: "T.J. Alumbaugh" <talumbau@google.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Yuanchu Xie <yuanchu@google.com>, 
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eric Blake <eblake@redhat.com>, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3Jt9vZAgKCs0Ct4D5utDz77z4x.v759x5D-wxEx4676z6D.7Az@flex--talumbau.bounces.google.com;
 helo=mail-yw1-x114a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Balloon header includes:
 - feature bit for Working Set Reporting
 - number of Working Set bins member in balloon config
 - types for communicating Working Set information

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 .../standard-headers/linux/virtio_balloon.h   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
index f343bfefd8..df61eaceee 100644
--- a/include/standard-headers/linux/virtio_balloon.h
+++ b/include/standard-headers/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_WS_REPORTING	6 /* Working set report virtqueues */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12
@@ -59,6 +60,9 @@ struct virtio_balloon_config {
 	};
 	/* Stores PAGE_POISON if page poisoning is in use */
 	uint32_t poison_val;
+	/* Stores the number of histogram bins if WS reporting in use */
+	uint8_t working_set_num_bins;
+	uint8_t padding[3];
 };
 
 #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
@@ -116,4 +120,20 @@ struct virtio_balloon_stat {
 	__virtio64 val;
 } QEMU_PACKED;
 
+enum virtio_balloon_working_set_op {
+    VIRTIO_BALLOON_WS_REQUEST = 1, /* a Working Set request from the host */
+    VIRTIO_BALLOON_WS_CONFIG = 2,  /* a Working Set config from the host */
+};
+
+struct virtio_balloon_working_set {
+	/* A tag for additional metadata */
+	__virtio16 tag;
+	/* The NUMA node for this report. */
+	__virtio16 node_id;
+	uint8_t reserved[4];
+	__virtio64 idle_age_ms;
+	/* A bin each for anonymous and file-backed memory. */
+	__virtio64 memory_size_bytes[2];
+} QEMU_PACKED;
+
 #endif /* _LINUX_VIRTIO_BALLOON_H */
-- 
2.41.0.rc0.172.g3f132b7071-goog


