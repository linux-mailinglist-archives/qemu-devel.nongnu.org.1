Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CA6AC09CE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 May 2025 12:31:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI3Bt-0003AU-I4; Thu, 22 May 2025 06:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3Br-000392-6H
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uI3Bo-0006cs-5t
 for qemu-devel@nongnu.org; Thu, 22 May 2025 06:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747909815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IbbIsrmYqzBf/pcS4JhraC6Fa/Yn5do/AQdr/9z95P8=;
 b=DtfYkINpTXe6FNkAhpqCSBH3UCy10DZek0A0HhRfTvmones9E0I6ApllcHoEfim35WG4yq
 XDeu7P0yZBRDlQutCSk3og+FWLZ86d2LiYi1dcntqNMR8N1aRlPomcE4l1t3LtpD5gZU3G
 8thccy/6DnwW2ZSlQZ7nH0pT27w3omY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-252-4ycuZalKPIyzlZofpUHnuQ-1; Thu,
 22 May 2025 06:30:12 -0400
X-MC-Unique: 4ycuZalKPIyzlZofpUHnuQ-1
X-Mimecast-MFC-AGG-ID: 4ycuZalKPIyzlZofpUHnuQ_1747909811
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00DCC19560AE; Thu, 22 May 2025 10:30:11 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.179])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 01FE51958014; Thu, 22 May 2025 10:30:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/23] scripts/checkpatch: use new hook for file permissions
 check
Date: Thu, 22 May 2025 11:29:12 +0100
Message-ID: <20250522102923.309452-13-berrange@redhat.com>
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

The file permissions check is the kind of check intended to be performed
in the new start of file hook.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 817df98231..881dcac29b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1448,6 +1448,17 @@ sub process_file_list {
 # Called at the start of processing a diff hunk for a file
 sub process_start_of_file {
 	my $fileinfo = shift;
+
+	# Check for incorrect file permissions
+	if ($fileinfo->{action} eq "new" && ($fileinfo->{mode} & 0111)) {
+		my $permhere = $fileinfo->{linestart} . "FILE: " .
+			$fileinfo->{filenew} . "\n";
+		if ($fileinfo->{filenew} =~
+		    /(\bMakefile(?:\.objs)?|\.(c|cc|cpp|h|mak|s|S))$/) {
+			ERROR("do not set execute permissions for source " .
+			      "files\n" . $permhere);
+		}
+	}
 }
 
 # Called at the end of processing a diff hunk for a file
@@ -1719,14 +1730,6 @@ sub process {
 
 		$cnt_lines++ if ($realcnt != 0);
 
-# Check for incorrect file permissions
-		if ($line =~ /^new (file )?mode.*[7531]\d{0,2}$/) {
-			my $permhere = $here . "FILE: $realfile\n";
-			if ($realfile =~ /(\bMakefile(?:\.objs)?|\.c|\.cc|\.cpp|\.h|\.mak|\.[sS])$/) {
-				ERROR("do not set execute permissions for source files\n" . $permhere);
-			}
-		}
-
 # Only allow Python 3 interpreter
 		if ($realline == 1 &&
 			$line =~ /^\+#!\ *\/usr\/bin\/(?:env )?python$/) {
-- 
2.49.0


