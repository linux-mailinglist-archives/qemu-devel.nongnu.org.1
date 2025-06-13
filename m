Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0142AD9690
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Jun 2025 22:40:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQBBh-0006BO-Q9; Fri, 13 Jun 2025 16:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQBAa-0004Om-Oz
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:38:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uQBAZ-0005Gj-8p
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 16:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749847114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M9Pic9u0SAGuTiZR9R8w60irKdbuoJr7Oywb6RlenAA=;
 b=YTKrlrVJNY0UPep0z6ehEemR7O2U0eSbucKf5JNHtwF6Iiu+LgGshsilYX0nsrJnQvQ5af
 xBOfRyiuykcX6WK0qInt+BjKMUWkQTmdnb69K9vma3fLWJ48MAGbG8QvnQ86E93EMPQ+Ar
 ZS/so0n9m+WSRpRYtWFTBMjnHbGkBKI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-RQ2DiqTTP0aP4EAxrzR92Q-1; Fri,
 13 Jun 2025 16:38:31 -0400
X-MC-Unique: RQ2DiqTTP0aP4EAxrzR92Q-1
X-Mimecast-MFC-AGG-ID: RQ2DiqTTP0aP4EAxrzR92Q_1749847109
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3A0E180028C; Fri, 13 Jun 2025 20:38:28 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.65.203])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB02930044CC; Fri, 13 Jun 2025 20:38:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 17/18] qapi: add cross-references to yank.json
Date: Fri, 13 Jun 2025 16:36:19 -0400
Message-ID: <20250613203620.1283814-18-jsnow@redhat.com>
In-Reply-To: <20250613203620.1283814-1-jsnow@redhat.com>
References: <20250613203620.1283814-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/yank.json | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/qapi/yank.json b/qapi/yank.json
index 9bd8ecce27f..931d4b22d4b 100644
--- a/qapi/yank.json
+++ b/qapi/yank.json
@@ -9,7 +9,7 @@
 ##
 # @YankInstanceType:
 #
-# An enumeration of yank instance types.  See @YankInstance for more
+# An enumeration of `yank` instance types.  See `YankInstance` for more
 # information.
 #
 # Since: 6.0
@@ -20,7 +20,7 @@
 ##
 # @YankInstanceBlockNode:
 #
-# Specifies which block graph node to yank.  See @YankInstance for
+# Specifies which block graph node to `yank`.  See `YankInstance` for
 # more information.
 #
 # @node-name: the name of the block graph node
@@ -33,7 +33,7 @@
 ##
 # @YankInstanceChardev:
 #
-# Specifies which character device to yank.  See @YankInstance for
+# Specifies which character device to `yank`.  See `YankInstance` for
 # more information.
 #
 # @id: the chardev's ID
@@ -46,20 +46,20 @@
 ##
 # @YankInstance:
 #
-# A yank instance can be yanked with the @yank qmp command to recover
+# A `yank` instance can be yanked with the `yank` qmp command to recover
 # from a hanging QEMU.
 #
-# @type: yank instance type
+# @type: `yank` instance type
 #
-# Currently implemented yank instances:
+# Currently implemented `yank` instances:
 #
 # - nbd block device: Yanking it will shut down the connection to the
 #   nbd server without attempting to reconnect.
 # - socket chardev: Yanking it will shut down the connected socket.
 # - migration: Yanking it will shut down all migration connections.
-#   Unlike @migrate_cancel, it will not notify the migration process,
+#   Unlike `migrate_cancel`, it will not notify the migration process,
 #   so migration will go into @failed state, instead of @cancelled
-#   state.  @yank should be used to recover from hangs.
+#   state.  `yank` should be used to recover from hangs.
 #
 # Since: 6.0
 ##
@@ -74,7 +74,7 @@
 # @yank:
 #
 # Try to recover from hanging QEMU by yanking the specified instances.
-# See @YankInstance for more information.
+# See `YankInstance` for more information.
 #
 # @instances: the instances to be yanked
 #
@@ -100,7 +100,7 @@
 ##
 # @query-yank:
 #
-# Query yank instances.  See @YankInstance for more information.
+# Query `yank` instances.  See `YankInstance` for more information.
 #
 #
 # .. qmp-example::
-- 
2.48.1


