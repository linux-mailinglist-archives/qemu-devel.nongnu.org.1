Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48FE68FEC69
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jun 2024 16:31:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFE8N-0000zf-PX; Thu, 06 Jun 2024 10:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8I-0000r4-Lp
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8F-0000dj-29
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717684222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=95xaXvMprzDMvmX4eoWwgPpaL0IdhMVaXc9iZtlkYJ0=;
 b=HWXIdiLjN49V6VLJlMeWUjOZpdsg7au4NM8qRC/emDXjS+8ziGa7x57KmB8ocBjcQ25/gt
 tEZf/p1Vw7QtHYkKz/7010jx40+PR8R2EVHxbVFTyrKy5wxRtTHeBZkR0L33PyLlMf3pic
 gsJ2mY0KM3PwqmufQq/KhFb4wZG3GRA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-5HL7A8xHNlSkCV2oEN8scA-1; Thu,
 06 Jun 2024 10:30:15 -0400
X-MC-Unique: 5HL7A8xHNlSkCV2oEN8scA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C40831944D09; Thu,  6 Jun 2024 14:30:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E97BA1955F4B; Thu,  6 Jun 2024 14:30:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CC851180098E; Thu,  6 Jun 2024 16:30:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 0/4] allow to deprecate objects and devices
Date: Thu,  6 Jun 2024 16:30:06 +0200
Message-ID: <20240606143010.1318226-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Put some infrastructure in place to allow tagging objects (including
devices) as deprected.  Use it to mark the ohci pci host adapter and
the usb hub as deprecated.

v3:
 - switch to two properties: 'deprecated' and 'not secure' flags.
 - add rfc patch implementing policies for devices with flags.

v2:
 - pick up reviews.
 - drop ohci patch.
 - add cirrus vga patch.

Gerd Hoffmann (4):
  qom: allow to mark objects as deprecated or not secure.
  usb/hub: mark as deprecated
  vga/cirrus: mark as not secure
  qdev: add device policy [RfC]

 include/qom/object.h        |  3 ++
 hw/core/qdev.c              | 60 ++++++++++++++++++++++++++++++++++++-
 hw/display/cirrus_vga.c     |  1 +
 hw/display/cirrus_vga_isa.c |  1 +
 hw/usb/dev-hub.c            |  1 +
 qom/qom-qmp-cmds.c          |  8 +++++
 system/qdev-monitor.c       |  8 +++++
 qapi/qom.json               |  8 ++++-
 8 files changed, 88 insertions(+), 2 deletions(-)

-- 
2.45.2


