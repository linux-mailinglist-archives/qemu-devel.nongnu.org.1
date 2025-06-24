Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC33AAE6DE6
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Jun 2025 19:54:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU7pw-0002t0-Ck; Tue, 24 Jun 2025 13:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pm-0002rx-Pr; Tue, 24 Jun 2025 13:53:26 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pk-0002ic-J2; Tue, 24 Jun 2025 13:53:26 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.98.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1uU7pW-00000005WmG-12EG; Tue, 24 Jun 2025 19:53:10 +0200
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Avihai Horon <avihaih@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 0/3] VFIO multifd device state transfer patches for QEMU 10.1
Date: Tue, 24 Jun 2025 19:51:55 +0200
Message-ID: <cover.1750787338.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

When VFIO multifd device state transfer support was merged in QEMU 10.0
some of patches were separated for the future QEMU release after the
spring cleanup.

Since QEMU 10.1 code freeze is getting closer let's have them reviewed
now.

The most important patch from this patch set is the one adding
"x-migration-load-config-after-iter" VFIO property since it is a
correctness fix for an ARM64 platform idiosyncrasy with respect
to VFIO load dependency on interrupt controller being loaded first.

I've also CCed the ARM maintainer and qemu-arm as suggested previously
by Cédric.

Maciej S. Szmigiero (3):
  vfio/migration: Max in-flight VFIO device state buffer count limit
  vfio/migration: Add x-migration-load-config-after-iter VFIO property
  vfio/migration: Add also max in-flight VFIO device state buffers size
    limit

 docs/devel/migration/vfio.rst     |  21 +++++
 hw/core/machine.c                 |   1 +
 hw/vfio/migration-multifd.c       | 125 +++++++++++++++++++++++++++++-
 hw/vfio/migration-multifd.h       |   3 +
 hw/vfio/migration.c               |  10 ++-
 hw/vfio/pci.c                     |  27 +++++++
 hw/vfio/vfio-migration-internal.h |   1 +
 include/hw/vfio/vfio-device.h     |   3 +
 8 files changed, 188 insertions(+), 3 deletions(-)


