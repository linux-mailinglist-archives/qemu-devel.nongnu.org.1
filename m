Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D7A14F6C
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 13:43:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYlfl-0003pz-1r; Fri, 17 Jan 2025 07:42:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlfh-0003jv-RI
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlfg-0008OC-4J
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:41:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737117711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KXf6PxSUQ9yIrDcM5OXYcyszX+HHbMzUhivospHhLYc=;
 b=CGROTPdCvyeBCYHlkwL2+DHqoHZSrhUXPo7+TN0OHNjd/91RhpWjgSZ1gmecthkKyy8CdW
 dAUp2tbmRb0BrDcFCW/OEfIJxgZHEMlpiwWwHq4rv6HxpvCbHWvBw4kKPbyfTNcHtMZyRU
 ZsutbG9NxuHnb6+oRvvDJyEqgAxhMwU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-rnxOrVXUMJWuGSXJp4F_lQ-1; Fri,
 17 Jan 2025 07:41:47 -0500
X-MC-Unique: rnxOrVXUMJWuGSXJp4F_lQ-1
X-Mimecast-MFC-AGG-ID: rnxOrVXUMJWuGSXJp4F_lQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8283E1955DD7; Fri, 17 Jan 2025 12:41:41 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6395195605F; Fri, 17 Jan 2025 12:41:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 1/3] scripts: mandate that new files have
 SPDX-License-Identifier
Date: Fri, 17 Jan 2025 12:41:34 +0000
Message-ID: <20250117124136.3389778-2-berrange@redhat.com>
In-Reply-To: <20250117124136.3389778-1-berrange@redhat.com>
References: <20250117124136.3389778-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
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

Going forward we want all newly created source files to have an
SPDX-License-Identifier tag present.

Initially mandate this for C, Python, Perl, Shell source files,
as well as JSON (QAPI) and Makefiles, while encouraging users
to consider it for other file types.

Reviewed-by: Brian Cain <bcain@quicinc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 06d07e6c22..01f25aa88d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1378,6 +1378,8 @@ sub process {
 	my $in_imported_file = 0;
 	my $in_no_imported_file = 0;
 	my $non_utf8_charset = 0;
+	my $expect_spdx = 0;
+	my $expect_spdx_file;
 
 	our @report = ();
 	our $cnt_lines = 0;
@@ -1615,6 +1617,34 @@ sub process {
 			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
 		}
 
+# All new files should have a SPDX-License-Identifier tag
+		if ($line =~ /^new file mode\s*\d+\s*$/) {
+		    if ($expect_spdx) {
+			if ($expect_spdx_file =~
+			    /\.(c|h|py|pl|sh|json|inc|Makefile)$/) {
+			    # source code files MUST have SPDX license declared
+			    ERROR("New file '$expect_spdx_file' requires " .
+				  "'SPDX-License-Identifer'");
+			} else {
+			    # Other files MAY have SPDX license if appropriate
+			    WARNING("Does new file '$expect_spdx_file' need " .
+				    "'SPDX-License-Identifer'?");
+			}
+		    }
+		    $expect_spdx = 1;
+		    $expect_spdx_file = undef;
+		} elsif ($expect_spdx) {
+		    $expect_spdx_file = $realfile unless
+			defined $expect_spdx_file;
+
+		    # SPDX tags may occurr in comments which were
+		    # stripped from '$line', so use '$rawline'
+		    if ($rawline =~ /SPDX-License-Identifier/) {
+			$expect_spdx = 0;
+			$expect_spdx_file = undef;
+		    }
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
2.47.1


