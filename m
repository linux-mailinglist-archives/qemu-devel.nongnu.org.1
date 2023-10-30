Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E56097DBBBB
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 15:27:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxTEb-0006Oz-HC; Mon, 30 Oct 2023 10:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTEa-0006OP-8V
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxTET-0007PG-BP
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 10:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698676027;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QcLaGxMw1IOX2a8+6Krl5rSlMXUVaL325CgVTiThsRY=;
 b=ZrTlnsV14Co/+1eCuReZhRKFYkJzR1XQ/a1MqtCOmS+oQDcGxByFyA6OHyW7hIl+cAiT4V
 knmdqiQQFkSTwLCc9HS+3DCKYAU0gYWhTSNB3PDDyU3rO9wVqy10m9j/vpDwrqNPF3FHPV
 wMwhU8M4zeSc8yq2vuxHflCgtWADEsM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-57-66xW1tRSO5u6Nuq6EPBC5A-1; Mon,
 30 Oct 2023 10:27:06 -0400
X-MC-Unique: 66xW1tRSO5u6Nuq6EPBC5A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1529F1C05AAD;
 Mon, 30 Oct 2023 14:27:06 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B299492BE0;
 Mon, 30 Oct 2023 14:27:04 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 00/12] qdev: Make array properties user accessible again
Date: Mon, 30 Oct 2023 15:26:46 +0100
Message-ID: <20231030142658.182193-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
lists. See patch 12 for details.

v2:
- Patch 1: Use unsigned instead of uint32_t
- Patch 9: Fixed build error
- Patch 11: Split into a separate patch to clarify the intention
- Patch 12:
  * Improved the commit message
  * Document and statically assert alignment requirements for array
    elements (the static assertion turned out to be much uglier than I
    had hoped, but it is what it is)
  * Replace UB in pointer arithmetics with uintptr_t calculations
  * Fix properties without a .release callback
  * Check array size for integer overflow
  * Call visit_check_list() even for output visitors
- Coding style changes

Kevin Wolf (12):
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
  qdev: Make netdev properties work as list elements
  qdev: Rework array properties based on list visitor

 include/hw/qdev-properties.h     |  62 ++++++---
 include/qom/object.h             |   8 ++
 hw/arm/mps2-tz.c                 |  10 +-
 hw/arm/mps2.c                    |  12 +-
 hw/arm/sbsa-ref.c                |   7 +-
 hw/arm/vexpress.c                |  21 +--
 hw/arm/virt.c                    |  31 +++--
 hw/arm/xlnx-versal.c             |   9 +-
 hw/core/qdev-properties-system.c |   2 +-
 hw/core/qdev-properties.c        | 217 +++++++++++++++++++++----------
 hw/i386/pc.c                     |   8 +-
 hw/rx/rx62n.c                    |  19 +--
 qom/object.c                     |   6 +
 13 files changed, 278 insertions(+), 134 deletions(-)

-- 
2.41.0


