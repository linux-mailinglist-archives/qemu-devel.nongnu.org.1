Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38FA694F9
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 17:30:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwHZ-00071j-7i; Wed, 19 Mar 2025 12:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuwHM-0006xu-M3
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:28:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1tuwHG-0001yu-0e
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742401699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ldx0piybqUILZ+q26+wafghVoHtgoMwecCWubBVXrAc=;
 b=DQrtu/a0RyjzJ5jajXUs25D7sBk4eUfMEYYZF3JzGszmZHzlYZ/ly6IFgvF6E7+OJflDgz
 uGhrerBo3CvklH0WYKx6sJID8S3mPP+x6GKW2aXPZKTfLMCSFOmtehweeNzrXAiD+lL7K3
 mJC5c52HvUulx64VX0alRx4PbmkVOi0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-hWCLa-ciNtuVX_BbfSl9ow-1; Wed,
 19 Mar 2025 12:28:17 -0400
X-MC-Unique: hWCLa-ciNtuVX_BbfSl9ow-1
X-Mimecast-MFC-AGG-ID: hWCLa-ciNtuVX_BbfSl9ow_1742401697
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB77D1955DCF; Wed, 19 Mar 2025 16:28:15 +0000 (UTC)
Received: from speedmetal.redhat.com (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B691B180175E; Wed, 19 Mar 2025 16:28:13 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Pavel Hrdina <phrdina@redhat.com>
Subject: [PATCH v2 1/3] scripts: render_block_graph: Fix invalid escape
 sequence warning with python 3.12
Date: Wed, 19 Mar 2025 17:28:07 +0100
Message-ID: <8e38cc4aff81cfec21cc26e9dbb646c5d8fcabd6.1742401551.git.pkrempa@redhat.com>
In-Reply-To: <cover.1742401551.git.pkrempa@redhat.com>
References: <cover.1742401551.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Krempa <pkrempa@redhat.com>

Trying to run 'render_block_graph' produces following warnings on
machine with python 3.12:

 $ ./scripts/render_block_graph.py cd-throttle ble.png
 ./scripts/render_block_graph.py:57: SyntaxWarning: invalid escape sequence '\l'
   '  w - Write\l'
 ./scripts/render_block_graph.py:58: SyntaxWarning: invalid escape sequence '\l'
   '  r - consistent-Read\l'
 ./scripts/render_block_graph.py:59: SyntaxWarning: invalid escape sequence '\l'
   '  u - write - Unchanged\l'
 ./scripts/render_block_graph.py:60: SyntaxWarning: invalid escape sequence '\l'

 [...]

The graphviz '\l' escape sequence is used to left-justify the line and
new python started enforcing of strings to contain only known escape
sequences. Convert the strings containing the dot language to raw.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
---
 scripts/render_block_graph.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 3e1a2e3fa7..14b2d02ec2 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -53,16 +53,16 @@ def render_block_graph(qmp, filename, format='png'):

     graph = Digraph(comment='Block Nodes Graph')
     graph.format = format
-    graph.node('permission symbols:\l'
-               '  w - Write\l'
-               '  r - consistent-Read\l'
-               '  u - write - Unchanged\l'
-               '  g - Graph-mod\l'
-               '  s - reSize\l'
-               'edge label scheme:\l'
-               '  <child type>\l'
-               '  <perm>\l'
-               '  <shared_perm>\l', shape='none')
+    graph.node(r'permission symbols:\l'
+               r'  w - Write\l'
+               r'  r - consistent-Read\l'
+               r'  u - write - Unchanged\l'
+               r'  g - Graph-mod\l'
+               r'  s - reSize\l'
+               r'edge label scheme:\l'
+               r'  <child type>\l'
+               r'  <perm>\l'
+               r'  <shared_perm>\l', shape='none')

     for n in block_graph['nodes']:
         if n['type'] == 'block-driver':
@@ -83,8 +83,8 @@ def render_block_graph(qmp, filename, format='png'):
         graph.node(str(n['id']), label, shape=shape)

     for e in block_graph['edges']:
-        label = '%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
-                                  perm(e['shared-perm']))
+        label = r'%s\l%s\l%s\l' % (e['name'], perm(e['perm']),
+                                   perm(e['shared-perm']))
         graph.edge(str(e['parent']), str(e['child']), label=label)

     graph.render(filename)
-- 
2.48.1


