Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EECABC4BA
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 18:39:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH3Uz-0002qA-Px; Mon, 19 May 2025 12:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Ux-0002nJ-74
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH3Uv-0005kR-Ff
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747672672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PIUaRKuYcvrrpm/JrbDy5K1w1botK8DhkqScYbEn/0g=;
 b=Z1mSDZMc0EZw/j4BS/aYrSKsLo15YE4vkU8GFpiK9Xne2EDk8ecNoObqh3kHyqhzm58tvw
 wjKhQE3uSHaMCNlZS25UlIdwWFYOyFo5VHRzRSOaawqNj2WHsVp7BPQv4UQPjYqFOiFIeR
 0phl7BhH3VyvKDkS5r0zs9+J91oFrBI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-Cavy5Gi9MQyQjliDmnXwUA-1; Mon,
 19 May 2025 12:37:49 -0400
X-MC-Unique: Cavy5Gi9MQyQjliDmnXwUA-1
X-Mimecast-MFC-AGG-ID: Cavy5Gi9MQyQjliDmnXwUA_1747672668
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C1F61800877; Mon, 19 May 2025 16:37:48 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.50])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5043619560AB; Mon, 19 May 2025 16:37:45 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 8/9] scripts/checkpatch: reimplement mandate for
 SPDX-License-Identifier
Date: Mon, 19 May 2025 17:37:20 +0100
Message-ID: <20250519163721.347322-9-berrange@redhat.com>
In-Reply-To: <20250519163721.347322-1-berrange@redhat.com>
References: <20250519163721.347322-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Going forward we want all newly created source files to have an
SPDX-License-Identifier tag present.

Initially mandate this for C, Python, Perl, Shell source files,
as well as JSON (QAPI) and Makefiles, while encouraging users
to consider it for other file types.

The new attempt at detecting missing SPDX-License-Identifier relies
on the hooks for relying triggering logic at the end of scanning a
new file in the diff.

Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index de6ea2fc14..dc2c3e6aa1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1483,6 +1483,20 @@ sub process_start_of_file {
 # Called at the end of processing a diff hunk for a file
 sub process_end_of_file {
 	my $fileinfo = shift;
+
+	if ($fileinfo->{action} eq "new" &&
+	    !exists $fileinfo->{facts}->{sawspdx}) {
+		if ($fileinfo->{filenew} =~
+		    /(\.(c|h|py|pl|sh|json|inc)|Makefile.*)$/) {
+			# source code files MUST have SPDX license declared
+			ERROR("New file '" . $fileinfo->{filenew} .
+			      "' requires 'SPDX-License-Identifier'");
+		} else {
+			# Other files MAY have SPDX license if appropriate
+			WARN("Does new file '" . $fileinfo->{filenew} .
+			     "' need 'SPDX-License-Identifier'?");
+		}
+	}
 }
 
 sub process {
@@ -1781,6 +1795,7 @@ sub process {
 
 # Check SPDX-License-Identifier references a permitted license
 		if ($rawline =~ m,SPDX-License-Identifier: (.*?)(\*/)?\s*$,) {
+			$fileinfo->{facts}->{sawspdx} = 1;
 			&checkspdx($realfile, $1);
 		}
 
-- 
2.49.0


