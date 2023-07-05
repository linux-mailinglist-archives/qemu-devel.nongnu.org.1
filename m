Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DB7482E3
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 13:26:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH0do-0000k2-0T; Wed, 05 Jul 2023 07:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH0dl-0000ja-QA
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:25:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qH0dk-00075z-BL
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 07:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688556343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRiSgzLFaJJeJ6EaNdB1G5P7C2mjdtmSUgXnuWHFD3o=;
 b=BajZADNLT29tFyyopjq2ciUW1Urv4JFF40t/+1UyMjHC/5z9KdZsJ/aqpzn7dcS7fzaxGO
 7WkroKju3syW2Dblee7jacEkAkO15NO1iPBpsVxVOhb7dZIszDVnA1C8G3OvAMNJ1I5bi6
 1BozTSmP239jfSQUCeWUIYe6EJhOwlc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-SJDJagxJPKWtARkmPbKozg-1; Wed, 05 Jul 2023 07:25:41 -0400
X-MC-Unique: SJDJagxJPKWtARkmPbKozg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso77614566b.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 04:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688556340; x=1691148340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRiSgzLFaJJeJ6EaNdB1G5P7C2mjdtmSUgXnuWHFD3o=;
 b=XIUXJFm1RaJF41GtUwxPC+0yVFK/DDUcIU97HWco3tIOeXGTRnn+IyBbADy3qL+PFO
 xF1iJpLsq2EABmVTKxuP/bB4cLVIiBeujMvuXmydsSylJrcgj6qa4L3rmdelgGAHoynE
 QlwmvNs9rVwt0+2uyThag39CEtgGNoB9VRhLAzrKQrwhFM+mCHRdNMB87+QT3+1a4oB6
 w2N9iXnJgiYooZrQSVLeE4XVAcbbRB/IK4lVIfMhAoL1AYDKL69fGk2RQiQgwpACZ3Kd
 Dffry38fntFeLHpx6KwsXZbm8EkncFc/BX0FATCChkINvQrRjgJ+bME9OVbuwPjlQfmv
 iKdw==
X-Gm-Message-State: ABy/qLYVpUbYSooSlU5yMW9DMLOz4wbRazTNsbAXok5mcj8BqF4t6C62
 IAyHpdRo6pIMmx2v1EKxuEn4bP2Pdy0UjSDsEv9mHE/Kr85jCoBsjdsZpoJSc9D8zNJxeS40rCj
 KDj9qqHOYNNKoGJXKL9UG0ORAB32x7A4MKotd/oM20SUFMcWYoJUDpV17kHcM8TFDNdsm57r+zw
 E=
X-Received: by 2002:a17:907:7fa2:b0:96f:94f1:b0a5 with SMTP id
 qk34-20020a1709077fa200b0096f94f1b0a5mr1995142ejc.8.1688556340395; 
 Wed, 05 Jul 2023 04:25:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzBYYWwtwrUeC6S3AxAE86aynV71c/Pn78hGAWFt1Rsu/jFYM5CYFXB4OOt/GU3JStjVfesQ==
X-Received: by 2002:a17:907:7fa2:b0:96f:94f1:b0a5 with SMTP id
 qk34-20020a1709077fa200b0096f94f1b0a5mr1995124ejc.8.1688556340102; 
 Wed, 05 Jul 2023 04:25:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 j13-20020aa7de8d000000b0051a2c7f5b0fsm13245122edv.88.2023.07.05.04.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 04:25:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 1/2] python: work around mypy false positive
Date: Wed,  5 Jul 2023 13:25:35 +0200
Message-ID: <20230705112536.54025-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705112536.54025-1-pbonzini@redhat.com>
References: <20230705112536.54025-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

mypy 1.4.0 signals an error:

qemu/qmp/qmp_tui.py:350: error: Non-overlapping equality check (left operand type: "Literal[Runstate.DISCONNECTING]", right operand type: "Literal[Runstate.IDLE]")  [comparison-overlap]

This is because it does not realiez that self.disconnect() could change
the value of self.runstate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 python/qemu/qmp/qmp_tui.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 83691447231..1b68a71397f 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -346,7 +346,8 @@ async def manage_connection(self) -> None:
                 self._set_status('[Disconnected]')
                 await self.disconnect()
                 # check if a retry is needed
-                if self.runstate == Runstate.IDLE:
+                # mypy bug - doesn't realize self.runstate could change
+                if self.runstate == Runstate.IDLE:  # type: ignore
                     continue
             await self.runstate_changed()
 
-- 
2.41.0


