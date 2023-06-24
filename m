Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F18D73CC38
	for <lists+qemu-devel@lfdr.de>; Sat, 24 Jun 2023 19:43:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qD7Go-0005kg-V0; Sat, 24 Jun 2023 13:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7Gn-0005k2-3w
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:41:57 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qD7Gl-00069b-Mc
 for qemu-devel@nongnu.org; Sat, 24 Jun 2023 13:41:56 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-30fcda210cfso2011700f8f.3
 for <qemu-devel@nongnu.org>; Sat, 24 Jun 2023 10:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687628514; x=1690220514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWWds0uHrElgc22pSSxJ50tOp/lAV9kSI84s7Y2g/GM=;
 b=JjwltddD/cnNRwVGBpMlwyJ7wVl1Dd+vLMYIA1ed2CA1z7xOvX3DxVnc8gtCpAefSE
 xo5g1CiCqTPXpIH4UJy5+rsZYpuKE81Z7be0dQTZ7JzdeX9j5u9Mx8Z5FVXetI2JfTyn
 47UG4xbVI3FVQad68NuGZMbwNXEiWjQIy56FIAywQDCoHP3eiLzbyyHqhhjC+Qo5u3Cg
 4ws7FQYnR+gqZpuWyo+1mj6A2Kgebxl4XbhZ5VUeZWE7itV80GK8EINXxv01Dffpjd6L
 xbEKH2Df7yWf84jA7YjCpGFhq4pv94jz889H0Vtin/e3lUxP++i7igvK6CJ6NiiQ/q9Z
 ZPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687628514; x=1690220514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWWds0uHrElgc22pSSxJ50tOp/lAV9kSI84s7Y2g/GM=;
 b=BRXeSGI2+MvD/ooUwi/tDFGb29H8odtxdHiDASIwd8TCX/yb/2R9Ic220icoqWZKj0
 iX9ViSuQ6Yn1rGo2uHPkRqeTc3f0dPhqzzsPnBEU+XL5Z5/XJRQ5g6YxdDJH8KxsWxNM
 XoFKDTUwvEMCID8wmgzoZt5EArqIP0KW/MbyUzJkBcJo86BCVlBOL42Ys/WSG3qVZaNB
 wswuUzQg9S7r9FwSKHbsmuWtrFol+hBt2pFQY22j2a+Wf7ByS8vc3nG77VBXPQRjlBcS
 FYK2cW1EYIg8GPe7Xo1AF0x/zlRgvazqlYSciulQd/wsV5ypxo1VI459PkRT/c05dq1j
 h0nQ==
X-Gm-Message-State: AC+VfDx1k0SdbIBDNzPBgwLoeX6lJHLpndCyyonNwZBynARneYzUkY8A
 RlsJn4DuPT/i2qAEXCMaGKgpo3MKlynKE+xZpds=
X-Google-Smtp-Source: ACHHUZ4nAed12yC0ATc4y4T6ov4JNqGmFeW1j5VBFhJ02T6YV9zBXbm//g8zhdDQtOShKB4zz31FCw==
X-Received: by 2002:a5d:5541:0:b0:311:abb:e377 with SMTP id
 g1-20020a5d5541000000b003110abbe377mr6323739wrw.39.1687628513811; 
 Sat, 24 Jun 2023 10:41:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.217.150])
 by smtp.gmail.com with ESMTPSA id
 i11-20020adfefcb000000b0030ae3a6be5bsm2589165wrp.78.2023.06.24.10.41.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 24 Jun 2023 10:41:53 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, xen-devel@lists.xenproject.org,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Reinoud Zandijk <reinoud@netbsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 04/16] accel: Fix a leak on Windows HAX
Date: Sat, 24 Jun 2023 19:41:09 +0200
Message-Id: <20230624174121.11508-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230624174121.11508-1-philmd@linaro.org>
References: <20230624174121.11508-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

hThread is only used on the error path in hax_kick_vcpu_thread().

Fixes: b0cb0a66d6 ("Plumb the HAXM-based hardware acceleration support")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/hax/hax-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/hax/hax-all.c b/target/i386/hax/hax-all.c
index 3e5992a63b..a2321a1eff 100644
--- a/target/i386/hax/hax-all.c
+++ b/target/i386/hax/hax-all.c
@@ -205,6 +205,9 @@ int hax_vcpu_destroy(CPUState *cpu)
      */
     hax_close_fd(vcpu->fd);
     hax_global.vm->vcpus[vcpu->vcpu_id] = NULL;
+#ifdef _WIN32
+    CloseHandle(cpu->hThread);
+#endif
     g_free(vcpu);
     return 0;
 }
-- 
2.38.1


