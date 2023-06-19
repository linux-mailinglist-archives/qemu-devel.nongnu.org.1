Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F64A7350EE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 11:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBBa1-0007cj-Do; Mon, 19 Jun 2023 05:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qBBZw-0007c9-Jq
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <belmouss@redhat.com>)
 id 1qBBZv-0001hx-3k
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 05:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687168421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uWdzdOfMOg4Q2Gw4PfXmhMocu133OYOZv5/l29kgId4=;
 b=IRjq7/MTxxKwrKMnvivVCv7LWCEfpggLlc75g1n5J19+EIMxZgUgLcH/gR/aMl5ZvCrh3S
 MvPO8Nx9q4lyFMSm4C5Iq6D11uvtDi7cMlsaP3e4yRjkgAlpP9RWBIC/D/A/38rnNONL4/
 QDD41zlNR1vih1fYambmmVOYCuMRPcQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-438-B6P8asp_NO6Yb6cBzrSn8w-1; Mon, 19 Jun 2023 05:53:40 -0400
X-MC-Unique: B6P8asp_NO6Yb6cBzrSn8w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EFCE9101A531
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 09:53:39 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.45.224.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 133AC2166B26;
 Mon, 19 Jun 2023 09:53:38 +0000 (UTC)
From: Bilal Elmoussaoui <belmouss@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bilal Elmoussaoui <belmouss@redhat.com>
Subject: [PATCH v4 0/2] dbus/ui: Expose a multi touch interface
Date: Mon, 19 Jun 2023 11:53:35 +0200
Message-ID: <20230619095337.9899-1-belmouss@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=belmouss@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

*** Expose a multi touch device interface for the UI DBus backend ***

Bilal Elmoussaoui (2):
  ui/touch: Move event handling to a common helper
  ui/dbus: Expose a touch device interface

 include/ui/console.h | 15 ++++++++++
 ui/console.c         | 65 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-console.c    | 59 +++++++++++++++++++++++++++++++++++++++-
 ui/dbus-display1.xml | 45 ++++++++++++++++++++++++++++--
 ui/gtk.c             | 61 ++++-------------------------------------
 ui/trace-events      |  1 +
 6 files changed, 187 insertions(+), 59 deletions(-)

-- 
2.41.0


