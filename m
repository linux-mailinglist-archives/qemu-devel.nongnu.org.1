Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC547A94AC
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 15:23:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJeP-0007CH-7I; Thu, 21 Sep 2023 09:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJe7-0006rq-C6
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjJe3-00043P-NI
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 09:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695302582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yBatzSuAuhmbfH888wEatA9vflyhInrP780Sek2BQn4=;
 b=FyWYJeU0QhlGoyUHAPMciS33xUxmiE/9UVdyzQBYeDT0ykpk7oB51baWdPDmdgKaLCDGIq
 dXZQiEyLAsxxzeqn+w8f/VVc98IoMVYdTVB7ztkPgOlsqgXF8Zc/32PmEYWKDxoPZ1xHFF
 2wAdDkF7EyWnVDj1rbCXCZtFh9Zaufo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-4KqdsblxO7KC9h3VyFTycA-1; Thu, 21 Sep 2023 08:13:16 -0400
X-MC-Unique: 4KqdsblxO7KC9h3VyFTycA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2405D381458F;
 Thu, 21 Sep 2023 12:13:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D55F171128B;
 Thu, 21 Sep 2023 12:13:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7EAB321E690C; Thu, 21 Sep 2023 14:13:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, eblake@redhat.com,
 vsementsov@yandex-team.ru, jsnow@redhat.com, idryomov@gmail.com,
 pl@kamp.de, sw@weilnetz.de, sstabellini@kernel.org,
 anthony.perard@citrix.com, paul@xen.org, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, thuth@redhat.com,
 philmd@linaro.org, stefanha@redhat.com, fam@euphon.net,
 quintela@redhat.com, peterx@redhat.com, leobras@redhat.com,
 kraxel@redhat.com, qemu-block@nongnu.org, xen-devel@lists.xenproject.org,
 alex.bennee@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v3 6/7] block: Clean up local variable shadowing
Date: Thu, 21 Sep 2023 14:13:11 +0200
Message-ID: <20230921121312.1301864-7-armbru@redhat.com>
In-Reply-To: <20230921121312.1301864-1-armbru@redhat.com>
References: <20230921121312.1301864-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Local variables shadowing other local variables or parameters make the
code needlessly hard to understand.  Tracked down with -Wshadow=local.
Clean up: delete inner declarations when they are actually redundant,
else rename variables.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Acked-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c              |  9 +++++----
 block/rbd.c          |  2 +-
 block/stream.c       |  1 -
 block/vvfat.c        | 35 ++++++++++++++++++-----------------
 hw/block/xen-block.c |  6 +++---
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/block.c b/block.c
index 8da89aaa62..bb5dd17e9c 100644
--- a/block.c
+++ b/block.c
@@ -3035,18 +3035,19 @@ static BdrvChild *bdrv_attach_child_common(BlockDriverState *child_bs,
                                               &local_err);
 
         if (ret < 0 && child_class->change_aio_ctx) {
-            Transaction *tran = tran_new();
+            Transaction *aio_ctx_tran = tran_new();
             GHashTable *visited = g_hash_table_new(NULL, NULL);
             bool ret_child;
 
             g_hash_table_add(visited, new_child);
             ret_child = child_class->change_aio_ctx(new_child, child_ctx,
-                                                    visited, tran, NULL);
+                                                    visited, aio_ctx_tran,
+                                                    NULL);
             if (ret_child == true) {
                 error_free(local_err);
                 ret = 0;
             }
-            tran_finalize(tran, ret_child == true ? 0 : -1);
+            tran_finalize(aio_ctx_tran, ret_child == true ? 0 : -1);
             g_hash_table_destroy(visited);
         }
 
