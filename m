Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A35E80DD08
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:27:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnkT-0006dM-Di; Mon, 11 Dec 2023 16:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnkP-0006TG-EF
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:23:29 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnkM-0005wg-Rt
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:23:29 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a1f6433bc1eso738123866b.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329805; x=1702934605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mqu2MlgIdZS3QyZ/aQC1T5TlHEjoxgX9tzjZABIOL+s=;
 b=ip6a5NgNqHygdZxbPwyPH9o6TJImdbN6zqUfBwqPPSyeCGUAoltGLPSWYmyhuWKACA
 SE+p+f3KA7yG4pRJJZK1oJ0S3JOAF6fJL7MwXQ+nEY16ArlnYZm7mbQUEc7tZ7ugpuhu
 TkNESfVf1iHSXDwbtxZBok6A2XnDD1CtT/Qo41pCKKTFKsmHtsjUrqZg8a62RCq1wK0Q
 PDxqLer7qMvnIy+yYm4KxpRdQa1vEMlCsWomU0r/1ksMZTERBPWeC8Wm6RpgPVJuQ7aB
 IE9mnvTm5xhc7A20XXAj1P0C/jbqZfE5azusYLp0+fH+PffuDyj4e8MIU69bRv+R4pBp
 c07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329805; x=1702934605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mqu2MlgIdZS3QyZ/aQC1T5TlHEjoxgX9tzjZABIOL+s=;
 b=igFc9bVl74nuXQho2oRF85oXGNTVkhDR/WGs53oYmliNkg5CTL8ZIR8eVmTIIsm5BM
 xXt3sUR42MsCtISd6aemjI50xlWk+MEZpe/1sMwweTA0z84ynEniBe6zw6mlE3tk/ykO
 w6Ma3Dc4GGd18HOV9dBqxDvlzZGrnklwcmi4+b/LJ9bycknAx5+hbkB6nw00sh537vYr
 2FHjGpV6ZvwiJwtrxVDJTbeeF+4pzDm8c/D8g1YErPB9o1WKCzf3fRWhO78W4EvG4JkR
 UpF9s4HyG821A9hS7ic/vRa9On3NbGzmwhKD9949iMQnjYUwyBpwGSgLYosjCy6XyvZ3
 8N0w==
X-Gm-Message-State: AOJu0YxFqq/yX/N71WDN0VygrJz3XNqBqttmlARFSDZhSle/nx7GfYi6
 iUX30CvzVXPYj0L9+6cooEpJ0dsGdJJ5btS+ObLXDg==
X-Google-Smtp-Source: AGHT+IFn8/3rk8CtW9OM9MwSkcANYhGT/MeN5C5V5YIFguGIcvrA/lPPLRPS+jv/cd9Ds9KT/8JIBA==
X-Received: by 2002:a17:907:20aa:b0:a1c:6e3e:4873 with SMTP id
 pw10-20020a17090720aa00b00a1c6e3e4873mr4173217ejb.43.1702329805455; 
 Mon, 11 Dec 2023 13:23:25 -0800 (PST)
Received: from m1x-phil.lan ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 vv9-20020a170907a68900b00a1db8b08610sm5437885ejc.148.2023.12.11.13.23.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 Dec 2023 13:23:25 -0800 (PST)
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>
Subject: [PATCH 24/24] target: Restrict 'sysemu/reset.h' to system emulation
Date: Mon, 11 Dec 2023 22:20:01 +0100
Message-ID: <20231211212003.21686-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
References: <20231211212003.21686-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

vCPU "reset" is only possible with system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c      | 2 +-
 target/loongarch/cpu.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index dfb96217ad..17b6962d43 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -24,7 +24,6 @@
 #include "qemu/hw-version.h"
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
-#include "sysemu/reset.h"
 #include "sysemu/hvf.h"
 #include "hvf/hvf-i386.h"
 #include "kvm/kvm_i386.h"
@@ -37,6 +36,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/i386/topology.h"
 #ifndef CONFIG_USER_ONLY
+#include "sysemu/reset.h"
 #include "qapi/qapi-commands-machine-target.h"
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fc075952e6..b26187dfde 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -17,7 +17,9 @@
 #include "internals.h"
 #include "fpu/softfloat-helpers.h"
 #include "cpu-csr.h"
+#ifndef CONFIG_USER_ONLY
 #include "sysemu/reset.h"
+#endif
 #include "tcg/tcg.h"
 #include "vec.h"
 
-- 
2.41.0


