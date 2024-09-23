Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3997B921
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Sep 2024 10:18:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqpsG-0000re-U5; Wed, 18 Sep 2024 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sqpsE-0000qo-KK
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 04:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sqpsC-0005pF-RH
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726647434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0pbCoZDR3JfRHhpWltvEzkcaigBa4B2aZ9fev/m6yKU=;
 b=cCAcpJOvUdFUiqitTzUnwKkAwR0Xm1erXyUTWODvZxL0Iyz3Mmtdr1NDf9Fao3xJlEirxr
 to3AWRTmHXzy1U5jCXL4XyAb18MEui0ZEIpwDrhFY94Wvb0ERUjMrwJ+0HY75OleVHN0g9
 pjBYlDfrZy1JL+NetdVYwE2Rgtg6zR0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-vbNM_kGgOPSj8h3vw7HrpA-1; Wed,
 18 Sep 2024 04:17:13 -0400
X-MC-Unique: vbNM_kGgOPSj8h3vw7HrpA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4647C1956048
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 08:17:11 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8ACA51955DC6; Wed, 18 Sep 2024 08:17:08 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v2] audio/pw: Report more accurate error when connecting to
 PipeWire fails
Date: Wed, 18 Sep 2024 10:17:06 +0200
Message-ID: <3a78811ad5b0e87816b7616ab21d2eeef00b9c52.1726647033.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

According to its man page [1], pw_context_connect() sets errno on
failure:

  Returns a Core on success or NULL with errno set on error.

It may be handy to see errno when figuring out why PipeWire
failed to connect. That leaves us with just one possible path to
reach 'fail_error' label which is then moved to that path and
also its error message is adjusted slightly.

1: https://docs.pipewire.org/group__pw__core.html#ga5994e3a54e4ec718094ca02a1234815b

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---

v2 of:

https://mail.gnu.org/archive/html/qemu-devel/2024-09/msg03485.html

diff to v1:
- Dropped duplicated S-o-b line
- Fixed typo on error message (s/PipeWite/PipeWire/)

 audio/pwaudio.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/pwaudio.c b/audio/pwaudio.c
index 3b14e04fbb..8e13b58286 100644
--- a/audio/pwaudio.c
+++ b/audio/pwaudio.c
@@ -769,13 +769,15 @@ qpw_audio_init(Audiodev *dev, Error **errp)
     pw->core = pw_context_connect(pw->context, NULL, 0);
     if (pw->core == NULL) {
         pw_thread_loop_unlock(pw->thread_loop);
-        goto fail_error;
+        error_setg_errno(errp, errno, "Failed to connect to PipeWire instance");
+        goto fail;
     }
 
     if (pw_core_add_listener(pw->core, &pw->core_listener,
                              &core_events, pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
-        goto fail_error;
+        error_setg(errp, "Failed to add PipeWire listener");
+        goto fail;
     }
     if (wait_resync(pw) < 0) {
         pw_thread_loop_unlock(pw->thread_loop);
@@ -785,8 +787,6 @@ qpw_audio_init(Audiodev *dev, Error **errp)
 
     return g_steal_pointer(&pw);
 
-fail_error:
-    error_setg(errp, "Failed to initialize PW context");
 fail:
     if (pw->thread_loop) {
         pw_thread_loop_stop(pw->thread_loop);
-- 
2.44.2


