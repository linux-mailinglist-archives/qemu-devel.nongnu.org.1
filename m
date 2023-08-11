Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A96B77924D
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 16:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTb7-0001te-A4; Fri, 11 Aug 2023 10:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUTb5-0001tW-G0
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:58:39 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yin31149@gmail.com>)
 id 1qUTb3-0003tp-Uw
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 10:58:39 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686ba97e4feso1896755b3a.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 07:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691765917; x=1692370717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ig4bGUXjVQxVRXkXE363PNmEeuHWoH0Y7Ce9MWEJKZE=;
 b=cTTfpn/al8hdjO00skWS0jG1eGvAgsSd3TGr2r/88txvKHGfqTNaSYXyRM2A15+DTT
 XEeRL06xDidHtfufwatpB0FAaQGVSvvZaIR1TeeVJMAUoEcNRf1E8L5xXsw6gVSwhmcm
 BSjq4KQLt63iRQM4Jw9jGGKtWTd70oxwrDcNw9T2i1Qt2DeiJUP4XvfBbvKEGaV3uxR3
 T6M36N+nEO5HT6nQJbus/l1+fr0EkMNYx4WIQLjFT6wswX7YJlrAeDIyMNMUY1MRbDkr
 +rlZq18yOnX90uvPPNydp0aj6JcSk5vBTZnS/QUjfy5d7BASxHl6O9aMzsc6JEafE9N7
 e1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691765917; x=1692370717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ig4bGUXjVQxVRXkXE363PNmEeuHWoH0Y7Ce9MWEJKZE=;
 b=gr1f3SwW7ERlInKFHRaDZ4dMmE2LqFwetGaaVD4wvcB4GjNvSnxMD4tzjbJDVY3xWa
 FPGrQT4lX6knwqIN0gtyLuRoMiQKzSTKBb9TlDxD7xXmfRrLY3DBpRZIPA7H5GYFWEoP
 OSMOvm18KvYoQ3czxrlXWKJzEdPTpUUsObJ0GjambjawIXPN8RZ+nT0HlgNlSb5KSrXU
 CQn9vfPkwGKpZs8mKIoDFGaaL/pON2M4q+aLveulJLCcROXuQDrnnE4eJU8zZlNle7nH
 admkh1f1f0R5yUUbYIcwD5rg7z5PqCYPxqUt6+haEItwIlmTl0ZHbyXfs/r+pm9Kyeja
 pMQA==
X-Gm-Message-State: AOJu0YzUvmUfb8QjDwaQVxVS4a5cKvPxMVTPOZ9U0aDp9XXryclV5Q6C
 SPZv1FHcv4pctaCIBo8ZjC8=
X-Google-Smtp-Source: AGHT+IG1gdiDOQ4N4lMfZ7gj8+RhfI/nW4ICWdCpuja/BPi6DpFIuEZ/tA0LylYy7wpa/arpUOJXnw==
X-Received: by 2002:a05:6a00:a0c:b0:64c:4f2f:a235 with SMTP id
 p12-20020a056a000a0c00b0064c4f2fa235mr2504094pfh.30.1691765916313; 
 Fri, 11 Aug 2023 07:58:36 -0700 (PDT)
Received: from localhost ([183.242.254.166]) by smtp.gmail.com with ESMTPSA id
 c4-20020a63ea04000000b0055c178a8df1sm3430243pgi.94.2023.08.11.07.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 07:58:35 -0700 (PDT)
From: Hawkins Jiawei <yin31149@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com,
	eperezma@redhat.com
Cc: qemu-devel@nongnu.org, yin31149@gmail.com, 18801353760@163.com,
 yuri.benditovich@daynix.com
Subject: [RFC PATCH 2/2] vdpa: Allow VIRTIO_NET_F_HASH_REPORT in SVQ
Date: Fri, 11 Aug 2023 22:58:28 +0800
Message-Id: <f19fadf2d5e75410df9ce12d996357d4b95db047.1691762906.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691762906.git.yin31149@gmail.com>
References: <cover.1691762906.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=yin31149@gmail.com; helo=mail-pf1-x434.google.com
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

Enable SVQ with VIRTIO_NET_F_HASH_REPORT feature.

Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 net/vhost-vdpa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index bd51020771..a13b267250 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -118,6 +118,7 @@ static const uint64_t vdpa_svq_device_features =
     BIT_ULL(VIRTIO_NET_F_CTRL_MAC_ADDR) |
     /* VHOST_F_LOG_ALL is exposed by SVQ */
     BIT_ULL(VHOST_F_LOG_ALL) |
+    BIT_ULL(VIRTIO_NET_F_HASH_REPORT) |
     BIT_ULL(VIRTIO_NET_F_RSC_EXT) |
     BIT_ULL(VIRTIO_NET_F_STANDBY) |
     BIT_ULL(VIRTIO_NET_F_SPEED_DUPLEX);
-- 
2.25.1


