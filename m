Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C40703243
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyaiK-0006Ef-GM; Mon, 15 May 2023 12:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahy-0005NG-83
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1pyahu-0002Ab-1I
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684166753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YTcjmxqtSvVPGQaZ0SXB++FKN48c2ec24jCxFpCBrLs=;
 b=Fqwe5wpacpFJzOsqLVFe7s1oUifxM/N3kl7xChzak+aBoK2vJbDEc867pi7WZ75e4nGAf3
 8t9QCfe/R0Vhmw69J1xzessAD5k30gtIWaT26gsnkQF1eTRz6GPha5XOx3olvXDcnPupzn
 AFM37y1fezOxGzVjiHaagP9gJEB15R0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-QRnZstKdPvKDqMrWGTrxOw-1; Mon, 15 May 2023 12:05:50 -0400
X-MC-Unique: QRnZstKdPvKDqMrWGTrxOw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AC0D32812944;
 Mon, 15 May 2023 16:05:48 +0000 (UTC)
Received: from localhost (unknown [10.39.192.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28B2BC15BA0;
 Mon, 15 May 2023 16:05:47 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, kvm@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Fam Zheng <fam@euphon.net>,
 Sam Li <faithilikerun@gmail.com>
Subject: [PULL v2 16/16] docs/zoned-storage:add zoned emulation use case
Date: Mon, 15 May 2023 12:05:06 -0400
Message-Id: <20230515160506.1776883-17-stefanha@redhat.com>
In-Reply-To: <20230515160506.1776883-1-stefanha@redhat.com>
References: <20230515160506.1776883-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

From: Sam Li <faithilikerun@gmail.com>

Add the documentation about the example of using virtio-blk driver
to pass the zoned block devices through to the guest.

Signed-off-by: Sam Li <faithilikerun@gmail.com>
Message-id: 20230508051916.178322-5-faithilikerun@gmail.com
[Fix pre-formatted code syntax
--Stefan]
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/devel/zoned-storage.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/devel/zoned-storage.rst b/docs/devel/zoned-storage.rst
index da78db2783..30296d3c85 100644
--- a/docs/devel/zoned-storage.rst
+++ b/docs/devel/zoned-storage.rst
@@ -41,3 +41,22 @@ APIs for zoned storage emulation or testing.
 For example, to test zone_report on a null_blk device using qemu-io is::
 
   $ path/to/qemu-io --image-opts -n driver=host_device,filename=/dev/nullb0 -c "zrp offset nr_zones"
+
+To expose the host's zoned block device through virtio-blk, the command line
+can be (includes the -device parameter)::
+
+  -blockdev node-name=drive0,driver=host_device,filename=/dev/nullb0,cache.direct=on \
+  -device virtio-blk-pci,drive=drive0
+
+Or only use the -drive parameter::
+
+  -driver driver=host_device,file=/dev/nullb0,if=virtio,cache.direct=on
+
+Additionally, QEMU has several ways of supporting zoned storage, including:
+(1) Using virtio-scsi: --device scsi-block allows for the passing through of
+SCSI ZBC devices, enabling the attachment of ZBC or ZAC HDDs to QEMU.
+(2) PCI device pass-through: While NVMe ZNS emulation is available for testing
+purposes, it cannot yet pass through a zoned device from the host. To pass on
+the NVMe ZNS device to the guest, use VFIO PCI pass the entire NVMe PCI adapter
+through to the guest. Likewise, an HDD HBA can be passed on to QEMU all HDDs
+attached to the HBA.
-- 
2.40.1


