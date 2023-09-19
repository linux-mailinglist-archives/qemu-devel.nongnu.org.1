Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD7F7A5FA6
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:33:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiY16-0003ck-3k; Tue, 19 Sep 2023 06:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY0E-00036l-Kc
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qiY09-0001u6-1A
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 06:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695119440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fzs6UaTMElWwPPP2tQTuBJ3znpi1DbgvjOGuscTphKU=;
 b=Q9f/bpZb6wTTYLjBMbr/z351rC7yZ5hYMORbLUgy7ZQ+VA1k8mndbpnGGpCYpqiY3SgXix
 V5Cd/LNoylGqf7ndSrozFf48jPceDvf8BpwBKAAZOl7cilMmslbjR0KCvqkIx3Kkk+noz7
 5FOhKwi6PNuCwQAfXDbP4a+kX5cjZi4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-bnXRwZzQNXWRwUUBa1thww-1; Tue, 19 Sep 2023 06:30:38 -0400
X-MC-Unique: bnXRwZzQNXWRwUUBa1thww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 50E2485A5BF
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 10:30:38 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.194.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C486540C6EC0;
 Tue, 19 Sep 2023 10:30:37 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
Subject: [GIT PULL 08/12] docs: Don't mention "-mem-path" in multi-process.rst
Date: Tue, 19 Sep 2023 12:30:25 +0200
Message-ID: <20230919103029.235736-9-david@redhat.com>
In-Reply-To: <20230919103029.235736-1-david@redhat.com>
References: <20230919103029.235736-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

Message-ID: <20230906120503.359863-9-david@redhat.com>
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


