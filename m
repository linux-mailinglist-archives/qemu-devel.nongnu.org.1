Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1AD47E7E1B
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 18:25:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1VE7-0004VX-Tp; Fri, 10 Nov 2023 12:23:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r1VDx-0004UE-Vj
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:23:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r1VDw-0001HE-0t
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 12:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699636994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sAKUJF/E0XKKCKsMpuI2I2dBDENV4ZzJj8jwY/xFeX4=;
 b=PojUwZLU4Yq8EcAULAGO2u6FEBOEPYPs9T47kqCBVHJp8ZQMyvwknlWgUaFYYLOFu5E5hX
 p9qtLloVKaltlKK1VYNDktb9KDOyLmD7AbuGcE1siiz0hTlsM+tzFsLQb3Y47G+eAPGVBQ
 OFn+22pH3XaKkicz86uOj6yZu1u+ZT0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-ZZ_im5IeMw-ecw3LAPHw8A-1; Fri,
 10 Nov 2023 12:23:13 -0500
X-MC-Unique: ZZ_im5IeMw-ecw3LAPHw8A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E139F29ABA19
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 17:23:12 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D23E1121306;
 Fri, 10 Nov 2023 17:23:12 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL v2 00/11] qdev: Make array properties user accessible again
Date: Fri, 10 Nov 2023 18:23:05 +0100
Message-ID: <20231110172305.29107-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit ea10c3817814b8be75be22c78ea91d633b0d2532:

  Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-11-10 08:10:43 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git tags/qdev-array-prop

for you to fetch changes up to b06f8b500da2a5a73dfb15de17cd96ad2385fdc7:

  qdev: Rework array properties based on list visitor (2023-11-10 18:19:19 +0100)

----------------------------------------------------------------
qdev: Make array properties user accessible again

----------------------------------------------------------------
Kevin Wolf (11):
      hw/i386/pc: Use qdev_prop_set_array()
      hw/arm/mps2-tz: Use qdev_prop_set_array()
      hw/arm/mps2: Use qdev_prop_set_array()
      hw/arm/sbsa-ref: Use qdev_prop_set_array()
      hw/arm/vexpress: Use qdev_prop_set_array()
      hw/arm/virt: Use qdev_prop_set_array()
      hw/arm/xlnx-versal: Use qdev_prop_set_array()
      hw/rx/rx62n: Use qdev_prop_set_array()
      qom: Add object_property_set_default_list()
      qdev: Make netdev properties work as list elements
      qdev: Rework array properties based on list visitor

 include/hw/qdev-properties.h     |  35 +++---
 include/qom/object.h             |   8 ++
 hw/arm/mps2-tz.c                 |  10 +-
 hw/arm/mps2.c                    |  12 +-
 hw/arm/sbsa-ref.c                |   7 +-
 hw/arm/vexpress.c                |  21 ++--
 hw/arm/virt.c                    |  31 ++---
 hw/arm/xlnx-versal.c             |   9 +-
 hw/core/qdev-properties-system.c |   2 +-
 hw/core/qdev-properties.c        | 237 ++++++++++++++++++++++++++-------------
 hw/i386/pc.c                     |   8 +-
 hw/rx/rx62n.c                    |  19 ++--
 qom/object.c                     |   6 +
 13 files changed, 257 insertions(+), 148 deletions(-)


