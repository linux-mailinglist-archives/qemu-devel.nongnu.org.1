Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBD07AB349
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgqx-0002xy-A2; Fri, 22 Sep 2023 10:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqp-0002uv-Dq
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:47 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqn-0008PY-Ub
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:47 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2c007d6159aso37174111fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1695391784; x=1695996584;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RwgPyvay9DFmsLuOUJUHjUScLN28OjxwI/Y1FI48aMc=;
 b=RUwVJC1EJcctYPFti4fCvVIX+NkdzJtzSZeUljmJsL1hj+qZILfjB51Z7bvMR4Tz3U
 p6OITbZz+E6E0Dc6rQFzCZZ9nK5HHbDJq4C8Ap8iRp7tCj5NHp4yrfvH4jn+hN14YCis
 itDahkmERN1DWTlXgNiH3e1YTBTWPY1UwhV50btxmHlv6ZGKjXxa2AYKUUR69R0hyst2
 bX3MiigiZuqHugzdRCqDfc3MSWGkhc8pr+uKgEHsyJD0ozmNAFda7MvqNelAaDdCJi8H
 c9Rjc9G9sI/3iJJH33LrBNse82eHeb/PYiOOfRdV/oQrlpDronGYYxhMLTrwbRIo2q1d
 b+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391784; x=1695996584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RwgPyvay9DFmsLuOUJUHjUScLN28OjxwI/Y1FI48aMc=;
 b=t/OA3C7qDNtxddUqS0ylPkg6fZ4pUsQaoX9jGwtyFzKTrirenA5ZYw+8NChv4GFhV+
 36I/Ftbn1hU79j60ERay7NyY3o55e4nlzGhz3p5NSP2z3rpBC/5difot0N1swAWRRcQP
 3NzRoFrXfUyXJRxM5V8/OlwIba0xwZH9m7h5CKnXUI3OFBczu9NbM40LdI73Usfp5ZrH
 5B4UG8kbqxLTlD32cSZiWwBjBHRdbyVzf+2gkkdSr44RJ9jFOy1PNB2zwtSYX+tsqAFm
 frAkREC1+RRIc48ZzRKQOiR/qa2a2JlThN8JwoYDozCOGF47azF6/+6hNi9hSi7mo7jr
 IRVw==
X-Gm-Message-State: AOJu0YzQBH7hZffvqmgysXw2yF+5NWmwtaQJM8/6PXlbyd5GOxLk5Tm2
 pAiyZ/Q2YKY2EIpnwZrQjHTueqSiIU51jQCn9Ek=
X-Google-Smtp-Source: AGHT+IETnI/4u8YyfHlagvukoYXzlEM9QY8mUCNmZocylHYkU7Q/8cYIrAIgdBXhby/cWT4JpsiIbA==
X-Received: by 2002:a2e:9b86:0:b0:2bf:fb49:6619 with SMTP id
 z6-20020a2e9b86000000b002bffb496619mr7325385lji.23.1695391784123; 
 Fri, 22 Sep 2023 07:09:44 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 g27-20020a170906395b00b009ae587ce128sm2725823eje.216.2023.09.22.07.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 07:09:43 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to force
 exit
Date: Fri, 22 Sep 2023 16:09:13 +0200
Message-Id: <20230922140914.13906-3-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230922140914.13906-1-phil@philjordan.eu>
References: <20230922140914.13906-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::22e;
 envelope-from=phil@philjordan.eu; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

When interrupting a vCPU thread, this patch actually tells the hypervisor to
stop running guest code on that vCPU.

Calling hv_vcpu_interrupt actually forces a vCPU exit, analogously to
hv_vcpus_exit on aarch64.

Previously, hvf_kick_vcpu_thread relied upon hv_vcpu_run returning very
frequently, including many spurious exits, which made it less of a problem that
nothing was actively done to stop the vCPU thread running guest code.
The newer, more efficient hv_vcpu_run_until exits much more rarely, so a true
"kick" is needed.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index cb2cd0b02f..55bd7d2af8 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -209,7 +209,10 @@ static inline bool apic_bus_freq_is_known(CPUX86State *env)
 
 void hvf_kick_vcpu_thread(CPUState *cpu)
 {
+    hv_vcpuid_t hvf_vcpuid;
     cpus_kick_thread(cpu);
+    hvf_vcpuid = cpu->accel->fd;
+    hv_vcpu_interrupt(&hvf_vcpuid, 1);
 }
 
 int hvf_arch_init(void)
-- 
2.36.1


