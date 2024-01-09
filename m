Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0CB5827EE6
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 07:48:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN5sr-0005V0-QP; Tue, 09 Jan 2024 01:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5sn-0005Uf-DV
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN5sl-0005bi-Kz
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 01:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704782798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zveqoq8lfc6Wt8AqipJ7HDk1OK9gBnHGXcrKTr2HS2M=;
 b=EIabC4oIUoE+LzmY2tYtb6Hdu4osRezMvc7qCR6pWzGRm0DB+DpFCClTE0iEHE5rFOcS5b
 OsDQGazBYYTg3KPn3eNVStIo8jg/fx11a98H3H9Sp2AVDFaR9hfZjOIS6zIhjUpS1X1NoA
 cl9pH4qDXycB9RWpWm0s+Vrg2kgHobU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-rhxNJD9mMAqLmqNOBRNvqg-1; Tue,
 09 Jan 2024 01:46:35 -0500
X-MC-Unique: rhxNJD9mMAqLmqNOBRNvqg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6DF53C0ED46;
 Tue,  9 Jan 2024 06:46:34 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.15])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA0F492BC7;
 Tue,  9 Jan 2024 06:46:30 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 00/10] docs/migration: Reorganize migration documentations
Date: Tue,  9 Jan 2024 14:46:18 +0800
Message-ID: <20240109064628.595453-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

Migration docs grow larger and larger.  There are plenty of things we can
do here in the future, but to start that we'd better reorganize the current
bloated doc files first and properly organize them into separate files.
This series kicks that off.

This series mostly does the movement only, so please don't be scared of the
slightly large diff.  I did touch up things here and there, but I didn't
yet started writting much.  One thing I did is I converted virtio.txt to
rST, but that's trivial and no real content I touched.

I am copying both virtio and vfio people because I'm merging the two
separate files into the new docs/devel/migration/ folder.

Comments welcomed.  Thanks,

Peter Xu (10):
  docs/migration: Create migration/ directory
  docs/migration: Create index page
  docs/migration: Convert virtio.txt into rST
  docs/migration: Split "Backwards compatibility" separately
  docs/migration: Split "Debugging" and "Firmware"
  docs/migration: Split "Postcopy"
  docs/migration: Split "dirty limit"
  docs/migration: Organize "Postcopy" page
  docs/migration: Further move vfio to be feature of migration
  docs/migration: Further move virtio to be feature of migration

 docs/devel/index-internals.rst                |    3 +-
 docs/devel/migration.rst                      | 1514 -----------------
 docs/devel/migration/best-practises.rst       |   48 +
 docs/devel/migration/compatibility.rst        |  517 ++++++
 docs/devel/migration/dirty-limit.rst          |   71 +
 docs/devel/migration/features.rst             |   12 +
 docs/devel/migration/index.rst                |   13 +
 docs/devel/migration/main.rst                 |  575 +++++++
 docs/devel/migration/postcopy.rst             |  313 ++++
 .../vfio.rst}                                 |    2 +-
 docs/devel/migration/virtio.rst               |  115 ++
 docs/devel/virtio-migration.txt               |  108 --
 12 files changed, 1666 insertions(+), 1625 deletions(-)
 delete mode 100644 docs/devel/migration.rst
 create mode 100644 docs/devel/migration/best-practises.rst
 create mode 100644 docs/devel/migration/compatibility.rst
 create mode 100644 docs/devel/migration/dirty-limit.rst
 create mode 100644 docs/devel/migration/features.rst
 create mode 100644 docs/devel/migration/index.rst
 create mode 100644 docs/devel/migration/main.rst
 create mode 100644 docs/devel/migration/postcopy.rst
 rename docs/devel/{vfio-migration.rst => migration/vfio.rst} (99%)
 create mode 100644 docs/devel/migration/virtio.rst
 delete mode 100644 docs/devel/virtio-migration.txt

-- 
2.41.0


