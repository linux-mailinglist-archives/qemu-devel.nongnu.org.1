Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 447AE7C863E
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 14:58:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrHid-0002O1-ND; Fri, 13 Oct 2023 08:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHiY-0002GL-Nh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrHiV-0002Xb-9W
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 08:56:37 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so3629328a12.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697201793; x=1697806593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2sd8M/BA0KQYN9MHAuIQYiELCXQubNQTUhqVxhnT8/M=;
 b=JrEqhIx2CFFY0bGKCtUZlwSbVuYQc+u9HuUjHwX0JYjGTQbuT7EoCGr80JvOBX1IEI
 VMCtE1K2WFfjwYGy+ot7Ifi1mbJZBUpd4cRaXkGvE+cd2CCH2lRxi4irmnccCadRLat/
 iTP6IZTCL4d0JuOY0Zs/TIFsbSinGPDbgsUgRYLDyAhGPPPjv7ST0ZWbT4Sl+HossOFU
 7W04ET7AbTgyXfkEOYOU9dx0/EXvmOuUF+9d+CKXMlfuAcp5Ar2N5bh47HfSlrYwjTXw
 oLWxMA6CQ0ouxudgM5+f3gWXOs/v4knlWGo8lWRgZmFgIjSfRJF4N4eZLMdGmSncBxDH
 10TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697201793; x=1697806593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2sd8M/BA0KQYN9MHAuIQYiELCXQubNQTUhqVxhnT8/M=;
 b=W39v60l44Ob9OwRCbN/ezAMfZTwRRydEuGK1KuG3N6+yvqRxsu8wzTwbjJVfRC3n2h
 wCwUoIfC3MTFO91PLpHHkA6xn6+ZYo0gSWrC43m5M5SjdxLJqd2YxHpgwdq04dlK5AQI
 xFyNFJufDcH8kROemu3HcpyetOLHTFhhuXN6RfrLjRMVthfDT5jcTtN0LxFzDXCukg2q
 x/TPxBLOk9LuQSe+t/Ir/ptex37sX6YbZsCsxiVOoVtSeoOfdZYBAtoCfIBYK1KHUBCn
 vVKFwAolkdtmIW3MeHHy61I2RFGPGdIJBzR/1ND8aONuyRYgHsis4qnWMoabB7HnFYGw
 A5Xg==
X-Gm-Message-State: AOJu0YxbjQeVdrc1UDx0vmNVUFb71RwkjVMktdNWEXkU5h6vFcubj17G
 mlTU9/0NHtTNp46daqxQeAIlMUP/9FzWpxaCeXQ=
X-Google-Smtp-Source: AGHT+IFRS/ZIPGLPLO1wDCKAz2Z3Fq9ITfc3V2XQV0/y/Qyvb8yNmPfliggg7oKsaddpn6YdWGKBrQ==
X-Received: by 2002:a05:6402:288f:b0:53d:d7e5:a9b9 with SMTP id
 eg15-20020a056402288f00b0053dd7e5a9b9mr6990855edb.0.1697201793248; 
 Fri, 13 Oct 2023 05:56:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 f26-20020a056402005a00b00530bc7cf377sm11451578edu.12.2023.10.13.05.56.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Oct 2023 05:56:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] target/ppc: Move most of 'cpu-qom.h' definitions to
 'cpu.h'
Date: Fri, 13 Oct 2023 14:56:23 +0200
Message-ID: <20231013125630.95116-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

I'm going to post a v2 of "target: Make 'cpu-qom.h' really
target agnostic" [*]. Since the series is already big enough,
I extracted the PPC specific patches in their own preliminary
series.

In short, "cpu-qom.h" exposes QOM definitions and must be
target agnostic. This series moves the PPC specific definitions
to target/ppc/cpu.h.

Please review,

Phil.

[*] https://lore.kernel.org/qemu-devel/20231010092901.99189-1-philmd@linaro.org/

Philippe Mathieu-Daudé (7):
  hw/ppc/spapr: Restrict PPCTimebase structure declaration to sPAPR
  target/ppc: Define powerpc_pm_insn_t in 'internal.h'
  target/ppc: Move ppc_cpu_class_by_name() declaration to 'cpu.h'
  target/ppc: Move PowerPCCPUClass definition to 'cpu.h'
  target/ppc: Move powerpc_excp_t definition to 'cpu.h'
  target/ppc: Move powerpc_mmu_t definition to 'cpu.h'
  target/ppc: Move powerpc_input_t definition to 'cpu.h'

 include/hw/ppc/ppc.h   |   2 +-
 include/hw/ppc/spapr.h |   6 ++
 target/ppc/cpu-qom.h   | 183 -----------------------------------------
 target/ppc/cpu.h       | 141 +++++++++++++++++++++++++++++++
 target/ppc/internal.h  |   9 ++
 hw/ppc/ppc.c           | 107 ------------------------
 hw/ppc/spapr.c         | 116 ++++++++++++++++++++++++++
 7 files changed, 273 insertions(+), 291 deletions(-)

-- 
2.41.0


