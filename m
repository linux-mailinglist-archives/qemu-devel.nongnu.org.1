Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E75DB832EBF
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 19:16:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQtNN-0001k5-P1; Fri, 19 Jan 2024 13:13:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN7-0001cs-RV
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rQtN5-0007aL-UY
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 13:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705688018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFh+AqQpoSOmGs1u/gVZMucu4s6GGMQAjVb0Pg0NBuc=;
 b=AD+91MWFnX6o4n7N/4m9WCXC76c2yaWD201VXmJpt/Zw6C+YHEUW73sqkEXgikFeQzsFyZ
 syw/Z6u6CKL7nhN996CMRjHqph2cDUKjQpj3TFxMqwk8B79IWg6YeAaxBLXSN/wel95ZFi
 gYWZr28zzuy1BDI4mW6NBSidXbnNEZg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-AE59Fc6_OWOnu-UP72imTw-1; Fri,
 19 Jan 2024 13:13:36 -0500
X-MC-Unique: AE59Fc6_OWOnu-UP72imTw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AE513C28672;
 Fri, 19 Jan 2024 18:13:36 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.86])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91A1F494;
 Fri, 19 Jan 2024 18:13:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 04/14] stream: Allow users to request only format driver names
 in backing file format
Date: Fri, 19 Jan 2024 19:13:17 +0100
Message-ID: <20240119181327.236745-5-kwolf@redhat.com>
In-Reply-To: <20240119181327.236745-1-kwolf@redhat.com>
References: <20240119181327.236745-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Krempa <pkrempa@redhat.com>

Introduce a new flag 'backing-mask-protocol' for the block-stream QMP
command which instructs the internals to use 'raw' instead of the
protocol driver in case when a image is used without a dummy 'raw'
wrapper.

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
Message-ID: <bbee9a0a59748a8893289bf8249f568f0d587e62.1701796348.git.pkrempa@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json                   |  9 ++++++++-
 include/block/block_int-global-state.h |  3 +++
 block/monitor/block-hmp-cmds.c         |  2 +-
 block/stream.c                         | 10 +++++++++-
 blockdev.c                             |  7 +++++++
 5 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 726145ec8a..04982bff96 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2826,6 +2826,11 @@
 #     Care should be taken when specifying the string, to specify a
 #     valid filename or protocol.  (Since 2.1)
 #
+# @backing-mask-protocol: If true, replace any protocol mentioned in the
+#     'backing file format' with 'raw', rather than storing the protocol
+#     name as the backing format.  Can be used even when no image header
+#     will be updated (default false; since 9.0).
+#
 # @speed: the maximum speed, in bytes per second
 #
 # @on-error: the action to take on an error (default report). 'stop'
@@ -2864,7 +2869,9 @@
 ##
 { 'command': 'block-stream',
   'data': { '*job-id': 'str', 'device': 'str', '*base': 'str',
-            '*base-node': 'str', '*backing-file': 'str', '*bottom': 'str',
+            '*base-node': 'str', '*backing-file': 'str',
+            '*backing-mask-protocol': 'bool',
+            '*bottom': 'str',
             '*speed': 'int', '*on-error': 'BlockdevOnError',
             '*filter-node-name': 'str',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' },
diff --git a/include/block/block_int-global-state.h b/include/block/block_int-global-state.h
index 2162269df6..d2201e27f4 100644
--- a/include/block/block_int-global-state.h
+++ b/include/block/block_int-global-state.h
@@ -46,6 +46,8 @@
  * flatten the whole backing file chain onto @bs.
  * @backing_file_str: The file name that will be written to @bs as the
  * the new backing file if the job completes. Ignored if @base is %NULL.
+ * @backing_mask_protocol: Replace potential protocol name with 'raw' in
+ *                         'backing file format' header
  * @creation_flags: Flags that control the behavior of the Job lifetime.
  *                  See @BlockJobCreateFlags
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
@@ -64,6 +66,7 @@
  */
 void stream_start(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *base, const char *backing_file_str,
+                  bool backing_mask_protocol,
                   BlockDriverState *bottom,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index bdbb5cb141..d954bec6f1 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -496,7 +496,7 @@ void hmp_block_stream(Monitor *mon, const QDict *qdict)
     const char *base = qdict_get_try_str(qdict, "base");
     int64_t speed = qdict_get_try_int(qdict, "speed", 0);
 
-    qmp_block_stream(device, device, base, NULL, NULL, NULL,
+    qmp_block_stream(device, device, base, NULL, NULL, false, false, NULL,
                      qdict_haskey(qdict, "speed"), speed,
                      true, BLOCKDEV_ON_ERROR_REPORT, NULL,
                      false, false, false, false, &error);
diff --git a/block/stream.c b/block/stream.c
index 048c2d282f..7031eef12b 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -39,6 +39,7 @@ typedef struct StreamBlockJob {
     BlockDriverState *target_bs;
     BlockdevOnError on_error;
     char *backing_file_str;
+    bool backing_mask_protocol;
     bool bs_read_only;
 } StreamBlockJob;
 
@@ -95,7 +96,12 @@ static int stream_prepare(Job *job)
         if (unfiltered_base) {
             base_id = s->backing_file_str ?: unfiltered_base->filename;
             if (unfiltered_base->drv) {
-                base_fmt = unfiltered_base->drv->format_name;
+                if (s->backing_mask_protocol &&
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
+                  bool backing_mask_protocol,
                   BlockDriverState *bottom,
                   int creation_flags, int64_t speed,
                   BlockdevOnError on_error,
@@ -398,6 +405,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     s->base_overlay = base_overlay;
     s->above_base = above_base;
     s->backing_file_str = g_strdup(backing_file_str);
+    s->backing_mask_protocol = backing_mask_protocol;
     s->cor_filter_bs = cor_filter_bs;
     s->target_bs = bs;
     s->bs_read_only = bs_read_only;
diff --git a/blockdev.c b/blockdev.c
index 292c8af3f9..f8bb0932f8 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2278,6 +2278,8 @@ void qmp_block_stream(const char *job_id, const char *device,
                       const char *base,
                       const char *base_node,
                       const char *backing_file,
+                      bool has_backing_mask_protocol,
+                      bool backing_mask_protocol,
                       const char *bottom,
                       bool has_speed, int64_t speed,
                       bool has_on_error, BlockdevOnError on_error,
@@ -2313,6 +2315,10 @@ void qmp_block_stream(const char *job_id, const char *device,
         return;
     }
 
+    if (!has_backing_mask_protocol) {
+        backing_mask_protocol = false;
+    }
+
     if (!has_on_error) {
         on_error = BLOCKDEV_ON_ERROR_REPORT;
     }
@@ -2400,6 +2406,7 @@ void qmp_block_stream(const char *job_id, const char *device,
     }
 
     stream_start(job_id, bs, base_bs, backing_file,
+                 backing_mask_protocol,
                  bottom_bs, job_flags, has_speed ? speed : 0, on_error,
                  filter_node_name, &local_err);
     if (local_err) {
-- 
2.43.0


