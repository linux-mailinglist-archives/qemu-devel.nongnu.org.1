Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24521AEF85C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Jul 2025 14:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWa4J-0007SE-Fz; Tue, 01 Jul 2025 08:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uWa4A-0007QV-CM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uWa3w-0007Gv-NT
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 08:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751372768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4/IE0kA+tK64lWzA4WBAePbn9r8PxB5eGvpLlW/ki2U=;
 b=fv/KV5p21lwzj55ERbul8iDkN/jYc27kbuBA8aafzThR4ZCJI6b1mO7S5JmVcweH3+3t8Q
 HFVVyoYSlh63Ie1uyNtfDeOBhLm5KdNmTUPGTu6G/yqWWysouFOvI891foQenL/Yp75hg8
 +H7O18+m/SxLb3rNLBBiLrJjAvCwW10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-QxKawMd6NBeMnloD_5T1EA-1; Tue,
 01 Jul 2025 08:26:04 -0400
X-MC-Unique: QxKawMd6NBeMnloD_5T1EA-1
X-Mimecast-MFC-AGG-ID: QxKawMd6NBeMnloD_5T1EA_1751372764
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A9701801207; Tue,  1 Jul 2025 12:26:04 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.225.98])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B70C19560A7; Tue,  1 Jul 2025 12:26:00 +0000 (UTC)
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, Dehan Meng <demeng@redhat.com>,
 Elizabeth Ashurov <eashurov@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 0/3] Misc QGA fixes for 2025-07-01
Date: Tue,  1 Jul 2025 15:25:55 +0300
Message-ID: <20250701122558.31556-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit aec6836c73403cffa56b9a4c5556451ee16071fe:

  Merge tag 'pull-vfio-20250626' of https://github.com/legoater/qemu into staging (2025-06-26 10:25:01 -0400)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-07-01

for you to fetch changes up to 1c90e89e64beb2bd72f8e437c56274c885df7b3f:

  qga/vss-win32: Add VSS provider unregistration retry (2025-06-30 13:17:10 +0300)

----------------------------------------------------------------
qga-pull-2025-07-01

----------------------------------------------------------------
Elizabeth Ashurov (1):
      qga/vss-win32: Add VSS provider unregistration retry

Kostiantyn Kostiuk (2):
      MAINTAINERS: Update Kostiantyn Kostiuk transliteration
      qga-vss: Exit with non-zero code when register fail

 MAINTAINERS               |  4 ++--
 qga/vss-win32/install.cpp | 15 +++++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

--
2.48.1


