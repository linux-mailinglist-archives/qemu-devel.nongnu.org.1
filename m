Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 377197D4AA5
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCz3-0004RA-Ix; Tue, 24 Oct 2023 04:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyz-0004KW-KG
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyx-0003Sy-UU
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698136907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LCp3AYBhBG3mDrqT6tO9NXD2VXeACBOwSKm4rlSu9xk=;
 b=jQ2ztbBMoxRDaij/j7HehfdzZEPExYFrhOxkGj7dGXfDe+hu4jYNTIEf91XMxr80etg3jy
 83OFTTimWtDORiKMxwISVgXHvIApH7/tucn+C2S0gPfUS33BGo7hQvVjeu1JScaM0DetYF
 4tk1wY0x1nXWms/MnOJbYRHa3xiQVMI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-Y-ZUxls1MVmdDlquaqdkUQ-1; Tue, 24 Oct 2023 04:41:27 -0400
X-MC-Unique: Y-ZUxls1MVmdDlquaqdkUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D272185AD06;
 Tue, 24 Oct 2023 08:41:27 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7A2892166B26;
 Tue, 24 Oct 2023 08:41:26 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 9/9] docs/migration: reflect the changes about needed
 subsections
Date: Tue, 24 Oct 2023 12:40:43 +0400
Message-ID: <20231024084043.2926316-10-marcandre.lureau@redhat.com>
In-Reply-To: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/migration.rst | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index c3e1400c0c..50f313f178 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -240,17 +240,16 @@ a newer form of device, or adding that state that you previously
 forgot to migrate.  This is best solved using a subsection.
 
 A subsection is "like" a device vmstate, but with a particularity, it
-has a Boolean function that tells if that values are needed to be sent
-or not.  If this functions returns false, the subsection is not sent.
-Subsections have a unique name, that is looked for on the receiving
-side.
+has a Boolean function that tells if that values are needed or not. If
+this functions returns false, the subsection is not sent. Subsections
+have a unique name, that is looked for on the receiving side.
 
 On the receiving side, if we found a subsection for a device that we
-don't understand, we just fail the migration.  If we understand all
-the subsections, then we load the state with success.  There's no check
-that a subsection is loaded, so a newer QEMU that knows about a subsection
-can (with care) load a stream from an older QEMU that didn't send
-the subsection.
+don't understand, we just fail the migration. If we understand all the
+subsections, then we load the state with success. There's no check
+that an optional subsection is loaded, so a newer QEMU that knows
+about a subsection can (with care) load a stream from an older QEMU
+that didn't send the subsection.
 
 If the new data is only needed in a rare case, then the subsection
 can be made conditional on that case and the migration will still
-- 
2.41.0


