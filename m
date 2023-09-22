Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8457AAE18
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcW3-0004pS-Jp; Fri, 22 Sep 2023 05:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVw-0004mw-N2
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVu-0003Oy-SC
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tqWqPvdI3aBX8tuEyTlgIJpIs01Oj1UkJ9BJ8gznLeI=;
 b=XfpdeKYwe9VCEFEIMVUBQWenEE5imRh3UvHgVfxl0U4wAmUOuMmfLeQKR2HQCEzvRxyGn4
 u4hkboRb8xuQIX6xD2Sb/saPXYA9y1E0tg7VaYSme38eDRo0UuLVPcx653500Xq3DBI10R
 3NTC/P45njXK3PoDciNbYt366e/btIA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-QR9u-pfSPhSw4OLLT_oF0g-1; Fri, 22 Sep 2023 05:31:52 -0400
X-MC-Unique: QR9u-pfSPhSw4OLLT_oF0g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5042bc93273so2011342e87.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375109; x=1695979909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tqWqPvdI3aBX8tuEyTlgIJpIs01Oj1UkJ9BJ8gznLeI=;
 b=sdG8Fnd7joLHUKy5WUfO076e4NtgJGBYurx+QCuCxwUEFpNE8NoveDNkO5XOh4OQS9
 fqP+X4Dy2PYqMevXt5WHAJNGEFallfqNWuTAbn3iYg+UlhGNH/U4c8JEwEx3Haluj9TM
 nxCzu3WFGHZU1J5yi6KnTwsBylRtMJlXsUZKno9WFlDasZo9f6CmaHscc4Nxi6sd0tZL
 rSrPhx9fc8SqFzJGS+b0Bgx2qpLmnWbPv6pByqYejVDc/dUyVdCBRqm7C+fZWyOR85Tj
 WXRa6GihBw7mUyYiMdFhI7D35ABZ24zssXHVBTAoMQcnUDe6w4exkcewoLyFxKMNkA5L
 8pxA==
X-Gm-Message-State: AOJu0YyY15LWz5C4uRuQOFLLM/goAgB8g2YfjwKbqvT8rP6Di71hGp8m
 vcqcQWI1MQyHU42OzeCY6qMaI4ajFhMRun7rVziN7ofonK9KP7KUs9kPfAxnoEps16zmGcliRCm
 iScu4Hv54CCbk5I6ykST608wA2oUN9NJf2tA5/MWwcVmEksbODrNxueF5aOyS8+TicMXxvuI5ix
 s=
X-Received: by 2002:a05:6512:b8b:b0:500:7cab:efc3 with SMTP id
 b11-20020a0565120b8b00b005007cabefc3mr9008240lfv.11.1695375109747; 
 Fri, 22 Sep 2023 02:31:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHhvMQH/EMxF0hwyu4snhpCDhMbV5VCVf3FhIe42uSy1LohB8IFNDXpIMiCJsnby2dtzhzCA==
X-Received: by 2002:a05:6512:b8b:b0:500:7cab:efc3 with SMTP id
 b11-20020a0565120b8b00b005007cabefc3mr9008222lfv.11.1695375109493; 
 Fri, 22 Sep 2023 02:31:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 c24-20020a7bc858000000b004030c778396sm6987870wml.4.2023.09.22.02.31.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Martin Kletzander <mkletzan@redhat.com>
Subject: [PULL 12/12] audio: Require AudioState in AUD_add_capture
Date: Fri, 22 Sep 2023 11:31:25 +0200
Message-ID: <20230922093126.264016-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922093126.264016-1-pbonzini@redhat.com>
References: <20230922093126.264016-1-pbonzini@redhat.com>
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

From: Martin Kletzander <mkletzan@redhat.com>

Since all callers require a valid audiodev this function can now safely
abort in case of missing AudioState.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Message-ID: <c6e87e678e914df0f59da2145c2753cdb4a16f63.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 audio/audio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/audio/audio.c b/audio/audio.c
index 666ef4237dd..d72e7db7fb9 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -1854,8 +1854,9 @@ CaptureVoiceOut *AUD_add_capture(
     struct capture_callback *cb;
 
     if (!s) {
-        dolog("Capturing without setting an audiodev is deprecated\n");
-        s = audio_init(NULL, NULL);
+        error_setg(&error_abort,
+                   "Capturing without setting an audiodev is not supported");
+        abort();
     }
 
     if (!audio_get_pdo_out(s->dev)->mixing_engine) {
-- 
2.41.0


