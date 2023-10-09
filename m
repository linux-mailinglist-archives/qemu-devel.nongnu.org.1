Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4C27BD363
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:33:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjp4-0007Lo-Ap; Mon, 09 Oct 2023 02:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpjp1-0007LX-L6
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qpjoz-0004Ew-N0
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696833172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DvLY3ctE0x8uuPf45c19zilDzEV1zJdbOxGVShgfm4Q=;
 b=N4OsDId/lKjx0WlEBhCVmMYaE3CGKvTsprCSgJViaX854wRuvWdJJESfhm8A2EMRAPS34C
 Z5wMmhoKh+LuL7BxqTIuGNwli3nq2YeI/ZJozWOSTL1LJn+wKb+vTtnqokV8GzkugbaCk8
 C7xDZ+iVIHc1zyJ83qqqZSc2SgI8SDE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-176-FXiMIb0SMuKVvuvciUwpEw-1; Mon, 09 Oct 2023 02:32:50 -0400
X-MC-Unique: FXiMIb0SMuKVvuvciUwpEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 612C83816C81
 for <qemu-devel@nongnu.org>; Mon,  9 Oct 2023 06:32:50 +0000 (UTC)
Received: from localhost (unknown [10.39.208.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2816140EBB7;
 Mon,  9 Oct 2023 06:32:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v5 0/3] ramfb: migration support
Date: Mon,  9 Oct 2023 10:32:44 +0400
Message-ID: <20231009063247.119333-1-marcandre.lureau@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

thanks

v5:
- add missing VMSTATE_END_OF_LIST
- changed ramfb=off & x-mig=on user config error to a warning
- add r-b tags

v4: (Laszlo review and suggestions)
- change migrate_needed() to assert(ramfb_exists)
- rename vfio_display_needed() to vfio_display_migration_needed(),
  update the condition and associated comment
- move the ramfb-migrate option check and add a check for ramfb=on
- add a stub to fix compilation on some architectures

v3:
- add a "x-" prefix to properties, as they are not meant for users.
- RAMFB now exports a ramfb_vmstate for actual devices to include
- VFIOPCIDevice now has a VFIODisplay optional subsection whenever ramfb
  migration is required (untested)

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1859424

Marc-André Lureau (3):
  ramfb: add migration support
  ramfb-standalone: add migration support
  hw/vfio: add ramfb migration support

 hw/vfio/pci.h                 |  3 +++
 include/hw/display/ramfb.h    |  4 ++++
 hw/core/machine.c             |  2 ++
 hw/display/ramfb-standalone.c | 27 +++++++++++++++++++++
 hw/display/ramfb.c            | 19 +++++++++++++++
 hw/vfio/display.c             | 21 +++++++++++++++++
 hw/vfio/pci.c                 | 44 +++++++++++++++++++++++++++++++++++
 stubs/ramfb.c                 |  2 ++
 8 files changed, 122 insertions(+)

-- 
2.41.0


