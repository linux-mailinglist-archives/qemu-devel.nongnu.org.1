Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE9C718B6B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 22:45:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Sfl-00060Q-LF; Wed, 31 May 2023 16:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4Sfi-0005wI-3Y
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1q4Sfa-0004uE-5s
 for qemu-devel@nongnu.org; Wed, 31 May 2023 16:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685565825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/yy1BBiZJor5XxfSqUzZjbxpusCld+EOf+qCIGJEwWA=;
 b=BTRFgzs8Cqy+ngHvukiNuk9YIv2J3db7bjHH7P8TMAALk05teuV/t2NXp+kavKTGAcNZK2
 oR36/avf5DTWeIp9B9Z1DLwajUOKOzAsPcTEHcTBpdrcZSSBzvrpOa3fPu0zbqbMuAvaSx
 k88KEfEUvs0bfc5dLsIJ1VrkqEuuTvo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-eGnFS5LfPXWWAqt6DZwz6g-1; Wed, 31 May 2023 16:43:41 -0400
X-MC-Unique: eGnFS5LfPXWWAqt6DZwz6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5FEAB801182;
 Wed, 31 May 2023 20:43:41 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.9.159])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3F162029F6D;
 Wed, 31 May 2023 20:43:40 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PULL 3/5] python/machine: use connect-based interface for existing
 sockets
Date: Wed, 31 May 2023 16:43:36 -0400
Message-Id: <20230531204338.1656158-4-jsnow@redhat.com>
In-Reply-To: <20230531204338.1656158-1-jsnow@redhat.com>
References: <20230531204338.1656158-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Instead of using accept() with sockets (which uses open_with_socket()),
use calls to connect() to utilize existing sockets instead. A benefit of
this is more robust error handling already present within the connect()
call that isn't present in open_with_socket().

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20230517163406.2593480-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index e57c254484..cc636cb6bd 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -337,18 +337,17 @@ def _pre_launch(self) -> None:
             self._remove_files.append(self._console_address)
 
         if self._qmp_set:
-            monitor_address = None
             sock = None
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
                 sock = self._sock_pair[1]
             if isinstance(self._monitor_address, str):
                 self._remove_files.append(self._monitor_address)
-                monitor_address = self._monitor_address
+
             self._qmp_connection = QEMUMonitorProtocol(
-                address=monitor_address,
+                address=self._monitor_address,
                 sock=sock,
-                server=True,
+                server=bool(self._monitor_address),
                 nickname=self._name
             )
 
@@ -370,7 +369,10 @@ def _post_launch(self) -> None:
         if self._sock_pair:
             self._sock_pair[0].close()
         if self._qmp_connection:
-            self._qmp.accept(self._qmp_timer)
+            if self._sock_pair:
+                self._qmp.connect()
+            else:
+                self._qmp.accept(self._qmp_timer)
 
     def _close_qemu_log_file(self) -> None:
         if self._qemu_log_file is not None:
-- 
2.40.1


