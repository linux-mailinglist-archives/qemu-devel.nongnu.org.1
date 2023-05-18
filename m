Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23395708687
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 19:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzhCg-0007lg-OI; Thu, 18 May 2023 13:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhCY-0007Vh-DS
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:14:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzhCW-0000ph-4k
 for qemu-devel@nongnu.org; Thu, 18 May 2023 13:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684430043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GsF9qWT21STVri0HTe7Z95CXLprSzpMdbCnFQsxQ4sg=;
 b=IHz//Zx5fz02MejGGnB0Pr6vBUsB13xjXUZ/DP+Hg6r1tHnjn36UJlf+KJe7b+p5OxK4dv
 lFPxamIITLrbNKilCBT7p5igDRstVz8DMTgK+CX8BDD8YrY/MOg0lylT9G9Vj/CCFCvdLb
 pypRj62uLniSqliqwEuFWtrnAXDNnyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-m-dDPPDqOPq0HbmXRg1gfQ-1; Thu, 18 May 2023 13:13:52 -0400
X-MC-Unique: m-dDPPDqOPq0HbmXRg1gfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22C0888B76F;
 Thu, 18 May 2023 17:13:50 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A81740C6EC4;
 Thu, 18 May 2023 17:13:45 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Leonardo Bras <leobras@redhat.com>, David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Greg Kurz <groug@kaod.org>, Juan Quintela <quintela@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, Peter Xu <peterx@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/12] qemu-file: Account for rate_limit usage on qemu_fflush()
Date: Thu, 18 May 2023 19:12:57 +0200
Message-Id: <20230518171304.95006-6-quintela@redhat.com>
In-Reply-To: <20230518171304.95006-1-quintela@redhat.com>
References: <20230518171304.95006-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

That is the moment we know we have transferred something.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Message-Id: <20230515195709.63843-5-quintela@redhat.com>
---
 migration/qemu-file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 9728002de5..3d66c5c512 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -302,7 +302,9 @@ void qemu_fflush(QEMUFile *f)
                                    &local_error) < 0) {
             qemu_file_set_error_obj(f, -EIO, local_error);
         } else {
-            f->total_transferred += iov_size(f->iov, f->iovcnt);
+            uint64_t size = iov_size(f->iov, f->iovcnt);
+            qemu_file_acct_rate_limit(f, size);
+            f->total_transferred += size;
         }
 
         qemu_iovec_release_ram(f);
@@ -519,7 +521,6 @@ void qemu_put_buffer_async(QEMUFile *f, const uint8_t *buf, size_t size,
         return;
     }
 
-    f->rate_limit_used += size;
     add_to_iovec(f, buf, size, may_free);
 }
 
@@ -537,7 +538,6 @@ void qemu_put_buffer(QEMUFile *f, const uint8_t *buf, size_t size)
             l = size;
         }
         memcpy(f->buf + f->buf_index, buf, l);
-        f->rate_limit_used += l;
         add_buf_to_iovec(f, l);
         if (qemu_file_get_error(f)) {
             break;
@@ -554,7 +554,6 @@ void qemu_put_byte(QEMUFile *f, int v)
     }
 
     f->buf[f->buf_index] = v;
-    f->rate_limit_used++;
     add_buf_to_iovec(f, 1);
 }
 
-- 
2.40.1


