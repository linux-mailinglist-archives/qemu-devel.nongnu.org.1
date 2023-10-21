Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A687D1F50
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 22:07:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quIEC-00048e-Pw; Sat, 21 Oct 2023 16:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIEA-00046K-2J
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:05:42 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1quIE7-0006qF-Kk
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 16:05:41 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b96c3b4be4so287758466b.1
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697918736; x=1698523536;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zvT4k7WW8dK/L3s/qHnjsztIYAybaYKJqNyN1ZNc86U=;
 b=AZ7gPPuB+p3Oy+l47lr3U+16UTG4vBuvrGJ2IIiv2xP2Wr79JZVU4yoxWmesyQ0NX9
 Fwqzjl2wuP7DU4puL7kFcaonVZpeh4Rtv8dVvK7i1Fuj+fipdaxDejR0vKgZmX8GOsLw
 hRRLIXVQefEaDIEa5PEl9dzbSKBX0idqAXkmkF445w1cH1jCwupYCokm65vlC7QBD1Vj
 vNxCqNR2Ci4L4JbEJR6ihOd3VRPQl6y+TMhnaHC3ySAFo0S0d9IOKzIEjCSDfE8kyYgL
 pny0HptOTKGKptbLG9lvI9l4ssxRMk5aaIu7XP0+u6sS72IMjSiON+WWxgABmS4o69Ib
 O7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697918736; x=1698523536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvT4k7WW8dK/L3s/qHnjsztIYAybaYKJqNyN1ZNc86U=;
 b=ZT2Vpy/SlGKZKZHHxV5uHnPHVhoE8dM/Z3Dw1Xfp2dOp9ufVsR/nZ44xTF8OF1NBZH
 lQ5AVmQWojrQCQwwC7DeR/1Ucx5SdvX9OoGaL5D79prvCgC3RJZ/iLysF/jvviXDULy8
 +pt7Y0Zs3t8dwG/1yiwQtlD1wnkJc9UaxJEia0+VzALYZ8LfZWSSwe+/MEuEWHsrHjZR
 QBqHc3wnvvA0B/7o/fYjKqU5LRJOUZIqjnZDNrVOioVTyiDJLjsBaGFsBdSeM64vjdqn
 Qtsul5TAzzZU86JymPlXOUDVe/8rZeQFPNKRTQFJ5/7JZPSu3eiVtZj3B/jwdYQF9fsr
 CgFA==
X-Gm-Message-State: AOJu0YzJsVbYIUAZsOXEFAE0JmorwPqTWDESUESrrVewyy1hIzNYbJy/
 FIIKlJln0ugUfwjEHrG8pI1LK+fpXsr+sszjeBs=
X-Google-Smtp-Source: AGHT+IHMrWDEVlUloGQ2H+QNpZtB9HXiQqSAXkDdHapZ+Hdily37zVnkDYL2gf4XVTTQV6y8uzDYUg==
X-Received: by 2002:a17:907:985:b0:9ba:dcbf:6f53 with SMTP id
 bf5-20020a170907098500b009badcbf6f53mr3890245ejc.35.1697918735803; 
 Sat, 21 Oct 2023 13:05:35 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 u2-20020a17090617c200b0098ce63e36e9sm4138253eje.16.2023.10.21.13.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 13:05:35 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, roman@roolebo.dev, pbonzini@redhat.com,
 lists@philjordan.eu, phil@philjordan.eu
Subject: [PATCH v2 0/4] hvf x86 correctness and efficiency improvements part 1
Date: Sat, 21 Oct 2023 22:05:14 +0200
Message-Id: <20231021200518.30125-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::62f;
 envelope-from=phil@philjordan.eu; helo=mail-ej1-x62f.google.com
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
(hvf) accelerator backend. The intention is to (1) fix bugs and (2) move the
hvf backend to use more modern and efficient APIs in Hypervisor.framework.

The eventual goal is to replace the main hv_vcpu_run() call with
hv_vcpu_run_until(); the final 2 patches for this were included in v1 of this
series, but I've omitted them until part 2 this time around, as discussion
raised some questions about edge cases and race conditions when forcing VM
exits. I'm still working on getting solid answers on those questions and will
only then follow up with corresponding patches. Until then, this first set
of changes lays some groundwork.

Patch 1 enables the INVTSC CPUID bit when running with hvf. This can enable
some optimisations in the guest OS, and I've not found any reason it shouldn't
be allowed for hvf based hosts. It now also includes setting a migration
blocker when the feature is active.

Patch 2 fixes a bunch of compile warnings that kept littering my build logs,
so I finally caved and fixed them. As far as I can tell, these were all
ancient typos.

Patch 3 sorts out the minor mess of hvf vCPU IDs/handles. The aarch64 and
x86-64 versions of Hypervisor.framework's APIs use different integral types
(uint64_t vs unsigned int) when referencing vCPUs, so this changes the code
to use the correct one depending on build arch instead of awkward pointer
casts. (There's currently only one instance of such a cast, but the patches
in part 2 would have added more, so I'm fixing this preemptively.)

Patch 4 fixes dirty page tracking for the x86 hvf backend. This has
previously only accidentally worked because hv_vcpu_run() makes spurious EPT
fault exits. Switching to hv_vcpu_run_until() surfaces this issue when using
an emulated VGA adapter for example, as those use dirty page tracking to do
partial screen updates.

changelog:
v2:
 - Migration blocker when INVTSC is set (Thanks Paolo for pointing that out!)
 - Dirty page tracking fix (Thanks Roman for noticing the regression in
   observed behaviour on certain VMs, which led me to debugging this issue.)
 - vCPU handle type cleanup (Based on discussion with Paolo)
 - Added fixes for existing compile warnings.
 - Split patch series into 2 parts.

This work has been sponsored by Sauce Labs Inc.

Phil Dennis-Jordan (4):
  i386: hvf: Adds support for INVTSC cpuid bit
  hvf: Fixes some compilation warnings
  hvf: Consistent types for vCPU handles
  i386/hvf: Fixes dirty memory tracking by page granularity RX->RWX
    change

 accel/hvf/hvf-accel-ops.c    |  2 +-
 include/sysemu/hvf_int.h     |  4 +++-
 target/i386/hvf/hvf.c        | 23 +++++++++++++++++++++--
 target/i386/hvf/vmx.h        |  3 +--
 target/i386/hvf/x86_cpuid.c  |  4 ++++
 target/i386/hvf/x86_decode.c |  2 +-
 target/i386/hvf/x86_emu.c    |  4 ++--
 7 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.36.1


