Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 224CEA58204
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:43:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCC4-0002fl-Qi; Sun, 09 Mar 2025 04:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCB9-0000mU-16
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCB7-0002iI-Fz
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wg+vE2XW8XbeutKPbz1Cqy4vPolUw4ouDrgiQ62+Cac=;
 b=jMVdyCmSs0YMgjDk0qnhzsykFnJ5bAfU7P6rdHwVxc3oQsj0OGhc8ZtqO9tMevooH7/997
 ouwjlW488kz/TS/QhLYE+nGAFsgHoM2HAMKYAqBOmLYG8/PwPJzpIZ+ouJv87uEOPusNn9
 iO6haUsJwySf7sHH0v7QTzEO1HC/bbk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-sOy5bzxjOGSd1Zuz_q_XZw-1; Sun,
 09 Mar 2025 04:38:28 -0400
X-MC-Unique: sOy5bzxjOGSd1Zuz_q_XZw-1
X-Mimecast-MFC-AGG-ID: sOy5bzxjOGSd1Zuz_q_XZw_1741509507
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E7D8180AF6A; Sun,  9 Mar 2025 08:38:27 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 617E419560AB; Sun,  9 Mar 2025 08:38:25 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 61/62] docs: enable qapidoc transmogrifier for QEMU QMP
 Reference
Date: Sun,  9 Mar 2025 04:35:48 -0400
Message-ID: <20250309083550.5155-62-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

We are not enabling the transmogrifier for QSD or QGA yet because we
don't (yet) have a way to create separate indices, and all of the
definitions will bleed together, which isn't so nice.

For now, QMP is better than nothing at all!

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/interop/qemu-qmp-ref.rst | 1 +
 qapi/qapi-schema.json         | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/docs/interop/qemu-qmp-ref.rst b/docs/interop/qemu-qmp-ref.rst
index f94614a0b2f..e95eeac45e2 100644
--- a/docs/interop/qemu-qmp-ref.rst
+++ b/docs/interop/qemu-qmp-ref.rst
@@ -7,3 +7,4 @@ QEMU QMP Reference Manual
    :depth: 3
 
 .. qapi-doc:: qapi/qapi-schema.json
+   :transmogrify:
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 2877aff73d0..4475e81cc3e 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -5,6 +5,8 @@
 #
 # This document describes all commands currently supported by QMP.
 #
+# For locating a particular item, please see the `qapi-index`.
+#
 # Most of the time their usage is exactly the same as in the user
 # Monitor, this means that any other document which also describe
 # commands (the manpage, QEMU's manual, etc) can and should be
-- 
2.48.1


