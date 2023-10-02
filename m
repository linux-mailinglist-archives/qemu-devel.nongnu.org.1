Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 608567B5103
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 13:16:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnGud-0001PT-Rn; Mon, 02 Oct 2023 07:16:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGtf-0001B5-Cv
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qnGtc-0003D9-U6
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 07:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696245327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/PKDW4SKjT0/pPuXlaJHtob9as3/n5rKxApAiiXMLWE=;
 b=h96qM0bNRQ/4H4cFK509j6/MHsxnKBS3YBqoiE9NmrtiZfOhYL0hZ9aF5pN6vwzuIH1pWP
 aoZEo7aQ0Ps2IvZyGFoKslaMF2S5D1RYUVReJdfoEi7E4h6dr37t/zO7F8Gl/yq8IP8rGt
 GqK9mD+mD2TZoIAxaup9y5CTNVuFgYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-625-DoBhVGoaOE-mHMJQw2nT7w-1; Mon, 02 Oct 2023 07:14:32 -0400
X-MC-Unique: DoBhVGoaOE-mHMJQw2nT7w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61459855336
 for <qemu-devel@nongnu.org>; Mon,  2 Oct 2023 11:11:57 +0000 (UTC)
Received: from localhost (unknown [10.39.208.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8B5042156701;
 Mon,  2 Oct 2023 11:11:56 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, lersek@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/5] ramfb: migration support
Date: Mon,  2 Oct 2023 15:11:48 +0400
Message-ID: <20231002111154.1002655-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Fixes:
https://bugzilla.redhat.com/show_bug.cgi?id=1859424

Marc-André Lureau (5):
  hw: remove needless includes
  pc: remove needless includes
  ramfb: implement migration support
  ramfb: make migration conditional
  hw: turn off ramfb migration for machines <= 8.1

 hw/vfio/pci.h                 |  1 +
 include/hw/display/ramfb.h    |  2 +-
 hw/core/machine.c             | 15 ++++---------
 hw/display/ramfb-standalone.c |  8 ++++++-
 hw/display/ramfb.c            | 25 ++++++++++++++++++++-
 hw/i386/pc.c                  | 41 -----------------------------------
 hw/vfio/display.c             |  4 ++--
 hw/vfio/pci.c                 |  1 +
 stubs/ramfb.c                 |  2 +-
 9 files changed, 41 insertions(+), 58 deletions(-)

-- 
2.41.0


