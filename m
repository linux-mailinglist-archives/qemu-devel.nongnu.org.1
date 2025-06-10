Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 525AEAD36DA
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Jun 2025 14:43:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyGE-00038q-Ra; Tue, 10 Jun 2025 08:39:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyFU-0001bD-6M
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:38:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uOyFJ-0000Ub-A4
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749559099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=toEkH1s5f8vci1RuoAYo3gtCYWNbPS0arYGBo09vN/A=;
 b=MMwx+L6wavSVMyhu7CR3bqqOXiX4332CJMCbqFDjPZVxLk6wY9NDhLdXpSvx1RzouNLOoq
 Xm+w3kyYaS+a9L30QofLfcxRFpGH5v9ATZD9dc65NY6kgDTUYgnDQMBKs16D8sM0xhHs/v
 7D/TA9GpSAU0p8TMDtcOprs+hXmh3mU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-SNu3Yd67OuatdxZ3En6zqA-1; Tue,
 10 Jun 2025 08:38:15 -0400
X-MC-Unique: SNu3Yd67OuatdxZ3En6zqA-1
X-Mimecast-MFC-AGG-ID: SNu3Yd67OuatdxZ3En6zqA_1749559094
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82CC418089B4; Tue, 10 Jun 2025 12:38:14 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.87])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CDAC930001B1; Tue, 10 Jun 2025 12:38:11 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 23/31] hw/nvme/ctrl: skip automatic zero-init of large arrays
Date: Tue, 10 Jun 2025 13:37:01 +0100
Message-ID: <20250610123709.835102-24-berrange@redhat.com>
In-Reply-To: <20250610123709.835102-1-berrange@redhat.com>
References: <20250610123709.835102-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The 'nvme_map_sgl' method has a 256 element array used for copying
data from the device. Skip the automatic zero-init of this array
to eliminate the performance overhead in the I/O hot path.

The 'segment' array will be fully initialized when reading data from
the device.

The 'nme_changed_nslist' method has a 4k byte array that is manually
initialized with memset(). The compiler ought to be intelligent
enough to turn the memset() into a static initialization operation,
and thus not duplicate the automatic zero-init. Replacing memset()
with '{}' makes it unambiguous that the array is statically initialized.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/nvme/ctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index fd935507bc..220002830d 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1057,7 +1057,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
      */
 #define SEG_CHUNK_SIZE 256
 
-    NvmeSglDescriptor segment[SEG_CHUNK_SIZE], *sgld, *last_sgld;
+    QEMU_UNINITIALIZED NvmeSglDescriptor segment[SEG_CHUNK_SIZE];
+    NvmeSglDescriptor *sgld, *last_sgld;
     uint64_t nsgld;
     uint32_t seg_len;
     uint16_t status;
@@ -5128,7 +5129,7 @@ static uint16_t nvme_error_info(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
 static uint16_t nvme_changed_nslist(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
                                     uint64_t off, NvmeRequest *req)
 {
-    uint32_t nslist[1024];
+    uint32_t nslist[1024] = {};
     uint32_t trans_len;
     int i = 0;
     uint32_t nsid;
@@ -5138,7 +5139,6 @@ static uint16_t nvme_changed_nslist(NvmeCtrl *n, uint8_t rae, uint32_t buf_len,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    memset(nslist, 0x0, sizeof(nslist));
     trans_len = MIN(sizeof(nslist) - off, buf_len);
 
     while ((nsid = find_first_bit(n->changed_nsids, NVME_CHANGED_NSID_SIZE)) !=
-- 
2.49.0


