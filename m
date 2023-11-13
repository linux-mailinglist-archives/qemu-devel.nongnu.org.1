Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2367E9ABC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 12:09:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2UnE-0006MH-SN; Mon, 13 Nov 2023 06:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnC-0006Lu-Ca
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2UnA-0001GG-Q9
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 06:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699873664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3E9FPn8rFHDmshNSoaYnMigCtKSpC91+q746KF9+mHQ=;
 b=VxxzX0ABP1/aW7PCRcTlWdHgqEcZ9NIXJQLi3GaXmNmD0GI7H1VVeu78qYEnphhLlnwOzI
 Jna+uUFU/pyY5B/V/A+LI+7CqLrYBpTrr6rRszBwWvhKqJNHOmKQxlRn1TzUf0dJyFNeiu
 kHcxOW+SAhpCqDXTwgB5SFoJU5yq1/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-PbV-bnoEMKWFVs7IF8eIFA-1; Mon, 13 Nov 2023 06:07:42 -0500
X-MC-Unique: PbV-bnoEMKWFVs7IF8eIFA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4439085A5B5
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 11:07:42 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B4F12166B26;
 Mon, 13 Nov 2023 11:07:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/12] Misc patches for 8.2-rc0
Date: Mon, 13 Nov 2023 12:07:28 +0100
Message-ID: <20231113110740.38270-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit 69680740eafa1838527c90155a7432d51b8ff203:

  Merge tag 'qdev-array-prop' of https://repo.or.cz/qemu/kevin into staging (2023-11-11 11:23:25 +0800)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2023-11-13

for you to fetch changes up to 4409a6d85522925df580554d476161a570bb1ed9:

  hw/audio/es1370: Clean up comment (2023-11-13 11:35:47 +0100)

----------------------------------------------------------------
* Fix compilation with Clang 17 on s390x hosts
* Two small s390x PCI fixes
* Update MAINTAINERS file with more entries
* Fix NetBSD VM test
* Clean up some bad wordings

----------------------------------------------------------------
Eric Auger (1):
      test-resv-mem: Fix CID 1523911

Matthew Rosato (2):
      s390x/pci: bypass vfio DMA counting when using cdev
      s390x/pci: only limit DMA aperture if vfio DMA limit reported

Peter Maydell (1):
      hw/audio/es1370: Clean up comment

Philippe Mathieu-Daudé (1):
      tests/vm/netbsd: Use Python v3.11

Thomas Huth (7):
      host/include/generic/host/atomic128: Fix compilation problem with Clang 17
      MAINTAINERS: Add include/hw/input/pl050.h to the PrimeCell/CMSDK section
      MAINTAINERS: Add hw/input/ads7846.c to the PXA2XX section
      MAINTAINERS: Add hw/display/sii9022.c to the Versatile Express section
      MAINTAINERS: Extend the Stellaris section
      MAINTAINERS: Add a general architecture section for x86
      tests/tsan: Rename the file with the entries that should be ignored

 MAINTAINERS                                | 16 ++++++++++++++++
 docs/devel/testing.rst                     |  4 ++--
 host/include/generic/host/atomic128-cas.h  |  2 +-
 host/include/generic/host/atomic128-ldst.h |  2 +-
 include/qemu/int128.h                      |  2 ++
 hw/audio/es1370.c                          |  9 +++++++--
 hw/s390x/s390-pci-vfio.c                   |  6 +++++-
 tests/unit/test-resv-mem.c                 |  4 ++++
 tests/tsan/{blacklist.tsan => ignore.tsan} |  6 +++---
 tests/vm/netbsd                            |  4 ++--
 10 files changed, 43 insertions(+), 12 deletions(-)
 rename tests/tsan/{blacklist.tsan => ignore.tsan} (57%)


