Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA315712570
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 13:29:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2VcD-0004RE-TL; Fri, 26 May 2023 07:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1q2Vc9-0004Qf-W9
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1q2Vc8-0003Se-4f
 for qemu-devel@nongnu.org; Fri, 26 May 2023 07:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685100487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=epoHGUNlNZHzLD1gawlt5oOGUpDvlZyTvUt3ZwXQrlc=;
 b=S9dYSypL0MOAlHem7pEa6C8HNa28uQpCRqi/hJscBIl3tETNvXaZXy6EB2m3QuqsGw3CUE
 qJiKGDSOrk9EAJNDR1jdxtfl9o7ZiAzHun/ZBxK16JSwkQNf7RJukR+d4E5hwyEv8gAWnx
 FMi2HxwR2SgSsuITmbblNqgjUufWHAI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-85Y1S-HdOGe_I-z1FlFDHA-1; Fri, 26 May 2023 07:28:05 -0400
X-MC-Unique: 85Y1S-HdOGe_I-z1FlFDHA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E41F8007D9;
 Fri, 26 May 2023 11:28:05 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88AB0140E95D;
 Fri, 26 May 2023 11:28:03 +0000 (UTC)
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergio Lopez <slp@redhat.com>
Subject: [PATCH v5 0/6] Implement virtio-multitouch and enable GTK3 to use it
Date: Fri, 26 May 2023 13:29:19 +0200
Message-Id: <20230526112925.38794-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=slp@redhat.com;
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

This series adds a virtio-multitouch device to the family of devices emulated
by virtio-input implementing the Multi-touch protocol as descripted here:

https://www.kernel.org/doc/html/latest/input/multi-touch-protocol.html?highlight=multi+touch

It also extends the GTK UI backend to be able to receive multi-touch events
and transpose them to a guest, so the latter can recognize them as gestures
when appropriate.

An example of this in action can be seen here:

 https://fosstodon.org/@slp/109545849296546767

Since v4:
- Minor improvements to the documentation in qapi/ui.json (Markus).
- Rebase and collect R-b.

Since v3:
- Use MultiTouch instead of Multitouch and multi-touch instead of multitouch in
  qapi/ui.json (Markus).
- Adopt documentation suggestions by Markus to qapi/ui.json.
- Adapt the references to automatically generated structs after the spelling
  change.

Since v2:
- Fix InputMultitouchEvent doc in qapi/ui.json (Marc-André).
- Use warn_report() instead of fprintf() in gtk.c (Marc-André).
- Rebase and collect R-b.

Since v1:
- Split 0002 patch to implement ui, virtio-input-hid and virtio-input-pci
  changes in different patches (Marc-André).
- Fix versioning in qapi/ui.json (Marc-André).
- Print a warning if touch->sequence >= INPUT_EVENT_SLOTS_MAX (Marc-André).
- Only send SYN_REPORT once, if needed (Marc-André).
- Rebase and collect R-b.

Sergio Lopez (6):
  virtio-input: generalize virtio_input_key_config()
  ui: add the infrastructure to support MT events
  virtio-input: add a virtio-mulitouch device
  virtio-input-pci: add virtio-multitouch-pci
  ui: add helpers for virtio-multitouch events
  ui/gtk: enable backend to send multi-touch events

 hw/input/virtio-input-hid.c      | 156 +++++++++++++++++++++++++++----
 hw/virtio/virtio-input-pci.c     |  25 ++++-
 include/hw/virtio/virtio-input.h |   9 +-
 include/ui/input.h               |   8 ++
 qapi/ui.json                     |  68 ++++++++++++--
 replay/replay-input.c            |  18 ++++
 ui/gtk.c                         |  92 ++++++++++++++++++
 ui/input.c                       |  42 +++++++++
 ui/trace-events                  |   1 +
 9 files changed, 382 insertions(+), 37 deletions(-)

-- 
2.38.1


