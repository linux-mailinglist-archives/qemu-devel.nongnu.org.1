Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3CE8B03DD
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Apr 2024 10:06:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXcI-0007Td-Qd; Wed, 24 Apr 2024 04:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbX-0005t0-5j
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbR-0003n5-LH
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Zunl/HWq8Dw2wpmCVEkJl4ueEcDyCn1CQwpLkNWnB5k=;
 b=NbdpG0vryu3++gLOfG/BHtLrcQLwZjAVr6rvZnfUjJ22pDfg+4FDEJi/WXNAMqrnirpELT
 +JDhKC/4VjDmbBMdkHXteTOoEEU7zeGhiHBV/fpNf6Y2tZ1lrxi0JIs9jAIYCcngOcszNd
 kWQMoDR2jd7wZCTD0ZFAk6Om/Xn0iyQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-fHvQLwp0NsC3dCVV8Cs6Xg-1; Wed, 24 Apr 2024 04:03:38 -0400
X-MC-Unique: fHvQLwp0NsC3dCVV8Cs6Xg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3739E81F309;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 172A02166B31;
 Wed, 24 Apr 2024 08:03:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3676C21E66C8; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 00/10] Error reporting patches for 2024-04-24
Date: Wed, 24 Apr 2024 10:03:27 +0200
Message-ID: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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


The following changes since commit c25df57ae8f9fe1c72eee2dab37d76d904ac382e:

  Update version for 9.0.0 release (2024-04-23 14:19:21 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2024-04-24

for you to fetch changes up to be842efbe3102c6aa1980039f6d4a8f997f1ff8c:

  qapi: Inline and remove QERR_PROPERTY_VALUE_BAD definition (2024-04-24 09:50:58 +0200)

----------------------------------------------------------------
Error reporting patches for 2024-04-24

----------------------------------------------------------------
Markus Armbruster (1):
      error: Drop superfluous #include "qapi/qmp/qerror.h"

Philippe Mathieu-Daudé (9):
      qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
      qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM definition
      qapi: Inline and remove QERR_DEVICE_NO_HOTPLUG definition
      qapi: Inline and remove QERR_INVALID_PARAMETER definition
      qapi: Inline QERR_INVALID_PARAMETER_TYPE definition (constant value)
      qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE definition
      qapi: Correct error message for 'vcpu_dirty_limit' parameter
      qapi: Inline and remove QERR_MIGRATION_ACTIVE definition
      qapi: Inline and remove QERR_PROPERTY_VALUE_BAD definition

 include/qapi/qmp/qerror.h    | 21 ---------------------
 backends/iommufd.c           |  1 -
 block/snapshot.c             |  7 ++++---
 blockdev.c                   |  2 +-
 chardev/char-fe.c            |  1 -
 hw/core/qdev-properties.c    |  3 +--
 hw/core/qdev.c               |  4 ++--
 hw/ppc/spapr_pci.c           |  5 ++---
 migration/migration.c        |  2 +-
 migration/options.c          |  9 ++++-----
 migration/savevm.c           |  2 +-
 qapi/opts-visitor.c          |  2 +-
 qapi/qobject-input-visitor.c | 32 ++++++++++++++++----------------
 qapi/string-input-visitor.c  |  8 ++++----
 qom/object.c                 | 16 ++++++++++------
 system/qdev-monitor.c        | 10 ++++++----
 system/rtc.c                 |  1 -
 util/qemu-option.c           | 10 +++++-----
 scripts/qapi/visit.py        |  5 ++---
 19 files changed, 60 insertions(+), 81 deletions(-)

-- 
2.44.0


