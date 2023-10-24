Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F677D4AA1
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:42:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCyu-0004Fw-L5; Tue, 24 Oct 2023 04:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCya-00048e-8z
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyY-0003OX-Oq
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698136881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMfsu1D3Em5HyaSgl6VAZL8RSeHOmIYpXte1yU4sBcs=;
 b=ToT6vPiVFFR9MJbsUtgYuMeKTp7LpAHPSsbLxmrCAEbNMSu3oMhe+rwQ5N3+eaoJBoFJAd
 gWMIErjMp22bC9Mf606VqJxxQfjhZvmLsDBY47auIAHUd/ND1us6NjYwyE/R9nECAah1A7
 5XJ4lkPLuSjvl57m8R0dUAI4zmmcpso=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-JNJFnvLTNSmafGL3_WoVPw-1; Tue,
 24 Oct 2023 04:41:18 -0400
X-MC-Unique: JNJFnvLTNSmafGL3_WoVPw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C45F1C05AD7;
 Tue, 24 Oct 2023 08:41:18 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70BCE492BD9;
 Tue, 24 Oct 2023 08:41:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 7/9] migration: set file error on subsection loading
Date: Tue, 24 Oct 2023 12:40:41 +0400
Message-ID: <20231024084043.2926316-8-marcandre.lureau@redhat.com>
In-Reply-To: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

commit 13cde50889237 ("vmstate: Return error in case of error") sets
QemuFile error to stop reading from it and report to the caller (checked
by unit tests). We should do the same on subsection loading error.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/vmstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index d6fe38a5e1..be2193158f 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -179,6 +179,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
     assert(field->flags == VMS_END);
     ret = vmstate_subsection_load(f, vmsd, opaque);
     if (ret != 0) {
+        qemu_file_set_error(f, ret);
         return ret;
     }
     if (vmsd->post_load) {
-- 
2.41.0


