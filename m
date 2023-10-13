Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F160C7C88BE
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 17:34:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrKAO-0003Of-Oi; Fri, 13 Oct 2023 11:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qrKAM-0003Ng-S4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:33:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qrKAK-00037P-1s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 11:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697211206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=twFSIx+ypsOGhYB3/C5hyPH8eKhiVRYm7iEtgCIFdsA=;
 b=MrMcL6eYPp/Gyyb4qXbLJ8eIvjyevrv6D/HfMm4r+UJEjsgINcGNIIxJvnE+HJUps/foc+
 C+xhRp+otlQyHqJZC2D1X2ZSwLRnDct+Ijk8EJujvjGjhh1PfAed5AGtsTs+GmwZYQHlAL
 aD2KbhN09UK60dcb+XcdGS8IrywTRHY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-3spgbJeNPwGIkk675nZTZA-1; Fri, 13 Oct 2023 11:33:24 -0400
X-MC-Unique: 3spgbJeNPwGIkk675nZTZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 252C23826D3F;
 Fri, 13 Oct 2023 15:33:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.253])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3A0C15BBC;
 Fri, 13 Oct 2023 15:33:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] iotests: Test media change with iothreads
Date: Fri, 13 Oct 2023 17:33:02 +0200
Message-ID: <20231013153302.39234-3-kwolf@redhat.com>
In-Reply-To: <20231013153302.39234-1-kwolf@redhat.com>
References: <20231013153302.39234-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

iotests case 118 already tests all relevant operations for media change
with multiple devices, however never with iothreads. This changes the
test so that the virtio-scsi tests run with an iothread.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/118 | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/118 b/tests/qemu-iotests/118
index cae52ffa5e..bc7533bb54 100755
--- a/tests/qemu-iotests/118
+++ b/tests/qemu-iotests/118
@@ -295,7 +295,8 @@ class TestInitiallyFilled(GeneralChangeTestsBaseClass):
                                    'file.driver=file',
                                    'file.filename=%s' % old_img ])
         if self.interface == 'scsi':
-            self.vm.add_device('virtio-scsi-pci')
+            self.vm.add_object('iothread,id=iothread0')
+            self.vm.add_device('virtio-scsi-pci,iothread=iothread0')
         self.vm.add_device('%s,drive=drive0,id=%s' %
                            (interface_to_device_name(self.interface),
                             self.device_name))
@@ -332,7 +333,8 @@ class TestInitiallyEmpty(GeneralChangeTestsBaseClass):
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


