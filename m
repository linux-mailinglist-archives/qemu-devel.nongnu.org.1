Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F607FF45B
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:06:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jYf-0007or-Pj; Thu, 30 Nov 2023 11:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1r8jYS-0007kp-1v
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:06:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1r8jYO-0002lT-SL
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701360376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVJOMTGcoIXrHfoFIgB94hI++Y2mZRVqUMHXg2Wb6GQ=;
 b=Z0OXhH6EkyidpjcOshC+bC8FIKjOOfIorNS3Ba068q+0iElddcZj4dw7Fu09DZP+JrDfUr
 bCkj6BUBzuUyrvdkHxp0is79Pn6642pk0zhVCsS7r/PXjIbdVTmyG5wIJPp8QPcJGpyv+9
 o52XRQ5lPU26VWWlsPGBLf4Y3krXKS8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-w4M0KDdkNXuCy6FZGn81tQ-1; Thu,
 30 Nov 2023 11:06:11 -0500
X-MC-Unique: w4M0KDdkNXuCy6FZGn81tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E0252815E21;
 Thu, 30 Nov 2023 16:06:11 +0000 (UTC)
Received: from speedmetal.lan (unknown [10.45.242.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ACE4C10F45;
 Thu, 30 Nov 2023 16:06:09 +0000 (UTC)
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v2 2/2] block: stream: Allow users to request only format
 driver names in backing file format
Date: Thu, 30 Nov 2023 17:06:04 +0100
Message-ID: <13ca32193b29046fa5a0d046f4d45a902eecfb4b.1701360249.git.pkrempa@redhat.com>
In-Reply-To: <cover.1701360249.git.pkrempa@redhat.com>
References: <cover.1701360249.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Introduce a new flag 'backing_file_format_no_protocol' for the
block-commit QMP command which instructs the internals to use 'raw'
instead of the protocol driver in case when a image is used without a
dummy 'raw' wrapper.

The flag is designed such that it can be always asserted by management
tools even when there isn't any update to backing files.

The flag will be used by libvirt so that the backing images still
reference the proper format even when libvirt will stop using the dummy
raw driver (raw driver with no other config). Libvirt needs this so that
the images stay compatible with older libvirt versions which didn't
expect that a protocol driver name can appear in the backing file format
field.

Signed-off-by: Peter Krempa <pkrempa@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/monitor/block-hmp-cmds.c         |  2 +-
 block/stream.c                         | 10 +++++++++-
 blockdev.c                             |  7 +++++++
 include/block/block_int-global-state.h |  3 +++
 qapi/block-core.json                   | 11 ++++++++++-
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index c729cbf1eb..9080e29d4d 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -509,7 +509,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     const char *base = qdict_get_try_str(qdict, "base");
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);

-    qmp_block_stream(device, device, base, NULL, NULL, NULL,
+    qmp_block_stream(device, device, base, NULL, NULL, false, false, NULL,
                      qdict_haskey(qdict, "speed"), speed,
                      true, BLOCKDEV_ON_ERROR_REPORT, NULL,
                      false, false, false, false, &error);
diff --git a/block/stream.c b/block/stream.c
index 01fe7c0f16..42befd6b1d 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -39,6 +39,7 @@ typedef struct StreamBlockJob {
     BlockDriverState *target_bs;
     BlockdevOnError on_error;
     char *backing_file_str;
+    bool backing_file_format_no_protocol;
     bool bs_read_only;
 } StreamBlockJob;

@@ -95,7 +96,12 @@ static int stream_prepare(Job *job)
         if (unfiltered_base) {
             base_id = s->backing_file_str ?: unfiltered_base->filename;
             if (unfiltered_base->drv) {
-                base_fmt = unfiltered_base->drv->format_name;
+                if (s->backing_file_format_no_protocol &&
+                    unfiltered_base->drv->protocol_name) {
+                    base_fmt = "raw";
+                } else {
+                    base_fmt = unfiltered_base->drv->format_name;
+                }
             }
         }

@@ -247,6 +253,7 @@ static const BlockJobDriver stream_job_driver = {

 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
+                  bool backing_file_format_no_protocol,
                   BlockDriverState *bottom,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
@@ -398,6 +405,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     s->base_overlay = base_overlay;
     s->above_base = above_base;
     s->backing_file_str = g_strdup(backing_file_str);
+    s->backing_file_format_no_protocol = backing_file_format_no_protocol;
     s->cor_filter_bs = cor_filter_bs;
     s->target_bs = bs;
     s->bs_read_only = bs_read_only;
diff --git a/blockdev.c b/blockdev.c
index 038031bb03..dc477c4f7e 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2408,6 +2408,8 @@ void qmp_block_stream(const char *job_id, const char *device,
                       const char *base,
                       const char *base_node,
                       const char *backing_file,
+                      bool has_backing_file_format_no_protocol,
+                      bool backing_file_format_no_protocol,
                       const char *bottom,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
@@ -2443,6 +2445,10 @@ void qmp_block_stream(const char *job_id, const char *device,
         return;
     }

+    if (!has_backing_file_format_no_protocol) {
+        backing_file_format_no_protocol = false;
+    }
+
     if (!has_on_error) {
         on_error = BLOCKDEV_ON_ERROR_REPORT;
     }
@@ -2531,6 +2537,7 @@ void qmp_block_stream(const char *job_id, const char *device,
     }

     stream_start(job_id, bs, base_bs, backing_file,
+                 backing_file_format_no_protocol,
                  bottom_bs, job_flags, has_speed ? speed : 0, on_error,
                  filter_node_name, &local_err);
     if (local_err) {
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index 4f253ff362..4301061048 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -46,6 +46,8 @@
  * flatten the whole backing file chain onto @bs.
  * @backing_file_str: The file name that will be written to @bs as the
  * the new backing file if the job completes. Ignored if @base is %NULL.
+ * @backing_file_format_no_protocol: Use format name instead of potental
+ *                                   protocol name as backing image format
  * @creation_flags: Flags that control the behavior of the Job lifetime.
  *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
@@ -64,6 +66,7 @@
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
+                  bool backing_file_format_no_protocol,
                   BlockDriverState *bottom,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index d6b87f1bdd..ec61d94487 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2829,6 +2829,13 @@
 #     Care should be taken when specifying the string, to specify a
 #     valid filename or protocol.  (Since 2.1)
 #
+# @backing-file-format-no-protocol: If true always use a 'format' driver name
+#     for the 'backing file format' field if updating the image header of 'top'.
+#     Otherwise the real name of the driver of the backing
+#     image may be used which may be a protocol driver.
+#
+#     (default: false; since: 9.0)
+#
 # @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error (default report). 'stop'
@@ -2867,7 +2874,9 @@
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
-            '*base-node': 'str', '*backing-file': 'str', '*bottom': 'str',
+            '*base-node': 'str', '*backing-file': 'str',
+            '*backing-file-format-no-protocol': 'bool',
+            '*bottom': 'str',
             '*speed': 'int', '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
-- 
2.43.0


