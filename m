Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCFBD3ACDB
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jan 2026 15:52:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqaA-0008Pz-Pz; Mon, 19 Jan 2026 09:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZm-0008Ci-L2; Mon, 19 Jan 2026 09:49:56 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZi-0008Nd-T8; Mon, 19 Jan 2026 09:49:54 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 190A880865;
 Mon, 19 Jan 2026 17:49:49 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-nKJwXnB6; Mon, 19 Jan 2026 17:49:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834188;
 bh=k8HQhsmMIL31NlPqKNV8IB2vML1614dgEzgG38+hPMQ=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=D1Btn0jKd2dlodPL8R34Jc98ihNdsiVCMvuo+bBkejC7KhFto3pKqdHg55s05tmi1
 0pwjZv3s1kk9yYk6axA9Kl5S2UVcbd48+0noy7xVadD/qGR4xf71MI0hJX07oj3FOi
 8X4QqpJ97omCMCqJK/AjszgjyD4BysFwEMzLGth0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 6/8] iotests.py: introduce VM.assert_edges_list() method
Date: Mon, 19 Jan 2026 17:49:39 +0300
Message-ID: <20260119144941.87936-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Add an alternative method to check block graph, to be used in further
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/iotests.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 05274772ce..d6f4e890da 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1126,6 +1126,23 @@ def check_bitmap_status(self, node_name, bitmap_name, fields):
 
         return fields.items() <= ret.items()
 
+    def get_block_graph(self):
+        """
+        Returns block graph in form of edges list, where each edge is a tuple:
+          (parent_node_name, child_name, child_node_name)
+        """
+        graph = self.qmp('x-debug-query-block-graph')['return']
+
+        nodes = {n['id']: n['name'] for n in graph['nodes']}
+        # Check that all names are unique:
+        assert len(set(nodes.values())) == len(nodes)
+
+        return [(nodes[e['parent']], e['name'], nodes[e['child']])
+                for e in graph['edges']]
+
+    def assert_edges_list(self, edges):
+        assert sorted(edges) == sorted(self.get_block_graph())
+
     def assert_block_path(self, root, path, expected_node, graph=None):
         """
         Check whether the node under the given path in the block graph
-- 
2.52.0


