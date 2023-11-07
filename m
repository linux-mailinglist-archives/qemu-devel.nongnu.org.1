Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C4E7E3875
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:11:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0J2j-0001u2-7d; Tue, 07 Nov 2023 05:10:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1j-00019n-S5
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0J1h-0002A8-SJ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699351781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G27Bg2CuZWkA/233UntEih70bv+0jSA10exjx5QF86o=;
 b=IO3gBY4bX3w2mNMIJzCAKVsJHBJvfSNggnPEpLAl3MRg34TlKN9XfhnTGiXaf5Zp+mzi8f
 zP8P626yCS8wFVc8TrOMGJe3TmWQXVA8N/hg/P3AtGIuVFoZGn2vn5DlukMBYzjAKggD3y
 Z7W9Db+O/BdXmpmM5sH02v/RmmmwhSw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-xwj_t_VnMc6fpsC6nj3_mw-1; Tue, 07 Nov 2023 05:09:39 -0500
X-MC-Unique: xwj_t_VnMc6fpsC6nj3_mw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32de9f93148so2913859f8f.2
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351778; x=1699956578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G27Bg2CuZWkA/233UntEih70bv+0jSA10exjx5QF86o=;
 b=WWpHGfOLZD7+ybyP4jfKU6m51jn+YnqnNvVkDuwngmq85IJRMiPpcb9H1eG21yKWqN
 zb8JO9KQtUtpDtmac/8w0Qb8ZrIv1X+HA/AthE3RawmyFrePJMX8acHr8Ka5OLFlKYhA
 Rmx8VOsxOEb9CfjcByGZFqdeAWWTLsCEgNt7uMZKeoPtejJ2w9qqPihMRWyjujHqbz22
 g6amfXpLJ+xCJ+BMRJb286lBhDNvzV0YjfMglrCZX+Xa3KSBKRxdo8D0QmbbmdIxwRuT
 L8/ppUuR5xLmD78AmA4fT99lGjQHmD32xSWXWRLAbWGx8Lbp1+g9olp15zTdWB4a29uz
 94cQ==
X-Gm-Message-State: AOJu0YxcA6i/EOuSGCxRXMwAscfp54+9MOZ3KWBh8bXtB9m53emCv4tr
 JZKOTCtDSc87ajQs5a0KTu2RCWm4ZrlX/3ZWEPhxXOC+tETm6jiSz5t+PrVW2tfArYgKVS4FJni
 bKM2Wcd9rm5f38vLQ9RNYeNCscmaJyV4pyVV0W9PLbmvj5le+3Ri6j+koFce+m7dBrWvQ
X-Received: by 2002:a5d:4147:0:b0:32d:a335:e33d with SMTP id
 c7-20020a5d4147000000b0032da335e33dmr19807291wrq.58.1699351777817; 
 Tue, 07 Nov 2023 02:09:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG18XI6ATGCEJOY9QGFrs2KRvdjD4SN3Q09Rgl/NqZaVEDCz4JmjD/8NLhgFP7agrdtjjYfsQ==
X-Received: by 2002:a5d:4147:0:b0:32d:a335:e33d with SMTP id
 c7-20020a5d4147000000b0032da335e33dmr19807273wrq.58.1699351777307; 
 Tue, 07 Nov 2023 02:09:37 -0800 (PST)
Received: from redhat.com ([2.55.5.143]) by smtp.gmail.com with ESMTPSA id
 x6-20020a5d6506000000b0032d88e370basm1915059wru.34.2023.11.07.02.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:09:36 -0800 (PST)
Date: Tue, 7 Nov 2023 05:09:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 02/63] vhost-user.rst: Clarify enabling/disabling vrings
Message-ID: <eae69cc36b278a3e84bb013909135e138b37855d.1699351720.git.mst@redhat.com>
References: <cover.1699351720.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699351720.git.mst@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Hanna Czenczek <hreitz@redhat.com>

Currently, the vhost-user documentation says that rings are to be
initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
negotiated.  However, by the time of feature negotiation, all rings have
already been initialized, so it is not entirely clear what this means.

At least the vhost-user-backend Rust crate's implementation interpreted
it to mean that whenever this feature is negotiated, all rings are to
put into a disabled state, which means that every SET_FEATURES call
would disable all rings, effectively halting the device.  This is
problematic because the VHOST_F_LOG_ALL feature is also set or cleared
this way, which happens during migration.  Doing so should not halt the
device.

Other implementations have interpreted this to mean that the device is
to be initialized with all rings disabled, and a subsequent SET_FEATURES
call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all of
them.  Here, SET_FEATURES will never disable any ring.

This interpretation does not suffer the problem of unintentionally
halting the device whenever features are set or cleared, so it seems
better and more reasonable.

We can clarify this in the documentation by making it explicit that the
enabled/disabled state is tracked even while the vring is stopped.
Every vring is initialized in a disabled state, and SET_FEATURES without
VHOST_USER_F_PROTOCOL_FEATURES simply becomes one way to enable all
vrings.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Message-Id: <20231016134243.68248-3-hreitz@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/interop/vhost-user.rst | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 9202b167dd..e5a04c04ed 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -411,31 +411,33 @@ negotiation.
 Ring states
 -----------
 
-Rings can be in one of three states:
+Rings have two independent states: started/stopped, and enabled/disabled.
 
-* stopped: the back-end must not process the ring at all.
+* While a ring is stopped, the back-end must not process the ring at
+  all, regardless of whether it is enabled or disabled.  The
+  enabled/disabled state should still be tracked, though, so it can come
+  into effect once the ring is started.
 
-* started but disabled: the back-end must process the ring without
+* started and disabled: The back-end must process the ring without
   causing any side effects.  For example, for a networking device,
   in the disabled state the back-end must not supply any new RX packets,
   but must process and discard any TX packets.
 
-* started and enabled.
+* started and enabled: The back-end must process the ring normally, i.e.
+  process all requests and execute them.
 
-Each ring is initialized in a stopped state.  The back-end must start
-ring upon receiving a kick (that is, detecting that file descriptor is
-readable) on the descriptor specified by ``VHOST_USER_SET_VRING_KICK``
-or receiving the in-band message ``VHOST_USER_VRING_KICK`` if negotiated,
-and stop ring upon receiving ``VHOST_USER_GET_VRING_BASE``.
+Each ring is initialized in a stopped and disabled state.  The back-end
+must start a ring upon receiving a kick (that is, detecting that file
+descriptor is readable) on the descriptor specified by
+``VHOST_USER_SET_VRING_KICK`` or receiving the in-band message
+``VHOST_USER_VRING_KICK`` if negotiated, and stop a ring upon receiving
+``VHOST_USER_GET_VRING_BASE``.
 
 Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
 
-If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
-ring starts directly in the enabled state.
-
-If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring is
-initialized in a disabled state and is enabled by
-``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
+In addition, upon receiving a ``VHOST_USER_SET_FEATURES`` message from
+the front-end without ``VHOST_USER_F_PROTOCOL_FEATURES`` set, the
+back-end must enable all rings immediately.
 
 While processing the rings (whether they are enabled or not), the back-end
 must support changing some configuration aspects on the fly.
-- 
MST


