Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFB833368
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 10:54:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rR82j-00080r-Jf; Sat, 20 Jan 2024 04:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82i-00080a-7S
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rR82g-00062q-DN
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 04:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705744412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EkcAOlIpsHu3Yk36ORmBRWTDHkhZ5CeYfkZ72QQhXvQ=;
 b=EaNA/tqFkKIXX2nDT7zoUWsDg7rp5eyzHhicsQbg7Jx6SH9buE67HDCcNUuUttzzd06ygV
 tDNh5Qn+1L9JD9o2rxtQ98IWcs+xZKjdOH5Y+TPXXwlu4Qo1R8Nkb+buIqjS2lCWjXW0Ov
 EORpKt6ZEoSAKtPwNo1DbwXlzJPgvbI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-A4pV4eMYMwCx3IF1GYCf2A-1; Sat, 20 Jan 2024 04:53:28 -0500
X-MC-Unique: A4pV4eMYMwCx3IF1GYCf2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9801185A589;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7339051D5;
 Sat, 20 Jan 2024 09:53:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 556D121E66F9; Sat, 20 Jan 2024 10:53:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com,
	peter.maydell@linaro.org,
	jsnow@redhat.com
Subject: [PATCH 2/7] docs: Replace dangling references to
 docs/interop/qmp-intro.txt
Date: Sat, 20 Jan 2024 10:53:22 +0100
Message-ID: <20240120095327.666239-3-armbru@redhat.com>
In-Reply-To: <20240120095327.666239-1-armbru@redhat.com>
References: <20240120095327.666239-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
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

Deletion of docs/interop/qmp-intro.txt left two dangling references
behind.  Replace them by references to docs/interop/qmp-spec.rst.

Fixes: 0ec4468f233c (docs/interop: Delete qmp-intro.txt)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/writing-monitor-commands.rst | 4 ++--
 docs/interop/bitmaps.rst                | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing-monitor-commands.rst
index 2c11e71665..3b3d5517a2 100644
--- a/docs/devel/writing-monitor-commands.rst
+++ b/docs/devel/writing-monitor-commands.rst
@@ -8,8 +8,8 @@ This document doesn't discuss QMP protocol level details, nor does it dive
 into the QAPI framework implementation.
 
 For an in-depth introduction to the QAPI framework, please refer to
-docs/devel/qapi-code-gen.txt. For documentation about the QMP protocol,
-start with docs/interop/qmp-intro.txt.
+docs/devel/qapi-code-gen.txt.  For the QMP protocol, see the
+:doc:`/interop/qmp-spec`.
 
 New commands may be implemented in QMP only.  New HMP commands should be
 implemented on top of QMP.  The typical HMP command wraps around an
diff --git a/docs/interop/bitmaps.rst b/docs/interop/bitmaps.rst
index 1de46febdc..c731be2f01 100644
--- a/docs/interop/bitmaps.rst
+++ b/docs/interop/bitmaps.rst
@@ -166,9 +166,9 @@ Basic QMP Usage
 ---------------
 
 The primary interface to manipulating bitmap objects is via the QMP
-interface. If you are not familiar, see docs/interop/qmp-intro.txt for a broad
-overview, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full reference of all
-QMP commands.
+interface. If you are not familiar, see the :doc:`qmp-spec` for the
+protocol, and `qemu-qmp-ref <qemu-qmp-ref.html>`_ for a full
+reference of all QMP commands.
 
 Supported Commands
 ~~~~~~~~~~~~~~~~~~
-- 
2.43.0


