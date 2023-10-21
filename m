Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EB47D1F4E
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIEi-0005Ns-2S; Sat, 21 Oct 2023 16:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEg-0005M1-5O
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:06:14 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEb-0006uv-2P
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:06:13 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e3b8f906fso2934815a12.2
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 13:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697918765; x=1698523565;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VsUolhqTt9BsjhTqkC8onV1WKcY/dQnGV/wAPJThXRA=;
 b=I251L+3kvZINlM43FAF4bRTalAZe/V/G2T7fTj7yxn8PwSkZpmOFJyxTSAgTU9bQ3D
 Je5o+R9jAp1GwYpc/T7Xzh2UkbBR1QtEUQDvmCg0ZF/Y5qsAWGAH+6g4G3sK4IiEfRmD
 x1+nLk88ec07uLAcRAbV5LiVGyrx3Tp62LHKLPWhQlBy7G2yR/fyg93umBS59+40ix/V
 oLELqp2IbmMyWc6mjAt4PuiqLPAuCe9kr8uou7vZvRIgMCrQAPjmIzg12MblNq/aigoI
 j50QXytj1s3VH03ZN5uty4BeXUmmtZxHFiIkPQaFVKpM2OOx59LGrESAxz6A0q3GA3tP
 uI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697918765; x=1698523565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsUolhqTt9BsjhTqkC8onV1WKcY/dQnGV/wAPJThXRA=;
 b=FfFA9SzVXQuhn6l7a2mHP/zDrPGoO+QkseBx3wwzkE2mT0jx+9ZzZiJ4OByFxZM4tq
 eF7JNNGIEn/xCqzkWhr/nmc4bxJ0B9S2jEfb6IkYGTmMzq7AMDr66k5TbyjvOeebKE7M
 AkHolaSuRM4MzxM5qLcu77cgrIxaw5B7ZAzwQOo/tCUqr7j2wRgw3Y59z3z9kd/vOufF
 YKWyr8otqWSXK4ui+ibreyJOt9DckIwbfXv7PyBg/lYDyBsQ6SfO/ubmCEMVPkAkadOE
 1ajo5ibYj9gAPIDmf1b7XKI7FQeStZqSaUsUyRXU5Jjf0M2CW0l6A18/nqZN8EwMeMME
 2Qcg==
X-Gm-Message-State: AOJu0YxaGxJ0GT5PjbrqB7NrmeW2hRJ/6eMSIZcvH3PgOQL4jbIHoSta
 9p02/q7Hy9lP4sNGLtGbrNIYGz6TSwQnA/J1GDI=
X-Google-Smtp-Source: AGHT+IG8zrJOXiClewdKeoNrNMCN34ckI155S0Xr/u1IfL71l2TBvVQ3WxgVe2LNpqvs6qIORhUZzQ==
X-Received: by 2002:a17:907:70b:b0:9c6:724:fa16 with SMTP id
 xb11-20020a170907070b00b009c60724fa16mr3806927ejb.59.1697918764637; 
 Sat, 21 Oct 2023 13:06:04 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090617c200b0098ce63e36e9sm4138253eje.16.2023.10.21.13.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 13:06:03 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, roman@roolebo.dev, pbonzini@redhat.com,
 lists@philjordan.eu, phil@philjordan.eu
Subject: [PATCH v2 3/4] hvf: Consistent types for vCPU handles
Date: Sat, 21 Oct 2023 22:05:17 +0200
Message-Id: <20231021200518.30125-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231021200518.30125-1-phil@philjordan.eu>
References: <20231021200518.30125-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52e;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

macOS Hypervisor.framework uses different types for identifying vCPUs,
hv_vcpu_t or hv_vcpuid_t, depending on host architecture. They are not just
differently named typedefs for the same primitive type, but reference
different-width integers.

Instead of using an integer type and casting where necessary, this change
introduces a typedef which resolves to the active architecture’s hvf typedef.
It also removes a now-unnecessary cast.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 accel/hvf/hvf-accel-ops.c | 2 +-
 include/sysemu/hvf_int.h  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index abe7adf7ee..165e54ea27 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -400,7 +400,7 @@ static int hvf_init_vcpu(CPUState *cpu)
     r = hv_vcpu_create(&cpu->accel->fd,
                        (hv_vcpu_exit_t **)&cpu->accel->exit, NULL);
 #else
-    r = hv_vcpu_create((hv_vcpuid_t *)&cpu->accel->fd, HV_VCPU_DEFAULT);
+    r = hv_vcpu_create(&cpu->accel->fd, HV_VCPU_DEFAULT);
 #endif
     cpu->vcpu_dirty = 1;
     assert_hvf_ok(r);
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 718beddcdd..7980c90825 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -13,8 +13,10 @@
 
 #ifdef __aarch64__
 #include <Hypervisor/Hypervisor.h>
+typedef hv_vcpu_t hvf_vcpuid;
 #else
 #include <Hypervisor/hv.h>
+typedef hv_vcpuid_t hvf_vcpuid;
 #endif
 
 /* hvf_slot flags */
@@ -50,7 +52,7 @@ struct HVFState {
 extern HVFState *hvf_state;
 
 struct AccelCPUState {
-    uint64_t fd;
+    hvf_vcpuid fd;
     void *exit;
     bool vtimer_masked;
     sigset_t unblock_ipi_mask;
-- 
2.36.1


