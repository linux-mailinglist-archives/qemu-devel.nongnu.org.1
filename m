Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2E989C7A
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Sep 2024 10:18:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svBbA-0006K0-MH; Mon, 30 Sep 2024 04:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBZa-00035N-KX
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:16:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1svBZY-0005hl-EC
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 04:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727684159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FCeKBonFNyUflZYNMAOxtHXtj8QpjqLDQ64BJECt8as=;
 b=aebhQ44N1lwnZ/5hLL1xoNtvplnQ8vgs6TjCX04X0QXPoeeuuC/hLYZSgPd/mawthZNzYm
 ga1/pzEv8sRWzijifhE7G9vVsxxQleDa5IxHWXRy9ntHtxvbLX5JoD8APOSg/syz3KYPyD
 iUOS56kLpDykyGJ94lG8Caw+MQpVbvI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-gTTXg1I8Og-16VJtiXkRWQ-1; Mon,
 30 Sep 2024 04:15:56 -0400
X-MC-Unique: gTTXg1I8Og-16VJtiXkRWQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C362A192D0E1; Mon, 30 Sep 2024 08:15:53 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D87651979060; Mon, 30 Sep 2024 08:15:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Fam Zheng <fam@euphon.net>,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-block@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jesper Devantier <foss@defmacro.it>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Keith Busch <kbusch@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 06/22] block/mirror: fix -Werror=maybe-uninitialized
 false-positive
Date: Mon, 30 Sep 2024 12:14:41 +0400
Message-ID: <20240930081458.1926382-7-marcandre.lureau@redhat.com>
In-Reply-To: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
References: <20240930081458.1926382-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.095,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../block/mirror.c:404:5: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
../block/mirror.c:895:12: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
../block/mirror.c:578:12: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]

Change a variable to int, as suggested by Manos: "bdrv_co_preadv()
which is int and is passed as an int argument to mirror_read_complete()"

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/mirror.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 54e3a7ea9d..2afe700b4d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -349,7 +349,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
     int nb_chunks;
-    uint64_t ret;
+    int ret = -1;
     uint64_t max_bytes;
 
     max_bytes = s->granularity * s->max_iov;
@@ -565,7 +565,7 @@ static void coroutine_fn GRAPH_UNLOCKED mirror_iteration(MirrorBlockJob *s)
 
     bitmap_set(s->in_flight_bitmap, offset / s->granularity, nb_chunks);
     while (nb_chunks > 0 && offset < s->bdev_length) {
-        int ret;
+        int ret = -1;
         int64_t io_bytes;
         int64_t io_bytes_acct;
         MirrorMethod mirror_method = MIRROR_METHOD_COPY;
@@ -841,7 +841,7 @@ static int coroutine_fn GRAPH_UNLOCKED mirror_dirty_init(MirrorBlockJob *s)
     int64_t offset;
     BlockDriverState *bs;
     BlockDriverState *target_bs = blk_bs(s->target);
-    int ret;
+    int ret = -1;
     int64_t count;
 
     bdrv_graph_co_rdlock();
-- 
2.45.2.827.g557ae147e6


