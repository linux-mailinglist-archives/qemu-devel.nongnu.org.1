Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3DFD7AB501
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:43:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIy-0000nV-Eo; Fri, 22 Sep 2023 11:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIu-0000b3-68
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIp-0002pJ-FP
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IqGt2fPfgTyHEp6DMIYvMCh4gKwvp12ld6099wBQ+mY=;
 b=JIT6wKwtw6J1ngNIfS02iNcEnOHGQNrRbHwzmKr5VBttaGcHyoQvcP0BLWDGGuidLgr+Rh
 qWKEVxT+8r2H+GpTyqKfXy51somch9UCeCmXwIuPObddIqvOwIJrVv3wh6Ytvk3QOmIPp6
 gILhd81VesF5Hyw8/9Bgf6ykJqPbWDM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-aI1KLTL3O6CKv0yFW4_rVg-1; Fri, 22 Sep 2023 11:42:45 -0400
X-MC-Unique: aI1KLTL3O6CKv0yFW4_rVg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-403ca0e2112so17386785e9.0
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397363; x=1696002163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqGt2fPfgTyHEp6DMIYvMCh4gKwvp12ld6099wBQ+mY=;
 b=tD0mtHo1LmXHBtcBYS2Nu8KJVVWeqBFR1Aw71coAT4A7dI43qEPjY1HS2ApDQwnaeR
 Ey5FcB32s42GAKUumb8uK0HLSf4tGDz7pH8OO70bHWAaV77vo4DKUwWZiLcRIX3k2ZQA
 +ifPtQzbmZL+60z1uA66mEowsKeHRj6Z27WnCMxLIEZP13aLaSm2kz62n5n1heg+tICz
 RgsaBoIbGl/JR62/qqCZFuf8smbqyxVUswTNp1XucziBTjsNT4NKiMaiY+B+bYb/Tzm4
 SLzkztFeHkDADLlkXwrfJ2idPSgKDw/aZ6L0FQuuedtTA3dNKmM9iDv3MM8LiId950h8
 eY9g==
X-Gm-Message-State: AOJu0Yy/bBzEtM6L8tESCuOIjRuIUCrbZtaF4H9B7YN/ttY8PenhYj5e
 K5e7IIhVVVAASXJsSSX84xAI4IJw72qCnNNqp1AgLuvAOtzPzuNmMPXA/aTp/IomjMq3APO+IaM
 v8zmiMlFWsyTEze4A1th4sKqHZTpyqywXTb8XWqyHi8rZVPBQZUuZHqj2YnfYVlPFpA5guPs9wC
 M=
X-Received: by 2002:a7b:cbd3:0:b0:3fd:2e89:31bd with SMTP id
 n19-20020a7bcbd3000000b003fd2e8931bdmr8158284wmi.14.1695397363537; 
 Fri, 22 Sep 2023 08:42:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfgCLEhw53eJfZE0rF7xkomyzHjiE+JKoAaPuh22PAd6ysKUNko2FGBinK04arsoC8KEiFYw==
X-Received: by 2002:a7b:cbd3:0:b0:3fd:2e89:31bd with SMTP id
 n19-20020a7bcbd3000000b003fd2e8931bdmr8158266wmi.14.1695397363241; 
 Fri, 22 Sep 2023 08:42:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a05600c251200b003fed7fa6c00sm7848768wma.7.2023.09.22.08.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 6/9] hw/audio/lm4549: Add errp error reporting to init function
Date: Fri, 22 Sep 2023 17:42:25 +0200
Message-ID: <20230922154228.304933-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This will be used in future commit.

Signed-off-by: Martin Kletzander <mkletzan@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <be1bf295b3c6a3dee272b4b4e8115e37c2a772b5.1650874791.git.mkletzan@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/audio/lm4549.c | 3 ++-
 hw/audio/lm4549.h | 3 ++-
 hw/audio/pl041.c  | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/audio/lm4549.c b/hw/audio/lm4549.c
index 32b1481b561..418041bc9c6 100644
--- a/hw/audio/lm4549.c
+++ b/hw/audio/lm4549.c
@@ -276,7 +276,8 @@ static int lm4549_post_load(void *opaque, int version_id)
     return 0;
 }
 
-void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque)
+void lm4549_init(lm4549_state *s, lm4549_callback data_req_cb, void* opaque,
+                 Error **errp)
 {
     struct audsettings as;
 
diff --git a/hw/audio/lm4549.h b/hw/audio/lm4549.h
index aba9bb5b077..61c3ab12dd3 100644
--- a/hw/audio/lm4549.h
+++ b/hw/audio/lm4549.h
@@ -36,7 +36,8 @@ typedef struct {
 extern const VMStateDescription vmstate_lm4549_state;
 
 
-void lm4549_init(lm4549_state *s, lm4549_callback data_req, void *opaque);
+void lm4549_init(lm4549_state *s, lm4549_callback data_req, void *opaque,
+                 Error **errp);
 uint32_t lm4549_read(lm4549_state *s, hwaddr offset);
 void lm4549_write(lm4549_state *s, hwaddr offset, uint32_t value);
 uint32_t lm4549_write_samples(lm4549_state *s, uint32_t left, uint32_t right);
diff --git a/hw/audio/pl041.c b/hw/audio/pl041.c
index 03acd4fe344..868dffbfd32 100644
--- a/hw/audio/pl041.c
+++ b/hw/audio/pl041.c
@@ -564,7 +564,7 @@ static void pl041_realize(DeviceState *dev, Error **errp)
     }
 
     /* Init the codec */
-    lm4549_init(&s->codec, &pl041_request_data, (void *)s);
+    lm4549_init(&s->codec, &pl041_request_data, (void *)s, errp);
 }
 
 static const VMStateDescription vmstate_pl041_regfile = {
-- 
2.41.0