@@ -6077,12 +6078,12 @@ void bdrv_iterate_format(void (*it)(void *opaque, const char *name),
     QLIST_FOREACH(drv, &bdrv_drivers, list) {
         if (drv->format_name) {
             bool found = false;
-            int i = count;
 
             if (use_bdrv_whitelist && !bdrv_is_whitelisted(drv, read_only)) {
                 continue;
             }
 
+            i = count;
             while (formats && i && !found) {
                 found = !strcmp(formats[--i], drv->format_name);
             }
diff --git a/block/rbd.c b/block/rbd.c
index 978671411e..472ca05cba 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -1290,7 +1290,7 @@ static int coroutine_fn qemu_rbd_start_co(BlockDriverState *bs,
          * operations that exceed the current size.
          */
         if (offset + bytes > s->image_size) {
-            int r = qemu_rbd_resize(bs, offset + bytes);
+            r = qemu_rbd_resize(bs, offset + bytes);
             if (r < 0) {
                 return r;
             }
diff --git a/block/stream.c b/block/stream.c
index e522bbdec5..007253880b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -282,7 +282,6 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     /* Make sure that the image is opened in read-write mode */
     bs_read_only = bdrv_is_read_only(bs);
     if (bs_read_only) {
-        int ret;
         /* Hold the chain during reopen */
         if (bdrv_freeze_backing_chain(bs, above_base, errp) < 0) {
             return;
diff --git a/block/vvfat.c b/block/vvfat.c
index 0ddc91fc09..856b479c91 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -777,7 +777,6 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
     while((entry=readdir(dir))) {
         unsigned int length=strlen(dirname)+2+strlen(entry->d_name);
         char* buffer;
-        direntry_t* direntry;
         struct stat st;
         int is_dot=!strcmp(entry->d_name,".");
         int is_dotdot=!strcmp(entry->d_name,"..");
@@ -857,7 +856,7 @@ static int read_directory(BDRVVVFATState* s, int mapping_index)
 
     /* fill with zeroes up to the end of the cluster */
     while(s->directory.next%(0x10*s->sectors_per_cluster)) {
-        direntry_t* direntry=array_get_next(&(s->directory));
+        direntry = array_get_next(&(s->directory));
         memset(direntry,0,sizeof(direntry_t));
     }
 
@@ -1962,24 +1961,24 @@ get_cluster_count_for_direntry(BDRVVVFATState* s, direntry_t* direntry, const ch
                  * This is horribly inefficient, but that is okay, since
                  * it is rarely executed, if at all.
                  */
-                int64_t offset = cluster2sector(s, cluster_num);
+                int64_t offs = cluster2sector(s, cluster_num);
 
                 vvfat_close_current_file(s);
                 for (i = 0; i < s->sectors_per_cluster; i++) {
                     int res;
 
                     res = bdrv_is_allocated(s->qcow->bs,
-                                            (offset + i) * BDRV_SECTOR_SIZE,
+                                            (offs + i) * BDRV_SECTOR_SIZE,
                                             BDRV_SECTOR_SIZE, NULL);
                     if (res < 0) {
                         return -1;
                     }
                     if (!res) {
-                        res = vvfat_read(s->bs, offset, s->cluster_buffer, 1);
+                        res = vvfat_read(s->bs, offs, s->cluster_buffer, 1);
                         if (res) {
                             return -1;
                         }
-                        res = bdrv_co_pwrite(s->qcow, offset * BDRV_SECTOR_SIZE,
+                        res = bdrv_co_pwrite(s->qcow, offs * BDRV_SECTOR_SIZE,
                                              BDRV_SECTOR_SIZE, s->cluster_buffer,
                                              0);
                         if (res < 0) {
@@ -2467,8 +2466,9 @@ commit_direntries(BDRVVVFATState* s, int dir_index, int parent_mapping_index)
 
     for (c = first_cluster; !fat_eof(s, c); c = modified_fat_get(s, c)) {
         direntry_t *first_direntry;
-        void* direntry = array_get(&(s->directory), current_dir_index);
-        int ret = vvfat_read(s->bs, cluster2sector(s, c), direntry,
+
+        direntry = array_get(&(s->directory), current_dir_index);
+        ret = vvfat_read(s->bs, cluster2sector(s, c), (uint8_t *)direntry,
                 s->sectors_per_cluster);
         if (ret)
             return ret;
@@ -2690,12 +2690,12 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
                 direntry_t* direntry = array_get(&(s->directory),
                         mapping->info.dir.first_dir_index);
                 uint32_t c = mapping->begin;
-                int i = 0;
+                int j = 0;
 
                 /* recurse */
                 while (!fat_eof(s, c)) {
                     do {
-                        direntry_t* d = direntry + i;
+                        direntry_t *d = direntry + j;
 
                         if (is_file(d) || (is_directory(d) && !is_dot(d))) {
                             int l;
@@ -2716,8 +2716,8 @@ static int handle_renames_and_mkdirs(BDRVVVFATState* s)
 
                             schedule_rename(s, m->begin, new_path);
                         }
-                        i++;
-                    } while((i % (0x10 * s->sectors_per_cluster)) != 0);
+                        j++;
+                    } while (j % (0x10 * s->sectors_per_cluster) != 0);
                     c = fat_get(s, c);
                 }
             }
@@ -2804,16 +2804,16 @@ static int coroutine_fn GRAPH_RDLOCK handle_commits(BDRVVVFATState* s)
             int begin = commit->param.new_file.first_cluster;
             mapping_t* mapping = find_mapping_for_cluster(s, begin);
             direntry_t* entry;
-            int i;
+            int j;
 
             /* find direntry */
-            for (i = 0; i < s->directory.next; i++) {
-                entry = array_get(&(s->directory), i);
+            for (j = 0; j < s->directory.next; j++) {
+                entry = array_get(&(s->directory), j);
                 if (is_file(entry) && begin_of_direntry(entry) == begin)
                     break;
             }
 
-            if (i >= s->directory.next) {
+            if (j >= s->directory.next) {
                 fail = -6;
                 continue;
             }
@@ -2833,8 +2833,9 @@ static int coroutine_fn GRAPH_RDLOCK handle_commits(BDRVVVFATState* s)
             mapping->mode = MODE_NORMAL;
             mapping->info.file.offset = 0;
 
-            if (commit_one_file(s, i, 0))
+            if (commit_one_file(s, j, 0)) {
                 fail = -7;
+            }
 
             break;
         }
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 3906b9058b..a07cd7eb5d 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -369,7 +369,7 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
     case XEN_BLOCK_VDEV_TYPE_XVD:
     case XEN_BLOCK_VDEV_TYPE_HD:
     case XEN_BLOCK_VDEV_TYPE_SD: {
-        char *name = disk_to_vbd_name(vdev->disk);
+        char *vbd_name = disk_to_vbd_name(vdev->disk);
 
         str = g_strdup_printf("%s%s%lu",
                               (vdev->type == XEN_BLOCK_VDEV_TYPE_XVD) ?
@@ -377,8 +377,8 @@ static void xen_block_get_vdev(Object *obj, Visitor *v, const char *name,
                               (vdev->type == XEN_BLOCK_VDEV_TYPE_HD) ?
                               "hd" :
                               "sd",
-                              name, vdev->partition);
-        g_free(name);
+                              vbd_name, vdev->partition);
+        g_free(vbd_name);
         break;
     }
     default:
-- 
2.41.0


