Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA33698FAD2
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Oct 2024 01:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swVSr-0007JO-93; Thu, 03 Oct 2024 19:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVSo-0007Io-Ew
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:30 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1swVSm-0003OE-9U
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 19:42:30 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42cc43454d5so12151755e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 16:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727998946; x=1728603746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjVB53iD7/yKN8TlGeZ4BX8eqm15vighx+LztRMtmDo=;
 b=zjwh96r/za/WtD691dZ0ovxjwhy5R7jlMdykmxrF4YCz3GSYylzec5dGJ3OUJCD7hA
 goruyYSsPSVnu/vMmLgWaz4mSYFCG0wdSoqsF440+cKhJb/L/qpO6dpObSAFnWVDkgwT
 LqIp4s7RB+Na8NakiqhyFbrnXvb2zO0gcOicPdlhXljFhG6FgjfwfXWBQixlPo6JbJuD
 K1C1lcbEwJ1vJK+kbBy9cnFta5xARUsdG7khN6wekDWP6XXLtPD70VEY18/ZMgNG5Trb
 p2jeBTXQbF/zIs/EHmyEKttBKagUpsZUmVfZIDpI2OPJ2/VNwCvT2jpAB4doetrHUkV6
 XKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727998946; x=1728603746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjVB53iD7/yKN8TlGeZ4BX8eqm15vighx+LztRMtmDo=;
 b=XWwYTvSexleyA6o1ukNBlBgi2i+cWxogdY1nUQo3lYz5Mskijvcoc868aIpEZO39EQ
 BmlWe4tPEv0PfmGY9bcFWjzZDTG1FXArBqIjiAhAgPRg31LtMij8jess7P+CMDw+PPiL
 Ax9vQNqAR4ZFnX69Ms6YbtlRsr+JI3+WZk4ZAemaQ74dnUHS2Pj/mlUXaMPS/aB1sqT8
 3fhbLL19uHig90+ktdtTyuMMpM+Cc21De2XTqKBk11D8I0n/gL6QGtN+5GMJfW2WL84x
 AeGCa6j2pVSH/G7kI9L6n4K3HPvhrFycAcjIL+yf1pTqkiZutr51U3a16372uCWwiDp0
 nJog==
X-Gm-Message-State: AOJu0YxlmVXtIc/YJHntB85y7nzCjleBGXDB+PNIyYOp4dGTAe9Kr/bV
 cz/gIj/FeXWz+f3LqJP4KWTOuK70Ju8xx1tUS5pvClDwSoq5TZye/xiarsgy/bYKv8dVXMcdiDJ
 YxXE=
X-Google-Smtp-Source: AGHT+IGLwHCdkB/RhpUtcOQmM8s5Ft6eGONxZVMIWQGP+Ee0mmONGxrTyU4Gv+Xxv0liMtV1c0KvZg==
X-Received: by 2002:adf:f603:0:b0:37c:d567:7c8c with SMTP id
 ffacd0b85a97d-37d0e7781c5mr398122f8f.30.1727998946200; 
 Thu, 03 Oct 2024 16:42:26 -0700 (PDT)
Received: from localhost.localdomain (45.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.45]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm1338845e9.1.2024.10.03.16.42.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Oct 2024 16:42:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 01/16] qemu/bswap: Undefine CPU_CONVERT() once done
Date: Fri,  4 Oct 2024 01:41:56 +0200
Message-ID: <20241003234211.53644-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241003234211.53644-1-philmd@linaro.org>
References: <20241003234211.53644-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Better undefined macros once we are done with them,
like we do few lines later with DO_STN_LDN_P().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/bswap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/qemu/bswap.h b/include/qemu/bswap.h
index ad22910a5d1..b915835bead 100644
--- a/include/qemu/bswap.h
+++ b/include/qemu/bswap.h
@@ -140,6 +140,8 @@ CPU_CONVERT(le, 16, uint16_t)
 CPU_CONVERT(le, 32, uint32_t)
 CPU_CONVERT(le, 64, uint64_t)
 
+#undef CPU_CONVERT
+
 /*
  * Same as cpu_to_le{16,32,64}, except that gcc will figure the result is
  * a compile-time constant if you pass in a constant.  So this can be
-- 
2.45.2


