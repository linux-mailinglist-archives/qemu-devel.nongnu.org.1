Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 458737DD68D
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:05:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxtyn-0004g8-Iq; Tue, 31 Oct 2023 15:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtyT-0004P3-Lc
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxtxq-00069i-Cz
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698778785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqrr02uN+z5c7BudcVMcP+TzuU0wbGWhKEfZ0sMqlWw=;
 b=JvQm64GNzkUxTpADrpycTHECjCijs5tfLbU+Ueqs3bJpknxlu0Ho+XkVCoesy6cZR/g3ms
 wW7DdpfLHLDJRvYtypSeAZ6cit6fMCmaJs7nsx5UR+GOBoOk3iYyuiQyKWd+WKzJcpxvBA
 R7X15tCl2YPVzZmvhwFB5lmvmoB5gIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-dQ867sSBMiK0-6Xi8Tz4bQ-1; Tue, 31 Oct 2023 14:59:29 -0400
X-MC-Unique: dQ867sSBMiK0-6Xi8Tz4bQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C781F85A5B5;
 Tue, 31 Oct 2023 18:59:28 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37BCA143;
 Tue, 31 Oct 2023 18:59:28 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 10/27] iotests: Test media change with iothreads
Date: Tue, 31 Oct 2023 19:59:01 +0100
Message-ID: <20231031185918.346940-11-kwolf@redhat.com>
In-Reply-To: <20231031185918.346940-1-kwolf@redhat.com>
References: <20231031185918.346940-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

iotests case 118 already tests all relevant operations for media change
with multiple devices, however never with iothreads. This changes the
test so that the virtio-scsi tests run with an iothread.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20231013153302.39234-3-kwolf@redhat.com>
Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/118 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index 10dc47459f..6a4210c219 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -277,7 +277,8 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
                                    'file.driver=file',
                                    'file.filename=%s' % old_img ])
         if self.interface == 'scsi':
-            self.vm.add_device('virtio-scsi-pci')
+            self.vm.add_object('iothread,id=iothread0')
+            self.vm.add_device('virtio-scsi-pci,iothread=iothread0')
         self.vm.add_device('%s,drive=drive0,id=%s' %
                            (interface_to_device_name(self.interface),
                             self.device_name))
@@ -312,7 +313,8 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
         if self.use_drive:
             self.vm.add_drive(None, 'media=%s' % self.media, 'none')
         if self.interface == 'scsi':
-            self.vm.add_device('virtio-scsi-pci')
+            self.vm.add_object('iothread,id=iothread0')
+            self.vm.add_device('virtio-scsi-pci,iothread=iothread0')
         self.vm.add_device('%s,%sid=%s' %
                            (interface_to_device_name(self.interface),
                             'drive=drive0,' if self.use_drive else '',
-- 
2.41.0


