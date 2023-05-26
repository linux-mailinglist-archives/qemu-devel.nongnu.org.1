Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E490271298E
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 17:33:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2ZQA-0003p7-6E; Fri, 26 May 2023 11:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZQ4-0003oh-52
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:32:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q2ZQ1-0003Lf-V4
 for qemu-devel@nongnu.org; Fri, 26 May 2023 11:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685115112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZkVtQfkKq8wBsdwrlvmHJNY0oUgHnJ6yUOXeXjL0b+M=;
 b=fWJVqSJPZP+B2mqqQKihWTxa8/pkEWX9pozq56gCuEp38scR3g9V5pS0LI8thzeah7uNN0
 665KeSqiN/V1Ge4dmc92rRrGl7zahX21AmKE+Xv5KML0WJaYhNrcxXuph0IB82YxCS2gjM
 VLr7uQ4eRlS7/6Pcq6UeDlqzq1vwWOA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-106-XI1sO6JrPXCs8rC5cY8NJw-1; Fri, 26 May 2023 11:31:48 -0400
X-MC-Unique: XI1sO6JrPXCs8rC5cY8NJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDF5A101A531;
 Fri, 26 May 2023 15:31:47 +0000 (UTC)
Received: from eperezma.remote.csb (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E687740C1438;
 Fri, 26 May 2023 15:31:44 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Parav Pandit <parav@mellanox.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng2@huawei.com,
 Shannon Nelson <snelson@pensando.io>, Laurent Vivier <lvivier@redhat.com>,
 si-wei.liu@oracle.com, Cindy Lu <lulu@redhat.com>,
 Lei Yang <leiyang@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Gautam Dawar <gdawar@xilinx.com>,
 Jason Wang <jasowang@redhat.com>, Liuxiangdong <liuxiangdong5@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, alvaro.karsz@solid-run.com,
 Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH v4 0/2] Move ASID test to vhost-vdpa net initialization
Date: Fri, 26 May 2023 17:31:41 +0200
Message-Id: <20230526153143.470745-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

QEMU v8.0 is able to switch dynamically between vhost-vdpa passthrough=0D
and SVQ mode as long as the net device does not have CVQ.  The net device=0D
state followed (and migrated) by CVQ requires special care.=0D
=0D
A pre-requisite to add CVQ to that framework is to determine if devices wit=
h=0D
CVQ are migratable or not at initialization time.  The solution to it is to=
=0D
always shadow only CVQ, and vq groups and ASID are used for that.=0D
=0D
However, current qemu version only checks ASID at device start (as "driver =
set=0D
DRIVER_OK status bit"), not at device initialization.  A check at=0D
initialization time is required.  Otherwise, the guest would be able to set=
=0D
and remove migration blockers at will [1].=0D
=0D
This series is a requisite for migration of vhost-vdpa net devices with CVQ=
.=0D
However it already makes sense by its own, as it reduces the number of ioct=
ls=0D
at migration time, decreasing the error paths there.=0D
=0D
[1] https://lore.kernel.org/qemu-devel/2616f0cd-f9e8-d183-ea78-db1be4825d9c=
@redhat.com/=0D
---=0D
v4:=0D
* Only probe one of MQ or !MQ.=0D
* Merge vhost_vdpa_cvq_is_isolated in vhost_vdpa_probe_cvq_isolation=0D
* Call ioctl directly instead of adding functions.=0D
=0D
v3:=0D
* Only record cvq_isolated, true if the device have cvq isolated in both !M=
Q=0D
* and MQ configurations.=0D
* Drop the cache of cvq group, it can be done on top=0D
=0D
v2:=0D
* Take out the reset of the device from vhost_vdpa_cvq_is_isolated=0D
  (reported by Lei Yang).=0D
* Expand patch messages by Stefano G. questions.=0D
=0D
Eugenio P=C3=A9rez (2):=0D
  vdpa: return errno in vhost_vdpa_get_vring_group error=0D
  vdpa: move CVQ isolation check to net_init_vhost_vdpa=0D
=0D
 net/vhost-vdpa.c | 147 ++++++++++++++++++++++++++++++++++++-----------=0D
 1 file changed, 112 insertions(+), 35 deletions(-)=0D
=0D
-- =0D
2.31.1=0D
=0D


