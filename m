Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B692EB41436
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Sep 2025 07:16:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfpQ-0000Le-PC; Wed, 03 Sep 2025 01:14:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmm-0006Fi-V6
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmk-0006Ts-Hr
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tagIbdrrDMrYKknepF7MVfnL4rHnC0ypp6LupSkyNl8=;
 b=ePTqNglwl848Vygt9EVyGUoPeHL+OEJlIja7v71p5iFgPjTBaPvE3RZL4sC/b17iWfuUlU
 0ZZuLPT5vkRzQWfYPCyxhkxcSWqp667oRDjFHMSAKpPI+ng82ajwWS7CUT/F00itJqw7HH
 rHDi0w8GjTloL9dqUjAHdglxAjEQSdY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-5dRiywpsPzmidlaGIJhjKQ-1; Wed,
 03 Sep 2025 01:11:52 -0400
X-MC-Unique: 5dRiywpsPzmidlaGIJhjKQ-1
X-Mimecast-MFC-AGG-ID: 5dRiywpsPzmidlaGIJhjKQ_1756876311
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1EFA1180034F; Wed,  3 Sep 2025 05:11:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4058F19560A2; Wed,  3 Sep 2025 05:11:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 09/18] python: backport 'qmp-shell-wrap: handle missing
 binary gracefully'
Date: Wed,  3 Sep 2025 01:11:15 -0400
Message-ID: <20250903051125.3020805-10-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit 9c889dcbd58817b0c917a9d2dd16161f48ac8203
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/qmp_shell.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index 02028e94b5a..c923ff09e1f 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -607,6 +607,8 @@ def main_wrap() -> None:
 
                 for _ in qemu.repl():
                     pass
+    except FileNotFoundError:
+        sys.stderr.write(f"ERROR: QEMU executable '{cmd[0]}' not found.\n")
     finally:
         os.unlink(sockpath)
 
-- 
2.50.1


