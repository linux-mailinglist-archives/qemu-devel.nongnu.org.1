Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C48CAABC543
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 19:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH40R-0005wq-HJ; Mon, 19 May 2025 13:10:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH40O-0005vr-SR
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:10:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH40M-0001Ya-Tm
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747674621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AcM26vXczQLNBJGv0uqc1uZ7aik0JS+BDC4m3OHXOGM=;
 b=SpZHdEX677wkzHhQkHeY6EEk4yayp1/1KWHDQwZ0HZRN3zwn/fOmv+gqcfASMOcY8l/5Yo
 jufAeHnDlyRlC/HYqolWYv/WeHoL9UaW+KBeMHhA8dRRoV9gg8HdSjiwO4O9u977JwPmOv
 Ibc73KJZKUfk3D9wxJbtR9JiYrFwjeg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-8MekADBVN5eAwhWqFHD9bw-1; Mon,
 19 May 2025 13:10:19 -0400
X-MC-Unique: 8MekADBVN5eAwhWqFHD9bw-1
X-Mimecast-MFC-AGG-ID: 8MekADBVN5eAwhWqFHD9bw_1747674618
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDC05180048E; Mon, 19 May 2025 17:10:17 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3993619560AA; Mon, 19 May 2025 17:10:15 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v5 4/9] scripts/checkpatch: use new hook for ACPI test data
 check
Date: Mon, 19 May 2025 18:09:59 +0100
Message-ID: <20250519171004.352636-5-berrange@redhat.com>
In-Reply-To: <20250519171004.352636-1-berrange@redhat.com>
References: <20250519171004.352636-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The ACPI test data check needs to analyse a list of all files in a
commit, so can use the new hook for processing the file list.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 61 ++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 82056dcd24..60c26dca06 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1330,29 +1330,6 @@ sub WARN {
 	}
 }
 
-# According to tests/qtest/bios-tables-test.c: do not
-# change expected file in the same commit with adding test
-sub checkfilename {
-	my ($name, $acpi_testexpected, $acpi_nontestexpected) = @_;
-
-        # Note: shell script that rebuilds the expected files is in the same
-        # directory as files themselves.
-        # Note: allowed diff list can be changed both when changing expected
-        # files and when changing tests.
-	if ($name =~ m#^tests/data/acpi/# and not $name =~ m#^\.sh$#) {
-		$$acpi_testexpected = $name;
-	} elsif ($name !~ m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
-		$$acpi_nontestexpected = $name;
-	}
-	if (defined $$acpi_testexpected and defined $$acpi_nontestexpected) {
-		ERROR("Do not add expected files together with tests, " .
-		      "follow instructions in " .
-		      "tests/qtest/bios-tables-test.c: both " .
-		      $$acpi_testexpected . " and " .
-		      $$acpi_nontestexpected . " found\n");
-	}
-}
-
 sub checkspdx {
     my ($file, $expr) = @_;
 
@@ -1438,6 +1415,34 @@ sub checkspdx {
 # real filenames that were seen in the patch
 sub process_file_list {
 	my @fileinfos = @_;
+
+	# According to tests/qtest/bios-tables-test.c: do not
+	# change expected file in the same commit with adding test
+	my @acpi_testexpected;
+	my @acpi_nontestexpected;
+
+	foreach my $fileinfo (@fileinfos) {
+		# Note: shell script that rebuilds the expected files is in
+		# the same directory as files themselves.
+		# Note: allowed diff list can be changed both when changing
+		#  expected files and when changing tests.
+		if ($fileinfo->{filenew} =~ m#^tests/data/acpi/# &&
+		    $fileinfo->{filenew} !~ m#^\.sh$#) {
+			push @acpi_testexpected, $fileinfo->{filenew};
+		} elsif ($fileinfo->{filenew} !~
+			 m#^tests/qtest/bios-tables-test-allowed-diff.h$#) {
+			push @acpi_nontestexpected, $fileinfo->{filenew};
+		}
+	}
+	if (int(@acpi_testexpected) > 0 and int(@acpi_nontestexpected) > 0) {
+		ERROR("Do not add expected files together with tests, " .
+		      "follow instructions in " .
+		      "tests/qtest/bios-tables-test.c. Files\n\n  " .
+		      join("\n  ", @acpi_testexpected) .
+		      "\n\nand\n\n  " .
+		      join("\n  ", @acpi_nontestexpected) .
+		      "\n\nfound in the same patch\n");
+	}
 }
 
 # Called at the start of processing a diff hunk for a file
@@ -1502,9 +1507,6 @@ sub process {
 	my %suppress_whiletrailers;
 	my %suppress_export;
 
-        my $acpi_testexpected;
-        my $acpi_nontestexpected;
-
 	# Pre-scan the patch sanitizing the lines.
 
 	sanitise_line_reset();
@@ -1643,7 +1645,6 @@ sub process {
 			$fileold =~ s@^([^/]*)/@@ if (!$file);
 			$filenew =~ s@^([^/]*)/@@ if (!$file);
 			$realfile = $filenew;
-	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
 
 			$fileinfo = {
 				"isgit" => 1,
@@ -1677,8 +1678,6 @@ sub process {
 			$realfile = $1;
 			$realfile =~ s@^([^/]*)/@@ if (!$file);
 
-	                checkfilename($realfile, \$acpi_testexpected, \$acpi_nontestexpected);
-
 			$p1_prefix = $1;
 			if (!$file && $tree && $p1_prefix ne '' &&
 			    -e "$root/$p1_prefix") {
@@ -1771,9 +1770,7 @@ sub process {
 		     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
 		     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
 		      (defined($1) || defined($2)))) &&
-                      !(($realfile ne '') &&
-                        defined($acpi_testexpected) &&
-                        ($realfile eq $acpi_testexpected))) {
+		    $realfile !~ m#^tests/data/acpi/#) {
 			$reported_maintainer_file = 1;
 			WARN("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
 		}
-- 
2.49.0


