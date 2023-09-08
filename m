Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 349A97988F6
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 16:39:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeccM-0005ZM-K9; Fri, 08 Sep 2023 10:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccH-0005Sb-Ev
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeccF-00074x-5v
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 10:37:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694183866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=vGCaEd2USgjt4FPb3zJfFoQQvORRQreviVwnMUX9oII=;
 b=K+bytJ7ui1gFhJEngcgTXpj9XsskQ6aAbJVnHrBpo1KZfp77jKhVxIu6RprZAlA0IUfH2n
 tpsgCmR1PdZj6Jywo8RsPpiqeDb24h/jbrWl5AEtuXzuPzng6Q+f6SeuFIfE8VCV2j8JPs
 vlBvsdSieGx+dWhXdPtXA4ms0wGOydo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-3Mtvl6ojP2GIfoWreZmQfg-1; Fri, 08 Sep 2023 10:37:43 -0400
X-MC-Unique: 3Mtvl6ojP2GIfoWreZmQfg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8E88948FE0;
 Fri,  8 Sep 2023 14:37:42 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.193.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEBDE140E962;
 Fri,  8 Sep 2023 14:37:41 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Subject: [PATCH 00/11] qdev: Make array properties user accessible again
Date: Fri,  8 Sep 2023 16:36:51 +0200
Message-ID: <20230908143703.172758-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Array properties have been inaccessible since commit f3558b1b both on
the command line and in QMP. This series reworks them so that they are
made accessible again in these external interfaces, this time as JSON
lists. See patch 11 for details.

Kevin Wolf (11):
  qdev: Add qdev_prop_set_array()
  hw/i386/pc: Use qdev_prop_set_array()
  hw/arm/mps2-tz: Use qdev_prop_set_array()
  hw/arm/mps2: Use qdev_prop_set_array()
  hw/arm/sbsa-ref: Use qdev_prop_set_array()
  hw/arm/vexpress: Use qdev_prop_set_array()
  hw/arm/virt: Use qdev_prop_set_array()
  hw/arm/xlnx-versal: Use qdev_prop_set_array()
  hw/rx/rx62n: Use qdev_prop_set_array()
  qom: Add object_property_set_default_list()
  qdev: Rework array properties based on list visitor

 include/hw/qdev-properties.h     |  26 ++--
 include/qom/object.h             |   8 ++
 hw/arm/mps2-tz.c                 |  10 +-
 hw/arm/mps2.c                    |  12 +-
 hw/arm/sbsa-ref.c                |   7 +-
 hw/arm/vexpress.c                |  21 ++--
 hw/arm/virt.c                    |  31 ++---
 hw/arm/xlnx-versal.c             |   9 +-
 hw/core/qdev-properties-system.c |   2 +-
 hw/core/qdev-properties.c        | 197 ++++++++++++++++++++-----------
 hw/i386/pc.c                     |   8 +-
 hw/rx/rx62n.c                    |  19 +--
 qom/object.c                     |   6 +
 13 files changed, 227 insertions(+), 129 deletions(-)

-- 
2.41.0


