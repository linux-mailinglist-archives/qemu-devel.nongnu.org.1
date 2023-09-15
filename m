Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0057A244E
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCJB-0006zN-L4; Fri, 15 Sep 2023 13:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCJ9-0006ng-9A
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qhCJ7-0001mi-Sk
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694797721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SDjbyOd0y0bfA0SfgM237iKgjsl/i2kBwBy9eH+oxgU=;
 b=GQ01ryCRNIKV3Q2RrojlFAFkKl8mIJ7xREPc0HUiDI8XKRxR2UBiNJM3TEOMMK/vkjxAq5
 RYKjjVNj8WMsYwfdRbo+VRahDUvw9IZuM/kXCUOm0LG6K9UKMk2sQ4AIKlt1tdE8Jn6y5y
 MI4sJzC7p8EPagmyZ+x3iqdqQ+XlU7o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-677-uE7IoGztMXayRXut7U84DA-1; Fri, 15 Sep 2023 13:08:40 -0400
X-MC-Unique: uE7IoGztMXayRXut7U84DA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7785A185A79C;
 Fri, 15 Sep 2023 17:08:39 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.192.183])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2E8752026D4B;
 Fri, 15 Sep 2023 17:08:38 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hawkins Jiawei <yin31149@gmail.com>, qemu-stable@nongnu.org,
 si-wei.liu@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 0/3] Follow VirtIO initialization properly at vdpa net cvq
 isolation probing
Date: Fri, 15 Sep 2023 19:08:33 +0200
Message-Id: <20230915170836.3078172-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

This series solves a few issues.  The most obvious is that the feature set =
was=0D
done previous to ACKNOWLEDGE | DRIVER status bit set.  Current vdpa devices=
 are=0D
permissive with this, but it is better to follow the standard.=0D
=0D
Apart from that it fixes two issues reported by Peter Maydell:=0D
* Stop probing CVQ isolation if cannot set features (goto missed).=0D
* Fix incorrect error message statis "error setting features", while it sho=
uld=0D
say status.=0D
=0D
v2: add forgotten Fixes tag=0D
=0D
Eugenio P=C3=A9rez (3):=0D
  vdpa net: fix error message setting virtio status=0D
  vdpa net: stop probing if cannot set features=0D
  vdpa net: follow VirtIO initialization properly at cvq isolation=0D
    probing=0D
=0D
 net/vhost-vdpa.c | 15 +++++++++++----=0D
 1 file changed, 11 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.39.3=0D
=0D


