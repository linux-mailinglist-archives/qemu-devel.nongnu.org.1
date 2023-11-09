Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD27E7097
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:44:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1941-0003kT-VK; Thu, 09 Nov 2023 12:43:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193z-0003hO-2o
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r193u-0004rJ-Jc
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699551805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUdLdyp2BLHwpHRCpxCQS29+TL1qZOiGNAFhpjfVwyo=;
 b=AX2x3y4caOvtQuC8GsVKWXM11lGqeAWvRloaVuYuYBK5x/lSCEm/aSSGC1ymZjSTeq6MXb
 ZDw88tvl/M2zTfVh123cDEY5oTu9/SVWF819gQKHkbnTzf3246xb6pcQ7hg8W3v1xcZcXc
 L5ZkfVNv197g6zhUoiFBdE75itkgzKs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-S_yr74wPOTa9oZOMqc47AA-1; Thu, 09 Nov 2023 12:43:22 -0500
X-MC-Unique: S_yr74wPOTa9oZOMqc47AA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3665E101A52D;
 Thu,  9 Nov 2023 17:43:22 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CEA620268F8;
 Thu,  9 Nov 2023 17:43:21 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v3 10/11] qdev: Make netdev properties work as list elements
Date: Thu,  9 Nov 2023 18:42:39 +0100
Message-ID: <20231109174240.72376-11-kwolf@redhat.com>
In-Reply-To: <20231109174240.72376-1-kwolf@redhat.com>
References: <20231109174240.72376-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The 'name' parameter of QOM setters is primarily used to specify the name
of the currently parsed input element in the visitor interface. For
top-level qdev properties, this is always set and matches 'prop->name'.

However, for list elements it is NULL, because each element of a list
doesn't have a separate name. Passing a non-NULL value runs into
assertion failures in the visitor code.

Therefore, using 'name' in error messages is not right for property
types that are used in lists, because "(null)" (or even a segfault)
isn't very helpful to identify what QEMU is complaining about.

Change netdev properties to use 'prop->name' instead, which will contain
the name of the array property after switching array properties to lists
in the external interface. (This is still not perfect, as it doesn't
identify which element in the list caused the error, but strictly better
than before.)

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/qdev-properties-system.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index b46d16cd2c..1473ab3d5e 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -450,7 +450,7 @@ static void set_netdev(Object *obj, Visitor *v, const char *name,
     peers_ptr->queues = queues;
 
 out:
-    error_set_from_qdev_prop_error(errp, err, obj, name, str);
+    error_set_from_qdev_prop_error(errp, err, obj, prop->name, str);
     g_free(str);
 }
 
-- 
2.41.0


