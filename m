Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4374B71FCC5
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 10:54:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q50XL-0000qa-35; Fri, 02 Jun 2023 04:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q50XJ-0000q6-3r
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 04:53:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q50XH-0003g4-0m
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 04:53:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685696005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6AW9AR9M+iotOzHt0+t1JvwiGhnvklmj7HnUs4y1BEM=;
 b=Bvrn4UbZSkR5whCBfVpAaa3fke4O3U8NcfThFm/3s49f+WiDc3n5q1uHb9/WMka+Q+actP
 XrzDPdKBxuYiMx9ty0cFh3cB3YvKXpI1rzigk2+fv/RYaRCng3njZDaYwvP/zkuidP9vNo
 xBJuCr0YYhH0rDWz0j9buqFU1avewpg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-304-BlzvUoYcMpGXKxmE0Qk8FQ-1; Fri, 02 Jun 2023 04:53:24 -0400
X-MC-Unique: BlzvUoYcMpGXKxmE0Qk8FQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D049811E7F
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 08:53:24 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DC1140C6EC4;
 Fri,  2 Jun 2023 08:53:22 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 0/2] vdpa: map shadow vrings with MAP_SHARED
Date: Fri,  2 Jun 2023 10:53:19 +0200
Message-Id: <20230602085321.1814165-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The vdpa devices that use va addresses neeeds these maps shared.  Otherwise=
,=0D
vhost_vdpa checks will refuse to accept the maps.=0D
=0D
Discovered this issue while testing SVQ with vdpa sim, now defaulting to=0D
use_va=3Don.=0D
=0D
Eugenio P=C3=A9rez (2):=0D
  vdpa: reorder vhost_vdpa_net_cvq_cmd_page_len function=0D
  vdpa: map shadow vrings with MAP_SHARED=0D
=0D
 hw/virtio/vhost-shadow-virtqueue.c | 16 +++++-----=0D
 net/vhost-vdpa.c                   | 47 +++++++++++++++---------------=0D
 2 files changed, 30 insertions(+), 33 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D


