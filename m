Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B1781EE0E
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 11:07:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIQnz-00022T-OD; Wed, 27 Dec 2023 05:06:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIQnx-00021y-PX
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 05:06:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rIQnw-0005zZ-Bg
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 05:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703671583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QLmkAedjD80nzAcPdoDBqQLmIkljmO5y7IZtBDwMEzc=;
 b=EIa68gMQtNVPcsDrwghJ1ph5cOB7EQmbJnvDJgWBtSv42pjgT3JrYzh4giFNVKlRTJkyOl
 nGzVcoDKWLePKqJwspHP922jLoIGQ/+LB9CKKrhXiWbZOBM8k2QoV5S/NIvNkugepdpAir
 LBppOpG5iu6OiofmXVlOhePD+SU1rKY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-1hLDKfqKMEqI50mvcOwAlg-1; Wed,
 27 Dec 2023 05:06:21 -0500
X-MC-Unique: 1hLDKfqKMEqI50mvcOwAlg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 178D53C28648;
 Wed, 27 Dec 2023 10:06:21 +0000 (UTC)
Received: from localhost (unknown [10.39.192.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 710BD492BF0;
 Wed, 27 Dec 2023 10:06:20 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Stefan Hajnoczi <stefanha@redhat.com>,
 Carlos Santos <casantos@redhat.com>
Subject: [PULL 1/1] tracing: install trace events file only if necessary
Date: Wed, 27 Dec 2023 05:02:58 -0500
Message-ID: <20231227100258.130317-2-stefanha@redhat.com>
In-Reply-To: <20231227100258.130317-1-stefanha@redhat.com>
References: <20231227100258.130317-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.851,
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

From: Carlos Santos <casantos@redhat.com>

It is not useful when configuring with --enable-trace-backends=nop.

Signed-off-by: Carlos Santos <casantos@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20230408010410.281263-1-casantos@redhat.com>
---
 trace/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/trace/meson.build b/trace/meson.build
index b0d31a67e6..c3412dc0ba 100644
--- a/trace/meson.build
+++ b/trace/meson.build
@@ -64,7 +64,7 @@ trace_events_all = custom_target('trace-events-all',
                                  input: trace_events_files,
                                  command: [ 'cat', '@INPUT@' ],
                                  capture: true,
-                                 install: true,
+                                 install: get_option('trace_backends') != [ 'nop' ],
                                  install_dir: qemu_datadir)
 
 if 'ust' in get_option('trace_backends')
-- 
2.43.0


