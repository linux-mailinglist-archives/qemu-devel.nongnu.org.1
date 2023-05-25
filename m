Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA08C7106E9
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 10:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q263m-0007Xo-7t; Thu, 25 May 2023 04:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263I-0007Pq-Kx
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q263E-0001jg-RD
 for qemu-devel@nongnu.org; Thu, 25 May 2023 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685002223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vnjSZXWfWRdgZgrjCP5BjWviyv23eiW+JTQLFms7qR8=;
 b=O9rp3fUndfGvYXvvHv72LvyYPwgg4IfXAJvDHBtLxyqScCzCo3ZonshRcoaQxP1QtR03Qw
 gaMfrjbHMzzTCN6zGqy186/cuQWRECeAHVw+RWpOdUVVZu/B1R5zHELj8r+ubop6W53wgR
 OzJVodtg3PhDgqrqIslcgXCLOtwxukM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-1MT1Rib1OQi04CpIQge0mg-1; Thu, 25 May 2023 04:10:21 -0400
X-MC-Unique: 1MT1Rib1OQi04CpIQge0mg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D1E32A5957F;
 Thu, 25 May 2023 08:10:21 +0000 (UTC)
Received: from thuth.com (unknown [10.39.193.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3380740C6CDD;
 Thu, 25 May 2023 08:10:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 0/4] tests/qtest: Check for devices before using them
Date: Thu, 25 May 2023 10:10:12 +0200
Message-Id: <20230525081016.1870364-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Here are some more patches that are required for running the qtests
with builds that have been configured with "--without-default-devices".
We need to check whether the required devices are really available
in the binaries before we can use them, otherwise the tests will
fail.

Thomas Huth (4):
  tests/qtest/usb-hcd-uhci-test: Check whether "usb-storage" is
    available
  tests/qtest: Check for virtio-blk before using -cdrom with the arm
    virt machine
  tests/qtest/rtl8139-test: Check whether the rtl8139 device is
    available
  tests/qtest/usb-hcd-ehci-test: Check for EHCI and UHCI HCDs before
    using them

 tests/qtest/bios-tables-test.c  | 2 +-
 tests/qtest/cdrom-test.c        | 6 +++++-
 tests/qtest/rtl8139-test.c      | 4 ++++
 tests/qtest/usb-hcd-ehci-test.c | 5 +++++
 tests/qtest/usb-hcd-uhci-test.c | 4 +++-
 5 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.31.1


