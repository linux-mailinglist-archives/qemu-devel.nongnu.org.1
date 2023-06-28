Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B47EA74103A
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETYP-0006QU-5A; Wed, 28 Jun 2023 07:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETYM-0006Po-G4
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETYK-0000bq-Qy
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687952500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2fTK9GwBDg4mE+sgETpJKJTdC5LWsXGre4VDShxla8I=;
 b=SyqXUovMc86770N3+HBksjswQP/lNSy73XppisRBbUA56CbKpnUpFg+ifohOyczMhnHT/c
 DeAuDlWWJA01DTo9sTp25F+N9IOMoN02M9XnZyXTGVeGveAOd7TjqD9e4QwL1PEqGqa6On
 0zuLXXe1amgO+ovpj+acHQOBzPnixxk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-_YcKtDJFNFG2tTH480aVCA-1; Wed, 28 Jun 2023 07:41:39 -0400
X-MC-Unique: _YcKtDJFNFG2tTH480aVCA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f9b003507bso28640745e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687952497; x=1690544497;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2fTK9GwBDg4mE+sgETpJKJTdC5LWsXGre4VDShxla8I=;
 b=NI6N4z1pm6mRpsRMXYwiVdPhiyE7UUnMppuLBPABqClck3avKfYSC7ZitmDL/RsZbK
 Yxb7xiItdyjHuSjL76NbOi0efUoAe0Culz9FjHngRYg8IgYUUBWXIXKG8jWjVB9nF/Hl
 E/ub94UQQndLpTUkvKFjs6p3fg5xuoXjxa8CHcd6cJLJT6lDDsAih6jeVC496wTb3qaf
 WAoSa6uRycBhQ5kTtIUqSWRTsYDdFO5D0v2bwfx3Q9a4gQLoFitBzuuo/Voznjp/j1L5
 yh+Yo4QR7W61aIpugnZtw4XafY+35FB9EurZcGjvnAIBXLH6ZWebCdkGx8tsnDk7Chsf
 Ib0w==
X-Gm-Message-State: AC+VfDxo0PNehwKC/b+llkmRFsbgwDb+5rrGPX3iau23mvQE2s6GGSZX
 tLRz5sdQ6eAzVdtmnvYFO9hAVFqt+Bxlbj/apfk4nluHF4UhqFYegVLULn4f3nNjFtqHOiSDGf2
 7CC7lgElmrWBqkRlYSSYFGpz+SYxb0f6E0ia0ZBPYeVPbubAR1UxvjwS3SBk1NP3x6Lbo5ag=
X-Received: by 2002:a05:600c:215a:b0:3fb:b34f:6cd4 with SMTP id
 v26-20020a05600c215a00b003fbb34f6cd4mr833522wml.36.1687952497407; 
 Wed, 28 Jun 2023 04:41:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4oMhqTC8XubzXynwekukMgz2sP/q1ISLRytryN92AByIJUelUaAwqeJYvPF5Z4e+uC3VEP5Q==
X-Received: by 2002:a05:600c:215a:b0:3fb:b34f:6cd4 with SMTP id
 v26-20020a05600c215a00b003fbb34f6cd4mr833502wml.36.1687952497035; 
 Wed, 28 Jun 2023 04:41:37 -0700 (PDT)
Received: from redhat.com ([176.12.183.225]) by smtp.gmail.com with ESMTPSA id
 er8-20020a05600c84c800b003f7f475c3bcsm5742508wmb.1.2023.06.28.04.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 04:41:36 -0700 (PDT)
Date: Wed, 28 Jun 2023 07:41:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 1/1] net/vhost-net: do not assert on null pointer return from
 tap_get_vhost_net()
Message-ID: <0585e97f070014265e5ec3b28d27dcb963cde25b.1687952477.git.mst@redhat.com>
References: <cover.1687952477.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1687952477.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Ani Sinha <anisinha@redhat.com>

When 'vhost=off' or no vhost specific options at all are passed for the tap
net-device backend, tap_get_vhost_net() can return NULL. The function
net_init_tap_one() does not call vhost_net_init() on such cases and therefore
vhost_net pointer within the tap device state structure remains NULL. Hence,
assertion here on a NULL pointer return from tap_get_vhost_net() would not be
correct. Remove it and fix the crash generated by qemu upon initialization in
the following call chain :

qdev_realize() -> pci_qdev_realize() -> virtio_device_realize() ->
virtio_bus_device_plugged() -> virtio_net_get_features() -> get_vhost_net()

Fixes: 0e994668d00c9c ("vhost_net: add an assertion for TAP client backends")
Reported-by: Cédric Le Goater <clg@redhat.com>
Report: <abab7a71-216d-b103-fa47-70bdf9dc0080@redhat.com>
Signed-off-by: Ani Sinha <anisinha@redhat.com>
Message-Id: <20230628112804.36676-1-anisinha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/vhost_net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6db23ca323..6b958d6363 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -507,7 +507,12 @@ VHostNetState *get_vhost_net(NetClientState *nc)
     switch (nc->info->type) {
     case NET_CLIENT_DRIVER_TAP:
         vhost_net = tap_get_vhost_net(nc);
-        assert(vhost_net);
+        /*
+         * tap_get_vhost_net() can return NULL if a tap net-device backend is
+         * created with 'vhost=off' option, 'vhostforce=off' or no vhost or
+         * vhostforce or vhostfd options at all. Please see net_init_tap_one().
+         * Hence, we omit the assertion here.
+         */
         break;
 #ifdef CONFIG_VHOST_NET_USER
     case NET_CLIENT_DRIVER_VHOST_USER:
-- 
MST


