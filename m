Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9E57E4130
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 14:51:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0MSD-0008K0-JY; Tue, 07 Nov 2023 08:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MS8-000816-16
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r0MS5-0007OK-Gb
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 08:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699364943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=inSvZf/3JIdlqSEd0ljIYOciiXThvhGN8/zR4RlwoqU=;
 b=P4MOhgiF3sZKw3tSHAZX8b0j5ck1GBiwmBFmCxezHGetq5goEmUJt7fqJn9poE5/2HU2j7
 oOsDEHHMvQCObqXxdkg+3aRqwyq0fEJAOsonq1A/jccbQYpkaE6xdqUZiTGcuuT+VuCkkG
 /OHlT7e/VPdtxJLVGAEN/jj/6tix9fg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-H01tHjzXNJ-WtakOZNecXQ-1; Tue, 07 Nov 2023 08:49:01 -0500
X-MC-Unique: H01tHjzXNJ-WtakOZNecXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 660748528E6
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 13:48:45 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B34031C0A956;
 Tue,  7 Nov 2023 13:48:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com
Subject: [PULL 00/11] qdev: Make array properties user accessible again
Date: Tue,  7 Nov 2023 14:48:17 +0100
Message-ID: <20231107134828.35909-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit bb541a7068d2eee51a9abbe2dedcdf27298b1872:

  Merge tag 'pull-pa-20231106' of https://gitlab.com/rth7680/qemu into staging (2023-11-07 15:01:17 +0800)

are available in the Git repository at:

  https://repo.or.cz/qemu/kevin.git qdev-array-prop

for you to fetch changes up to d6df0059910b13071c15bba3b061aaed5bfdb5da:

  qdev: Rework array properties based on list visitor (2023-11-07 14:43:37 +0100)

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

 include/hw/qdev-properties.h     |  57 ++++++----
 include/qom/object.h             |   8 ++
 hw/arm/mps2-tz.c                 |  10 +-
 hw/arm/mps2.c                    |  12 ++-
 hw/arm/sbsa-ref.c                |   7 +-
 hw/arm/vexpress.c                |  21 ++--
 hw/arm/virt.c                    |  31 +++---
 hw/arm/xlnx-versal.c             |   9 +-
 hw/core/qdev-properties-system.c |   2 +-
 hw/core/qdev-properties.c        | 224 +++++++++++++++++++++++++--------------
 hw/i386/pc.c                     |   8 +-
 hw/rx/rx62n.c                    |  19 ++--
 qom/object.c                     |   6 ++
 13 files changed, 266 insertions(+), 148 deletions(-)


