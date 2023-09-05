Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CC479228D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:23:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdV4a-0003XU-WD; Tue, 05 Sep 2023 08:22:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV46-0003Ph-0V
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:56 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdV43-0000ow-KR
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:21:53 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b974031aeaso39986071fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693916509; x=1694521309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fom2vgYtrw2N7/lqmr4BnBWCA2ps570z0kqcY4sB1MA=;
 b=cHDpqXUPyr+Q5wrDdjumlIBWyv18b1CTKyLENihgkQNWEeFsAydztskW5r/vmOeyPk
 qZiVwwuY8I5l0OxGkslhg3iQkoSPzNOQgkv1VsDvB+1r2+W6c6NhvkA6e/Edlig+1R1W
 OdSaWCvHVaeBSJ+qnaT/fjzLI3rfGiZPt36JQIt9fj0Z4QBIWzWf1mht8FHuS3ExZHvr
 Vxtkvvhqgp8dvcoRYYGK0m6dFKdFrIxXE9VyNgX2hi8zHRSyr6zZzCgbmI3NHi2RTtlg
 amfObPcHkK9x0ZUhU+Bi2fP68Ma44HsdHSY4gXuXJymhp2CUaBc9OUONMAjLx8BP4u3h
 VQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693916509; x=1694521309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fom2vgYtrw2N7/lqmr4BnBWCA2ps570z0kqcY4sB1MA=;
 b=hPKF2Hn22fdOmOtNNw201Iv1uLImEddw1FVAS3HX7VBdB6YPu0q++QAQYAejnReFtc
 nMLa/sZeq1MffQH/KcwzkdfSqdhKWS+QrYnj5zxG4VypiK/ueM3EtcZoepJBhCED86Lw
 8uTU1T5Ar5tZEiKcOOMvfdNN+7CUDzjykz0fRtlGnTri/YvW76wlWRsFtRnUaXTo5bOo
 tZEJtx5vIZ0lQkm7Abqj9RUJ5YHF+h7wrEfsrx38Fd67cBKVnEkPqL+D/TtRGloxYXcl
 9WtCS4FjCY0Ze7rkGt79i3Xht2fRiOmAbz8d/iOSMbBXYY/ojbKeh26rPoRA2GOcyKQQ
 snrQ==
X-Gm-Message-State: AOJu0YzDQIxFoa8NlgS/N8c8xwa5kV3XIpVqNH+f+k/UQq8xU+zEsVTb
 y0uiElIUsZKmVrpafnFlzAV95qymKzBTj52d3qE=
X-Google-Smtp-Source: AGHT+IGMdsgf/s9WMe8CesBc8Ve0lvCwfg45DPh1IToTH7tHvHwDiyDho3ZmRnkrYkRDDX1PPf9pqQ==
X-Received: by 2002:a2e:b045:0:b0:2bc:df55:eec7 with SMTP id
 d5-20020a2eb045000000b002bcdf55eec7mr9131145ljl.40.1693916509654; 
 Tue, 05 Sep 2023 05:21:49 -0700 (PDT)
Received: from localhost.localdomain ([37.69.27.38])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a05600c1c1600b00402be2666bcsm12497901wms.6.2023.09.05.05.21.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Sep 2023 05:21:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] sysemu/xen: Remove unuseful CONFIG_USER_ONLY header guard
Date: Tue,  5 Sep 2023 14:21:40 +0200
Message-ID: <20230905122142.5939-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905122142.5939-1-philmd@linaro.org>
References: <20230905122142.5939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x235.google.com
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

In commit da278d58a0 ("accel: Move Xen accelerator code under
accel/xen/") we used include/sysemu/kvm.h as a template for
include/sysemu/xen.h, using the CONFIG_USER_ONLY header guard.
In retrospective, it is not used / useful, so remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/xen.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/sysemu/xen.h b/include/sysemu/xen.h
index bc13ad5692..9b2d0b21ff 100644
--- a/include/sysemu/xen.h
+++ b/include/sysemu/xen.h
@@ -26,16 +26,14 @@ extern bool xen_allowed;
 
 #define xen_enabled()           (xen_allowed)
 
-#ifndef CONFIG_USER_ONLY
 void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
                    struct MemoryRegion *mr, Error **errp);
-#endif
 
 #else /* !CONFIG_XEN_IS_POSSIBLE */
 
 #define xen_enabled() 0
-#ifndef CONFIG_USER_ONLY
+
 static inline void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
 {
     /* nothing */
@@ -45,7 +43,6 @@ static inline void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
 {
     g_assert_not_reached();
 }
-#endif
 
 #endif /* CONFIG_XEN_IS_POSSIBLE */
 
-- 
2.41.0


