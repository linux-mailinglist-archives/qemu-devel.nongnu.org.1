Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B163076F59D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 00:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRghF-0004PN-UZ; Thu, 03 Aug 2023 18:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghE-0004PE-9u
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRghC-0000VA-QP
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 18:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691101286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7p2D4s0LesrJ/eATvXaVZ3Ta+r1WEUNem6KlZDsO1yk=;
 b=A4YD2KoyVSDRO/CqvmOMjxI6M79HVVfmbXcZah5hDsV+eF3IQQC94muJhXVPSXg0fJKbgD
 rJ05WX6xxMl3xCrNSVJNfiHZdqJy9hMkDb9yFNiprUvz2A3BcCCxCz9/hvvtO7cOm4Chwe
 1xR1lQWfkAXsm+pquc2gK2dwp5K3caM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-oKHp57rbM76gn2gjYJj-Ow-1; Thu, 03 Aug 2023 18:21:24 -0400
X-MC-Unique: oKHp57rbM76gn2gjYJj-Ow-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99388334de6so131899666b.0
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 15:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691101283; x=1691706083;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7p2D4s0LesrJ/eATvXaVZ3Ta+r1WEUNem6KlZDsO1yk=;
 b=kqsd1p6yth1cHhBGv2CB5c35KsIDlLBzfvDco5d+7EyXiTYexuBiW1YE123LBCOJfg
 zmqUdNr7VfnGEjz6PPjYYOefPq4Bjm4OusPQ8epGNIorkRqj06FMFEIfjxE73Hluxqqp
 jELhKUvML6gm9I/fU/SQXot18+jrrerwcxK+QMG1ML4b41MX08hVl8YKuCrNQ+sJDc61
 3N/IjeYZ8PoYNtL2SAOTYz9/xIkyKoSgKPxXtJ9GCwdqxxxENvj2Yd3vDuVdpDC+TDvA
 Vagszkd+nK1RLctX4Y2Pw21xQKhPDAV/HR6DfHZMbwcLdTxAsCCjTAYt1Mh2YXCp4/KZ
 NWZw==
X-Gm-Message-State: ABy/qLalH3d/b+BnE7lSqzomtFAbJlX30Rx9pDkZqsQ1gR1lx9aHZjmf
 +XVnNQkw72EKO2iSyP2CuLmybUNMWFQPfmECDA3v4XT0VjMTCDQW1aZOIZT6k1SQq9fsnJGIXDD
 Fq1qtysVxcaTZXvwBTugus2svB0RLzcUn83CfvZU/ui+NOna7L+sXf7TuM9AELiCPbEze
X-Received: by 2002:a17:906:74cb:b0:994:8e9:67fe with SMTP id
 z11-20020a17090674cb00b0099408e967femr7990821ejl.35.1691101282866; 
 Thu, 03 Aug 2023 15:21:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHZWRVBC/4OthngQqFpzmDJa5NmB/lZ7UdnyoBRfTJ9RfXXeJNysTJucplaIfYsV2ZD/r72Cw==
X-Received: by 2002:a17:906:74cb:b0:994:8e9:67fe with SMTP id
 z11-20020a17090674cb00b0099408e967femr7990812ejl.35.1691101282677; 
 Thu, 03 Aug 2023 15:21:22 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 la1-20020a170906ad8100b0099b5a71b0bfsm375530ejb.94.2023.08.03.15.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 15:21:22 -0700 (PDT)
Date: Thu, 3 Aug 2023 18:21:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Edmondson <david.edmondson@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/22] hw/virtio: qmp: add RING_RESET to 'info virtio-status'
Message-ID: <92f04221379ae5e35f6474c2afed2eb02d552df3.1691101215.git.mst@redhat.com>
References: <cover.1691101215.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1691101215.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: David Edmondson <david.edmondson@oracle.com>

Signed-off-by: David Edmondson <david.edmondson@oracle.com>
Message-Id: <20230721072820.75797-1-david.edmondson@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/virtio/virtio-qmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/virtio/virtio-qmp.c b/hw/virtio/virtio-qmp.c
index 3d32dbec8d..7515b0947b 100644
--- a/hw/virtio/virtio-qmp.c
+++ b/hw/virtio/virtio-qmp.c
@@ -79,6 +79,8 @@ static const qmp_virtio_feature_map_t virtio_transport_map[] = {
             "VIRTIO_F_ORDER_PLATFORM: Memory accesses ordered by platform"),
     FEATURE_ENTRY(VIRTIO_F_SR_IOV, \
             "VIRTIO_F_SR_IOV: Device supports single root I/O virtualization"),
+    FEATURE_ENTRY(VIRTIO_F_RING_RESET, \
+            "VIRTIO_F_RING_RESET: Driver can reset a queue individually"),
     /* Virtio ring transport features */
     FEATURE_ENTRY(VIRTIO_RING_F_INDIRECT_DESC, \
             "VIRTIO_RING_F_INDIRECT_DESC: Indirect descriptors supported"),
-- 
MST


