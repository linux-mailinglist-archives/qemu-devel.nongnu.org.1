Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 151DF824640
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:31:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQbT-0007Mf-9u; Thu, 04 Jan 2024 11:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbQ-0007Le-LN
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbO-0002HY-7N
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704385789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vB9Tj5ReX31XSbomRbr1ueekSZ2nx3LkrxirNFJq230=;
 b=W9W1v2qTmI/gcVD2JpR4EyHOrGQ/IoECUN9Z4S+YHfSlUXABqitkK+U2eoDNG1a75QJ2T7
 y0mRK3x8PA5r36ywNhcwaRcJh8I4DXFzxba4jrBchTO2qLxbT4hg2Jr2+/nl/dGUVfOxx0
 22NnICMk9icA34MNxqlBWGsb7DaKfG4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-XOpYjQyONi-rjyESEO9F7g-1; Thu,
 04 Jan 2024 11:29:46 -0500
X-MC-Unique: XOpYjQyONi-rjyESEO9F7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1AD91C2B66A;
 Thu,  4 Jan 2024 16:29:45 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EA871C060AF;
 Thu,  4 Jan 2024 16:29:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/6] net: fix non-deterministic failures of the
 'netdev-socket' qtest
Date: Thu,  4 Jan 2024 16:29:36 +0000
Message-ID: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
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

We've previously bumped up the timeouts in the netdev-socket qtest
to supposedly fix non-deterministic failures, however, the failures
are still hitting CI.

A simple 'listen()' and 'connect()' pairing across 2 QEMU processes
should be very quick to execute, even under high system load, so it
was never likely that the test was failing due to timeouts being
reached.

The actual root cause was a race condition in the test design. It
was spawning a QEMU with a 'server' netdev, and then spawning one
with the 'client' netdev. There was insufficient synchronization,
however, so it was possible for the 2nd QEMU process to attempt
to 'connect()' before the 'listen()' call was made by the 1st QEMU.

In the test scenarios that did not use the 'reconnect' flag, this
would result in the client QEMU never getting into the expected
state. The test code would thus loop on 'info network' until
hitting the maximum wait time.

This series reverts the increased timeouts, and fixes synchronization
in the test scenarios. It also improves reporting of errors in the
socket netdev backend so that 'info network' reports what actually
went wrong rather than a useless generic 'connection error' string.
This will help us diagnose any future CI problems, should they occurr.

Daniel P. Berrangé (6):
  Revert "netdev: set timeout depending on loadavg"
  Revert "osdep: add getloadavg"
  Revert "tests/qtest/netdev-socket: Raise connection timeout to 120
    seconds"
  net: add explicit info about connecting/listening state
  net: handle QIOTask completion to report useful error message
  qtest: ensure netdev-socket tests have non-overlapping names

 include/qemu/osdep.h        | 10 ---------
 meson.build                 |  1 -
 net/stream.c                | 18 +++++++++++-----
 tests/qtest/netdev-socket.c | 42 +++++++------------------------------
 4 files changed, 21 insertions(+), 50 deletions(-)

-- 
2.43.0


