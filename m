Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F692496C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jul 2024 22:38:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjxx-0006OL-VO; Tue, 02 Jul 2024 16:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxT-0005MF-Tn
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxR-0000bk-7c
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QrTyYgO+P/l4LBdE4jQm9EUMOljixFZgw03WGI4si6s=;
 b=EjNHgTOoJgovvjsp/NLt+6+s/3QhNM0KroLhhHqJN+SSbvbk183IT3owJ/H4yek/l/TBQL
 s5lgYqLu4qUrIn8dZYirWt5Kc/+pz0d9R3U7MrUN+tJAufUtjnmXPJ7VVSXmAZlhf1vh5G
 0k11CM97mfpnVNHenkmqC3iomW+T82k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-3FPNjn0-OI6Sz62kkHXeVQ-1; Tue, 02 Jul 2024 16:18:31 -0400
X-MC-Unique: 3FPNjn0-OI6Sz62kkHXeVQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42568f0cc18so32353905e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951510; x=1720556310;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QrTyYgO+P/l4LBdE4jQm9EUMOljixFZgw03WGI4si6s=;
 b=dT0zE5OBi724dGOrjsa9gY7qQ4cDYeUKjKvXOIsCdl3Jhr7oIybKeMPAXdIKTBdzpc
 ukTNa4fAdIQViAzhrCQrxtfjIGYLF48tSn7ZUHJQklo9AJ+amtWnA6iqYCePcKbH3ZLr
 ci2+wun0O/K2DEJZ2F61uOkkH7N7dr6awY7kadSaj9dNqlNHH6L1MtGOZ3wfl8eAYVKp
 PI3BR0lRSGCbtq3iCru1BtZ0lFVw3zTi9T/Ib/xinUox+e6fU+61WYvnEXdFAd7mT5Ka
 qeN4w1wL/FkESkmP73SDWJfrLcKiv2oDVVrtJbzSz1YtJNkljK50wVabErCTOuh7/kfk
 zJww==
X-Gm-Message-State: AOJu0Yz2uKNBQGhRoRDIzkLwMWyqqIUaj5dz5Uq1D44gonULpqMwUyJM
 DTkiz4zbIavJZxp7KmAKyswxTEz6+295CAaFS+ygGVOakWZjlDu7H1/fKKNQdZgbQb4pUANlsKU
 1j323Z2UJg3OwEQ7HnIlRWF/m0m5IH1Dck0qj1VDskSfc4Ra9O0NtAUucdo0NLFB/na/+XmzTLk
 DgaZhh4RMK/6wK1EH9tm0xQwJ41Vi1PQ==
X-Received: by 2002:a05:600c:2e09:b0:424:acab:b84a with SMTP id
 5b1f17b1804b1-4257a0348c9mr59084525e9.38.1719951509798; 
 Tue, 02 Jul 2024 13:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFcusRkEeWOutYCdGSKbobfYGWvWy8OISFqby7+2gQ7zMwI7FV5RtmvktMwUgYLua5QeRQ8A==
X-Received: by 2002:a05:600c:2e09:b0:424:acab:b84a with SMTP id
 5b1f17b1804b1-4257a0348c9mr59084165e9.38.1719951508841; 
 Tue, 02 Jul 2024 13:18:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257c4e10d6sm138940045e9.30.2024.07.02.13.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:28 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PULL v2 49/88] libvhost-user: mask F_INFLIGHT_SHMFD if memfd is not
 supported
Message-ID: <ebdede644bbf5744f91dbe0d39742f17b03c4e10.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

libvhost-user will panic when receiving VHOST_USER_GET_INFLIGHT_FD
message if MFD_ALLOW_SEALING is not defined, since it's not able
to create a memfd.

VHOST_USER_GET_INFLIGHT_FD is used only if
VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD is negotiated. So, let's mask
that feature if the backend is not able to properly handle these
messages.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100043.144657-5-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index ea27683dac..9c630c2170 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -1674,6 +1674,17 @@ vu_get_protocol_features_exec(VuDev *dev, VhostUserMsg *vmsg)
         features |= dev->iface->get_protocol_features(dev);
     }
 
+#ifndef MFD_ALLOW_SEALING
+    /*
+     * If MFD_ALLOW_SEALING is not defined, we are not able to handle
+     * VHOST_USER_GET_INFLIGHT_FD messages, since we can't create a memfd.
+     * Those messages are used only if VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD
+     * is negotiated. A device implementation can enable it, so let's mask
+     * it to avoid a runtime panic.
+     */
+    features &= ~(1ULL << VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD);
+#endif
+
     vmsg_set_reply_u64(vmsg, features);
     return true;
 }
-- 
MST


