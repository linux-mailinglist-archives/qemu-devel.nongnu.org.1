Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0BB734916
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 00:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0ls-0002lv-Uj; Sun, 18 Jun 2023 18:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0lr-0002lk-Ky
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:21:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0lq-0004V3-66
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 18:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687126876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUEMlH5Vi9AGcf6+yYyykWVYaFzccZ57zOHtQD3Xf7Q=;
 b=FKIfrS03sjHo3WcgtrYvRkD9e3vkNHOPmv4gsBXLBdzSRc4P+IMdOYnMtol0gqmgbizHH9
 bgNq6j+Ok/BE1O+ZM1FwmBzmuTTI1/NMlizriU2D9beBB0Xl9kKm4H1N2RAPSljWa7gGfr
 fZEzH1xJgFQm3Fi9m8z0F7XB95ahITI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-oZ3V_eapMu2Ad5mDr2n2mg-1; Sun, 18 Jun 2023 18:21:15 -0400
X-MC-Unique: oZ3V_eapMu2Ad5mDr2n2mg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso161957866b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 15:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687126873; x=1689718873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUEMlH5Vi9AGcf6+yYyykWVYaFzccZ57zOHtQD3Xf7Q=;
 b=fgNG1+FmmWMySExPHn9aP60kIv1PTaqWO1WYs9g5o/f5KgB+f8mPx2rJ9RUtv89oEk
 vz6bLr6BpKWGoH8xZ08p/8a924gP3EcT0oBVCbiWmFz/nZeswCIBRZvLNFt0MsU0L3CQ
 t52NkDjLBSsgbKuonP3JsONSkmc6E70uRxU9XZifndMpghI3LLRJDGiUjZ9b295jWCfO
 skPcgV5nWSIpR4ssBm/mu9xOT5l9Ud0nMQG7nVPBd6P9I4Drp1F+VvzM9Y4aN0aQIywP
 tpxJx8JiEZ0b23Jxb9+MS/avi56XV5xQopaZ29qOlk6W9IgXXKSaljezIlUr6wshmZcX
 Eiow==
X-Gm-Message-State: AC+VfDwHo2TcY7D+1RCXknt4V9Y4mkRHr7YY3XrCCpHMUNQX4neWXq2J
 Qk3LflQxaqUxMNR4cF2qtLNP+U2imSQ0SZZi3JamdG9GBZK3VAjQQ1jBD1YJusuP0qXQwT1hldh
 bqExrKlrrgvD57olrb5M63UVHZix3sfomKdP+IzxDs8fQDE8e656zWbrmh9Y+FvpRZxyP2U4zqG
 MCTA==
X-Received: by 2002:a17:906:d542:b0:982:7505:fafa with SMTP id
 cr2-20020a170906d54200b009827505fafamr6679770ejc.47.1687126873715; 
 Sun, 18 Jun 2023 15:21:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ76wxnfo/uCq1LSJUX2D/1R8dOpwt1o86Nq+uqpfj1HFViaC5r6hrqEZr+cRgqWSWwESYHz/g==
X-Received: by 2002:a17:906:d542:b0:982:7505:fafa with SMTP id
 cr2-20020a170906d54200b009827505fafamr6679766ejc.47.1687126873314; 
 Sun, 18 Jun 2023 15:21:13 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 bk4-20020a170906b0c400b0096f675ce45csm13722542ejb.182.2023.06.18.15.21.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 15:21:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] target/i386: ignore ARCH_CAPABILITIES features in user
 mode emulation
Date: Mon, 19 Jun 2023 00:21:08 +0200
Message-Id: <20230618222109.110843-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618222109.110843-1-pbonzini@redhat.com>
References: <20230618222109.110843-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ARCH_CAPABILITIES is only accessible through a read-only MSR, so it has
no impact on any user-mode operation (user-mode cannot read the MSR).
So do not bother printing warnings about it in user mode emulation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dec376ab56d..f4ad6d58609 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1069,6 +1069,13 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
         },
+        /*
+         * FEAT_ARCH_CAPABILITIES only affects a read-only MSR, which
+         * cannot be read from user mode.  Therefore, it has no impact
+         > on any user-mode operation, and warnings about unsupported
+         * features do not matter.
+         */
+        .tcg_features = ~0U,
     },
     [FEAT_CORE_CAPABILITY] = {
         .type = MSR_FEATURE_WORD,
-- 
2.40.1


