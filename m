Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD829764946
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 09:49:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOvTb-0005Fp-PU; Thu, 27 Jul 2023 03:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTY-0005Dl-0z
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:56 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qOvTW-0003kh-E5
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 03:31:55 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-563531a3ad2so501433eaf.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 00:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690443113; x=1691047913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WUXy3jNQsy5PFGPCh7DZInihQgiJWpSfcmP70S5aNLc=;
 b=ErRkuXIDzI8EHN9RJalhLqdArv/g31OAVXPGZTxhgwm4bIExhwd4UPvDSRIJztk0ij
 8dWy86F8eEhs10cJ1ENhkeakq42mIoofDOZdQOKp1dEds0/JRCqiJ6HhOsJMRH/UQnvu
 XZ3bA41tzhxdLnEh+dDQKRh2JsZUz6k7Ciz62r5xlvsrQU86dTcuykBVsw2e58Qcwso8
 oeC7DWP3Eel+hhwJofaR9D77yQAaLpOYeISbfXP02vDpcNchsJN0ZtkS9B/TzAEhitnB
 vv0Vtdgo+pg0o+ZyyM+7Ds0RSgM1M0+ZdxfW0PJGJ0PUhPfSAH1XNeC+9zU3Pp0HHl/8
 hjXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690443113; x=1691047913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WUXy3jNQsy5PFGPCh7DZInihQgiJWpSfcmP70S5aNLc=;
 b=bpeFOJvqKRenXF6PewQi/j8LsM/93XXVbMRqvZX5oSG47kqmze+oVIQKy/x8xkdLeP
 xAcSw9c2SpkIxSHsk75X+8Pgio35bCpqd01gWSWLNj3+Vn9DCZNFOmuNFAylox6gLGHo
 nRsYaiEJ+JTbp2HQO8mzvNCec4jXOWG2xLDXe5+L1RgPEIiV3lcSd/c7jRQrj9IB82nQ
 sAERUFZ0alMvUG3l5SLUO0qBlcVn9B7ZuDVA9Nfe6BlFg6ypXBosuv3yAvL0QtnImIEb
 +rh8j2reZIK2+QWvCBsMmY9hK7f61E5OLJKpd8iKxTIyHyLTqCakBet4nlaCzFUPBmK6
 LuZQ==
X-Gm-Message-State: ABy/qLaMQMmiSWgb3JzvF59UzS3QHL2+d/rpmszGnR+IZjZ5AW5O4hgI
 gxOTkRlWZjC3m6jSlpVNpcm1PXVxz+A48DVHSEk=
X-Google-Smtp-Source: APBJJlFEta7887wC+EH2MCZzxvk/JmjxY935l/UatI0IUcVcQUEaVDafFfiot8/j0cB4J/3Md+iDSQ==
X-Received: by 2002:a05:6358:e4a7:b0:135:a52c:1d93 with SMTP id
 by39-20020a056358e4a700b00135a52c1d93mr1995699rwb.28.1690443113170; 
 Thu, 27 Jul 2023 00:31:53 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78689000000b0064fa2fdfa9esm802002pfo.81.2023.07.27.00.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 00:31:52 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 4/6] accel/kvm: Use negative KVM type for error propagation
Date: Thu, 27 Jul 2023 16:31:29 +0900
Message-ID: <20230727073134.134102-5-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727073134.134102-1-akihiko.odaki@daynix.com>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c31;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc31.google.com
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

On MIPS, kvm_arch_get_default_type() returns a negative value when an
error occurred so handle the case. Also, let other machines return
negative values when errors occur and declare returning a negative
value as the correct way to propagate an error that happened when
determining KVM type.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 accel/kvm/kvm-all.c | 5 +++++
 hw/arm/virt.c       | 2 +-
 hw/ppc/spapr.c      | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index d591b5079c..94a62efa3c 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -2527,6 +2527,11 @@ static int kvm_init(MachineState *ms)
         type = kvm_arch_get_default_type(ms);
     }
 
+    if (type < 0) {
+        ret = -EINVAL;
+        goto err;
+    }
+
     do {
         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
     } while (ret == -EINTR);
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8a4c663735..161f3ffbf7 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2977,7 +2977,7 @@ static int virt_kvm_type(MachineState *ms, const char *type_str)
                      "require an IPA range (%d bits) larger than "
                      "the one supported by the host (%d bits)",
                      requested_pa_size, max_vm_pa_size);
-        exit(1);
+        return -1;
     }
     /*
      * We return the requested PA log size, unless KVM only supports
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 54dbfd7fe9..1b522e8e40 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3104,7 +3104,7 @@ static int spapr_kvm_type(MachineState *machine, const char *vm_type)
     }
 
     error_report("Unknown kvm-type specified '%s'", vm_type);
-    exit(1);
+    return -1;
 }
 
 /*
-- 
2.41.0


