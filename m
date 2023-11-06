Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 252EF7E204D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:46:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxuK-0003Xi-An; Mon, 06 Nov 2023 06:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuJ-0003W9-1c
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuH-0003Pr-Hd
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699270596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=svaPW+rZPenlPAj6lm7d9unZr33RLfmLMwt20wLjubk=;
 b=WQqJnm9XByh9hyECQeryB99QilM0Y782Iq9mUfCTp+ieL7LVCiu5CQ8B7pVzcIdXkJtlYW
 iegmBEUBCkfKT6TS9FsDMpYSzwz8T07vxrU2fZAaHradSPARuzkNORHOTm0dndDi3D0u6i
 qr7+0MUtWLXqm6+gbXMA4TBROKVehFo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-m5Mjh_RZPammzu2xEslPVA-1; Mon,
 06 Nov 2023 06:36:35 -0500
X-MC-Unique: m5Mjh_RZPammzu2xEslPVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B20F11C02D45;
 Mon,  6 Nov 2023 11:36:34 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A66F025C0;
 Mon,  6 Nov 2023 11:36:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 6/6] docs/migration: reflect the changes about needed
 subsections
Date: Mon,  6 Nov 2023 15:36:00 +0400
Message-ID: <20231106113601.2052601-7-marcandre.lureau@redhat.com>
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 docs/devel/migration.rst | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 240eb16d90..22875ac40c 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -246,17 +246,16 @@ a newer form of device, or adding that state that you previously
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


