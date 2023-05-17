Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D925706EBF
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:53:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKNB-0003w2-KR; Wed, 17 May 2023 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKN9-0003uW-O4
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1pzKN7-0001OR-NS
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684342289;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rx2tAbxgvTISt6mI/zbELu5EFon9m9vMd7d3sRwfDjM=;
 b=IXxoBXO+LiQ2DjSC1GtY21oT5qBRMIBc+xoXR+4hX5pP6NczizwbkwHDpl3alNT2PbET9p
 H1Eul2c+pZ7W1dvuDUAPX6JgEQp181QGMKJwpHL3dnnxZd7GSFIjkaOO0DP5I0pIaAMLNo
 78iTGn42JYxxgIIwxMgpOaAU4molceQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-j_dKzCoMNoODfbH7BoN4eQ-1; Wed, 17 May 2023 12:51:26 -0400
X-MC-Unique: j_dKzCoMNoODfbH7BoN4eQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8BF94185A7A4;
 Wed, 17 May 2023 16:51:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D492D40C6EC4;
 Wed, 17 May 2023 16:51:24 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/18] blockdev: transactions: rename some things
Date: Wed, 17 May 2023 18:51:00 +0200
Message-Id: <20230517165116.475123-3-kwolf@redhat.com>
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Look at qmp_transaction(): dev_list is not obvious name for list of
actions. Let's look at qapi spec, this argument is "actions". Let's
follow the common practice of using same argument names in qapi scheme
and code.

To be honest, rename props to properties for same reason.

Next, we have to rename global map of actions, to not conflict with new
name for function argument.

Rename also dev_entry loop variable accordingly to new name of the
list.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20230510150624.310640-3-vsementsov@yandex-team.ru>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3c72d40f51..75e313f403 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2291,7 +2291,7 @@ static void abort_commit(void *opaque)
     g_assert_not_reached(); /* this action never succeeds */
 }
 
-static const BlkActionOps actions[] = {
+static const BlkActionOps actions_map[] = {
     [TRANSACTION_ACTION_KIND_BLOCKDEV_SNAPSHOT] = {
         .instance_size = sizeof(ExternalSnapshotState),
         .action  = external_snapshot_action,
@@ -2373,12 +2373,12 @@ static TransactionProperties *get_transaction_properties(
  *
  * Always run under BQL.
  */
-void qmp_transaction(TransactionActionList *dev_list,
-                     struct TransactionProperties *props,
+void qmp_transaction(TransactionActionList *actions,
+                     struct TransactionProperties *properties,
                      Error **errp)
 {
-    TransactionActionList *dev_entry = dev_list;
-    bool has_props = !!props;
+    TransactionActionList *act = actions;
+    bool has_properties = !!properties;
     JobTxn *block_job_txn = NULL;
     Error *local_err = NULL;
     Transaction *tran = tran_new();
@@ -2388,8 +2388,8 @@ void qmp_transaction(TransactionActionList *dev_list,
     /* Does this transaction get canceled as a group on failure?
      * If not, we don't really need to make a JobTxn.
      */
-    props = get_transaction_properties(props);
-    if (props->completion_mode != ACTION_COMPLETION_MODE_INDIVIDUAL) {
+    properties = get_transaction_properties(properties);
+    if (properties->completion_mode != ACTION_COMPLETION_MODE_INDIVIDUAL) {
         block_job_txn = job_txn_new();
     }
 
@@ -2397,24 +2397,24 @@ void qmp_transaction(TransactionActionList *dev_list,
     bdrv_drain_all();
 
     /* We don't do anything in this loop that commits us to the operations */
-    while (NULL != dev_entry) {
+    while (NULL != act) {
         TransactionAction *dev_info = NULL;
         const BlkActionOps *ops;
         BlkActionState *state;
 
-        dev_info = dev_entry->value;
-        dev_entry = dev_entry->next;
+        dev_info = act->value;
+        act = act->next;
 
-        assert(dev_info->type < ARRAY_SIZE(actions));
+        assert(dev_info->type < ARRAY_SIZE(actions_map));
 
-        ops = &actions[dev_info->type];
+        ops = &actions_map[dev_info->type];
         assert(ops->instance_size > 0);
 
         state = g_malloc0(ops->instance_size);
         state->ops = ops;
         state->action = dev_info;
         state->block_job_txn = block_job_txn;
-        state->txn_props = props;
+        state->txn_props = properties;
 
         state->ops->action(state, tran, &local_err);
         if (local_err) {
@@ -2432,8 +2432,8 @@ delete_and_fail:
     /* failure, and it is all-or-none; roll back all operations */
     tran_abort(tran);
 exit:
-    if (!has_props) {
-        qapi_free_TransactionProperties(props);
+    if (!has_properties) {
+        qapi_free_TransactionProperties(properties);
     }
     job_txn_unref(block_job_txn);
 }
-- 
2.40.1


