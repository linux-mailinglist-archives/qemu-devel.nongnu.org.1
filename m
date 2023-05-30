Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB397169AB
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 18:34:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q42IF-0008AA-2C; Tue, 30 May 2023 12:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HW-0006bL-5q
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1q42HO-0008HW-7M
 for qemu-devel@nongnu.org; Tue, 30 May 2023 12:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685464381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eEbrIWHNsw3oAC1xjBUi+vQde6gFmeUaa662q/As5gU=;
 b=IGnUvQwArTnE9ZquqavZshg4Pt6O0rwQxAIeP0zxvHB9rVPwJA3EQ0mvqk8RnAC6n3RFxL
 U6ldgczlBsdwMvPBhLVIE62DcNMEQK1KiUV1xJYIBYMS3u5Bm3OBN+xMQD19dRdZrF0brT
 C/dN1FmryfujzPm0Q7HsXGk5UGAiXaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-ObF70y9mMS-qAlCzxyZ5Hw-1; Tue, 30 May 2023 12:32:57 -0400
X-MC-Unique: ObF70y9mMS-qAlCzxyZ5Hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94FD3101AA44;
 Tue, 30 May 2023 16:32:57 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD985C154D2;
 Tue, 30 May 2023 16:32:56 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 11/32] iotests: Make verify_virtio_scsi_pci_or_ccw() public
Date: Tue, 30 May 2023 18:32:18 +0200
Message-Id: <20230530163239.576632-12-kwolf@redhat.com>
In-Reply-To: <20230530163239.576632-1-kwolf@redhat.com>
References: <20230530163239.576632-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

It has no internal callers, so its only use is being called from
individual test cases. If the name starts with an underscore, it is
considered private and linters warn against calling it. 256 only gets
away with it currently because it's on the exception list for linters.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230525124713.401149-12-kwolf@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 tests/qemu-iotests/256        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7073579a7d..ef66fbd62b 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1421,7 +1421,7 @@ def _verify_virtio_blk() -> None:
     if 'virtio-blk' not in out:
         notrun('Missing virtio-blk in QEMU binary')
 
-def _verify_virtio_scsi_pci_or_ccw() -> None:
+def verify_virtio_scsi_pci_or_ccw() -> None:
     out = qemu_pipe('-M', 'none', '-device', 'help')
     if 'virtio-scsi-pci' not in out and 'virtio-scsi-ccw' not in out:
         notrun('Missing virtio-scsi-pci or virtio-scsi-ccw in QEMU binary')
diff --git a/tests/qemu-iotests/256 b/tests/qemu-iotests/256
index 13666813bd..d7e67f4a05 100755
--- a/tests/qemu-iotests/256
+++ b/tests/qemu-iotests/256
@@ -24,7 +24,7 @@ import os
 import iotests
 from iotests import log
 
-iotests._verify_virtio_scsi_pci_or_ccw()
+iotests.verify_virtio_scsi_pci_or_ccw()
 
 iotests.script_initialize(supported_fmts=['qcow2'])
 size = 64 * 1024 * 1024
-- 
2.40.1


