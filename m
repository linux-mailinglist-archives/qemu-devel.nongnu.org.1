Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 852897D66C8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:30:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvaCk-00053W-Sx; Wed, 25 Oct 2023 05:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvaCj-00052N-4N
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qvaCh-0001eL-OD
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:29:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698226171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w3cCn7Y916ynZ4//BBn6xyIsbiAWArD9z+qJ58H4kKE=;
 b=edQVq8IDvv8hBVqNZOmdm2IlNJfX0UOAOYKdSusr9aSJGFEqQAY53kSda0Wtou3dEQ2UzY
 YnS4h8TZx6YfYB7VM1jX+34V8Gl3eqe6mDkfSl7erZpTz4P9qijkl9otIcgwcmVI8BjyvX
 7urKb9YHDC3u6/v9pJjbrNHtsfSbZuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-Eh79P9D-NOCF3_7r_QQsNQ-1; Wed, 25 Oct 2023 05:29:26 -0400
X-MC-Unique: Eh79P9D-NOCF3_7r_QQsNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6E6E857CE9;
 Wed, 25 Oct 2023 09:29:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 864012026D66;
 Wed, 25 Oct 2023 09:29:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 843CF21E6A1F; Wed, 25 Oct 2023 11:29:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com
Subject: [PATCH] tests/qapi-schema: Tidy up pylint warnings and advice
Date: Wed, 25 Oct 2023 11:29:25 +0200
Message-ID: <20231025092925.1785934-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pylint warns:

    tests/qapi-schema/test-qapi.py:139:13: W1514: Using open without explicitly specifying an encoding (unspecified-encoding)
    tests/qapi-schema/test-qapi.py:143:13: W1514: Using open without explicitly specifying an encoding (unspecified-encoding)

Add encoding='utf-8'.

Pylint advises:

    tests/qapi-schema/test-qapi.py:143:13: R1732: Consider using 'with' for resource-allocating operations (consider-using-with)

Silence this by returning the value directly.

Pylint advises:

    tests/qapi-schema/test-qapi.py:221:4: R1722: Consider using sys.exit() (consider-using-sys-exit)
    tests/qapi-schema/test-qapi.py:226:4: R1722: Consider using sys.exit() (consider-using-sys-exit)

Sure, why not.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/test-qapi.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index d58c31f539..14f7b62a44 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -136,12 +136,11 @@ def test_frontend(fname):
 def open_test_result(dir_name, file_name, update):
     mode = 'r+' if update else 'r'
     try:
-        fp = open(os.path.join(dir_name, file_name), mode)
+        return open(os.path.join(dir_name, file_name), mode, encoding='utf-8')
     except FileNotFoundError:
         if not update:
             raise
-        fp = open(os.path.join(dir_name, file_name), 'w+')
-    return fp
+    return open(os.path.join(dir_name, file_name), 'w+', encoding='utf-8')
 
 
 def test_and_diff(test_name, dir_name, update):
@@ -218,9 +217,9 @@ def main(argv):
         test_name = os.path.splitext(base_name)[0]
         status |= test_and_diff(test_name, dir_name, args.update)
 
-    exit(status)
+    sys.exit(status)
 
 
 if __name__ == '__main__':
     main(sys.argv)
-    exit(0)
+    sys.exit(0)
-- 
2.41.0


