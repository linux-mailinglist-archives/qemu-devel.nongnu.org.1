Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEC9709A7C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 16:52:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01RL-0008R7-Qt; Fri, 19 May 2023 10:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liavalb@gmail.com>) id 1q01RE-0008FM-RB
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:36 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liavalb@gmail.com>) id 1q01RC-0003YP-VM
 for qemu-devel@nongnu.org; Fri, 19 May 2023 10:50:36 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f42ba32e24so21471655e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684507833; x=1687099833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+UqaBf/3EWEVcRHfzI/IWSrk5fsp7AYGXW0lMDUp6Sw=;
 b=UPjECYaRYkpfzAQCNSPFJ8bPrxyxyJG+5gFR7p/DA8aEMxTPgL5JoXw4+m4yy4EnUq
 hh8wZmLt3rOZNrGpMOIET2piJEjoM7wZYkTfQj5Dp//sEGBZtBDgZFpHdd4r4l3G/AUV
 vJGH7tBzANh9uZecOKbDKR9G979fwmK+w7vJdXIwsdCFC6z4F4vwr27D8IsCwU0eXfNd
 HURO8Lo16m6YTJSS5yx0g/BK01tuwbPctxRAMaeFkxqY+mg8sYfjweaSpadrsB/1/ZNB
 6y3MM0Tes8WyLDkWY+0S4sNVAgU/4wpKZzkkOg88/QGVBjJh1olG1FcZ6/a5M90uZ4xO
 FThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684507833; x=1687099833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+UqaBf/3EWEVcRHfzI/IWSrk5fsp7AYGXW0lMDUp6Sw=;
 b=QUs6V5LN6hTYBQOruSztfzswHyJRcmaJkBVqNiwKwneczjj/jHyho73FVOwbAQks2D
 siv+4T5+fvGAuLziEE9+08FaM1C0IY+cyPBYu5nW3qJaU4Iqku1fE736Z67o+H3D9PY6
 s9zXKOJxEB0H20cP9pfhwSaS4nhciz3QAnc1pbPHwotzb1bZvaTS21jncy/BzW9DiV6J
 hyC+xU/ll6uVlUFErgfTKSDvYqLQQZMlh0DHiGucKl8wATjYMX6u1O5ZIf9CHTZS+raW
 kzcj1D+uhVNvRrCxGDSxR2dpjJQ6+kS6bj/jTyzi+yobZoWuuvoqwHPdv63SVLhVc5qr
 RUjQ==
X-Gm-Message-State: AC+VfDxHx7rVVbD1uZtDKuxIXtvsi/w7R6z4GsY8yzwfTUnKvZX5zyf3
 9wlvULDzinRxkrcYQYYsH61Yts6cHuw=
X-Google-Smtp-Source: ACHHUZ7z5L/ysQFV/WpxyDOm4Q3rxgJAtwjsIrQl8r/Q0sDBZQu1OvKzB+a4RtJ9VosUnNRKZ/SHfA==
X-Received: by 2002:a05:600c:2150:b0:3f5:d0ba:3c1a with SMTP id
 v16-20020a05600c215000b003f5d0ba3c1amr1435381wml.4.1684507832539; 
 Fri, 19 May 2023 07:50:32 -0700 (PDT)
Received: from liavpc.localdomain ([2a06:c701:433c:c01:70:9d02:6925:e2f7])
 by smtp.gmail.com with ESMTPSA id
 x6-20020a05600c21c600b003f4fbd9cdb3sm2623534wmj.34.2023.05.19.07.50.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 07:50:32 -0700 (PDT)
From: Liav Albani <liavalb@gmail.com>
To: qemu-devel@nongnu.org
Cc: Liav Albani <liavalb@gmail.com>
Subject: [RFC 0/1] hw/input: add basic support for a PCI PS/2 controller
Date: Fri, 19 May 2023 17:50:25 +0300
Message-Id: <20230519145026.235592-1-liavalb@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=liavalb@gmail.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This small patch I wrote might raise few questions on the motivation to
why someone would write such thing like this - I'll try my best to be
descriptive about this.

I am SerenityOS developer. In that project I mainly work on kernel stuff
for the most part.
Recently I started to fix issues with the HID code in the SerenityOS
kernel and I stumbled upon fixing some issues with our PS/2 abstractions
in relation to hardware implementations (such as the i8042) and the rest
of the HID subsystem. I figured that it would be nice that with strong
abstractions in place that I could write more drivers for other PS2
serial IO controllers.

That's where I started to look into the Linux source code and I found
that sometime in the past, someone wrote a driver for PS/2 controller,
which is connected over the PCI bus. This driver is called pcips2 and
almost nobody touched it since its initial write in 2003 (by now it's 20
years old, so getting hardware to test it might be even harder today!).

Therefore, my goal was to see if I could actually use that driver, and
so I wrote this small patch for letting QEMU to emulate that very old
PS/2 PCI card. If this ever goes into the tree, a SerenityOS kernel
driver could be written too, and will probably be used someday in our
upcoming aarch64 port (probably for the virt machine as it supports the
PCI bus).

As for what it gives, keyboard works perfectly fine. I had some struggle
with interrupts initially (mainly getting "bogus" interrupts).
As for the mouse support - I tried to boot Manjaro live-CD on QEMU with
either both of the "pci-ps2-keyboard" and "pci-ps2-mouse" devices and
also with only "pci-ps2-mouse" - both options resulted in a kernel panic
a few seconds after booting. The panic seemed to be some sort of nullptr
dereference in the linux PS/2 core code, which I still need to debug.

In general, this potentially could benefit multiple projects, which is
the best case I'd imagine - more emulation options for QEMU, more
drivers for SerenityOS, and maybe even fixing issues in PS/2 core (in
Linux) and improving the pcips2 driver code in Linux as well.

Liav Albani (1):
  hw/input: add basic support for a PCI PS/2 controller

 hw/i386/Kconfig           |   1 +
 hw/input/Kconfig          |   5 +
 hw/input/meson.build      |   2 +
 hw/input/ps2pci.c         | 282 ++++++++++++++++++++++++++++++++++++++
 include/hw/input/ps2pci.h |  52 +++++++
 5 files changed, 342 insertions(+)
 create mode 100644 hw/input/ps2pci.c
 create mode 100644 include/hw/input/ps2pci.h

-- 
2.40.1


