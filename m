Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A44A14F6D
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Jan 2025 13:43:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYlff-0003es-5k; Fri, 17 Jan 2025 07:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlfd-0003eS-5Z
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:41:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYlfb-0008Nn-Gg
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 07:41:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737117710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XngVGLXTSadpJgMbE9fRr6XaEIXLeTK1mNEUBzv8rzo=;
 b=fzpdvhC0f6690j2f/1k2+unPSv/S7HqjgHbFrG6qVQYwFb26xcYXogazPV6383gW2q+H9Y
 O21pRrRpKBFUl6JP00gJOhUtDFe32jtnI5J2/MMigF/B/wu5i8LV7DWaTfQ2U+d8ujmcKo
 uibUHXoeKvqb6T9ayMHlCk+2u6V7pgY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-ODlUJT2iP8Grf_Zs9EqncA-1; Fri,
 17 Jan 2025 07:41:46 -0500
X-MC-Unique: ODlUJT2iP8Grf_Zs9EqncA-1
X-Mimecast-MFC-AGG-ID: ODlUJT2iP8Grf_Zs9EqncA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09AAA1955D82; Fri, 17 Jan 2025 12:41:46 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.60])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 123E519560BF; Fri, 17 Jan 2025 12:41:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/3] scripts: forbid use of arbitrary SPDX tags besides
 license identifiers
Date: Fri, 17 Jan 2025 12:41:36 +0000
Message-ID: <20250117124136.3389778-4-berrange@redhat.com>
In-Reply-To: <20250117124136.3389778-1-berrange@redhat.com>
References: <20250117124136.3389778-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
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

While SPDX-License-Identifier is a well known SPDX tag, there are a
great many more besides that[1]. These are mostly focused on making
machine readable metadata available to the 'reuse' tool and similar.
They cover concepts like author names, copyright owners, and much
more. It is even possible to define source file line groups and apply
different SPDX tags to regions of code within a file.

At this time we're only interested in adopting SPDX for recording the
file global licensing info, so detect & reject any other SPDX metadata.
If we want to explicitly collect extra data in SPDX format, we can
evaluate each data item on its merits when someone wants to propose it
at a later date.

[1] https://spdx.github.io/spdx-spec/v2.2.2/file-tags/
    https://spdx.github.io/spdx-spec/v2.2.2/file-information/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/checkpatch.pl | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 8995d2c391..83b59fb443 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1714,6 +1714,18 @@ sub process {
 		    &checkspdx($realfile, $1);
 		}
 
+		if ($rawline =~ m,(SPDX-[a-zA-Z0-9-_]+):,) {
+		    my $tag = $1;
+		    my @permitted = qw(
+			SPDX-License-Identifier
+		    );
+
+		    unless (grep { /^$tag$/ } @permitted) {
+			ERROR("Tag $tag not permitted in QEMU code, valid " .
+			      "choices are: " . join(", ", @permitted));
+		    }
+		}
+
 # Check for wrappage within a valid hunk of the file
 		if ($realcnt != 0 && $line !~ m{^(?:\+|-| |\\ No newline|$)}) {
 			ERROR("patch seems to be corrupt (line wrapped?)\n" .
-- 
2.47.1


