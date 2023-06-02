Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 466C67204A9
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 16:40:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q55vl-0003uo-Lp; Fri, 02 Jun 2023 10:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q55vj-0003uB-Sx
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:39:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q55vi-0001dc-9l
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685716741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dL0qA1pZEJS7XzaoVzVJ9M798uJl4XMKqV6v0OK34Ek=;
 b=Jsq+c023FaU1+X8oHypZ+PbGCQL46yq9z5MY7+oW/uwPz2jl0IFeOGJNpfUmkJRBU9SNOe
 LxzvGR/nx2HGF+v0YHqEYhGvsR629o8cN4o0jlmEhAUbDAAwA9M7Tabrke8Cn9TWXor+02
 4IZfTxM+gkeZIoZj8gCHKXW8zJAH17s=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-KQCqYyIZPGeHugZSNez3Tw-1; Fri, 02 Jun 2023 10:38:58 -0400
X-MC-Unique: KQCqYyIZPGeHugZSNez3Tw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 194443802277
 for <qemu-devel@nongnu.org>; Fri,  2 Jun 2023 14:38:57 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.168])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F33C9145B966;
 Fri,  2 Jun 2023 14:38:55 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Lei Yang <leiyang@redhat.com>
Subject: [PATCH v2 0/3] vdpa: map shadow vrings with MAP_SHARED
Date: Fri,  2 Jun 2023 16:38:51 +0200
Message-Id: <20230602143854.1879091-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
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
v2:=0D
* Use PROT_READ|PROT_WRITE instead of O_RDWR. The latter does not work for=
=0D
  mmap.=0D
=0D
Eugenio P=C3=A9rez (3):=0D
  vdpa: do not block migration if device has cvq and x-svq=3Don=0D
  vdpa: reorder vhost_vdpa_net_cvq_cmd_page_len function=0D
  vdpa: map shadow vrings with MAP_SHARED=0D
=0D
 hw/virtio/vhost-shadow-virtqueue.c | 18 ++++-----=0D
 net/vhost-vdpa.c                   | 59 ++++++++++++++++--------------=0D
 2 files changed, 40 insertions(+), 37 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D


