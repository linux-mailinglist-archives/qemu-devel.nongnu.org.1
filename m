Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBE181BCF5
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMid-0007ZL-8x; Thu, 21 Dec 2023 12:20:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMib-0007Yb-CE
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMiO-0004SM-L2
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YqVi++Kwt0Mq/jHDdFR9I7zkYuN87hUwBjZExhWjvrA=;
 b=eZIXClOWglA28xKi/pxh+2xksv6c7aj5up4V566iasJaqAqzSdD5JQvbtUbxvF2xSvCa/0
 Rps9hbh6owcQjxE68L6ZjoTBcYrA97j63fApfzgbSBIn6Vk75tspVjqRCRT/oKJLc3tABf
 8zRy+zW1dQk4ZwU1KBj3I16ROA11AlQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-Irrs4epbMMC_QaWlQLNaGw-1; Thu, 21 Dec 2023 12:20:06 -0500
X-MC-Unique: Irrs4epbMMC_QaWlQLNaGw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50e30efbcf2so562975e87.1
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:20:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179204; x=1703784004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YqVi++Kwt0Mq/jHDdFR9I7zkYuN87hUwBjZExhWjvrA=;
 b=TvIT5fXDR6jUBN4ZOfYIrr4ReiungwRh7DNaQ0C4yCpjCwV+BiyL3BadOWKJdP1C2N
 FcBifaQ8D72k3mQ4tKoMTzEZGoWZC65OqBjAW6eDIxTna/XD+zRGwepZQ3Ww+OW27EnC
 v917fVG2SSzBel2Q0VDuzmx/Xj02aKxhNhRq3CHW0IYIShV/wgBy5JmHbdDPASr1Sehc
 z1Wct6PrikjZ6KZqro/rzYuFz/gRgeJyL+Yyi81POsaShfisJwtXzSk+pDArDZ84b6no
 tYkc0FllB5x5h6NQS1168GSw6DkIOSeqSFZJeKWQmzE75iHR3pDe869IE9ONuMDWx15m
 l+lQ==
X-Gm-Message-State: AOJu0YzyqEjcUWbuo9SgQqVHqU9shlcdFY4IYigOgVcl77xGTL2ceTvP
 BgsHFealnfXw6yxUUTUjDfBqtLvosrg64rnAzenNsrxnSYEqM1DZ13ofIWuMfb3pZKSfK5fkxqN
 UHuiejV1pBbFLwJk1n78+Vi0bVay/PIolMas2MXJCOPX2Q6S0/tutlDAKR9U1lc0rv/GbaE6T4d
 CT2O9FmR4=
X-Received: by 2002:ac2:5fcd:0:b0:50e:4b1f:5ddb with SMTP id
 q13-20020ac25fcd000000b0050e4b1f5ddbmr10853lfg.16.1703179203973; 
 Thu, 21 Dec 2023 09:20:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkr9u1DakS/bVdSp9fZvI/7Ic07yvLjPs7qe5WLrKdcxi0ulZlEDJ4xGA9S7MKxI9+5443hg==
X-Received: by 2002:ac2:5fcd:0:b0:50e:4b1f:5ddb with SMTP id
 q13-20020ac25fcd000000b0050e4b1f5ddbmr10846lfg.16.1703179203684; 
 Thu, 21 Dec 2023 09:20:03 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 a4-20020a056512020400b0050e0d35e41dsm317297lfo.266.2023.12.21.09.20.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:20:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/21] meson: remove unused variable
Date: Thu, 21 Dec 2023 18:19:39 +0100
Message-ID: <20231221171958.59350-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221171958.59350-1-pbonzini@redhat.com>
References: <20231221171958.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 tests/bench/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/bench/meson.build b/tests/bench/meson.build
index 3c799dbd983..7e76338a52d 100644
--- a/tests/bench/meson.build
+++ b/tests/bench/meson.build
@@ -3,9 +3,9 @@ qht_bench = executable('qht-bench',
                        sources: 'qht-bench.c',
                        dependencies: [qemuutil])
 
-qtree_bench = executable('qtree-bench',
-                         sources: 'qtree-bench.c',
-                         dependencies: [qemuutil])
+executable('qtree-bench',
+           sources: 'qtree-bench.c',
+           dependencies: [qemuutil])
 
 executable('atomic_add-bench',
            sources: files('atomic_add-bench.c'),
-- 
2.43.0


