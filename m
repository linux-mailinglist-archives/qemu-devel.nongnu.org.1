Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D837916BD
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:02:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8CC-0001Pz-5P; Mon, 04 Sep 2023 07:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bq-0001Hj-Mp
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qd8Bo-00010F-0Z
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 07:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693828579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSqUYwaW5065Yca/fSouV8kPEZ/gVgMxFwvOit9bqlM=;
 b=YUPGqymxMLDK+pN3isYJoNd28ZnjyRrw70aDVnGDYEtMhm1KHBjXKjFcd848zidPasUHvi
 UVcPLrf8aOVOHzhYo7mcqR2TzidXt2J4b5BjyPdqvh3la95i/1Gh9rgKo0MFKVFjM5s+C7
 BIf6W9DA59u7RKysmebjGuM14K7Slj0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-A5bE_0ckO8umSGBkwrF92A-1; Mon, 04 Sep 2023 07:56:17 -0400
X-MC-Unique: A5bE_0ckO8umSGBkwrF92A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7F9191817909;
 Mon,  4 Sep 2023 11:56:17 +0000 (UTC)
Received: from localhost (unknown [10.39.208.42])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1FE5A1182D4;
 Mon,  4 Sep 2023 11:56:15 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Guoyi Tu <tugy@chinatelecom.cn>,
 dengpengcheng <dengpc12@chinatelecom.cn>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 50/52] ui/vdagent: call vdagent_disconnect() when agent
 connection is lost
Date: Mon,  4 Sep 2023 15:52:47 +0400
Message-ID: <20230904115251.4161397-51-marcandre.lureau@redhat.com>
In-Reply-To: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
References: <20230904115251.4161397-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

From: Guoyi Tu <tugy@chinatelecom.cn>

when the agent connection is lost, the input handler of the mouse
doesn't deactivate, which results in unresponsive mouse events in
VNC windows.

To fix this issue, call vdagent_disconnect() to reset the state
each time the frontend disconncect

Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
Signed-off-by: dengpengcheng <dengpc12@chinatelecom.cn>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <71fd5a58fd09f10cdb35f167b2edb5669300116e.1692281173.git.tugy@chinatelecom.cn>
---
 ui/vdagent.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 8a651492f0..4b9a1fb7c5 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -870,8 +870,11 @@ static void vdagent_disconnect(VDAgentChardev *vd)
 
 static void vdagent_chr_set_fe_open(struct Chardev *chr, int fe_open)
 {
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(chr);
+
     if (!fe_open) {
         trace_vdagent_close();
+        vdagent_disconnect(vd);
         /* To reset_serial, we CLOSED our side. Make sure the other end knows we
          * are ready again. */
         qemu_chr_be_event(chr, CHR_EVENT_OPENED);
-- 
2.41.0


