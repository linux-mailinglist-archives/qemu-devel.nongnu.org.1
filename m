Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F11A57AB34B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgqf-0002sl-NN; Fri, 22 Sep 2023 10:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqZ-0002sd-QF
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:32 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqX-0008NV-J5
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:31 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-52f9a45b4bdso2577704a12.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1695391767; x=1695996567;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6r1Rb+JcWYyH45vCMnyzJFvNFOoKUMi9zu+1fi2NLWU=;
 b=aGcAHJNuQsryFziUHEG0vLDxKNGQi2k1pCtDl4OtsDlkTKbLIcWcUNRYvBGD/F80E3
 zHLzBfk6vHp7O/pQpluaNhETDZ4lTD2uwm9TmBLBO8DNLfA/9CybAp+s321Ja0DyF1iu
 iwi6SzMiKAyOxnZSYmyn6/xUNkUYLLApuOpCuKGytm8lvaku5jJZtzI70PbnuxFJjR7h
 7WLwAcmNisJGdQVGbvelfYmrKkmpEl7pw6kpmUXhKhKkhD1ki5vTUNWGbuUQKwE+rbdf
 tzpNMIlMxi8XgRpfk2aG+6SO6KPbma0go575qU3AL0TOSTrgNZweZyMS6AtLhmzh21o0
 xmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391767; x=1695996567;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6r1Rb+JcWYyH45vCMnyzJFvNFOoKUMi9zu+1fi2NLWU=;
 b=toWVwlnSpQWEfcKeHZuxq/XKfEEoAWOZGukoUSUfSkKvFzWDuOBtybJpjF05voP2ou
 USMg/Aiw7IiUGfRT4yJHPHEbDlOKjbULqHCZdfOGEITlrqVXRwgGl5bRAvcKUTSugGu2
 Pdqz0Bovj1mqHDWwrlq+xpChZiQ062L7/KPsvwXQr+1OfwjiJiYkLKDQWi8hPKm0yhUZ
 PWafSlkrfLn96x5H+zChqxgcyz4YAzsnFw7Wl20c2qji/xfalJiXji07Y6UWn87MCsD2
 4SJWI5C62889TwZ0++R+Oi5ezdSThP1Et4ajt2gQhq4xISWCC8FD9nTvy2c3YGhuPldE
 ztNg==
X-Gm-Message-State: AOJu0YxWyx8h3KCcsdaNakmWDFArjpGIyB8Lr8zo4lgA7GUOriphJ9s4
 zoTmxAeCkH/C8agnhCHYTE02p7EGdgcZInj5cXc=
X-Google-Smtp-Source: AGHT+IEW3HbXnxRLCqKHXSyDZlNeV2BFqb1oa9Ma5SsaBPHMxO0QALI9YhDUXJGSW/zYrELmL505GA==
X-Received: by 2002:a17:906:8a72:b0:9ae:68bf:bf2 with SMTP id
 hy18-20020a1709068a7200b009ae68bf0bf2mr3593877ejc.69.1695391766345; 
 Fri, 22 Sep 2023 07:09:26 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 g27-20020a170906395b00b009ae587ce128sm2725823eje.216.2023.09.22.07.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 07:09:25 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/3] hvf x86 correctness and efficiency improvements
Date: Fri, 22 Sep 2023 16:09:11 +0200
Message-Id: <20230922140914.13906-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::52d;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x52d.google.com
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

This is a series of semi-related patches for the x86 macOS Hypervisor.framework
(hvf) accelerator backend. The intention is to make VMs run slightly more
efficiently on macOS host machines. They have been subject to some months of
CI workloads with macOS guest VMs without issues and they seem to give a few
percent performance improvement. (Though this varies greatly with the type of
workload.)

Patch 1 enables the INVTSC CPUID bit when running with hvf. This can enable
some optimisations in the guest OS, and I've not found any reason it shouldn't
be allowed for hvf based hosts.

Patch 2 fixes hvf_kick_vcpu_thread so it actually forces a VM exit instead of
doing nothing. I guess this previously didn't cause any huge issues because
hvf's hv_vcpu_run() would exit so extremely frequently on its own accord. The
temp variable is needed because the pointer expected by the hv_vcpu_interrupt()
call doesn't match the fd field's type in the hvf accel's struct AccelCPUState.
I'm unsure if it would be better to change that struct field to the relevant
architecture's handle types, hv_vcpuid_t (x86, unsigned int) and hv_vcpu_t
(aarch64, uint64_t), perhaps via an intermediate typedef?

Patch 3, which replaces the call to hv_vcpu_run() with the more modern
hv_vcpu_run_until() for running the guest vCPU. The newer API is available
from macOS 10.15 host systems onwards. This call causes significantly fewer
VM exits, which also means we really need that exit-forcing interrupt from
patch 2. The reduction in VM exits means less overhead from exits and less
contention on the BQL. Using hv_vcpu_run_until() is also a prerequisite for
using certain newer hvf features, though this patchset doesn't use any.

Patches 2 & 3 must therefore be applied in that order, patch 1 is independent.

This work has been sponsored by Sauce Labs Inc.

Phil Dennis-Jordan (3):
  i386: hvf: Adds support for INVTSC cpuid bit
  i386: hvf: In kick_vcpu use hv_vcpu_interrupt to force exit
  i386: hvf: Updates API usage to use modern vCPU run function

 target/i386/hvf/hvf.c       | 26 +++++++++++++++++++++++++-
 target/i386/hvf/x86_cpuid.c |  4 ++++
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.36.1


