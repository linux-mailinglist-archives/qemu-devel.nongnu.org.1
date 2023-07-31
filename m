Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE47D769939
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 16:16:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQTgb-0005aA-2a; Mon, 31 Jul 2023 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgS-0005Wa-L8
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQTgQ-0007ei-ON
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 10:15:40 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8fcso31569445e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 07:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690812937; x=1691417737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=itpHEVbLfs3D8/erGt8kWjQtJGFDTxDKtjwIc6dYdN8=;
 b=e5+4En45SlVWfKIsyAyz7S0ZUVgFHYMsM+E+yPGBgy+tnKUF/VfSNKbp2JSi68nZv6
 AEGVg+pc21h5s1nhNYTDUQD9Ve003ADYmqNRXvbjd58hJgLLIfCiBv1kffNODXG2O5Vi
 P14BoUUZEbPwOFTllStI91VZF7BVCUQMEwHZipaXgMVWn4OiBOTF53WcXe1T+KS5JXl6
 DHyXZJH0u2iu2rNV1qO/lqA/cyDC3hJLwN+iAeKtq9xMRuxk5kjLoeGtlyNvNVFeGV3c
 nS/DWejQngouDrfRmwbkRFUUeqiB4cbyWLOD7PbgWpD52W4znvEERh0izytx5IboL6En
 wL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690812937; x=1691417737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itpHEVbLfs3D8/erGt8kWjQtJGFDTxDKtjwIc6dYdN8=;
 b=RpS9i4jiYAmOwOSDntEH0ljgdA8Ywj47S8t4TJFnirxtdD4FosxKtZTlZjamyHCbRj
 Lr69jm1vM94fZNg7IBwk74+iEMV0cRxgXYecNtPNHNpbvRP16PPcXnO2QvXqm2hxNYwp
 firnFnqw1lSK/cxDjxEWeoq5iV6sMkhy2HTAgim+GA1dkTm+TZG9fMP3cK6e8gEmSBBJ
 Jf0fJedIN+hjwxETSSX+YQI+I9ov76/NPE5K9qNgdMob5Nu1pQrJX3Ic5Mu/z2kypTIY
 n3j9LhChXVa5Lcz1BYV/Rglm0MIndiEa20VBVmYjothr94khSkoamOo775Itbhvjyele
 v8/A==
X-Gm-Message-State: ABy/qLZWYpazJBCCwolYoiF2081V7+R4g1ucmRiqSwt9rxiZPOi76H2a
 Ls/NVfCyLKgGcR7OhmZVELeC4xmd7DMFYFcjsr8=
X-Google-Smtp-Source: APBJJlH3/iXOLSmQVS82aDbh+0PRPg1jOccDSVBBkBx1dNYj1ASBIgmoAuYhlKZxMUDSlT2ws10NQg==
X-Received: by 2002:a05:600c:3d13:b0:3fb:e1d0:6417 with SMTP id
 bh19-20020a05600c3d1300b003fbe1d06417mr10584857wmb.19.1690812937057; 
 Mon, 31 Jul 2023 07:15:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c114f00b003fbb5506e54sm11450675wmz.29.2023.07.31.07.15.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 07:15:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] target/arm/tcg: Don't build AArch64 decodetree files for
 qemu-system-arm
Date: Mon, 31 Jul 2023 15:15:31 +0100
Message-Id: <20230731141533.3303894-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731141533.3303894-1-peter.maydell@linaro.org>
References: <20230731141533.3303894-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently we list all the Arm decodetree files together and add them
unconditionally to arm_ss.  This means we build them for both
qemu-system-aarch64 and qemu-system-arm.  However, some of them are
AArch64-specific, so there is no need to build them for
qemu-system-arm.  (Meson is smart enough to notice that the generated
.c.inc file is not used by any objects that go into qemu-system-arm,
so we only unnecessarily run decodetree, not anything more
heavyweight like a recompile or relink, but it's still unnecessary
work.)

Split gen into gen_a32 and gen_a64, and only add gen_a64 for
TARGET_AARCH64 compiles.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230718104628.1137734-1-peter.maydell@linaro.org
---
 target/arm/tcg/meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index bdcab564899..6fca38f2ccb 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -1,7 +1,11 @@
-gen = [
+gen_a64 = [
+  decodetree.process('a64.decode', extra_args: ['--static-decode=disas_a64']),
   decodetree.process('sve.decode', extra_args: '--decode=disas_sve'),
   decodetree.process('sme.decode', extra_args: '--decode=disas_sme'),
   decodetree.process('sme-fa64.decode', extra_args: '--static-decode=disas_sme_fa64'),
+]
+
+gen_a32 = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
@@ -13,10 +17,10 @@ gen = [
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
   decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
-  decodetree.process('a64.decode', extra_args: ['--static-decode=disas_a64']),
 ]
 
-arm_ss.add(gen)
+arm_ss.add(gen_a32)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.34.1


