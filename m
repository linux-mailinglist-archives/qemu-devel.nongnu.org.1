Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5785373A5B6
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:10:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMsH-0002xg-Jr; Thu, 22 Jun 2023 12:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMs4-0002uI-1n
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:09:20 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qCMry-0007nC-WD
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:09:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fa71db41b6so9551865e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687450150; x=1690042150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KWWds0uHrElgc22pSSxJ50tOp/lAV9kSI84s7Y2g/GM=;
 b=EbM780AWzavorYGjwE/j3EeJGIDw52NMRbKdS1s1/gZWniGA7sDBRZVP2QyfRqO47I
 7X7B7xFYS297uGD3scmvxOmMiYP9OTll3eGFYcIQd4FpE0WW7V3oKBilIjfQT/k+/GPn
 V5BiCj2bgxxHGiIPvjbPJuQdy4VGi6sUnUZ8JyXtmAJEU6CrcXGXcSuxoa+cZFjfMKPW
 ZWhlpEG7XgwDT27Y537Y1ehWshHrG0ia2ToE68LsnrY1dFG/RpCqknDRqgAY2g/hC1Kd
 jf7UQOxMVQuZzQgTtEe05+aD9m+AbSf0u4R9D8Us4q4EE6ZIvJq/tj+t/EKcZaxvsqzH
 qQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450150; x=1690042150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KWWds0uHrElgc22pSSxJ50tOp/lAV9kSI84s7Y2g/GM=;
 b=LM4lAitrWGJbz62pKLHFW6U2vvGvTeK+4xEvGYhfAWc5f6Umwt3GowahOhbk5C6E0M
 ZeYALDMDVNnxZ/bHpUEVjfpLCKRwnXrihtiotdXyRB2Ombks0IZv2p8TeocNRa5PWKPS
 LGWsICQvmju7mi0EXUCuNms7szcncy2Pc/QamI/1QLDy9sq8IqElVjQH+dGkZ0c4VWdm
 qT2jZ4tWvFHsyvl/ATo9sK1b+WMfBksN/jI/A/1lW3Ynt+L1N7opmTdzYet9aVxf1XiF
 OgTOftfNoq5jZhTeJ0a7srD7FYFC+4T3SVRkpAsq02qTV/fq88SjegrTfgp1Q/jWLpxw
 6XzQ==
X-Gm-Message-State: AC+VfDyn1431OkOoDJVRDwT2QMjHrh2x9RjsNFtz2OmwxTasiK2G1Vpi
 Sw+Ys66TaIKqYYlNunnYSBU/oQ3hXkigHEiEC7AUsw==
X-Google-Smtp-Source: ACHHUZ51xfqu7ycVqyxzIHVhQQRD4BRESLxxv3gkwPL1UAb0nB49UkufaCFZkef5SDfT9giEDTGvXg==
X-Received: by 2002:a1c:6a0e:0:b0:3fa:78d1:572 with SMTP id
 f14-20020a1c6a0e000000b003fa78d10572mr642130wmc.0.1687450150672; 
 Thu, 22 Jun 2023 09:09:10 -0700 (PDT)
Received: from localhost.localdomain (230.red-88-28-3.dynamicip.rima-tde.net.
 [88.28.3.230]) by smtp.gmail.com with ESMTPSA id
 n6-20020a05600c294600b003f7e4639aabsm19231418wmd.10.2023.06.22.09.09.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jun 2023 09:09:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v2 04/16] accel: Fix a leak on Windows HAX
Date: Thu, 22 Jun 2023 18:08:11 +0200
Message-Id: <20230622160823.71851-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230622160823.71851-1-philmd@linaro.org>
References: <20230622160823.71851-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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


