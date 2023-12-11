Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3080DD05
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:27:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnk8-0005LL-2f; Mon, 11 Dec 2023 16:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnk3-0005Ep-J8
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:23:07 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjx-0005pv-MA
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:23:07 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50d176eb382so4344983e87.2
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329780; x=1702934580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IVD0fP181N6yKPURwFJTLnTnzSvk7D9idiGLSO6/Cw=;
 b=j2dxbNdV6HhJOO/qnq5xW1LOo6MzI1uHNTaURVb7sOkMF/zhyaoqvzfOXw4LbZTHwF
 lipBpHTtTzmvcIlcesyEDh+6s9m1I8GdAjXvlNgoyhFq5ZE9MBw0/KSaamtKzJ24tEWM
 iMPX1QUntrll0LtwiPuIOBa1OrIH+Ze/QWS8tHBaOQMSp8nKd5/CN0mkjaHzo2DtoQgj
 zbK1ethi7tHQLgvXIgtYK/7k6i94yeGJvd9P1CIIPUTdPZMotk+mpFEqElUsAJl0hcok
 ZpLzB2E/seuHDmCc3ZdAzwUNAeGMp5NUSZmyNSe/uqzg2GFObsZufqruvUArRCN9XDvK
 AQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329780; x=1702934580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6IVD0fP181N6yKPURwFJTLnTnzSvk7D9idiGLSO6/Cw=;
 b=NbN4voTAch0Mae3YGguF6/KjPGKCAYTF63k4vacLnxnzwhhvsObAZN8tCIzNO6EN5F
 Ndwx/3HTjSJdqXX+Rj6s5AoxdSqjMN2pTe9URL2jSPBV8Ox/tvvTtmgu9FIZgyGA2HAY
 R4a0Bju2Zl+n/SXYup+nmKr7Mu2N6uEJzkDkW65tCRl93LScHoG0znUNtMAK7C28gw1I
 MzB1XJ/FKeoWkE0sPc1t1FvgZLOLVDgQ3r29wAVNSnYsRKsQsM1LPDrS52wIGCTWI+9/
 Eg0pQQkEYHJ5Z0JjSUwTOFUi8uLfGkJii16lJJivLNyulKLvLue/VaR11dQu2IFTKy7L
 OKZw==
X-Gm-Message-State: AOJu0YypuD4TK0xE35X3uQIRA4xNf+Dphn3v/xWCSsxl4PFnoBERgh8w
 97LYTHsfpRDJhKZvCEqh1RksK5I4uGlNA3N5yDyE4g==
X-Google-Smtp-Source: AGHT+IGImOxVOWgtEtRNbTpMP3VyoEVtcVk7T/kTyJSDnJhEjGlDz85TYtGNSnv9pwyCRPaMJL33wQ==
X-Received: by 2002:a05:6512:610:b0:50b:fbbb:2035 with SMTP id
 b16-20020a056512061000b0050bfbbb2035mr2542678lfe.97.1702329779237; 
 Mon, 11 Dec 2023 13:22:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vb5-20020a170907d04500b00a1d885359d6sm5283778ejc.46.2023.12.11.13.22.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:22:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Claudio Fontana <cfontana@suse.de>,
 Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 21/24] exec/cpu_ldst: Avoid including 'cpu.h'
Date: Mon, 11 Dec 2023 22:19:58 +0100
Message-ID: <20231211212003.21686-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

"exec/cpu_ldst.h" doesn't need to huge "cpu.h" header,
but simply:

 - exec/cpu-defs.h
 - exec/tlb-common.h
 - exec/user/abitypes.h
 - exec/user/guest-base.h

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/cpu_ldst.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
index c69f02b699..a115553ee8 100644
--- a/include/exec/cpu_ldst.h
+++ b/include/exec/cpu_ldst.h
@@ -64,11 +64,15 @@
 
 #include "exec/memopidx.h"
 #include "qemu/int128.h"
-#include "cpu.h"
+#include "exec/cpu-defs.h"
+#include "exec/tlb-common.h"
 #include "tcg/abi_ptr.h"
 
 #if defined(CONFIG_USER_ONLY)
 
+#include "exec/user/abitypes.h"
+#include "exec/user/guest-base.h"
+
 #ifndef TARGET_TAGGED_ADDRESSES
 static inline abi_ptr cpu_untagged_addr(CPUState *cs, abi_ptr x)
 {
-- 
2.41.0


