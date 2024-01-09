Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E09828C36
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:12:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGZO-0004kD-SZ; Tue, 09 Jan 2024 13:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGZ6-0003cL-L3
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:11:05 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGZ2-0004VS-5W
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:11:03 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3367601a301so3088135f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823857; x=1705428657; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTZBSvKw8jVi+klzEjHlnxZcbayvqCJEGNzo5jVRjUI=;
 b=CDLUhKRAHOtJORJkE1WJwN/+s2GrVQ46yPcW3hvoEAefBkv3hmMbYwAmw7aQ/9/r8Q
 KO1AvcnA6kR8Cj6O4YLJyUm8bvjhi9fHUSvZzCoHEpCr7QtiajgGyZYNBkUFjr57cUxN
 dRn+cyilZkLH4/vuX54YOLEUI4PAaSbmvoU5hKnx5Wq4k+gqjrDkbmxSC3OXMA432KDJ
 ninyLSaebENaY75D/+Xz+luZFovRgZMxK8n1iQQyB4GaWoviIY3G9fqNmkCa6BVTau2p
 EZLF/eMrbjzhxrXXD8CZStxv5118KgjYZFO34f9rzvhke0e03EpSjMhLsJzMm67NT1NV
 yApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823857; x=1705428657;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TTZBSvKw8jVi+klzEjHlnxZcbayvqCJEGNzo5jVRjUI=;
 b=C2knWI9so6x//XTv+ZWV77yQFHF+FJe5vlwY4FAyGYVTM7uw4hgfSbujli/vHiR78i
 SfHF/qNOFoDkgiViSjNeIXhCaDmTY9wgdah2FECR2VFla4fC0+LUGXscgWKAafAbE5ks
 gMErhS1nOCKTFLVH2K5bxDiWMb0Eb2Hn3UAkTVFBKHEeUPaTleRpOirvRtZVVxZHUMub
 cAAfnrMQppDznKcypoUvec6bqqucp3qlzKTY4naPbVJ1O0RnlUpTFVCKGrqi9DrRbdFH
 MbtKdJmXs/knX207AWm/nf2xc8uxHQthECEuH6ay+GLoKAOjiVCSL9ySmsWlmYBktpDW
 ad6A==
X-Gm-Message-State: AOJu0Yyi/CzgfN5XHzVfBdakdI7BANOPpVfMWOk+c5Nw3q4Bl7OLwE+n
 E+I6135l3iySe8mlrnpzNqWpysUCcaw4ms4rsqb1ECivpLqwZA==
X-Google-Smtp-Source: AGHT+IE4iZHZPpHy0g0Cu3FHdz9gyrxhzfhRi004s0M5I8nKQulT5SiowlGH/83JXZwoVHiQQzuJ8w==
X-Received: by 2002:a5d:50c3:0:b0:336:8940:c4e1 with SMTP id
 f3-20020a5d50c3000000b003368940c4e1mr475893wrt.30.1704823856733; 
 Tue, 09 Jan 2024 10:10:56 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 p4-20020a5d6384000000b0033760ad2eabsm2966695wru.69.2024.01.09.10.10.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:10:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/14] hw/arm: Prefer cpu_isar_feature(aa64_mte) over
 property_find(tag-memory)
Date: Tue,  9 Jan 2024 19:09:28 +0100
Message-ID: <20240109180930.90793-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240109180930.90793-1-philmd@linaro.org>
References: <20240109180930.90793-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

The "tag-memory" property is added to ARMCPU when the
A64_MTE bit is set in the feature ID register. Rather
than checking whether the QOM property is present, directly
check the feature bit.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6d1cb24a6e..2ce4a18d73 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2189,7 +2189,7 @@ static void machvirt_init(MachineState *machine)
                  * The property exists only if MemTag is supported.
                  * If it is, we must allocate the ram to back that up.
                  */
-                if (!object_property_find(cpuobj, "tag-memory")) {
+                if (!cpu_isar_feature(aa64_mte, ARM_CPU(cs))) {
                     error_report("MTE requested, but not supported "
                                  "by the guest CPU");
                     exit(1);
-- 
2.41.0


