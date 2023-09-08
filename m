Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA27E79866A
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 13:24:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeZZc-0003cE-7Y; Fri, 08 Sep 2023 07:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZZY-0003b1-IG
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:22:49 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qeZZS-0003UH-QC
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 07:22:45 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40037db2fe7so20723835e9.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694172161; x=1694776961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cDNuLK1WUEsuIA3ZtN60Dc1/gMCwnWEdZ5HlLK85gcs=;
 b=uqTlCaph8+xJALO9CBivdTv+jdPmugzcXxViJv0UrkKqPfbkggtyu99gFv+6Q2qjQs
 3qHSviP2xvL87jtUGhTHV3ASk8VPhC1AmbB9nWh4otXdIgB0vSA7xnVo7wDBlN/zGNtv
 D0Gg3BqpeqXRnZd4hqL6cOPGxVWxg8//a6G0ZLgEiUS7AjCPO3RI/iRyCmYqQb9dZQcR
 q/qQ9WW3eXx5iaecL9SPS7mfTxMOZF+lCiWsb9dV52LrItoYKLG/q6wssu/pYAjMXGkf
 eY8/08i1zd3739wkJmKdDlAfkbw4kXBdHU+9O5kUW8REIskwsRNIBfVdusR8IO7Jtf+d
 SSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694172161; x=1694776961;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cDNuLK1WUEsuIA3ZtN60Dc1/gMCwnWEdZ5HlLK85gcs=;
 b=A2s/siW6GKxngBHEELScRSYL9PjTDRuSwgVdZcx+3IGH3oqszvj+6fSJE9yUS57059
 1AyZazj+v8SHfVhkT91aTqpg9a0P89TK5BoDVlmmwY+15o4RgwXsXSwuIjpphSHXwEQ6
 zl1FRLUy1dW4J2gb8fRcsSGQfdsebEEEKUgv0kbEvBNeAtxzysZlxPUQq7e8yNjduqJm
 MTK2TlOUGUNoTVA1HvU72wQwBQYPF99YnYsCL5QyBPQ/KPWgVXXbWR7ZEJrYbTKOieko
 Y483OKFjxM9KbDgdyVhk6RtgywppLj+Jjmd7+ob41qgxBSBXe/7OsolZrO6kfx8iQoKw
 uCaw==
X-Gm-Message-State: AOJu0Yx4tMITL6FdP7dLjXQxVaxhsa9UDbrKPvdSLoxJ2DVrNr3J0td9
 cYxNpcUMQDCkfF8C2EWUo45kbU+owtdzAg3+0+s=
X-Google-Smtp-Source: AGHT+IElRLJcXYvJSvVnF/uUXlWzt4CDSKFLHoBGde8Mna2xvdVRLXStl+ls/DJ6a9c6p7yDQEoGvg==
X-Received: by 2002:a05:600c:c9:b0:3fe:c7fe:206e with SMTP id
 u9-20020a05600c00c900b003fec7fe206emr1894318wmm.16.1694172161010; 
 Fri, 08 Sep 2023 04:22:41 -0700 (PDT)
Received: from m1x-phil.lan (lfb24-h01-176-173-167-175.dsl.sta.abo.bbox.fr.
 [176.173.167.175]) by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b003fef3180e7asm4956965wmi.44.2023.09.08.04.22.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Sep 2023 04:22:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Gavin Shan <gshan@redhat.com>
Cc: Chris Wulff <crwulff@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org,
 Weiwei Li <liweiwei@iscas.ac.cn>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Greg Kurz <groug@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Marek Vasut <marex@denx.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Michael Rolnik <mrolnik@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Bin Meng <bin.meng@windriver.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Song Gao <gaosong@loongson.cn>,
 Stafford Horne <shorne@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Thomas Huth <thuth@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 0/4] hw/core/cpu-common: Consolidate cpu_class_by_name()
Date: Fri,  8 Sep 2023 13:22:30 +0200
Message-ID: <20230908112235.75914-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Gavin noticed the same pattern is duplicated in many
CPUClass::class_by_name() handlers [*].
This series consolidate the calls to
 - object_class_is_abstract()
 - object_class_dynamic_cast()
in the common cpu_class_by_name(), by introducing
the CPUClass::cpu_resolving_type field.

[*] https://lore.kernel.org/qemu-devel/ab07d81c-da98-a270-c3f6-0625912c6d0b@redhat.com/

Philippe Mathieu-Daudé (4):
  target/alpha: Tidy up alpha_cpu_class_by_name()
  hw/cpu: Call object_class_is_abstract() once in cpu_class_by_name()
  hw/cpu: Introduce CPUClass::cpu_resolving_type field
  hw/cpu: Call object_class_dynamic_cast() once in cpu_class_by_name()

 include/hw/core/cpu.h   |  9 ++++++---
 hw/core/cpu-common.c    | 15 ++++++++++++---
 target/alpha/cpu.c      | 11 ++++-------
 target/arm/cpu.c        |  6 ++----
 target/avr/cpu.c        |  6 ++----
 target/cris/cpu.c       |  6 ++----
 target/hexagon/cpu.c    |  6 ++----
 target/hppa/cpu.c       |  1 +
 target/i386/cpu.c       |  1 +
 target/loongarch/cpu.c  |  7 ++-----
 target/m68k/cpu.c       |  6 ++----
 target/microblaze/cpu.c |  1 +
 target/mips/cpu.c       |  1 +
 target/nios2/cpu.c      |  1 +
 target/openrisc/cpu.c   |  6 ++----
 target/ppc/cpu_init.c   |  1 +
 target/riscv/cpu.c      |  6 ++----
 target/rx/cpu.c         |  7 ++-----
 target/s390x/cpu.c      |  1 +
 target/sh4/cpu.c        |  4 +---
 target/sparc/cpu.c      |  1 +
 target/tricore/cpu.c    |  6 ++----
 target/xtensa/cpu.c     |  6 ++----
 23 files changed, 53 insertions(+), 62 deletions(-)

-- 
2.41.0


