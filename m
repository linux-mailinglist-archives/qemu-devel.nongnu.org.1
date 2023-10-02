Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805C7B558A
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKN2-0008Fx-8V; Mon, 02 Oct 2023 10:58:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMz-0008FL-VZ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMy-0003gg-3i
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TUsBw7Kt7G+GqYe51WoV2cEtrfFekkw/Aub/QiRVm0s=;
 b=KmgOnYtwqYvTV1uNaTkNPuKIEy83ZP1RpReGKCYKvYdU7aOUjwh+MOZQ8BgpMMlHrjjaZK
 D/DNFrJKVGH8A7oM86OIW8tzj3do544kOT7DQhPeubwRQ0bx985SZJxSfY9mlnm4akyaqA
 aETyeb+BtE4J6IpuRebBN3LjNkRdZiQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-PhzT7B29O_ytDecBmm9x_g-1; Mon, 02 Oct 2023 10:57:58 -0400
X-MC-Unique: PhzT7B29O_ytDecBmm9x_g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-533ca50404bso11107990a12.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258675; x=1696863475;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUsBw7Kt7G+GqYe51WoV2cEtrfFekkw/Aub/QiRVm0s=;
 b=LTd4B9myg1Tt1C4isVtph6XDDT4p6vSrlR+FjxXBDvNoSdM4q2jeXvarqavQqNCknP
 ChHhExsQ7LefN9bFaMq/FKNZRrOC11HX2h4b+n8F7PsTCdR0nTdU7dMyJaVEaHvbJW4b
 mGggUxP/6hKG18rx3xfWpch+Q80YqkdSK9pI3TPw4Gs1mGuod25Cb+VM/c/DmL+fInFi
 TGFAT+08PU6ZzXnKafVniPch+/hXq3GFexi1L56GZMTtUh2DNk/gdfx8t0g+cyShTuA8
 Y7wLbKkw9l5Vp2hMULVrHzJHqfm/62uodgdSx8F5xhu7gBDu2tGldCRwWrqgQDedLiga
 SMEg==
X-Gm-Message-State: AOJu0YzswW+r7q8zcqagutEx0WB6+qPwSUs9K79NobNOODlLe/jigXYk
 YMw40LaPcPYm9BofIrFRCFiEJxDyAMkAPaenFS0l2q/HFu6flLLGoplr+4KWmxrrNqX6jiGnBGB
 88fcI/MPQbKSXtXJ6gjoG4MKIy3JvEdRLKFkOjhlNX6Zy27hOPRaSycwCCe4t8SrTBPr35kESfE
 Q=
X-Received: by 2002:a17:906:311b:b0:9a2:28dc:4168 with SMTP id
 27-20020a170906311b00b009a228dc4168mr9513928ejx.61.1696258675087; 
 Mon, 02 Oct 2023 07:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhncKMHMryDyLiVNMzqCLQkKNnbEcXHGr8IyitvQd5WBLYqSGRvVvNNskzhjorWMscxLQ2zQ==
X-Received: by 2002:a17:906:311b:b0:9a2:28dc:4168 with SMTP id
 27-20020a170906311b00b009a228dc4168mr9513915ejx.61.1696258674772; 
 Mon, 02 Oct 2023 07:57:54 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 i22-20020a17090671d600b009929ab17be0sm17033320ejk.162.2023.10.02.07.57.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PATCH 13/13] audio: forbid default audiodev backend with -nodefaults
Date: Mon,  2 Oct 2023 16:57:27 +0200
Message-ID: <20231002145728.87958-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002145728.87958-1-pbonzini@redhat.com>
References: <20231002145728.87958-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Now that all callers support setting an audiodev, forbid using the default
audiodev if -nodefaults is provided on the command line.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/audio/audio.c b/audio/audio.c
index 4289b7bf028..730bf2498dc 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1692,6 +1692,10 @@ static void audio_create_default_audiodevs(void)
 {
     const char *drvname = getenv("QEMU_AUDIO_DRV");
 
+    if (!defaults_enabled()) {
+        return;
+    }
+
     /* QEMU_AUDIO_DRV=none is used by libqtest.  */
     if (drvname && !g_str_equal(drvname, "none")) {
         error_report("Please use -audiodev instead of QEMU_AUDIO_*");
@@ -1808,6 +1812,14 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
 {
     if (!card->state) {
         if (!QTAILQ_EMPTY(&audio_states)) {
+            /*
+             * FIXME: once it is possible to create an arbitrary
+             * default device via -audio DRIVER,OPT=VALUE (no "model"),
+             * replace this special case with the default AudioState*,
+             * storing it in a separate global.  For now, keep the
+             * warning to encourage moving off magic use of the first
+             * -audiodev.
+             */
             if (QSIMPLEQ_EMPTY(&default_audiodevs)) {
                 dolog("Device %s: audiodev default parameter is deprecated, please "
                       "specify audiodev=%s\n", name,
@@ -1820,6 +1832,10 @@ bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp)
             }
             card->state = audio_init(NULL, errp);
             if (!card->state) {
+                if (!QSIMPLEQ_EMPTY(&audiodevs)) {
+                    error_append_hint(errp, "Perhaps you wanted to set audiodev=%s?",
+                                      QSIMPLEQ_FIRST(&audiodevs)->dev->id);
+                }
                 return false;
             }
         }
-- 
2.41.0


