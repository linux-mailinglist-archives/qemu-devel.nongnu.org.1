Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E22608BF76B
	for <lists+qemu-devel@lfdr.de>; Wed,  8 May 2024 09:46:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4c06-0004A8-32; Wed, 08 May 2024 03:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzW-0003Uo-M8
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzR-0000su-VM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JySjkPtU/07Xae9r5wqBkaPv+VNyRJfG/fS50MPt6jw=;
 b=Y2HAW0I18SNk4cqWGMPw022ANv6lPHFwWp0feBO3FnBB9odnAFbUeyv/4/wgCTdnRc6iDc
 +165ZSibmyfNLpmftc/SZ2m8zZoJYOXuICWqv9eNMIV8QmtbcOpleo0VmHYh0X0zLb0Ueu
 +Caw7jgv+sCP7gOQ6xk3/pxXW7Gnqc0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-tQcDG_GRNbGirr7IPjOuoQ-1; Wed, 08 May 2024 03:45:20 -0400
X-MC-Unique: tQcDG_GRNbGirr7IPjOuoQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a51fdbd06c8so281454266b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154318; x=1715759118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JySjkPtU/07Xae9r5wqBkaPv+VNyRJfG/fS50MPt6jw=;
 b=aRHpcla0T9lVlQfhSmdVdYz//iQCnKSn2FLaLjfkFW6/zMUrjGB2AJe0TBsmY6lJLu
 kFKp0lMTUcfyq/SuNfifVyn8bnikBd2fC/7KsKOuzK8CSMeUcBYk6TyY+6xmheG5ZO2s
 i9TtciGBt/1NpAMgIpNEEHB5BAvEK7q+KcrCN951YSQ0C1D22xBe7xe52C31iAaBJQJz
 SqCmfkjckv9q2AoFVB8vhCcFYgy9/fzwbHN16L3nyIobdogqWMgSgDr/fb6do+lMIp1b
 stGjixtpANwMi/xOWFEh8ufOz4YgjM2zLkCxL80UNh8AIpmm1RbFfbAp3qSNQfeiuHwx
 NiHQ==
X-Gm-Message-State: AOJu0YwA+fIHYK1bsctaEocVT34n7LL4FU255uYzQruGrOw8Q0JXGrGA
 C8klAlnfSwEM+0heoKiTyWEnYPH4sxDZaIKw5v5AQft8aBCyR4vse8eHQkHlgBVZP4CAmdmIKy7
 rOWv5XZcH6sJKAfNm4a5EceqDg3aYuesl2Wrb9TTQxiR+cyBhAAC/oc0E6IU4evHsGWkjPRTogr
 jwtxZ08roQ3jPSWk5biRWY1W+mgx38T/eeANYP
X-Received: by 2002:a17:906:e244:b0:a59:8fae:f5c8 with SMTP id
 a640c23a62f3a-a59fb81a1b5mr98053866b.7.1715154318447; 
 Wed, 08 May 2024 00:45:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+NQidDII/N5W+g/qnrYrrhcSyBuWj66wwaqQXp3y4MDv5PXN3smV31TDaLJBMtnaSq0wr2A==
X-Received: by 2002:a17:906:e244:b0:a59:8fae:f5c8 with SMTP id
 a640c23a62f3a-a59fb81a1b5mr98049566b.7.1715154317993; 
 Wed, 08 May 2024 00:45:17 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 cx10-20020a170906c80a00b00a59fac165dfsm883206ejb.204.2024.05.08.00.45.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:17 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 03/12] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Date: Wed,  8 May 2024 09:44:47 +0200
Message-ID: <20240508074457.12367-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index a11afd1960..1c361ffd51 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1674,6 +1674,16 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+#ifndef MFD_ALLOW_SEALING
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
2.45.0


