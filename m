Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CD7AC09DC
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 12:32:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3Bg-00033E-6H; Thu, 22 May 2025 06:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3Bc-00032r-WF
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3Ba-0006PQ-Bd
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QlUv3WXzN1tjBcwFhwjIM/PQQRTgeOpjkK85tto1bTY=;
 b=Kh8qhjr7emiqK8WPy0kDsQ0ILkMe8krrdCErNCTpszlrHdSZMQuRQJklaz6miHirwCd1i7
 Y90ParLl4ohzswxfzCGGnOTiHpZRnQ1SQtEy58KpcJpqKQdB1IGkUy2nWwerw59XFyAGrq
 GAXfrlHUQCmI2vczmouzNY+8Cg52N6Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-PAOKFCZYPfyTwSVNlPRuWA-1; Thu,
 22 May 2025 06:29:57 -0400
X-MC-Unique: PAOKFCZYPfyTwSVNlPRuWA-1
X-Mimecast-MFC-AGG-ID: PAOKFCZYPfyTwSVNlPRuWA_1747909796
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1F8D18004AD; Thu, 22 May 2025 10:29:56 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 74AB81958014; Thu, 22 May 2025 10:29:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/23] Revert "scripts: mandate that new files have
 SPDX-License-Identifier"
Date: Thu, 22 May 2025 11:29:08 +0100
Message-ID: <20250522102923.309452-9-berrange@redhat.com>
In-Reply-To: <20250522102923.309452-1-berrange@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit fa4d79c64dae03ffa269e42e21822453856618b7.

The logic in this commit was flawed in two critical ways

 * It always failed to report SPDX validation on the last newly
   added file. IOW, it only worked if at least 2 new files were
   added in a commit

 * If an existing file change, followed a new file change, in
   the commit and the existing file context/changed lines
   included SPDX-License-Identifier, it would incorrectly
   associate this with the previous newly added file.

Simply reverting this commit will make it significantly easier to
understand the improved logic in the following commit.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 365892de04..d355c0dad5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1442,8 +1442,6 @@ sub process {
 	my $in_imported_file = 0;
 	my $in_no_imported_file = 0;
 	my $non_utf8_charset = 0;
-	my $expect_spdx = 0;
-	my $expect_spdx_file;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -1681,34 +1679,6 @@ sub process {
 			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
 		}
 
-# All new files should have a SPDX-License-Identifier tag
-		if ($line =~ /^new file mode\s*\d+\s*$/) {
-		    if ($expect_spdx) {
-			if ($expect_spdx_file =~
-			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
-			    # source code files MUST have SPDX license declared
-			    ERROR("New file '$expect_spdx_file' requires " .
-				  "'SPDX-License-Identifier'");
-			} else {
-			    # Other files MAY have SPDX license if appropriate
-			    WARN("Does new file '$expect_spdx_file' need " .
-				 "'SPDX-License-Identifier'?");
-			}
-		    }
-		    $expect_spdx = 1;
-		    $expect_spdx_file = undef;
-		} elsif ($expect_spdx) {
-		    $expect_spdx_file = $realfile unless
-			defined $expect_spdx_file;
-
-		    # SPDX tags may occurr in comments which were
-		    # stripped from '$line', so use '$rawline'
-		    if ($rawline =~ /SPDX-License-Identifier/) {
-			$expect_spdx = 0;
-			$expect_spdx_file = undef;
-		    }
-		}
-
 # Check SPDX-License-Identifier references a permitted license
 		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
 		    &checkspdx($realfile, $1);
-- 
2.49.0


