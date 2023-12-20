Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A885819B8A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:42:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5F-0002bV-SO; Wed, 20 Dec 2023 04:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5E-0002bK-Be
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5B-0005m2-O3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j4/1kj4XnLkKcHH2T938jrV1v0VE40TCDJUm/3gcycU=;
 b=EBKhf8hR+GBepJFP76B01h8aM3XS2suDWyIrHhT4IdNORboC1BYviqg2B0TxsjTqe9uPdp
 9XXJpaDofizEjcVvOb1Fxq+8WzBRm1pMNScF2X0Kxy7Li9mTl5nMzh7/JiGNLcDrZcYcBs
 gYuSrMKyNY8Xu88up8NR8xtUt+LwQKw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-ZAdqP3RsPtOuhj_9E9bxVA-1; Wed, 20 Dec 2023 04:41:37 -0500
X-MC-Unique: ZAdqP3RsPtOuhj_9E9bxVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92DFA863061;
 Wed, 20 Dec 2023 09:41:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 490AD2166B31;
 Wed, 20 Dec 2023 09:41:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Yihuan Pan <xun794@gmail.com>
Subject: [PULL 15/19] qemu-options: Clarify handling of commas in options
 parameters
Date: Wed, 20 Dec 2023 10:41:01 +0100
Message-ID: <20231220094105.6588-16-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yihuan Pan <xun794@gmail.com>

Provide explicit guidance on dealing with option parameters as arbitrary
strings containing commas, such as in "file=my,file" and "string=a,b". The
updated documentation emphasizes the need to double commas when they
appear within such parameters.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1839
Signed-off-by: Yihuan Pan <xun794@gmail.com>
Message-ID: <20231213141706.629833-2-xun794@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/system/invocation.rst   | 5 +++++
 docs/system/qemu-manpage.rst | 5 +++++
 qemu-options.hx              | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/docs/system/invocation.rst b/docs/system/invocation.rst
index 4ba38fc23d..14b7db1c10 100644
--- a/docs/system/invocation.rst
+++ b/docs/system/invocation.rst
@@ -10,6 +10,11 @@ Invocation
 disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
 not need a disk image.
 
+When dealing with options parameters as arbitrary strings containing
+commas, such as in "file=my,file" and "string=a,b", it's necessary to
+double the commas. For instance,"-fw_cfg name=z,string=a,,b" will be
+parsed as "-fw_cfg name=z,string=a,b".
+
 .. hxtool-doc:: qemu-options.hx
 
 Device URL Syntax
diff --git a/docs/system/qemu-manpage.rst b/docs/system/qemu-manpage.rst
index c47a412758..3ade4ee45b 100644
--- a/docs/system/qemu-manpage.rst
+++ b/docs/system/qemu-manpage.rst
@@ -31,6 +31,11 @@ Options
 disk_image is a raw hard disk image for IDE hard disk 0. Some targets do
 not need a disk image.
 
+When dealing with options parameters as arbitrary strings containing
+commas, such as in "file=my,file" and "string=a,b", it's necessary to
+double the commas. For instance,"-fw_cfg name=z,string=a,,b" will be
+parsed as "-fw_cfg name=z,string=a,b".
+
 .. hxtool-doc:: qemu-options.hx
 
 .. include:: keys.rst.inc
diff --git a/qemu-options.hx b/qemu-options.hx
index 42fd09e4de..a935aaae44 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4086,9 +4086,13 @@ DEF("fw_cfg", HAS_ARG, QEMU_OPTION_fwcfg,
 SRST
 ``-fw_cfg [name=]name,file=file``
     Add named fw\_cfg entry with contents from file file.
+    If the filename contains comma, you must double it (for instance,
+    "file=my,,file" to use file "my,file").
 
 ``-fw_cfg [name=]name,string=str``
     Add named fw\_cfg entry with contents from string str.
+    If the string contains comma, you must double it (for instance,
+    "string=my,,string" to use file "my,string").
 
     The terminating NUL character of the contents of str will not be
     included as part of the fw\_cfg item data. To insert contents with
-- 
2.43.0


