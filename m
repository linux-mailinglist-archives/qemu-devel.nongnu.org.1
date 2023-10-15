Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A387C9957
	for <lists+qemu-devel@lfdr.de>; Sun, 15 Oct 2023 16:07:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs1iq-000219-Bn; Sun, 15 Oct 2023 10:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1io-000205-49
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:58 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qs1il-0007n0-N2
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 10:03:56 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1ca74e77aecso1343715ad.1
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1697378634; x=1697983434;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ty1IxybyhWNHXp/JE5BsEZCNvT/kUKSyTE1Sr2v4muQ=;
 b=rRSb99Ypr8cMHdJVlbTa+HDuHkRT9fbwz6bWY+41xyxRLne6IRynK110yDjWwIFk2W
 8hSCAx2yBZoYe9SGccmzJ8V0g8itlDxFk5QW2kWUUl0PI/znZb01H/XZmwof5J7Lf4w4
 cOnDkQs0uJEQvghz7SAVni3TMQgePBQHAlMDlYDjQNg+v1XUgPB7im8CgomA3U7YXZhg
 77V0Eor7GUjDP11WygsFqUPolxisHyrFgE1G9zAwUJ3JgF4ZpwpDxxQsBjGmIHDDIR5j
 +i0a7X9KEEFmD+zoxCHoBYp1nsfide1ITAzNsaV/K5JTkB8W7DOLZtBsZi2Bk00Gglpp
 OOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697378634; x=1697983434;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ty1IxybyhWNHXp/JE5BsEZCNvT/kUKSyTE1Sr2v4muQ=;
 b=EzvXO8tXcLEMgpAj8IDBOoi3BTDk4XEmiQFDH2ZbIXsGFKprBGUh5TYoj0mIQzxgEi
 0P38BeVdATW7HAMQis7xU/n7ClF/QbAI3ob+1ZHhO+cqteQmjF92niJrgyU0BzgVkBuN
 26cubL8MXftgSmuWEqHlrlKm0GGo3kpX2e092trdNa8LEtcWeV2JZJlq3+071qtFcyf2
 28xO5cAcdysZqd+HX26T0JhJkMHcnCTAnqqbJhcA32HFta+ZNNgrC8tu/0TQvJQuWMvC
 HE+aV0rHSsIum0s93ujnF9NKmSviu7njUpl/3IIHZNxz8OUSvy+86ZFZQzNDs4CCUEj0
 Fg8g==
X-Gm-Message-State: AOJu0Yzhz/ZBhaJatYF/gg8LKRbIq9W9WhQXOipG42kiyLDWv6qwl4Ec
 BNutTU12T6Mev/TAB84TsnPpjj7yx4LtDK5Vaz1yyg==
X-Google-Smtp-Source: AGHT+IH7UcA89vkI0eYcWAWIzaEf6JUFJYWk5jTDRY5IE1e/5DqSrOB9vxa9wBb7Fusncb4Yto+exg==
X-Received: by 2002:a17:903:22c6:b0:1c5:9d00:be84 with SMTP id
 y6-20020a17090322c600b001c59d00be84mr7481296plg.33.1697378634241; 
 Sun, 15 Oct 2023 07:03:54 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 s7-20020a170902ea0700b001b9c5e07bc3sm6832602plg.238.2023.10.15.07.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 07:03:53 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 13/20] virtio-net: Do not clear VIRTIO_NET_F_RSS
Date: Sun, 15 Oct 2023 23:02:45 +0900
Message-ID: <20231015140259.259434-14-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231015140259.259434-1-akihiko.odaki@daynix.com>
References: <20231015140259.259434-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
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

Even if eBPF is not available, virtio-net can perform RSS on the
user-space if vhost is disabled although such a configuration results in
a warning. If vhost is enabled, the configuration will be rejected when
realizing the device. Therefore, VIRTIO_NET_F_RSS should not be cleared
even if eBPF is not loaded.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/net/virtio-net.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 6eb206f297..20df40442d 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -776,9 +776,6 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    if (!ebpf_rss_is_loaded(&n->ebpf_rss)) {
-        virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    }
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
-- 
2.42.0


