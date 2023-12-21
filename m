Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B379881AD47
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:23:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9ZN-0007U4-Rz; Wed, 20 Dec 2023 22:17:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZM-0007Tu-3F
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:56 -0500
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9ZK-0003ln-GK
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:55 -0500
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78102c516a7so21908285a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128673; x=1703733473; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6KY46huI3mUxtNUliqIZ5HRP38hRIGMvbGBE0iwxXC4=;
 b=KgWknse0nM0WBpcCWxVUA9tBg/ktu7onuOagXkBvdhhLpfR8G1JO3LsP9gEebClybT
 ge6OrbQhzrGJnF/iWbkvQsbe77C26imqtO1NZcSrFFnXsbsfpv/2EvYd8zfvxsqk7zHN
 414nLYIC5kd778K8iV+4Cgb2ch/9igPlj9k1BzIju8DHDC3vYA6zPLYQKZOMl+w1poXX
 v5zxQbchM4DaEwIQVV2CP/7fDgixR+2KRYxuftr+VTW0N9hKTWxF1HQQoVrFXO95DFRT
 3nQJZOml8heyXAYoPQclWzrRNA82dXenn7CMV4tQd3ihvfWgD3QVZKhwhCoIkockWRk5
 e8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128673; x=1703733473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KY46huI3mUxtNUliqIZ5HRP38hRIGMvbGBE0iwxXC4=;
 b=OcFQpJ6PxSx8ZLdir2BumVOfOUSPjUX3aHALh5VcAGeTZOfz2CXW1wATLzniUUBVfY
 xoRgHCGDqA5/0zMpMh4APQU2NuFLaY/xkaMITz+jB0/mZ6gpOq+QRGTz8FPnjKolYqK0
 W2PM0ktCmWlh2DYjP/Kk4m5Kqmc04IH5k88SgPT+nEEqEigdl+AlsP30C6JjGZX74WlM
 XZJLHm7aabXH5l7HkmMfDSmMQHAjmyGjjkOOK9fFOIC1wLiTYHit7wZNduG6b6TNqePE
 tTDgXfLFBM/LnZjxgdpN7ud0Ohb9EJpeTEivjaej4Wg3KBoPJUYUaNV9X0RD/JFWytlj
 uY6w==
X-Gm-Message-State: AOJu0YxEUxheeUUkfkiSH8rex07dRbHhv7EjecC56f5CoRbQMwh19rdA
 pqLZRldhcshIbpcg+47MROw6ZHgSl/x+VWEZcApw4RHe
X-Google-Smtp-Source: AGHT+IFSoqj5rd7RMmHGeAoNWc3NrPu8jpzYthIabSsCHMl2WGTsVLuO3GlYoGlLicnJV0s988+gGA==
X-Received: by 2002:a05:620a:2b98:b0:77f:92f:fcc0 with SMTP id
 dz24-20020a05620a2b9800b0077f092ffcc0mr28165310qkb.24.1703128673449; 
 Wed, 20 Dec 2023 19:17:53 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:53 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/71] target/microblaze: Constify VMState in machine.c
Date: Thu, 21 Dec 2023 14:15:52 +1100
Message-Id: <20231221031652.119827-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72e.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/machine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/microblaze/machine.c b/target/microblaze/machine.c
index d24def3992..51705e4f5c 100644
--- a/target/microblaze/machine.c
+++ b/target/microblaze/machine.c
@@ -22,7 +22,7 @@
 #include "migration/cpu.h"
 
 
-static VMStateField vmstate_mmu_fields[] = {
+static const VMStateField vmstate_mmu_fields[] = {
     VMSTATE_UINT64_2DARRAY(rams, MicroBlazeMMU, 2, TLB_ENTRIES),
     VMSTATE_UINT8_ARRAY(tids, MicroBlazeMMU, TLB_ENTRIES),
     VMSTATE_UINT32_ARRAY(regs, MicroBlazeMMU, 3),
@@ -60,7 +60,7 @@ static const VMStateInfo vmstate_msr = {
     .put = put_msr,
 };
 
-static VMStateField vmstate_env_fields[] = {
+static const VMStateField vmstate_env_fields[] = {
     VMSTATE_UINT32_ARRAY(regs, CPUMBState, 32),
 
     VMSTATE_UINT32(pc, CPUMBState),
@@ -92,7 +92,7 @@ static const VMStateDescription vmstate_env = {
     .fields = vmstate_env_fields,
 };
 
-static VMStateField vmstate_cpu_fields[] = {
+static const VMStateField vmstate_cpu_fields[] = {
     VMSTATE_CPU(),
     VMSTATE_STRUCT(env, MicroBlazeCPU, 1, vmstate_env, CPUMBState),
     VMSTATE_END_OF_LIST()
-- 
2.34.1


