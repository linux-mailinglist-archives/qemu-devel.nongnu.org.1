Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9139C1A24A
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Oct 2025 13:09:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE4xU-0003AV-FU; Wed, 29 Oct 2025 08:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4xB-000360-J4
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vE4wy-0004wB-OZ
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 08:06:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761739606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AmT8x+qOHL11jqdaDCEcFKPTxt0bXUDzwKkXxr+i52Q=;
 b=Q9RscTb2v9pViEClX7PP/7Yc2zej5OsbRRUI2iwcvckvgnPb/wbMS5DqzWL+V0hOA5UJbZ
 P9tYq6pBALLFUwvGIcmn6QS0cABO5vVEfXnAva1GNyUIBM8FCMHae1CF+VQZhPNUkkhsAf
 GcHoef5asvCo5Vlj7dY3qlXR+xp9D/c=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-GMz57SsDM66Kp7t76EsEnw-1; Wed,
 29 Oct 2025 08:06:45 -0400
X-MC-Unique: GMz57SsDM66Kp7t76EsEnw-1
X-Mimecast-MFC-AGG-ID: GMz57SsDM66Kp7t76EsEnw_1761739604
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70F64195608D; Wed, 29 Oct 2025 12:06:44 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.33.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 25473180057E; Wed, 29 Oct 2025 12:06:42 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 03/18] block: fix luks 'amend' when run in coroutine
Date: Wed, 29 Oct 2025 13:06:19 +0100
Message-ID: <20251029120634.288467-4-kwolf@redhat.com>
In-Reply-To: <20251029120634.288467-1-kwolf@redhat.com>
References: <20251029120634.288467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Launch QEMU with

  $ qemu-img create \
      --object secret,id=sec0,data=123456 \
      -f luks -o key-secret=sec0 demo.luks 1g

  $ qemu-system-x86_64 \
      --object secret,id=sec0,data=123456 \
      -blockdev  driver=luks,key-secret=sec0,file.filename=demo.luks,file.driver=file,node-name=luks

Then in QMP shell attempt

  x-blockdev-amend job-id=fish node-name=luks options={'state':'active','new-secret':'sec0','driver':'luks'}

