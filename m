Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE61772E85
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 21:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT5a1-0003ib-EJ; Mon, 07 Aug 2023 15:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT5Zy-0003hk-Rl
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:07:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT5Zx-0005o0-GD
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 15:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691435264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/JG4xq1fn1DPP8n2T9g6mLn79wHbUIsLvpRXYT889c=;
 b=K05oPt84vZBr+c0IOHa/EAUamwoZjZHQpkTBI6JL464i2rsuWiswAbmp9CJ2S6NjEwgZ0I
 Pqvys6SJFeOv8CkDDI4wkzaTKTz0aRRJGVOMqeqKQpIxG1PBc8btmAkUIylu/o73ySw/Ac
 augYjAnZWxe3ttT+HxBAIrEV/YyW/fQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-ENfz1GifPdqnYS8JGhrKtw-1; Mon, 07 Aug 2023 15:07:43 -0400
X-MC-Unique: ENfz1GifPdqnYS8JGhrKtw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94E6980523D;
 Mon,  7 Aug 2023 19:07:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F891403166;
 Mon,  7 Aug 2023 19:07:41 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v1 2/3] softmmu/physmem: fail creation of new files in
 file_ram_open() with readonly=true
Date: Mon,  7 Aug 2023 21:07:33 +0200
Message-ID: <20230807190736.572665-3-david@redhat.com>
In-Reply-To: <20230807190736.572665-1-david@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

Currently, if a file does not exist yet, file_ram_open() will create new
empty file and open it writable. However, it even does that when
readonly=true was specified. So instead of opening the file read-only,
we'll open it writable, implying that later fallocate() or ftruncate()
could succeed.

Specifying O_RDONLY instead would theoretically work, however,
ftruncate() will refuse to resize the new empty file and we'll get a
warning:
    ftruncate: Invalid argument

mmap() will succeed, but any later access to that memory would fail with
SIGBUS. Undesirable.

If someone intends to let QEMU open+mmap a file read-only, better
create+resize+fill that file ahead of time outside of QEMU context.

We'll now fail with:
./qemu-system-x86_64 \
    -object memory-backend-file,id=ram0,mem-path=tmp/ls,readonly=true,size=1g
qemu-system-x86_64: can't open backing store tmp/ls for guest RAM: No such file or directory

It's unlikely that this will harm existing users: especially R/O NVDIMMs
better expose some reasonable data that already exists. Everything else
would just hide user errors when accidentally specifying a non-existent
file.

Note that the only memory-backend-file will end up calling
memory_region_init_ram_from_file() -> qemu_ram_alloc_from_file() ->
file_ram_open().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 softmmu/physmem.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index d1ae694b20..9580567608 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -1304,6 +1304,13 @@ static int file_ram_open(const char *path,
             break;
         }
         if (errno == ENOENT) {
+            if (readonly) {
+                /*
+                 * O_RDONLY would later make ftruncate() fail, leading to
+                 * SIGBUS after mmap().
+                 */
+                return -ENOENT;
+            }
             /* @path names a file that doesn't exist, create it */
             fd = open(path, O_RDWR | O_CREAT | O_EXCL, 0644);
             if (fd >= 0) {
-- 
2.41.0


