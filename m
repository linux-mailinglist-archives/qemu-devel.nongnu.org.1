Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1687B11B8
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 06:50:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qliyQ-0002JZ-Sa; Thu, 28 Sep 2023 00:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qliyM-0002I2-NC
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 00:49:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qliyE-0006gO-Ny
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 00:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695876588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TmGgHENgntSbtlCsa0BEcNYq7zJ9XbDM4SQJ++ZpvxA=;
 b=XWiOJIPsDUP1opqGfiNOOq/TTMXqNfrvDkzy+F9M+a3cmF818iu4m0MLWWMOhPMZ1qwYnd
 lK0zLyq7zsw2FQ0tn5td9cFBmgcAvW9KawH44rkj33dpe6I8Mfbt6z3BgaB9J3g+ZOyuE1
 IayoK4LnRBTU2TIfTsBxhqqCLiw0A/I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-vCZji-f5P2SDuUOpVMFcpg-1; Thu, 28 Sep 2023 00:49:46 -0400
X-MC-Unique: vCZji-f5P2SDuUOpVMFcpg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF15B80349B;
 Thu, 28 Sep 2023 04:49:45 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D1111004145;
 Thu, 28 Sep 2023 04:49:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>, Daniel Berrange <berrange@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 2/6] python/machine: close sock_pair in cleanup path
Date: Thu, 28 Sep 2023 00:49:39 -0400
Message-ID: <20230928044943.849073-3-jsnow@redhat.com>
In-Reply-To: <20230928044943.849073-1-jsnow@redhat.com>
References: <20230928044943.849073-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

If everything has gone smoothly, we'll already have closed the socket we
gave to the child during post_launch. The other half of the pair that we
gave to the QMP connection should, likewise, be definitively closed by
now.

However, in the cleanup path, it's possible we've created the socketpair
but flubbed the launch and need to clean up resources. These resources
*would* be handled by the garbage collector, but that can happen at
unpredictable times. Nicer to just clean them up synchronously on the
exit path, here.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/machine/machine.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 345610d6e46..e26109e6f0e 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -396,6 +396,11 @@ def _post_shutdown(self) -> None:
         finally:
             assert self._qmp_connection is None
 
+        if self._sock_pair:
+            self._sock_pair[0].close()
+            self._sock_pair[1].close()
+            self._sock_pair = None
+
         self._close_qemu_log_file()
 
         self._load_io_log()
-- 
2.41.0


