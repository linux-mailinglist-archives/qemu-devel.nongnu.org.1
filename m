Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA752828659
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 13:57:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNBej-00067c-WA; Tue, 09 Jan 2024 07:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rNBeZ-000672-3v
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aesteve@redhat.com>)
 id 1rNBeX-0006hh-9T
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 07:56:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704804978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=r5YLNq50+vjTnWqaME3Rs4VG8PUOwNV2k7OkdOHq5BQ=;
 b=YTBEiycMT6RrE59wdzp0Vu7dN85G62amY2mcaJCAyGcZEbfyJFXGX1hSqTmxniITKV0lav
 CjzNLrI7wohaXK8LSYakxzi0+HmEfKCFEkbJ3Mb34ZWFyAqvlKDXlScuImO1JuM/bgcWOD
 EAA/OwneHZFBC5i8Q2ymRk3dy/+PqBs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-CfjFW1cGN3GY5EiZd9GgKw-1; Tue,
 09 Jan 2024 07:56:17 -0500
X-MC-Unique: CfjFW1cGN3GY5EiZd9GgKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 191483C0ED45;
 Tue,  9 Jan 2024 12:56:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.225.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 738D22166B33;
 Tue,  9 Jan 2024 12:56:15 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, Albert Esteve <aesteve@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, marcandre.lureau@gmail.com,
 kraxel@redhat.com
Subject: [PATCH v3 0/3] Virtio dmabuf improvements
Date: Tue,  9 Jan 2024 13:56:11 +0100
Message-ID: <20240109125614.220293-1-aesteve@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aesteve@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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
v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014615.html
v2 -> v3
  - Documented the new owner check for shared object removal
  - Updated test function names error in the last patch

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

 docs/interop/vhost-user.rst       |  4 +-
 hw/display/virtio-dmabuf.c        | 36 ++++++++++++---
 hw/virtio/vhost-user.c            | 31 ++++++++++---
 hw/virtio/vhost.c                 |  3 ++
 include/hw/virtio/virtio-dmabuf.h | 43 ++++++++++-------
 tests/unit/test-virtio-dmabuf.c   | 77 ++++++++++++++++++++++---------
 6 files changed, 141 insertions(+), 53 deletions(-)

-- 
2.43.0


