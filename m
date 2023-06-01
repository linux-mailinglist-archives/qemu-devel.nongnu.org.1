Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFAF7195FF
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dzQ-0002Id-Fl; Thu, 01 Jun 2023 04:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzK-00027p-HU
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:54 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1q4dzI-0006Ht-U7
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:48:54 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-256e1d87998so396537a91.3
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 01:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685609331; x=1688201331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SJGeDeGczfa76jgBf9PpER+RGPnyoyqgrid4pktCwr0=;
 b=IhPpzNH3wfOeOYgenT2JqejnrQF/kJjaBY9nSdCxFMogBxBoV82ySyPcICTx5VqBPg
 n8BCECrKYufENJFovaDNWmrDylsJOn7PxOP3Fd24R3BYJPmzcKrCyJjXeK4Ie4Ch+OGf
 wC2IMrlALblaFusCRxTQlX+TvaDjUAx90JJruMqcPv8jNMpVBFPNsO3ol+qYsLYA9mJ0
 E6XEhzNGejNKygTD0X1hNA9ztwXkr1v+MjDvr6v96ttTaefpzDe9CResNpYMHQK+XpGJ
 VNYski0151C4Fw2SmON32/3uYDH0s6FepYLwNrNZKeeMXlsRYWg3eVPARb9czx7fvlLG
 PG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685609331; x=1688201331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SJGeDeGczfa76jgBf9PpER+RGPnyoyqgrid4pktCwr0=;
 b=N6or2qKEUhQ5blNnqLEhElDCn7sBvUexDBPap441JPr0WsFxCDsyES3ONvNQnxgH9/
 xYyc9WU8If+j8yHh/0Qiesu2GwkuqvNmasNGhRsXNgIN7s04amjvrYEl3iY+EaBN9e3b
 X22d8EWBQWXiOAEOEyjXPw3yVP1xTlmngbnWL5P+YjOxMDNjsJ4nX9EEQUcfJtk07+tJ
 LxV2AxniF1QsvxXrbzAJTdRNoVKrU6FnG2o/gDFrxw1/BAGqS+t898xueS9sucLuAuAy
 o8I0NI7W99JE3yRt5sHPZVgYe0zlsl5Bsd07m7l7oTfmMkUKD302tPwvPlYORczn22Fv
 cv1Q==
X-Gm-Message-State: AC+VfDw5J6kj07Vkp9Xmfsav+wjwvX/4ws9LT3ySynm3rOEoTLdBvQAL
 VhPW2LjBeq4qcHMBtGVHovHZpE2z5GHkFM+5VUM=
X-Google-Smtp-Source: ACHHUZ4XiEPKhhpkgetie8AKTYEjV6t0A+aNOK5iUVzKhLcnU7j210SEHdX5VoN/J9oGhHiYQ10CEg==
X-Received: by 2002:a17:903:2641:b0:1ae:43a8:2759 with SMTP id
 je1-20020a170903264100b001ae43a82759mr7959164plb.58.1685609331234; 
 Thu, 01 Jun 2023 01:48:51 -0700 (PDT)
Received: from localhost ([117.136.38.170]) by smtp.gmail.com with ESMTPSA id
 jd21-20020a170903261500b001b045c9abd2sm2840856plb.143.2023.06.01.01.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 01:48:50 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org,
	yin31149@gmail.com
Subject: [PATCH v2 4/6] virtio-net: expose
 virtio_net_supported_guest_offloads()
Date: Thu,  1 Jun 2023 16:48:18 +0800
Message-Id: <39fddc462ad4c7619843a4cd7cba92e0bbc48c45.1685584543.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685584543.git.yin31149@gmail.com>
References: <cover.1685584543.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=yin31149@gmail.com; helo=mail-pj1-x102b.google.com
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

To support restoring offloads state in vdpa, need to expose
the function virtio_net_supported_guest_offloads(), then vdpa
uses this function to get the guest supported offloads.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 hw/net/virtio-net.c            | 2 +-
 include/hw/virtio/virtio-net.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7b27dad6c4..7e8897a8bc 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -874,7 +874,7 @@ static uint64_t virtio_net_guest_offloads_by_features(uint32_t features)
     return guest_offloads_mask & features;
 }
 
-static inline uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
+uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     return virtio_net_guest_offloads_by_features(vdev->guest_features);
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index ef234ffe7e..5f5dcb4572 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -227,5 +227,6 @@ size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
                                   unsigned out_num);
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
                                    const char *type);
+uint64_t virtio_net_supported_guest_offloads(const VirtIONet *n);
 
 #endif
-- 
2.25.1


