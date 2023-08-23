Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B02785B47
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpHp-0006w1-6D; Wed, 23 Aug 2023 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHA-0006nV-Na
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:04 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpH9-0007We-86
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:04 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a3ff5f0abso171301a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802561; x=1693407361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x/0A6NRHYgTIgaqFhmzm0vT0TysDa5bmQjI9W3T2tZA=;
 b=pPH/2B/vAgDI0Dz+yENsXNTZP92hGmDZzbRTMMKZkiH18Br9QzbgmetXJ2o4QK6JAj
 8FYJsQ+9Y3pqlDXbY00+Si+Os1Y1qQ9C3Os+MhSUpoPfXOAwvS5AdZSOiwIMhBCzSky/
 oMrHSBK5TKzPpvWeXQiTJlV71HqHRsD8arLI4Z5QVBGnP+KN6ncVMo1W/xsS25FLK+vR
 j0MIS5rEaHk4IiuGQimLGEZ0WHyIBAi7IBPWod8HYuOsN1orGsTpDGUW1xj/7mTMwk3w
 nxr8rKvCv4MQGwTZ/BpcWXwZDjAdu6fUKVTR9GZeer4yDjz8vithTQr9mPBGkJpSAHPx
 bBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802561; x=1693407361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x/0A6NRHYgTIgaqFhmzm0vT0TysDa5bmQjI9W3T2tZA=;
 b=iJljPe8g0Bn1OnbpipzPTw7RdFHXBCkH+KL7LujG4rdl45cf12wzb08Qa6MMpxj/2c
 xTW4n4jauKKUMogRn1mHWYDwlNjVbhLtRxll0cOcETolVmdrunnTULf9747ovbnKtVG5
 SBSNsHVzsxPr0o1XY5YryIj6AT3yH6tnSSBDspU4q9qNS0Qt520k/Z5ZgWisFmJgp3Ir
 fX6x3GJxulKuGvaEqndcQNEx0B8aW1bFK0sEF/wLxlpm+43p+7YoDV/g4VkcApw+gPaG
 F95lP9viPaVmfZU07DdAKzX75d1/xvLdxpk4XKxaAHKnlb7Jnri3zIcp/qu764zZIPuy
 u97A==
X-Gm-Message-State: AOJu0Yzq7+jNi5CDmHMQlPYMXBs0iFUwj/K2rRJc76bZjQM1ZQByNU8n
 sNPKJvFz2N16Wx3SdfGa5ZnB47KAwb1TL9yZBA/uYA==
X-Google-Smtp-Source: AGHT+IFhGV6BSOAfXdhi1r/YLO+sE0CeN4/QRvdvBabQGiO8T7HNFAX3hb6Tv3o/uhMbvBgHu71xgw==
X-Received: by 2002:a05:6402:134f:b0:525:6c9f:e1a3 with SMTP id
 y15-20020a056402134f00b005256c9fe1a3mr10198188edw.20.1692802561669; 
 Wed, 23 Aug 2023 07:56:01 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 i26-20020aa7c9da000000b0052333d7e320sm9403473edt.27.2023.08.23.07.56.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:56:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/8] tcg/tcg-op: Document bswap32_i32() byte pattern
Date: Wed, 23 Aug 2023 16:55:37 +0200
Message-ID: <20230823145542.79633-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 80ec6f01c4..fc9b21d30c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1069,6 +1069,11 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
     }
 }
 
+/*
+ * bswap32_i32: 32-bit byte swap on a 32-bit value.
+ *
+ * Byte pattern:  bswap32_i32(abcd) -> dcba
+ */
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     if (TCG_TARGET_HAS_bswap32_i32) {
-- 
2.41.0


