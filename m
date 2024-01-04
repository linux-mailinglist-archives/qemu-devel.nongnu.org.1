Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8AC82463E
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:31:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQbg-0007T6-Hj; Thu, 04 Jan 2024 11:30:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbd-0007SQ-Dm
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:30:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rLQbb-0002ON-V0
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:30:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704385803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+3JNEzcvarOHKa3q9hrfDZ4SHodTXzg+K6gMC3D5u+w=;
 b=WaA0JKtqg1VDuC29KPzAtUDjShtNtep61V7uikXneRxCfAuHdpICAnrNzha2HQ/A7oR8vz
 wo53Wy8KwwV54jlpcGZ3mNYmxgCX2yx42l/abZLf1UjTqHRfm+rKOn0BIDy2gWp1MddsJr
 h2xyhdlrdGJG30sgD8qRYtvYjVWKuBw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-883CETGiNLmw4oTn6Tg2wA-1; Thu,
 04 Jan 2024 11:30:00 -0500
X-MC-Unique: 883CETGiNLmw4oTn6Tg2wA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B22193806729;
 Thu,  4 Jan 2024 16:29:59 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE8A71C060AF;
 Thu,  4 Jan 2024 16:29:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 6/6] qtest: ensure netdev-socket tests have non-overlapping
 names
Date: Thu,  4 Jan 2024 16:29:42 +0000
Message-ID: <20240104162942.211458-7-berrange@redhat.com>
In-Reply-To: <20240104162942.211458-1-berrange@redhat.com>
References: <20240104162942.211458-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.691,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

When naming glib tests if the name of one test is a substring of the
name of another test, it is not possible to use the '-p /the/name'
option to run a single test.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/netdev-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/netdev-socket.c b/tests/qtest/netdev-socket.c
index 91441f7922..fc7d11961e 100644
--- a/tests/qtest/netdev-socket.c
+++ b/tests/qtest/netdev-socket.c
@@ -526,7 +526,7 @@ int main(int argc, char **argv)
 #ifndef _WIN32
         qtest_add_func("/netdev/dgram/unix", test_dgram_unix);
 #endif
-        qtest_add_func("/netdev/stream/unix", test_stream_unix);
+        qtest_add_func("/netdev/stream/unix/oneshot", test_stream_unix);
         qtest_add_func("/netdev/stream/unix/reconnect",
                        test_stream_unix_reconnect);
 #ifdef CONFIG_LINUX
-- 
2.43.0


