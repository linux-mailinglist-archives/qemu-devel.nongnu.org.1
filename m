Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 820FB7F2ACE
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 11:41:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5OBL-0007cZ-8p; Tue, 21 Nov 2023 05:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBI-0007bz-OS
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1r5OBG-0003EQ-T9
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 05:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700563234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=b3BozpQwDtKib7iiJ7gwprFgGFPi2TCfED2CmF9WCqw=;
 b=EfYkq9L2uSF2pOZPQsmi+5YKolZRhvHWKPEN35+I+rJCRB4UWIoREawmFtjaV35BduyEIg
 HIcC3a8EZy/yNMYAUnShxzQPKFruSpj9Izg1o8NDU1qZFZ6wtw73SD6MnQhLt0J/FXjK+L
 E8HTmVzYrMIF9DKhEOMh7AAp44W8ahs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-zn3TE-6JODmAxVjtieNMUQ-1; Tue, 21 Nov 2023 05:40:24 -0500
X-MC-Unique: zn3TE-6JODmAxVjtieNMUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 384988678A0;
 Tue, 21 Nov 2023 10:40:24 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 07BED2166B26;
 Tue, 21 Nov 2023 10:40:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 peter.maydell@linaro.org, dwmw@amazon.co.uk
Subject: [PULL 0/5] Ui patches
Date: Tue, 21 Nov 2023 14:40:15 +0400
Message-ID: <20231121104020.2209345-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit af9264da80073435fd78944bc5a46e695897d7e5:

  Merge tag '20231119-xtensa-1' of https://github.com/OSLL/qemu-xtensa into staging (2023-11-20 05:25:19 -0500)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request

for you to fetch changes up to e0c58720bfd8c0553f170b64717278b07438d2f5:

  ui/pixman-minimal.h: fix empty allocation (2023-11-21 14:38:14 +0400)

----------------------------------------------------------------
UI: fixes for 8.2-rc1

----------------------------------------------------------------

Manos Pitsidianakis (1):
  ui/pixman-minimal.h: fix empty allocation

Marc-André Lureau (4):
  vl: revert behaviour for -display none
  ui: use "vc" chardev for dbus, gtk & spice-app
  ui/console: fix default VC when there are no display
  vl: add missing display_remote++

 include/ui/pixman-minimal.h | 48 +++++++++++++++++++++++++++++++++++--
 system/vl.c                 |  4 +++-
 ui/console.c                | 18 +++++++-------
 ui/dbus.c                   |  1 +
 ui/gtk.c                    |  1 +
 ui/spice-app.c              |  1 +
 6 files changed, 60 insertions(+), 13 deletions(-)

-- 
2.42.0


