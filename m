Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2718C9483DE
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Aug 2024 23:10:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb4xK-0000Z3-KE; Mon, 05 Aug 2024 17:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xF-00009t-3J
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sb4xB-0008TO-4j
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 17:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722892154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8S4R7oZAhxgp9+WrqCsInnag+q6eChG8pRT5Mw+3qaA=;
 b=bSSckfScUPXnn6e9MBnz9qRJ+v2CpzJcdXI5Ae7mcJ/+NwFxB7z3tUUdr/NS1lWdDLw+Ss
 hHinHickllZvZBMio2wViClNmk4XRzIqspPDxyjb4pll/k6JYO9J9NEuRARobb7ygYxnpS
 zEH7B8KSW6olmAK0u3sOfsjBE98JSYw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-oO8LGGZzOMeggQp4xQtN5A-1; Mon,
 05 Aug 2024 17:09:12 -0400
X-MC-Unique: oO8LGGZzOMeggQp4xQtN5A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 68A101955D44; Mon,  5 Aug 2024 21:09:11 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF50D30001AA; Mon,  5 Aug 2024 21:09:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 05/13] scsi-block: Don't skip callback for sgio error
 status/driver_status
Date: Mon,  5 Aug 2024 23:08:43 +0200
Message-ID: <20240805210851.314076-6-kwolf@redhat.com>
In-Reply-To: <20240805210851.314076-1-kwolf@redhat.com>
References: <20240805210851.314076-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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

Instead of calling into scsi_handle_rw_error() directly from
scsi_block_sgio_complete() and skipping the normal callback, go through
the normal cleanup path by calling the callback with a positive error
value.

The important difference here is not only that the code path is cleaner,
but that the callbacks set r->req.aiocb = NULL. If we skip setting this
and the error action is BLOCK_ERROR_ACTION_STOP, resuming the VM runs
into an assertion failure in scsi_read_data() or scsi_write_data()
because the dangling aiocb pointer is unexpected.

Fixes: a108557bbf ("scsi: inline sg_io_sense_from_errno() into the callers.")
Buglink: https://issues.redhat.com/browse/RHEL-50000
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20240731123207.27636-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 3ff6798bde..6e1a5c98df 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2832,16 +2832,6 @@ static void scsi_block_sgio_complete(void *opaque, int ret)
         } else {
             ret = io_hdr->status;
         }
-
-        if (ret > 0) {
-            if (scsi_handle_rw_error(r, ret, true)) {
-                scsi_req_unref(&r->req);
-                return;
-            }
-
-            /* Ignore error.  */
-            ret = 0;
-        }
     }
 
     req->cb(req->cb_opaque, ret);
-- 
2.45.2


