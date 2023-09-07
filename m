Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F44E796F59
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 05:43:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qe5uh-0008RR-43; Wed, 06 Sep 2023 23:42:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5uf-0008QO-15
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qe5ub-0007EP-G0
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 23:42:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694058153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=LVLSpaUBpQa4SLxBD6d/Z7BeEuuL74B2QY5AhBlHeR0=;
 b=Q0OCdr8ueICQnjkaeUdktyC7vfV8kgK8os/i0gwGISM9FdtFA37bycXoYwu4cvF5i2LqKE
 CbbP87JrgpSmip3Zsp1DdKWG8S3WJooSqNPH6pjHUErH/EiwQ2rHd4jhFw5ulBj+Agr55l
 ytfG3YpkaGIcOHqz0RlrBZTJIBaCfYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-s8Vm6vBRMG6p-Guh4-5dGw-1; Wed, 06 Sep 2023 23:42:29 -0400
X-MC-Unique: s8Vm6vBRMG6p-Guh4-5dGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3D13800969;
 Thu,  7 Sep 2023 03:42:28 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.43])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 970B210EA0;
 Thu,  7 Sep 2023 03:42:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL for-6.2 0/7] Ide patches
Date: Wed,  6 Sep 2023 23:42:21 -0400
Message-ID: <20230907034228.4054839-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit c152379422a204109f34ca2b43ecc538c7d738ae=
:=0D
=0D
  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu i=
nto staging (2023-09-06 11:16:01 -0400)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/ide-pull-request=0D
=0D
for you to fetch changes up to 9f89423537653de07ca40c18b5ff5b70b104cc93:=0D
=0D
  hw/ide/ahci: fix broken SError handling (2023-09-06 22:48:04 -0400)=0D
=0D
----------------------------------------------------------------=0D
IDE Pull request=0D
=0D
----------------------------------------------------------------=0D
=0D
Niklas Cassel (7):=0D
  hw/ide/core: set ERR_STAT in unsupported command completion=0D
  hw/ide/ahci: write D2H FIS when processing NCQ command=0D
  hw/ide/ahci: simplify and document PxCI handling=0D
  hw/ide/ahci: PxSACT and PxCI is cleared when PxCMD.ST is cleared=0D
  hw/ide/ahci: PxCI should not get cleared when ERR_STAT is set=0D
  hw/ide/ahci: fix ahci_write_fis_sdb()=0D
  hw/ide/ahci: fix broken SError handling=0D
=0D
 tests/qtest/libqos/ahci.h |   8 ++-=0D
 hw/ide/ahci.c             | 110 +++++++++++++++++++++++++++-----------=0D
 hw/ide/core.c             |   2 +-=0D
 tests/qtest/libqos/ahci.c | 106 +++++++++++++++++++++++++++---------=0D
 4 files changed, 163 insertions(+), 63 deletions(-)=0D
=0D
-- =0D
2.41.0=0D
=0D


