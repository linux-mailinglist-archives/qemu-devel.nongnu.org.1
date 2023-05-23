Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EA070D1A7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 04:48:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1I0Z-00038P-Dm; Mon, 22 May 2023 22:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0X-000385-0J
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:17 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1q1I0V-00046d-DU
 for qemu-devel@nongnu.org; Mon, 22 May 2023 22:44:16 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-64d247a023aso3666044b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1684809854; x=1687401854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fXrhMcz/P3mkB39Ht6Evqc+Wg0GW18mnGpMmsiuBRE=;
 b=yNiGwnJMSQHXozoDYovyKE5Zqd/XhN04arBsO76hVIGjjNAiAONK66qiB+E6aO+Qix
 t/Hu7cJRez5mUlvR0Y31hlve3mNSw9GjUn9EPLDocDGOVK/oNiLlbF6lXqOzr0vMSSo+
 JnoRu7YSxz0HBKaDeaCenLTm3uzJjk82tesXi+3T26Tw/8JEjxMcd8BmXiHveDmj2F8C
 dRHmqS2SdgYdGpJ6SYlSsRPv1i5Gtn83/NC7p1ZPAZQNPeoH1bb2GQPpZQLyZJv15WxE
 vyUaEPwpzsSAL3EcMw3k8oFXQbu18WVNlJtjsRwzxakAQL/bRKg/5wT1Z14xEPkfCpq5
 3/MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684809854; x=1687401854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fXrhMcz/P3mkB39Ht6Evqc+Wg0GW18mnGpMmsiuBRE=;
 b=ShiibA02Cva5w5DPXEJJXvMra2Lk7E3HjHOSv8SWgekT5dRCWQGje4MT98iEc8iaf5
 dJ/BhQKN3TKr+1lYW90iMucM5FWv194pAipBeK5MqP9yzohmfdMAomx1R3FslmMUOQ6H
 27bbF6189b566/Z22J3nhQJxVDbUtka1y89ZcJWae2lgjhSSFX7l5H6Y3PVu0XVtP0zr
 MH6tENCepHuEF+0JRvRxvweKkkouv37GBBJsz16ItawUuD+TG6oY8Aib/Orasu9zeqmS
 W0PB+ENbkGtFIc3DpujlYE8y1VltbZ+HUMgKpCzFQsYml42lLIH90T3lQBK6R7gc7OC3
 8/Cg==
X-Gm-Message-State: AC+VfDzqiu/IL/Nw/5jMkDJnCXsPsyorhtGMQl25fA2xSttVrsEVI2VD
 pcWzqaXH9D41jjbe59A2bfBgyA==
X-Google-Smtp-Source: ACHHUZ60vgi29Oo0o9QHD/S1VALK1jdTMH99NwVBOdBIgBBA1sJhtZUg+L9f6ZsK+cU4qHGqQYbDcg==
X-Received: by 2002:a05:6a20:1444:b0:103:73a6:5cc1 with SMTP id
 a4-20020a056a20144400b0010373a65cc1mr13657334pzi.4.1684809854181; 
 Mon, 22 May 2023 19:44:14 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 o10-20020a17090aac0a00b002467717fa60sm4769847pjq.16.2023.05.22.19.44.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 19:44:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Tomasz Dzieciol <t.dzieciol@partner.samsung.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 06/48] igb: Clear IMS bits when committing ICR access
Date: Tue, 23 May 2023 11:42:57 +0900
Message-Id: <20230523024339.50875-7-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523024339.50875-1-akihiko.odaki@daynix.com>
References: <20230523024339.50875-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The datasheet says contradicting statements regarding ICR accesses so it
is not reliable to determine the behavior of ICR accesses. However,
e1000e does clear IMS bits when reading ICR accesses and Linux also
expects ICR accesses will clear IMS bits according to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/igb/igb_main.c?h=v6.2#n8048

Fixes: 3a977deebe ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
---
 hw/net/igb_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index 96a118b6c1..eaca5bd2b6 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -2452,16 +2452,16 @@ igb_set_ims(IGBCore *core, int index, uint32_t val)
 static void igb_commit_icr(IGBCore *core)
 {
     /*
-     * If GPIE.NSICR = 0, then the copy of IAM to IMS will occur only if at
+     * If GPIE.NSICR = 0, then the clear of IMS will occur only if at
      * least one bit is set in the IMS and there is a true interrupt as
      * reflected in ICR.INTA.
      */
     if ((core->mac[GPIE] & E1000_GPIE_NSICR) ||
         (core->mac[IMS] && (core->mac[ICR] & E1000_ICR_INT_ASSERTED))) {
-        igb_set_ims(core, IMS, core->mac[IAM]);
-    } else {
-        igb_update_interrupt_state(core);
+        igb_clear_ims_bits(core, core->mac[IAM]);
     }
+
+    igb_update_interrupt_state(core);
 }
 
 static void igb_set_icr(IGBCore *core, int index, uint32_t val)
-- 
2.40.1


