Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EC1AE94B0
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Jun 2025 05:47:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUdYm-00013P-2i; Wed, 25 Jun 2025 23:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uUdYk-00012R-6n
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 23:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shahuang@redhat.com>)
 id 1uUdYg-00081F-Pi
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 23:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750909542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LS0Nj0pX9AHR5YWuZobcUnVkGlGLkmNu16VSLdY1xWM=;
 b=Joi7xIL99nyV8Qjno3ilrA1WvE2CfjpBdjmi/H7pL2myq+FQ6qL0l5n1eNsWNgIQg8T9vV
 IwmUsqX8VZGSlNLKky+dh60HgA/J4hpLxNtfocEU+76WSRLKxRK7u6S0LK74YhwDUhdPk5
 fudcAloFLW9YzfHhjlrvDu7E67xtUjc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-tInWLXpmPAuWxqwuEZRFGA-1; Wed,
 25 Jun 2025 23:45:39 -0400
X-MC-Unique: tInWLXpmPAuWxqwuEZRFGA-1
X-Mimecast-MFC-AGG-ID: tInWLXpmPAuWxqwuEZRFGA_1750909537
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A961A1809C88; Thu, 26 Jun 2025 03:45:37 +0000 (UTC)
Received: from virt-mtcollins-01.lab.eng.rdu2.redhat.com
 (virt-mtcollins-01.lab.eng.rdu2.redhat.com [10.8.1.196])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7E5831956096; Thu, 26 Jun 2025 03:45:29 +0000 (UTC)
From: Shaoqin Huang <shahuang@redhat.com>
To: qemu-arm@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v5 0/2] ramfb: Add property to control if load the romfile
Date: Wed, 25 Jun 2025 23:45:24 -0400
Message-Id: <20250626034526.2136585-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=shahuang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Currently the ramfb device loads the vgabios-ramfb.bin unconditionally, but only
the x86 need the vgabios-ramfb.bin, this can cause that when use the
release package on arm64 it can't find the vgabios-ramfb.bin.

Because only seabios will use the vgabios-ramfb.bin, load the rom logic
is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
for ramfb, so they don't need to load the romfile.

So add a new property use-legacy-x86-rom in both ramfb and vfio_pci
device, because the vfio display also use the ramfb_setup() to load
the vgabios-ramfb.bin file.

After have this property, the machine type can set the compatibility to
not load the vgabios-ramfb.bin if the arch doesn't need it.

Then I set the use_legacy_x86_rom property to false by default, and only set it
to true on x86 since only x86 will need it.

Changelog:
---------
v4 -> v5:
  - Fix some typo error.
  - Set the property in piix machine type.
v3 -> v4:
  - Set the new property to false by default, only set it to true on x86.
v2 -> v3:
  - Fix the underscore error.
  - Add a new patch to set the property in arm compatibility.
v1 -> v2:
  - Change the property name.

v4: https://lore.kernel.org/all/20250617030521.2109305-1-shahuang@redhat.com/
v3: https://lore.kernel.org/all/20250609073408.2083831-1-shahuang@redhat.com/
v2: https://lore.kernel.org/all/20250606070234.2063451-1-shahuang@redhat.com/
v1: https://lore.kernel.org/all/20250605030351.2056571-1-shahuang@redhat.com/

Shaoqin Huang (2):
  ramfb: Add property to control if load the romfile
  hw/i386: Add the ramfb romfile compatibility

 hw/display/ramfb-standalone.c |  4 +++-
 hw/display/ramfb-stubs.c      |  2 +-
 hw/display/ramfb.c            |  6 ++++--
 hw/i386/pc_piix.c             | 10 ++++++++++
 hw/i386/pc_q35.c              |  3 +++
 hw/vfio/display.c             |  4 ++--
 hw/vfio/pci.c                 |  1 +
 hw/vfio/pci.h                 |  1 +
 include/hw/display/ramfb.h    |  2 +-
 9 files changed, 26 insertions(+), 7 deletions(-)

-- 
2.40.1


