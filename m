Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1BBABC547
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 19:11:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH40e-00060q-Jc; Mon, 19 May 2025 13:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH40b-0005zp-04
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH40Z-0001Zz-8t
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bHxr2avKZwMQbb4Nt5uTm7UKAaDRZw9/aTaWTEK5ZtI=;
 b=ON1Ze26T9LkFU6cB01I9ympb0TIQwAIap6RVr9/1gOqsLHTFQpBOEdnINTIQCH32gQu0sM
 jyYzCgmq/z2BMkUDJlQdBy8T8AW/zfEaUk2Peo1FxAOPK7Zx1fhMOK7p+jOepAKktVc+Uc
 QfDC71+LQOiWFs1tw+ER55ZNgekuebc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-6xq7pAJwPZicjOjCx8xOvg-1; Mon,
 19 May 2025 13:10:31 -0400
X-MC-Unique: 6xq7pAJwPZicjOjCx8xOvg-1
X-Mimecast-MFC-AGG-ID: 6xq7pAJwPZicjOjCx8xOvg_1747674629
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DC0E1800368; Mon, 19 May 2025 17:10:29 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABA0D19560AA; Mon, 19 May 2025 17:10:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 9/9] scripts/checkpatch: reject license boilerplate on new
 files
Date: Mon, 19 May 2025 18:10:04 +0100
Message-ID: <20250519171004.352636-10-berrange@redhat.com>
In-Reply-To: <20250519171004.352636-1-berrange@redhat.com>
References: <20250519171004.352636-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The previous commit mandates use of SPDX-License-Identifier on common
source files, and encourages it on all other files.

Some contributors are none the less still also including the license
boilerplate text. This is redundant and will potentially cause
trouble if inconsistent with the SPDX declaration.

Match common boilerplate text blurbs and report them as invalid,
for newly added files.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index dc2c3e6aa1..17b8db40ad 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -365,6 +365,18 @@ our @typeList = (
 	qr{guintptr},
 );
 
+# Match text found in common license boilerplate comments:
+# for new files the SPDX-License-Identifier line is sufficient.
+our @LICENSE_BOILERPLATE = (
+	"licensed under the terms of the GNU GPL",
+	"under the terms of the GNU General Public License",
+	"under the terms of the GNU Lesser General Public",
+	"Permission is hereby granted, free of charge",
+	"GNU GPL, version 2 or later",
+	"See the COPYING file"
+);
+our $LICENSE_BOILERPLATE_RE = join("|", @LICENSE_BOILERPLATE);
+
 # Load common spelling mistakes and build regular expression list.
 my $misspellings;
 my %spelling_fix;
@@ -1497,6 +1509,13 @@ sub process_end_of_file {
 			     "' need 'SPDX-License-Identifier'?");
 		}
 	}
+	if ($fileinfo->{action} eq "new" &&
+	    exists $fileinfo->{facts}->{sawboilerplate}) {
+		ERROR("New file '" . $fileinfo->{filenew} . "' must " .
+		      "not have license boilerplate header text, only " .
+		      "the SPDX-License-Identifier, unless this file was " .
+		      "copied from existing code already having such text.");
+	}
 }
 
 sub process {
@@ -1799,6 +1818,10 @@ sub process {
 			&checkspdx($realfile, $1);
 		}
 
+		if ($rawline =~ /$LICENSE_BOILERPLATE_RE/) {
+			$fileinfo->{facts}->{sawboilerplate} = 1;
+		}
+
 		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
 			my $tag = $1;
 			my @permitted = qw(
-- 
2.49.0


