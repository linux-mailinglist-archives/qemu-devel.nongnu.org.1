Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E155F8D17AA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 11:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtYB-0008D5-1k; Tue, 28 May 2024 05:55:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtY9-0008CF-4f
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtXz-0001TY-SF
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716890108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=C8G2ruFWfsr9EkCcmJvF66jZUVOMZECUE8i4j4uUYjw=;
 b=BSGyaXxjESbmoXikgMpqnMDs1DZWjVQOLj1xA13RuIg/BvuMEbKZZAQCIeG9P8xcNDU/Cq
 dCUYDOjOFoiChw40+PJTz9H3UYC8WQ5PatldTQwW+mioBrZSTlMw2G3SCJFTmUW2Zfy67C
 CmKlIRrti9kF8qU2Sc1f+z6c4WmjIuE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-NaOqMpTHPwygNST3EMBiqA-1; Tue,
 28 May 2024 05:55:02 -0400
X-MC-Unique: NaOqMpTHPwygNST3EMBiqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 022E0380670C;
 Tue, 28 May 2024 09:55:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 739CB40C6EB7;
 Tue, 28 May 2024 09:55:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C76B218009F4; Tue, 28 May 2024 11:54:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] allow to deprecate objects and devices
Date: Tue, 28 May 2024 11:54:55 +0200
Message-ID: <20240528095459.896594-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Put some infrastructure in place to allow tagging objects (including
devices) as deprected.  Use it to mark the ohci pci host adapter and
the usb hub as deprecated.

Gerd Hoffmann (4):
  qom: allow to mark objects (including devices) as deprecated.
  usb: add config options for the hub and hid devices
  usb/ohci-pci: deprecate, don't build by default
  usb/hub: deprecate, don't build by default

 include/qom/object.h  |  1 +
 hw/usb/dev-hub.c      |  1 +
 hw/usb/hcd-ohci-pci.c |  1 +
 qom/qom-qmp-cmds.c    |  4 ++++
 system/qdev-monitor.c |  5 +++++
 hw/usb/Kconfig        | 10 +++++++++-
 hw/usb/meson.build    |  4 ++--
 qapi/qom.json         |  4 +++-
 8 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.45.1


