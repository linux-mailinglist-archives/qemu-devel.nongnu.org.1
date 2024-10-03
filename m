Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF2B98EE10
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Oct 2024 13:25:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swJvP-0000ie-4u; Thu, 03 Oct 2024 07:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJvL-0000ho-08
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1swJvG-0004q9-FM
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 07:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727954584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pHm6wTPTzUjfAO4AzpcMzfTLULgYF6KhJ4rnk6cMfEI=;
 b=V0j8BlVS4+G+Wlvt9rD+4lxLyNCaUIaPnoTIJ4uEE4CqD9IE00dYZmLGflQyyfGftkpt5y
 +zLpWUUNIn2Xhkv6+mdgdWsB71Hug5tHsJDgCEOC6FgMdqNh8lvB9Is0c9fY9K2Y4EToAy
 uyf6YwZNuj1ePqvgmhR71t/hSGeiLig=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-_ZMQ2v7pNvq1Fpysyg6O_w-1; Thu,
 03 Oct 2024 07:23:01 -0400
X-MC-Unique: _ZMQ2v7pNvq1Fpysyg6O_w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4F491955F54; Thu,  3 Oct 2024 11:22:59 +0000 (UTC)
Received: from localhost (unknown [10.39.208.36])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA60019560A3; Thu,  3 Oct 2024 11:22:57 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 belmouss@redhat.com, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 02/16] hw/audio/hda: fix memory leak on audio setup
Date: Thu,  3 Oct 2024 15:22:29 +0400
Message-ID: <20241003112244.3340697-3-marcandre.lureau@redhat.com>
In-Reply-To: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
References: <20241003112244.3340697-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When SET_STREAM_FORMAT is called, we should clear the existing setup.

Factor out common function to close a stream.

Direct leak of 144 byte(s) in 3 object(s) allocated from:
    #0 0x7f91d38f7350 in calloc (/lib64/libasan.so.8+0xf7350) (BuildId: a4ad7eb954b390cf00f07fa10952988a41d9fc7a)
    #1 0x7f91d2ab7871 in g_malloc0 (/lib64/libglib-2.0.so.0+0x64871) (BuildId: 36b60dbd02e796145a982d0151ce37202ec05649)
    #2 0x562fa2f447ee in timer_new_full /home/elmarco/src/qemu/include/qemu/timer.h:538
    #3 0x562fa2f4486f in timer_new /home/elmarco/src/qemu/include/qemu/timer.h:559
    #4 0x562fa2f448a9 in timer_new_ns /home/elmarco/src/qemu/include/qemu/timer.h:577
    #5 0x562fa2f47955 in hda_audio_setup ../hw/audio/hda-codec.c:490
    #6 0x562fa2f4897e in hda_audio_command ../hw/audio/hda-codec.c:605

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/audio/hda-codec.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
index 74c0292284..bc661504cf 100644
--- a/hw/audio/hda-codec.c
+++ b/hw/audio/hda-codec.c
@@ -472,6 +472,24 @@ static void hda_audio_set_amp(HDAAudioStream *st)
     }
 }
 
+static void hda_close_stream(HDAAudioState *a, HDAAudioStream *st)
+{
+    if (st->node == NULL) {
+        return;
+    }
+    if (a->use_timer) {
+        timer_free(st->buft);
+        st->buft = NULL;
+    }
+    if (st->output) {
+        AUD_close_out(&a->card, st->voice.out);
+        st->voice.out = NULL;
+    } else {
+        AUD_close_in(&a->card, st->voice.in);
+        st->voice.in = NULL;
+    }
+}
+
 static void hda_audio_setup(HDAAudioStream *st)
 {
     bool use_timer = st->state->use_timer;
@@ -484,6 +502,7 @@ static void hda_audio_setup(HDAAudioStream *st)
     trace_hda_audio_format(st->node->name, st->as.nchannels,
                            fmt2name[st->as.fmt], st->as.freq);
 
+    hda_close_stream(st->state, st);
     if (st->output) {
         if (use_timer) {
             cb = hda_audio_output_cb;
@@ -741,23 +760,11 @@ static void hda_audio_init(HDACodecDevice *hda,
 static void hda_audio_exit(HDACodecDevice *hda)
 {
     HDAAudioState *a = HDA_AUDIO(hda);
-    HDAAudioStream *st;
     int i;
 
     dprint(a, 1, "%s\n", __func__);
     for (i = 0; i < ARRAY_SIZE(a->st); i++) {
-        st = a->st + i;
-        if (st->node == NULL) {
-            continue;
-        }
-        if (a->use_timer) {
-            timer_free(st->buft);
-        }
-        if (st->output) {
-            AUD_close_out(&a->card, st->voice.out);
-        } else {
-            AUD_close_in(&a->card, st->voice.in);
-        }
+        hda_close_stream(a, a->st + i);
     }
     AUD_remove_card(&a->card);
 }
-- 
2.45.2.827.g557ae147e6


