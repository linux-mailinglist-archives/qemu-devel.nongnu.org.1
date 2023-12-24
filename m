Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C27C81D8A3
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Dec 2023 10:53:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHL9J-0001vW-5y; Sun, 24 Dec 2023 04:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rHL9G-0001ux-Uw; Sun, 24 Dec 2023 04:51:54 -0500
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shlomopongratz@gmail.com>)
 id 1rHL9F-0007fL-89; Sun, 24 Dec 2023 04:51:54 -0500
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-67f9f6caabcso16428326d6.3; 
 Sun, 24 Dec 2023 01:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703411511; x=1704016311; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qKHNuH5Dl7a0s1TCOHWTAXT20DObZ7tUiyc07JETu+8=;
 b=BNSZa5HjretXtge4L1gvTQFNSR3set5Z4WD9h/edr96W3W2zoxu53GD9dqnKR0FG4A
 89PDfuhtAiFsISZGN3Bn/EZnDs4C1Ci4gTuWxZLGGMlcUVeN2xCLmv1+HkV8q4nfVyci
 KKA5RaXIRpW/e9b2kElGnJ1mthVAu/Zm6HsrFMaltTGTlwFgEflIDTw/r0a9PCSBfOKw
 gwZO4WUNwRxbm2GsiFeGoEkBK91mN82C/EF05vsjYjBAl6LJzci+jQgmGdsCZAHzBti7
 cXa7pMTQjChwCkXlgNDLCe//rJB5ryWvYTV9inir64z8VzZAmzvYuF6MZ3YbSHkgGirf
 ULBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703411511; x=1704016311;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qKHNuH5Dl7a0s1TCOHWTAXT20DObZ7tUiyc07JETu+8=;
 b=i0BOWoNv0rgGLhdqYIKJGyA8FxQl3hhCaxDYzxOuLegxvnDECt51j2mQ12xmD14J3e
 +EAxNZXNItV+2D8suxvgWX7f8VZGcPHA2JXAtRjhG1lGfRQa3hzuZNmAZQwJs2+Gj8eR
 i7Hq7wLBNqZxKoPiOO6XDSAOBnMdcQh3DcVX24CX7UAPInS+ff1hSlU5S2fEKOlwXYHk
 9JdqIplGcl6neDz2y48E5W/yBYCw6GUk5aHWkN5MbB3KbgEB60EobqjiHfPPOLOCtUgl
 C4A+il1sVANkK9Uuvvt63myFoAwK84jzcbgGMgZJ1OaU002VsdJC0Xh6QgHBWyWxPtNJ
 cZng==
X-Gm-Message-State: AOJu0YyRuJALGxjQp/ssRk6yJfz1EAkwzO+37nEQMpxjZ3PFbzJHfVk0
 b3Ka/12agXKtVAMK9EkC+c8reQq7xtLYNRL+8pLBqeOY5Iw=
X-Google-Smtp-Source: AGHT+IHI+7Y0wv+UQJsrtE+NCJ0naEbTqYmvCYTv4gfK2S/2lEA52npw01IB2YFtGb+WFMQIMpVUlbR6E/GlxlofSrA=
X-Received: by 2002:ad4:5ca1:0:b0:67f:8bee:a19d with SMTP id
 q1-20020ad45ca1000000b0067f8beea19dmr7930096qvh.31.1703411510962; Sun, 24 Dec
 2023 01:51:50 -0800 (PST)
MIME-Version: 1.0
From: Shlomo Pongratz <shlomopongratz@gmail.com>
Date: Sun, 24 Dec 2023 11:51:39 +0200
Message-ID: <CAHzK-V1CDcpa5LQzfx8ppU0nZh01AyfPkB-xXQcPqXuue7BJvw@mail.gmail.com>
Subject: PCIe with Designware RC.
To: qemu-discuss <qemu-discuss@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=shlomopongratz@gmail.com; helo=mail-qv1-xf31.google.com
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

Hi,
I'm working on a AARCH64 project that uses the designeware
(hw/pci-host/designware.c).
I've copied the designware initialization from hw/arm/fsl-imx7.c and I
hope I've updated the dtsi correctly.
After fixing an issue with the iATU windows (see patch
https://lists.gnu.org/archive/html/qemu-devel/2023-12/msg02643.html)
I've tried to add virtualized NVMe controller.
When I added the lines:
        -device nvme,serial=deadbeef,drive=nvme0,bus=pcie \  (Or without bus=)
        -drive file=/home/pliops/disk-1.img,if=none,id=nvme1 \
I could see in QEMU monitor that the NVMe device was preset i.e.
(qemu) info pci
  Bus  0, device   0, function 0:
    PCI bridge: PCI device 16c3:abcd
      IRQ 0, pin A
      BUS 0.
      secondary bus 1.
      subordinate bus 255.
      IO range [0xf000, 0x0fff]
      memory range [0xfff00000, 0x000fffff]
      prefetchable memory range [0xfff00000, 0x000fffff]
      id ""
  Bus  0, device   1, function 0:
    Class 0264: PCI device 1b36:0010
      PCI subsystem 1af4:1100
      IRQ 0, pin A
      BAR0: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
      id ""
However in lspci it was missing
# lspci
00:00.0 Class 0604: 16c3:abcd

If I used the following command
        -drive file=/home/pliops/disk.img,if=none,id=nvme0 \
        -device nvme,serial=deadbeef,drive=nvme0,bus=dw-pcie \
Then in the monitor I see:
(qemu) info pci
  Bus  0, device   0, function 0:
    PCI bridge: PCI device 16c3:abcd
      IRQ 0, pin A
      BUS 0.
      secondary bus 1.
      subordinate bus 255.
      IO range [0xf000, 0x0fff]
      memory range [0x40000000, 0x401fffff]
      prefetchable memory range [0xfff00000, 0x000fffff]
      id ""
  Bus  1, device   0, function 0:
    Class 0264: PCI device 1b36:0010
      PCI subsystem 1af4:1100
      IRQ 1, pin A
      BAR0: 64 bit memory at 0xffffffffffffffff [0x00003ffe].
      id ""
That is the NVMe is on BUS 1.
And in lspci I can now see the device but on bus 1.
# lspci
01:00.0 Class 0108: 1b36:0010
00:00.0 Class 0604: 16c3:abcd

Is this expected?

But the main problem is that during the initialization of the
controller registers in BAR0 all the read and writes are actually done
into the config space.

Any ideas?

Thank you
Shlomo Pongratz.

