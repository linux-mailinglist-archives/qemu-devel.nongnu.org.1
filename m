Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB14A581B1
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Mar 2025 09:38:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCAX-0006Tx-Rw; Sun, 09 Mar 2025 04:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAO-00067U-8f
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAL-0002YG-S0
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FhNc4XlKtZhVDqpp/h1XYzOnc0rVdthJ98dnkqQG2fU=;
 b=aiK/a3OUCqP1oLVZ5LrT9Bv/vGUqkzwBpXqMs/Rdf9blF8riJCrXIxn6LT3n7LoAW8J46j
 t76RTCfi9QfiNsA3ghaT8Cjqe8a0+yGo9j0P/U1f9Kke6K3G0M6qsG6JEz4tc1N06EkGt7
 C2/xkqXoNHuOdFFjrQ8uhX8GV4nmecM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-vV4ydShjOvaQPPg2o8xOEw-1; Sun,
 09 Mar 2025 04:37:39 -0400
X-MC-Unique: vV4ydShjOvaQPPg2o8xOEw-1
X-Mimecast-MFC-AGG-ID: vV4ydShjOvaQPPg2o8xOEw_1741509458
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECF1B195608F; Sun,  9 Mar 2025 08:37:37 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B6F619560AB; Sun,  9 Mar 2025 08:37:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 41/62] qapi/source: allow multi-line QAPISourceInfo
 advancing
Date: Sun,  9 Mar 2025 04:35:28 -0400
Message-ID: <20250309083550.5155-42-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is for the sake of the new rST generator (the "transmogrifier") so
we can advance multiple lines on occasion while keeping the
generated<-->source mappings accurate.

next_line now simply takes an optional n parameter which chooses the
number of lines to advance.

RFC: Here's the exorbitant detail on why I want this:

This is used mainly when converting section syntax in free-form
documentation to more traditional rST section header syntax, which
does not always line up 1:1 for line counts.

For example:

```
 ##
 # = Section     <-- Info is pointing here, "L1"
 #
 # Lorem Ipsum
 ##
```

would be transformed to rST as:

```
=======        <-- L1
Section        <-- L1
=======        <-- L1
               <-- L2
Lorem Ipsum    <-- L3
```

After consuming the single "Section" line from the source, we want to
advance the source pointer to the next non-empty line which requires
jumping by more than one line.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/source.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 7b379fdc925..ffdc3f482ac 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
         self.defn_meta = meta
         self.defn_name = name
 
-    def next_line(self: T) -> T:
+    def next_line(self: T, n: int = 1) -> T:
         info = copy.copy(self)
-        info.line += 1
+        info.line += n
         return info
 
     def loc(self) -> str:
-- 
2.48.1