It will result in an assertion

  #0  __pthread_kill_implementation (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
  #1  0x00007fad18b73f63 in __pthread_kill_internal (threadid=<optimized out>, signo=6) at pthread_kill.c:89
  #2  0x00007fad18b19f3e in __GI_raise (sig=sig@entry=6) at ../sysdeps/posix/raise.c:26
  #3  0x00007fad18b016d0 in __GI_abort () at abort.c:77
  #4  0x00007fad18b01639 in __assert_fail_base
      (fmt=<optimized out>, assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>) at assert.c:118
  #5  0x00007fad18b120af in __assert_fail (assertion=<optimized out>, file=<optimized out>, line=<optimized out>, function=<optimized out>)
      at assert.c:127
  #6  0x000055ff74fdbd46 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
  #7  0x000055ff7548521b in graph_lockable_auto_lock_mainloop (x=<optimized out>)
      at /usr/src/debug/qemu-9.2.4-1.fc42.x86_64/include/block/graph-lock.h:266
  #8  block_crypto_read_func (block=<optimized out>, offset=4096, buf=0x55ffb6d66ef0 "", buflen=256000, opaque=0x55ffb5edcc30, errp=0x55ffb6f00700)
      at ../block/crypto.c:71
  #9  0x000055ff75439f8b in qcrypto_block_luks_load_key
      (block=block@entry=0x55ffb5edbe90, slot_idx=slot_idx@entry=0, password=password@entry=0x55ffb67dc260 "123456", masterkey=masterkey@entry=0x55ffb5fb0c40 "", readfunc=readfunc@entry=0x55ff754851e0 <block_crypto_read_func>, opaque=opaque@entry=0x55ffb5edcc30, errp=0x55ffb6f00700)
      at ../crypto/block-luks.c:927
  #10 0x000055ff7543b90f in qcrypto_block_luks_find_key
      (block=<optimized out>, password=<optimized out>, masterkey=<optimized out>, readfunc=<optimized out>, opaque=<optimized out>, errp=<optimized out>) at ../crypto/block-luks.c:1045
  #11 qcrypto_block_luks_amend_add_keyslot
      (block=0x55ffb5edbe90, readfunc=0x55ff754851e0 <block_crypto_read_func>, writefunc=0x55ff75485100 <block_crypto_write_func>, opaque=0x55ffb5edcc3, opts_luks=0x7fad1715aef8, force=<optimized out>, errp=0x55ffb6f00700) at ../crypto/block-luks.c:1673
  #12 qcrypto_block_luks_amend_options
      (block=0x55ffb5edbe90, readfunc=0x55ff754851e0 <block_crypto_read_func>, writefunc=0x55ff75485100 <block_crypto_write_func>, opaque=0x55ffb5edcc30, options=0x7fad1715aef0, force=<optimized out>, errp=0x55ffb6f00700) at ../crypto/block-luks.c:1865
  #13 0x000055ff75485b95 in block_crypto_amend_options_generic_luks
      (bs=<optimized out>, amend_options=<optimized out>, force=<optimized out>, errp=<optimized out>) at ../block/crypto.c:949
  #14 0x000055ff75485c28 in block_crypto_co_amend_luks (bs=<optimized out>, opts=<optimized out>, force=<optimized out>, errp=<optimized out>)
      at ../block/crypto.c:1008
  #15 0x000055ff754778e5 in blockdev_amend_run (job=0x55ffb6f00640, errp=0x55ffb6f00700) at ../block/amend.c:52
  #16 0x000055ff75468b90 in job_co_entry (opaque=0x55ffb6f00640) at ../job.c:1106
  #17 0x000055ff755a0fc2 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at ../util/coroutine-ucontext.c:175

This changes the read/write callbacks to not assert that they
are run in mainloop context if already in a coroutine.

This is also reproduced by qemu-iotests cases 295 and 296.

Fixes: 1f051dcbdf2e4b6f518db731c84e304b2b9d15ce
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250919112213.1530079-1-berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 17b4749a1e..7c37b23e36 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -67,11 +67,18 @@ static int block_crypto_read_func(QCryptoBlock *block,
     BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
-    GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    if (qemu_in_coroutine()) {
+        GRAPH_RDLOCK_GUARD();
 
-    ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
-                     offset, buflen, buf, 0);
+        ret = bdrv_co_pread(crypto->header ? crypto->header : bs->file,
+                            offset, buflen, buf, 0);
+    } else {
+        GLOBAL_STATE_CODE();
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+        ret = bdrv_pread(crypto->header ? crypto->header : bs->file,
+                         offset, buflen, buf, 0);
+    }
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not read encryption header");
         return ret;
@@ -90,11 +97,18 @@ static int block_crypto_write_func(QCryptoBlock *block,
     BlockCrypto *crypto = bs->opaque;
     ssize_t ret;
 
-    GLOBAL_STATE_CODE();
-    GRAPH_RDLOCK_GUARD_MAINLOOP();
+    if (qemu_in_coroutine()) {
+        GRAPH_RDLOCK_GUARD();
 
-    ret = bdrv_pwrite(crypto->header ? crypto->header : bs->file,
-                      offset, buflen, buf, 0);
+        ret = bdrv_co_pwrite(crypto->header ? crypto->header : bs->file,
+                             offset, buflen, buf, 0);
+    } else {
+        GLOBAL_STATE_CODE();
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+        ret = bdrv_pwrite(crypto->header ? crypto->header : bs->file,
+                          offset, buflen, buf, 0);
+    }
     if (ret < 0) {
         error_setg_errno(errp, -ret, "Could not write encryption header");
         return ret;
-- 
2.51.0


