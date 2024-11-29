Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AE9D24DB
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Nov 2024 12:30:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDMQ5-0006Hh-5q; Tue, 19 Nov 2024 06:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDMQ1-0006HI-8R
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:29:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tDMPz-0002gu-PC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 06:29:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732015754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjHw+rM/xFiWzRF6JRDZUYcBXpHlF84F+omw36DJmyA=;
 b=TYjHqn9qUbbd/weURIyBnI3zDA2UIIWRZ5cfAaXjIuucWJzHDGCWDA74boW1IrV04ynLXT
 Cq5wvoffE964ljO4TFlgdSVeGYT7ZMUrFSV98vAJDL7xQotUm3UBaydHtHYvWn3isMxDFq
 L4/hbQOpOdZoFrQpghLAKDlqApDfcSQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-684-au10FTZFMoaoSlqxxLz67w-1; Tue,
 19 Nov 2024 06:29:12 -0500
X-MC-Unique: au10FTZFMoaoSlqxxLz67w-1
X-Mimecast-MFC-AGG-ID: au10FTZFMoaoSlqxxLz67w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 067CE1955EE9; Tue, 19 Nov 2024 11:29:12 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.110])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A75EA19560A3; Tue, 19 Nov 2024 11:29:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] scripts: forbid use of arbitrary SPDX tags besides
 license identifiers
Date: Tue, 19 Nov 2024 11:29:03 +0000
Message-ID: <20241119112903.1010350-4-berrange@redhat.com>
In-Reply-To: <20241119112903.1010350-1-berrange@redhat.com>
References: <20241119112903.1010350-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index b507da8e2b..888b670d43 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1709,6 +1709,18 @@ sub process {
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
2.46.0


