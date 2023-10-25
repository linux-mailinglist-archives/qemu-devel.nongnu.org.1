Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0677D7895
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:31:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHp-0001Ue-A4; Wed, 25 Oct 2023 19:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHi-0001Tz-Gh
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHg-0004gg-3q
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+5ZMh7npgru2Beet4Ol9LtAdUDexk3O80zMDwByw6o=;
 b=hFbjxcZk1ApUYVzaticprmg9W9kmQUM9qM6xV9B6F3pKSXsKBPwyYvWBWvkHACAVij9KmO
 VuYpmUlGv8UzIWBRAHKRUS2rWnRA6jyZPb1sI0MOXjoynHKEIEs183IBMNEPT7aWOo0oqv
 eLp83mQqK4IGc2BUXHTXf6Bh2IbMMTE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-6i282yveO9K9r-Wp2SVO4g-1; Wed, 25 Oct 2023 19:27:28 -0400
X-MC-Unique: 6i282yveO9K9r-Wp2SVO4g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41cb5ff64b0so3812511cf.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276447; x=1698881247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+5ZMh7npgru2Beet4Ol9LtAdUDexk3O80zMDwByw6o=;
 b=s9eT1KtysxNBuWSaFyQrkC3SvrGNZtJu2UWdQ8bt9PHfWAp5vI686d70c3KfSwOB0c
 9LuiI6k8xjQsxkkdZvTMWWIo+mtDHXiWdg4+8CXaBhElHyE7XXAvoR2T0VS4pBHaCpQX
 3KUifQa1HwAolBPWTDIFwV/HXY+qMMSgYwvq/71FIvz440SD3uyS/cV3ZK7qi10UeO2g
 ju0gWgWsC5Wd1v4OGLRg2qw49QygpgjkcapTms0RyOt6LE9Gu8nzFl6ZDHUH6AOvmBWU
 A480J7gL1uAEjt6fevrN2uYb0C1Oa+3MFXazTyiy2lkE91vy89e7t+dx/p8cYr9leCyA
 mhjQ==
X-Gm-Message-State: AOJu0YzRBJzuRksFGge/XD/j2vYStPoH7UXxTVSUeVEhjKTC4VWD6VYq
 CaHwUhP5L83sGPce+I2itJRLaSx9K5lGK5rJBINWmUXA+Agnh4mtFtmRuS+mFELrOWZIOJp1mfj
 ewj6qFVZxhXu+adsluNJ3U1n7ygT944r8bSySRjH7aTq46rjIVCg9jbSdgBPMn7BwbJ5IC1zKM/
 U=
X-Received: by 2002:a05:622a:118e:b0:41c:bbf3:b24b with SMTP id
 m14-20020a05622a118e00b0041cbbf3b24bmr18999626qtk.27.1698276447646; 
 Wed, 25 Oct 2023 16:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4VcwctxfcaEV+qj0Umzc9a9QFiq67WJw6uhYOM1ajDSQkSTvOofXn8wikDPyo8iTEgBhVlg==
X-Received: by 2002:a05:622a:118e:b0:41c:bbf3:b24b with SMTP id
 m14-20020a05622a118e00b0041cbbf3b24bmr18999609qtk.27.1698276447215; 
 Wed, 25 Oct 2023 16:27:27 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 10-20020ac84e8a000000b0041520676966sm4596646qtp.47.2023.10.25.16.27.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/24] tests/tcg/i386: test-avx: add test cases for SHA new
 instructions
Date: Thu, 26 Oct 2023 01:26:57 +0200
Message-ID: <20231025232718.89428-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-avx.py b/tests/tcg/i386/test-avx.py
index 641a2ef69eb..6063fb2d11d 100755
--- a/tests/tcg/i386/test-avx.py
+++ b/tests/tcg/i386/test-avx.py
@@ -9,7 +9,7 @@
 archs = [
     "SSE", "SSE2", "SSE3", "SSSE3", "SSE4_1", "SSE4_2",
     "AES", "AVX", "AVX2", "AES+AVX", "VAES+AVX",
-    "F16C", "FMA",
+    "F16C", "FMA", "SHA",
 ]
 
 ignore = set(["FISTTP",
@@ -43,6 +43,7 @@
     'vPS[LR][AL][WDQ]': 0x3f,
     'vPS[RL]LDQ': 0x1f,
     'vROUND[PS][SD]': 0x7,
+    'SHA1RNDS4': 0x03,
     'vSHUFPD': 0x0f,
     'vSHUFPS': 0xff,
     'vAESKEYGENASSIST': 0xff,
-- 
2.41.0


