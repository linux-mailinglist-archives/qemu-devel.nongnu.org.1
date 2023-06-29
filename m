Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E347423DC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 12:20:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEokK-0000Bf-KE; Thu, 29 Jun 2023 06:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokI-0000AC-DB
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qEokG-0005md-WD
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 06:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688033964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2c2zkm/eZJfTbSTlhRHnPmwWrHu8YrErxYEAgI8Iwts=;
 b=hTSa4SpcE2czCGVGqLnsUOH/VbcXfk3ffJUHYPs6KhEucqteBnQEwMLkHIxjwT2moNGvHF
 uTK6St35DNJj/qm/+IvKU2qe5LBuP+htVhpWpdKECCkqbVoEIN2LUn1kdwbe+XhhatXiMR
 QCGhc6WZDNJ32aI2UC/4coVX+rr3BoU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-p6YomXHOMQWy5foapAK7oA-1; Thu, 29 Jun 2023 06:19:23 -0400
X-MC-Unique: p6YomXHOMQWy5foapAK7oA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9874fbf5c95so65372566b.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 03:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688033961; x=1690625961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2c2zkm/eZJfTbSTlhRHnPmwWrHu8YrErxYEAgI8Iwts=;
 b=A9ubyHnxngeVFdReQYa0TEhAVZ7JS2XnUSQoq+sMYAQI2c5KfQSK9e94Bnr3XXuBU8
 qP8mFBrjKbxxsanF8nmLtgifkUodL6UtiLqkEh7lKNlfZ5+hIU6hv7debJzZ8NoIfUcW
 6Dy+BPBsTyl8OR/tCyfq9ZxyT+xfH0JsrWS05JSMwVhO4XaWDRafe3/99bRtaO83+R5L
 FHYeN82GXPs36mgXGdcHmZZmtqAdy5mqkUOqcRhqLk23Fgam6rCe+b/wGaOWXcXYby0/
 3sEToRVDge3ybtHMByYrSMwfWccKJVY4qoJ21tVo/YsPIVWUlyEu13JI7N/RCMI+k7L0
 xBhQ==
X-Gm-Message-State: AC+VfDwB7X8uSBRla7NgmvCkGCCZmIH1zXQqUEUsTz75XS3/9K6Ckorp
 oKaXBACIj+hS5uwYjp7QkiNMN1b8bHOg/n0VhDdZCzkm2TgVg9I0RQlvuvGOQaBaIu5+ry+AdnV
 touZpFIXU7vuLsKbR6Yw0FQBTs9JBDqUmxA2Re5HCv6HYyoYooFKWaGzsxfxDxRsbgyAtqj/X4k
 o=
X-Received: by 2002:a17:906:64d4:b0:992:4723:fc81 with SMTP id
 p20-20020a17090664d400b009924723fc81mr3064595ejn.17.1688033961760; 
 Thu, 29 Jun 2023 03:19:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xRgDrcmxiu7iQD6dnksXvUgQkYHzQuqLUHQx5kkIVfOAql90UEwyVgc8GEllUQN/MrvnfYQ==
X-Received: by 2002:a17:906:64d4:b0:992:4723:fc81 with SMTP id
 p20-20020a17090664d400b009924723fc81mr3064582ejn.17.1688033961402; 
 Thu, 29 Jun 2023 03:19:21 -0700 (PDT)
Received: from [192.168.10.81] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a17090655cf00b00992099223a0sm3099122ejp.103.2023.06.29.03.19.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 03:19:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PULL 1/5] icount: don't adjust virtual time backwards after warp
Date: Thu, 29 Jun 2023 12:19:14 +0200
Message-ID: <20230629101918.9800-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629101918.9800-1-pbonzini@redhat.com>
References: <20230629101918.9800-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

The icount-based QEMU_CLOCK_VIRTUAL runs ahead of the RT clock at times.
When warping, it is possible it is still ahead at the end of the warp,
which causes icount adaptive mode to adjust it backward. This can result
in the machine observing time going backwards.

Prevent this by clamping adaptive adjustment to 0 at minimum.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Message-ID: <20230627061406.241847-1-npiggin@gmail.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/icount.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/softmmu/icount.c b/softmmu/icount.c
index 4504433e168..a5cef9c60a7 100644
--- a/softmmu/icount.c
+++ b/softmmu/icount.c
@@ -259,11 +259,16 @@ static void icount_warp_rt(void)
         warp_delta = clock - timers_state.vm_clock_warp_start;
         if (icount_enabled() == 2) {
             /*
-             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
-             * far ahead of real time.
+             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too far
+             * ahead of real time (it might already be ahead so careful not
+             * to go backwards).
              */
             int64_t cur_icount = icount_get_locked();
             int64_t delta = clock - cur_icount;
+
+            if (delta < 0) {
+                delta = 0;
+            }
             warp_delta = MIN(warp_delta, delta);
         }
         qatomic_set_i64(&timers_state.qemu_icount_bias,
-- 
2.41.0


