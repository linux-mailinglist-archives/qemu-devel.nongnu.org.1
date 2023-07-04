Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A64F746C38
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGbc9-00029d-Jh; Tue, 04 Jul 2023 04:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qGbc4-00029T-Pt
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:42:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1qGbc3-0000PD-4w
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688460137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ng/ecASVryPUWeUCjgvL1EG9cG/qRB0bmFWKEPyPWG8=;
 b=HW2IibWYdRcUDwFI/gURIuFTQxblPKkjxGkBufIdDNIdlYBbnzux2nA5dVDczouQ5vtCPa
 s/i3ythFYlx6A3XUd0lLLhfMB2RifA5NHFm0hFvYThD1lvKf9NjeQqtU4iITFarwhRvOkX
 yjpu/x1UDMieNh8gs7qMDrpJI0G86b8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-343-hv990zZ6Nl-HETGtMWLvZQ-1; Tue, 04 Jul 2023 04:42:14 -0400
X-MC-Unique: hv990zZ6Nl-HETGtMWLvZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 363AA8A2E21;
 Tue,  4 Jul 2023 08:42:14 +0000 (UTC)
Received: from f38-work.redhat.com (unknown [10.39.193.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 33B53C00049;
 Tue,  4 Jul 2023 08:42:13 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Cc: mcascell@redhat.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 kevin.denis@synacktiv.com
Subject: [PATCH] ui/vnc-clipboard: fix infinite loop in inflate_buffer
 (CVE-2023-3255)
Date: Tue,  4 Jul 2023 10:41:22 +0200
Message-ID: <20230704084210.101822-1-mcascell@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
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

A wrong exit condition may lead to an infinite loop when inflating a
valid zlib buffer containing some extra bytes in the `inflate_buffer`
function. The bug only occurs post-authentication. Return the buffer
immediately if the end of the compressed data has been reached
(Z_STREAM_END).

Fixes: CVE-2023-3255
Fixes: 0bf41cab ("ui/vnc: clipboard support")
Reported-by: Kevin Denis <kevin.denis@synacktiv.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
---
 ui/vnc-clipboard.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 8aeadfaa21..c759be3438 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -50,8 +50,11 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
         ret = inflate(&stream, Z_FINISH);
         switch (ret) {
         case Z_OK:
-        case Z_STREAM_END:
             break;
+        case Z_STREAM_END:
+            *size = stream.total_out;
+            inflateEnd(&stream);
+            return out;
         case Z_BUF_ERROR:
             out_len <<= 1;
             if (out_len > (1 << 20)) {
@@ -66,11 +69,6 @@ static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
         }
     }
 
-    *size = stream.total_out;
-    inflateEnd(&stream);
-
-    return out;
-
 err_end:
     inflateEnd(&stream);
 err:
-- 
2.41.0


