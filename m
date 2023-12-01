Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A495800D1D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:26:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94SS-0008Rm-Le; Fri, 01 Dec 2023 09:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r94SQ-0008RB-M9
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:25:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r94SO-0006mN-TH
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701440727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=/GQad3gdIgV+/LMczo3IO7cBLrKJcmOMQJfCvNjmmMo=;
 b=LGmvV9j9UUCNcPJJfCPi7ubVSDpMLK9wJiFWNJ0f+UoDYgMBtrXJ7jIOdOIofJfFBUAcXv
 jjFHZyOBzH2yonoHUr6JM3ZE2OSVI9Mw7xgXS+/7Pn3bkvWH8hnrX4ZP3y+XMBIumErALD
 z8wK+9kNAswzCtTUE6sKvcBTcpjGbL8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-a3xGrd0nNSyI3spXQJrXDA-1; Fri, 01 Dec 2023 09:25:24 -0500
X-MC-Unique: a3xGrd0nNSyI3spXQJrXDA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B076811E7D;
 Fri,  1 Dec 2023 14:25:24 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C197B1C060AE;
 Fri,  1 Dec 2023 14:25:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] block: Make snapshots fail gracefully on inactive images
Date: Fri,  1 Dec 2023 15:25:17 +0100
Message-ID: <20231201142520.32255-1-kwolf@redhat.com>
MIME-Version: 1.0
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

Kevin Wolf (3):
  block: Fix crash when loading snapshot on inactive node
  vl: Improve error message for conflicting -incoming and -loadvm
  iotests: Basic tests for internal snapshots

 block/snapshot.c                              |   4 +-
 system/vl.c                                   |   4 +
 .../tests/qcow2-internal-snapshots            | 170 ++++++++++++++++++
 .../tests/qcow2-internal-snapshots.out        | 107 +++++++++++
 4 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/tests/qcow2-internal-snapshots
 create mode 100644 tests/qemu-iotests/tests/qcow2-internal-snapshots.out

-- 
2.43.0


