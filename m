Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB93706ECF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:54:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKND-0003wt-LG; Wed, 17 May 2023 12:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNC-0003we-CF
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKNA-0001PO-P0
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zstI19rKVNa+kdrsTIs7vlvr1F7iq82cM+TZD7FBpS8=;
 b=BeLH7y8LoceW1UsWJvhHfdLTb4yHsfis26UI1j79vXVX859pwAX3exlj806MZV3H9+LV+Q
 YxGjBmaKv3t5RPfyOlOrJAqELUvjMehiszboVgfhf8XSEuP4HZdM86VU5vtJlmm4719mZi
 j2+XSceEXsdnQ5jC1TPiozTEHgfmt5U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-3iiP3wSYMvi2nMagyPFIJA-1; Wed, 17 May 2023 12:51:30 -0400
X-MC-Unique: 3iiP3wSYMvi2nMagyPFIJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57AF529AB3EC;
 Wed, 17 May 2023 16:51:30 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A054940C6EC4;
 Wed, 17 May 2023 16:51:29 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/18] docs/interop/qcow2.txt: fix description about "zlib"
 clusters
Date: Wed, 17 May 2023 18:51:05 +0200
Message-Id: <20230517165116.475123-8-kwolf@redhat.com>
In-Reply-To: <20230517165116.475123-1-kwolf@redhat.com>
References: <20230517165116.475123-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

From: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>

"zlib" clusters are actually raw deflate (RFC1951) clusters without
zlib headers.

Signed-off-by: Akihiro Suda <akihiro.suda.cz@hco.ntt.co.jp>
Message-Id: <168424874322.11954.1340942046351859521-0@git.sr.ht>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 docs/interop/qcow2.txt | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index f7dc304ff6..e7f036c286 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -214,14 +214,18 @@ version 2.
                     type.
 
                     If the incompatible bit "Compression type" is set: the field
-                    must be present and non-zero (which means non-zlib
+                    must be present and non-zero (which means non-deflate
                     compression type). Otherwise, this field must not be present
-                    or must be zero (which means zlib).
+                    or must be zero (which means deflate).
 
                     Available compression type values:
-                        0: zlib <https://www.zlib.net/>
+                        0: deflate <https://www.ietf.org/rfc/rfc1951.txt>
                         1: zstd <http://github.com/facebook/zstd>
 
+                    The deflate compression type is called "zlib"
+                    <https://www.zlib.net/> in QEMU. However, clusters with the
+                    deflate compression type do not have zlib headers.
+
 
 === Header padding ===
 
-- 
2.40.1


