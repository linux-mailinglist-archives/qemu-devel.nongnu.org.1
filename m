Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AC47620EB
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 20:05:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOMNy-0002hU-87; Tue, 25 Jul 2023 14:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOMNv-0002fl-Ou
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:03:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOMNt-000137-12
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 14:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690308223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZQEjaImajQCAJb63at6vX9mIrvur84gIvRAOOVxPJco=;
 b=fFpxv2v4UZ8Z1jhwGouGczo02G1KKb+oQ6TDkw30jVmHjNtyT8yyLjoeijmz7kM4/z0wd/
 VaxPoW4zdDEw537RwJNHnPlV3dSN0/Ip1dzIo/gYezF2aUSztuHHaeIyRzqEVpGoyNG+L9
 gWIeVgLSBB8RPWz+quA93NMXE9fkN0Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-198-_dPqLpDvMYSj9nqYIl4GGQ-1; Tue, 25 Jul 2023 14:03:40 -0400
X-MC-Unique: _dPqLpDvMYSj9nqYIl4GGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74B753C11A06;
 Tue, 25 Jul 2023 18:03:39 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D17C41454150;
 Tue, 25 Jul 2023 18:03:38 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 1/6] python/machine: move socket setup out of _base_args
 property
Date: Tue, 25 Jul 2023 14:03:32 -0400
Message-ID: <20230725180337.2937292-2-jsnow@redhat.com>
In-Reply-To: <20230725180337.2937292-1-jsnow@redhat.com>
References: <20230725180337.2937292-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This property isn't meant to do much else besides return a list of
strings, so move this setup back out into _pre_launch().

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/machine/machine.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index c16a0b6fed..8be0f684fe 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -300,9 +300,7 @@ def _base_args(self) -> List[str]:
 
         if self._qmp_set:
             if self._sock_pair:
-                fd = self._sock_pair[0].fileno()
-                os.set_inheritable(fd, True)
-                moncdev = f"socket,id=mon,fd={fd}"
+                moncdev = f"socket,id=mon,fd={self._sock_pair[0].fileno()}"
             elif isinstance(self._monitor_address, tuple):
                 moncdev = "socket,id=mon,host={},port={}".format(
                     *self._monitor_address
@@ -339,6 +337,7 @@ def _pre_launch(self) -> None:
         if self._qmp_set:
             if self._monitor_address is None:
                 self._sock_pair = socket.socketpair()
+                os.set_inheritable(self._sock_pair[0].fileno(), True)
                 sock = self._sock_pair[1]
             if isinstance(self._monitor_address, str):
                 self._remove_files.append(self._monitor_address)
-- 
2.41.0


