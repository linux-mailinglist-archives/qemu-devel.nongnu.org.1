Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DF7B64C8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnbDJ-0004Yi-5b; Tue, 03 Oct 2023 04:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDE-0004Xr-S6
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnbDC-00061m-H5
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696323421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9+aGXz6JMW1xgkPpjEPXrCZbeukrj1wXvD4wWC2wxtc=;
 b=L8SaiRzkQFzXpKb54+bvf/mNcgBMsDsEVQ3SIiOjomrrB5ybs59MiHq6CsvG4NN4vCC3ao
 caUqaGqMbwRRPI6ZacsQWOlh4eAFQRlj4f0j1EK2sc4VlKcvATt5f9aFFpGEyf6iv5lVWa
 KittuVOXsLiHZtYbev6Gj2xJTjIs2ho=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-108-28IeQMIMOYOL8ATRJj-kDw-1; Tue, 03 Oct 2023 04:56:49 -0400
X-MC-Unique: 28IeQMIMOYOL8ATRJj-kDw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9C548F8720
 for <qemu-devel@nongnu.org>; Tue,  3 Oct 2023 08:56:48 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D485A140E953;
 Tue,  3 Oct 2023 08:56:47 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 0/5] WIP: ramfb: migration support
Date: Tue,  3 Oct 2023 12:56:39 +0400
Message-ID: <20231003085644.1220326-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi,

Implement RAMFB migration, and add properties to enable it only on >= 8.2
machines, + a few related cleanups.

v3:
- add a "x-" prefix to properties, as they are not meant for users.
- RAMFB now exports a ramfb_vmstate for actual devices to include
- VFIOPCIDevice now has a VFIODisplay optional subsection whenever ramfb
  migration is required (untested)

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1859424

Marc-André Lureau (5):
  hw/core: remove needless includes
  hw/pc: remove needless includes
  ramfb: add migration support
  ramfb-standalone: add migration support
  hw/vfio: add ramfb migration support

 hw/vfio/pci.h                 |  3 +++
 include/hw/display/ramfb.h    |  4 ++++
 hw/core/machine.c             | 15 ++++---------
 hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++++
 hw/display/ramfb.c            | 19 ++++++++++++++++
 hw/i386/pc.c                  | 41 -----------------------------------
 hw/vfio/display.c             | 23 ++++++++++++++++++++
 hw/vfio/pci.c                 | 32 +++++++++++++++++++++++++++
 8 files changed, 112 insertions(+), 52 deletions(-)

-- 
2.41.0


