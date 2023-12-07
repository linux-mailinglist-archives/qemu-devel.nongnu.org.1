Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495E9808B2F
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 15:57:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBFnE-0000Qa-Fw; Thu, 07 Dec 2023 09:56:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBFnB-0000Pv-8F
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 09:55:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rBFn7-0003px-QV
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 09:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701960951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mbcMxF/wcihFt3V8zH1U+nmAKj7mHAzAQfFRp5xG7nM=;
 b=TSheNLJHkNWYmLf+WRDf8X7X1LZlcnwbZp0siZYcVsVfjX0p2w9OqvXTlji076U2BJU0ns
 mwtmAmPN1UUA5Sas0EtKrzAtZnZzeqHthNFSj/P0SqYOOvFYqKNjzm/nqe+Q99xbjqTvrM
 QUOfgy158hkZM5kQ/cqiHAAXI8Ge0fQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-ecCFY8j4OEaGRwaPlpaHiw-1; Thu, 07 Dec 2023 09:55:48 -0500
X-MC-Unique: ecCFY8j4OEaGRwaPlpaHiw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08D25863B83;
 Thu,  7 Dec 2023 14:55:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA6B492BC6;
 Thu,  7 Dec 2023 14:55:46 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@gmail.com, kraxel@redhat.com,
 "Michael S. Tsirkin" <mst@redhat.com>, stefanha@gmail.com,
 Albert Esteve <aesteve@redhat.com>
Subject: [PATCH v2 0/3] Virtio dmabuf improvements
Date: Thu,  7 Dec 2023 15:55:42 +0100
Message-ID: <20231207145545.783877-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
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

v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1005257.html
v1 -> v2:
  - Solved an unitialized uuid value on vhost-user source
  - Changed cleanup strategy, and traverse all objects in the
    table to remove them instead.

Various improvements for the virtio-dmabuf module.
This patch includes:

- Check for ownership before allowing a vhost device
  to remove an object from the table.
- Properly cleanup shared resources if a vhost device
  object gets cleaned up.
- Rename virtio dmabuf functions to `virtio_dmabuf_*`

Albert Esteve (3):
  hw/virtio: check owner for removing objects
  hw/virtio: cleanup shared resources
  hw/virtio: rename virtio dmabuf API

 hw/display/virtio-dmabuf.c        | 36 ++++++++++++---
 hw/virtio/vhost-user.c            | 31 ++++++++++---
 hw/virtio/vhost.c                 |  3 ++
 include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------
 tests/unit/test-virtio-dmabuf.c   | 77 ++++++++++++++++++++++---------
 5 files changed, 138 insertions(+), 52 deletions(-)

-- 
2.43.0


