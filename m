Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B319579CFF0
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:31:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1bk-0004Ou-1l; Tue, 12 Sep 2023 07:31:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1bg-0004NK-BR
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:31:00 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qg1be-0000uY-6O
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:31:00 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-52a4737a08fso6930210a12.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694518256; x=1695123056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qjw2XAQ6HKVx9Z3EPaWrG+b3gjC37zBrk2Sv1nlYmYs=;
 b=Egw/iGjY/DgpRE5PDdVkqV1q9BZPIO1okohP3wN3KUyyrTrM9DGsjMnvNhxiUrNmVw
 xM+aAxjsNuDjOJXrjzlnae3UorV87mhWK6HajIRJjDN7WM6zY/WaNMtrIaC7piOcGM10
 jmZctYL19qtG8tXSuH43Bj1AB07a3vYDT2NAEXALJlSCvwTU13kmnnCBK+bFoKme7FG/
 Fs0WVPjBTBz9eqz2x2OR+8kWZ+RLDUWH+6RMFW7wPwHwx6jdxVpZkKYdFBkKPp2qvaxw
 xgBp5+Mq+kO6RXpRjK52hb7LQ/B+kPp9LI3zyiPf/9yb14DS1lTmzyBTrNofkt8IEWFq
 jRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694518256; x=1695123056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qjw2XAQ6HKVx9Z3EPaWrG+b3gjC37zBrk2Sv1nlYmYs=;
 b=tfeibj6EFI83PX0zkJ9tJxx8a+OKA+v4T0Lty9smN0KNApTr+RVWwO2AfcH9wq0fe0
 JN5f/qyCWuqjCTYNi8vv7EASx6uyGrFmWSbWSkTNL5fUlZVk/TLTwNWUg90B0N87IzNJ
 AdppzSjSRQilCm5WgW1FpyRC3PBMOrrFwSqrYmslL1wpyiJPsSal+sMCd2pvBsgOrJQ8
 GY8qB7eBtakDlQ4210KH03Rvc93KkujPKhkWJTa/mnWlsa6VtxwAdVxTijl9sJYjcbBG
 Av8CaJQH4EqZrlI9CCXN9UBEB7Zt3AjgkeVIShFB+M+qpLr0IFQ4YYYoMvTLzg4EvgPy
 SelQ==
X-Gm-Message-State: AOJu0Yx43p9bIJ+x3P1MrKdf9WKvOYmVCgm9jYCc4nNeOExn0M7fjjht
 PDGUzUbf9gNqFDkG/pgusdane2Kkn66uTyHGgi0=
X-Google-Smtp-Source: AGHT+IGiO5Y1ImU0e5NPiApxvVuGIaqglPuHqf13s/S2DHwx1SaXcvGhb+gpSsNwSY48HsTaLRHqKw==
X-Received: by 2002:a17:906:10c:b0:9ad:805d:70da with SMTP id
 12-20020a170906010c00b009ad805d70damr1647683eje.12.1694518256600; 
 Tue, 12 Sep 2023 04:30:56 -0700 (PDT)
Received: from m1x-phil.lan (cou50-h01-176-172-50-150.dsl.sta.abo.bbox.fr.
 [176.172.50.150]) by smtp.gmail.com with ESMTPSA id
 o6-20020a17090637c600b00991e2b5a27dsm6698164ejc.37.2023.09.12.04.30.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Sep 2023 04:30:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] target/ppc: Prohibit target specific KVM prototypes on
 user emulation
Date: Tue, 12 Sep 2023 13:30:26 +0200
Message-ID: <20230912113027.63941-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912113027.63941-1-philmd@linaro.org>
References: <20230912113027.63941-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

None of these target-specific prototypes should be used
by user emulation. Remove their declaration there, so we
get a compile failure if ever used (instead of having to
deal with linker and its possible optimizations, such
dead code removal).

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/kvm_ppc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index 440e93f923..ffda8054b2 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -13,6 +13,10 @@
 #include "exec/hwaddr.h"
 #include "cpu.h"
 
+#ifdef CONFIG_USER_ONLY
+#error Cannot include kvm_ppc.h from user emulation
+#endif
+
 #ifdef CONFIG_KVM
 
 uint32_t kvmppc_get_tbfreq(void);
-- 
2.41.0


