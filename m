Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A585B7DB2BB
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 06:17:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxKcN-0002JQ-Ep; Mon, 30 Oct 2023 01:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcJ-0002Fq-9c
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:12 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxKcF-0001tT-92
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 01:15:09 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc58219376so747145ad.1
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 22:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698642904; x=1699247704;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i0s5ogiHyPJYbyi6vNgHDA+W42ocPKN8ApgLgHmHQU4=;
 b=usmj+gBfYanYOUrM1z0sv2aIGkSGLA7K+cvvF8FSJjrF3xORsufZatl44BUea66Tgm
 o4VWx7Gb8j8nrZRE/FdRN2OnPWMR0BFIUMaL3HzPkcXaexOgg4krErFWnfZz75VMxq59
 Y6TaEzMeSLlT+CxGbiIq7Pu6+BbmFo7aqOT021QCZca6cF+rV+9TeINKUxY2Yr4z2x4r
 LZygLcssWO7zKs080DIK/dzcCtItq3g0aGMe8Aqzxy+5RafVzuof2xOABMggX985cHJ0
 IVjcVfke+UaYs7IEzmiuwGJcmbCGh4zUbhBbWNg33g8lpKB+J15AJEkDi81RdHUjKNzP
 0lwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698642904; x=1699247704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i0s5ogiHyPJYbyi6vNgHDA+W42ocPKN8ApgLgHmHQU4=;
 b=Xnxl45SD8SmvpWtPLEZH6fdFMSugWO9JCLreE+Dlepj8HNlLDA+KCmXuC4iXsXw/t9
 W6LRAQ+945MXhc7aflI9NCOi/EMrZ9suizRxYLmO5ednuxOtjZGz6S56ZigKKux34gM7
 SnT9rkwHCrgq+xoId5DSaOIux9UWuvj5G3EUNoaPj7mCji8pwRMU341/Vjf4WlKG7K4e
 cWjE+KyNXH3LgwobQgQLjqVXjPYhYfn0fWOWRhzFy/PDYcMcbSD9dpZxLUQwKB3qcgiY
 ROpb0QfJRlmKt8sluFXzSAhq2MQWLqHt0T/6wv2kkl+L3464p9Q9qaq5KJ96QoN0dELa
 fziA==
X-Gm-Message-State: AOJu0YzNIfWjgzy1893vkoIbBt6V7SeSbVCWscaU2E4WxFlEkH8ettsF
 ZbDZ824l0qGPq0knzDiOz0Sk9D+oiOqMhWOQUjIiMw==
X-Google-Smtp-Source: AGHT+IFWJKAAYvNS9mkyWaRMTz7yhCG02DBQ05DjKK0mFHUAX+o7nt45K8wqQYsSvc6oGzLmjOCBsg==
X-Received: by 2002:a17:902:fa87:b0:1cc:3773:3d7f with SMTP id
 lc7-20020a170902fa8700b001cc37733d7fmr3486409plb.21.1698642904742; 
 Sun, 29 Oct 2023 22:15:04 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 ji12-20020a170903324c00b001c9b35287aesm5401990plb.88.2023.10.29.22.15.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 22:15:04 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 15/21] virtio-net: Do not clear VIRTIO_NET_F_HASH_REPORT
Date: Mon, 30 Oct 2023 14:12:36 +0900
Message-ID: <20231030051356.33123-16-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231030051356.33123-1-akihiko.odaki@daynix.com>
References: <20231030051356.33123-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::635;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

virtio-net can report hash values even if the peer does not have a
virtio-net header.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e30105884c..bdb4579f98 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -774,8 +774,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_HOST_USO);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO4);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_USO6);
-
-        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
-- 
2.42.0


