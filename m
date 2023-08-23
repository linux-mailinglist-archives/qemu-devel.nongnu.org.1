Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD07785C42
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 17:38:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpu7-0004ci-01; Wed, 23 Aug 2023 11:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsd-0001yk-8R
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qYpsb-0008AP-T4
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 11:34:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692804885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xjl+jwf6S6C7TTZrfneBrUP7JU1jXf7dtndXiCRb7qo=;
 b=Cx3V5TgdAcGUPM1P2soV85A3BxnpT3Dgx2MfEqVE6XmIq/3u6TN7Uakmj/QKAQpmFzfeKr
 id45lgXlGxEK3b1bznYHcWNivF6sWlD9nIBenKQHgRgiou6RaDgRl1dL4M14hWm9C1YFDB
 tGuoyVoswxyIGyVmiQkfCDowluyqJ4w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-30-CQi_TBjFN4C86HPKSgS4dw-1; Wed, 23 Aug 2023 11:34:41 -0400
X-MC-Unique: CQi_TBjFN4C86HPKSgS4dw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 43FAC8D40AA;
 Wed, 23 Aug 2023 15:34:40 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 85E391121315;
 Wed, 23 Aug 2023 15:34:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v3 08/11] docs: Don't mention "-mem-path" in multi-process.rst
Date: Wed, 23 Aug 2023 17:34:08 +0200
Message-ID: <20230823153412.832081-9-david@redhat.com>
In-Reply-To: <20230823153412.832081-1-david@redhat.com>
References: <20230823153412.832081-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

"-mem-path" corresponds to "memory-backend-file,share=off" and,
therefore, creates a private COW mapping of the file. For multi-proces
QEMU, we need proper shared file-backed memory.

Let's make that clearer.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 docs/devel/multi-process.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/docs/devel/multi-process.rst b/docs/devel/multi-process.rst
index e4801751f2..4ef539c0b0 100644
--- a/docs/devel/multi-process.rst
+++ b/docs/devel/multi-process.rst
@@ -409,8 +409,9 @@ the initial messages sent to the emulation process is a guest memory
 table. Each entry in this table consists of a file descriptor and size
 that the emulation process can ``mmap()`` to directly access guest
 memory, similar to ``vhost_user_set_mem_table()``. Note guest memory
-must be backed by file descriptors, such as when QEMU is given the
-*-mem-path* command line option.
+must be backed by shared file-backed memory, for example, using
+*-object memory-backend-file,share=on* and setting that memory backend
+as RAM for the machine.
 
 IOMMU operations
 ^^^^^^^^^^^^^^^^
-- 
2.41.0


