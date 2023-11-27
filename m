Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFADE7F98A5
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 06:23:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7U3z-0004Px-1J; Mon, 27 Nov 2023 00:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U3x-0004P0-Kk
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:21:41 -0500
Received: from mail-yw1-x1144.google.com ([2607:f8b0:4864:20::1144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1r7U3u-00088h-I6
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 00:21:41 -0500
Received: by mail-yw1-x1144.google.com with SMTP id
 00721157ae682-5cc77e23218so38429827b3.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 21:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701062497; x=1701667297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RGFfa20gk+QsHh7ANQA9yzi8KfeAkApV0Viyv+XyN+Q=;
 b=yrxkrxQQuZPmX4aJI4kbRq++RVeXBcAb3v1XmGXj1RVBAwucFnYFDXPBjt4w9YBcUv
 Dk68203IcVt6dtdGJGJwPSnk7aJnrbXKqiHYeG2sMWuPcZSq6WeT3GuDYtqxi0RssX69
 /SDkD745VC/yyub2EVqK9KnYamsYv+w2aWQio4ASH5FuAYqTeIhd+FiSB5TCDV9mkuhz
 rSl3aYK8ECGVOlp0+DGtQixz50AbuYUzQitqXqefJ+8BQV1muJZ2HSYfe0E0KqOfZCYj
 HSrJbylCUn00nnxl/3MzJGpPGvdhhm97bdjhSCWp7wEHxLlcL2tJAqe0tn/67i9U1k60
 w8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701062497; x=1701667297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RGFfa20gk+QsHh7ANQA9yzi8KfeAkApV0Viyv+XyN+Q=;
 b=UFVduuLloQnikgIX15ucIs2EilBiECppZNk3lBq1jmTZvXF21D47L1TFONPMysuk27
 UmmKjq+BmIkomZBLQCLCu8qt8ZHX94srHwzirhgu+CmvKK7kwEK6J9xCrsqiX6OlYAnN
 NbIR+lpdKbKPRCVQLoIPmDwHqHIDH17fjcChbTjD2OWEklwz+SKQhVHbRacnM+WGG0tS
 U0RqdmG8GP96QnQdEg/B5Y0DW3+V1UBGtCErWSi1e9+pV9uJ+DItsIA5TPY4PxQlPBZU
 BYdS5mJs+4pcMSUg493V6v3P4Vi9X6ibG8CCIKdJ/FnYm02kgDmyN7Ofn3dQn3k7zLSr
 lP4Q==
X-Gm-Message-State: AOJu0YzIAf3aAxw3zv+l1FOWz5rIHCg+9NQ0PEpWp/QKZC3NCQG3e/Rh
 B7v7fCbWhX8kCCWnKW5mvPGoBoOv/oYknyMWZyYJ1mNxk+8=
X-Google-Smtp-Source: AGHT+IEtTR3m51Q7WdaPM+DxmekMn2vFHCgziJECVPNVIYSwAKp3yXUDouclFflgrIZsHF084tyF7w==
X-Received: by 2002:a0d:eb44:0:b0:5a7:dad7:61dd with SMTP id
 u65-20020a0deb44000000b005a7dad761ddmr6050586ywe.20.1701062496757; 
 Sun, 26 Nov 2023 21:21:36 -0800 (PST)
Received: from amd.. ([2804:7f0:b402:7782:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 v13-20020aa7808d000000b006cb9f436232sm6392316pff.114.2023.11.26.21.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Nov 2023 21:21:36 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, philmd@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: thuth@redhat.com,
	gustavo.romero@linaro.org
Subject: [PATCH 0/4] Add ivshmem-flat device
Date: Mon, 27 Nov 2023 05:20:20 +0000
Message-Id: <20231127052024.435743-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1144;
 envelope-from=gustavo.romero@linaro.org; helo=mail-yw1-x1144.google.com
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

This patchset introduces a new device, ivshmem-flat, which is similar to the
current ivshmem device but does not require a PCI bus. It implements the ivshmem
status and control registers as MMRs and the shared memory as a directly
accessible memory region in the VM memory layout. It's meant to be used on
machines like those with Cortex-M MCUs, which usually lack a PCI bus, e.g.,
lm3s6965evb and mps2-an385. Additionally, it has the benefit of requiring a tiny
'device driver,' which is helpful on some RTOSes, like Zephyr, that run on
memory-constrained resource targets.

The patchset includes a QTest for the ivshmem-flat device, however, it's also
possible to experiment with it in two ways:

(a) using two Cortex-M VMs running Zephyr; or
(b) using one aarch64 VM running Linux with the ivshmem PCI device and another
    arm (Cortex-M) VM running Zephyr with the new ivshmem-flat device.

Please note that for running the ivshmem-flat QTests the following patch, which
is not committed to the tree yet, must be applied:

https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03176.html

--

To experiment with (a), clone this Zephyr repo [0], set the Zephyr build
environment [1], and follow the instructions in the 'ivshmem' sample main.c [2].

[0] https://github.com/gromero/zephyr/tree/ivshmem
[1] https://docs.zephyrproject.org/latest/develop/getting_started/index.html
[2] https://github.com/gromero/zephyr/commit/73fbd481e352b25ae5483ba5048a2182b90b7f00#diff-16fa1f481a49b995d0d1a62da37b9f33033f5ee477035e73465e7208521ddbe0R9-R70

To experiment with (b):

$ git clone -b uio_ivshmem --single-branch https://github.com/gromero/linux.git
$ cd linux
$ wget https://people.linaro.org/~gustavo.romero/ivshmem/arm64_uio_ivshmem.config -O .config

If in an x86_64 machine, cross compile the kernel, for instance:

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 36

Install image in some directory, let's say, in ~/linux:

$ mkdir ~/linux
$ export INSTALL_PATH=~/linux
$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j 36 install

or, if you prefer, download the compiled image from:

$ wget https://people.linaro.org/~gustavo.romero/ivshmem/vmlinuz-6.6.0-rc1-g28f3f88ee261

... and then the rootfs:

$ wget https://people.linaro.org/~gustavo.romero/ivshmem/rootfs.qcow2

Now, build QEMU with this patchset applied:

$ mkdir build && cd build
$ ../configure --target-list=arm-softmmu,aarch64-softmmu
$ make -j 36

Start the ivshmem server:

$ contrib/ivshmem-server/ivshmem-server -F

Start the aarch64 VM + Linux + ivshmem PCI device:

$ ./qemu-system-aarch64 -kernel ~/linux/vmlinuz-6.6.0-rc1-g28f3f88ee261 -append "root=/dev/vda initrd=/bin/bash console=ttyAMA0,115200" -drive file=~/linux/rootfs.qcow2,media=disk,if=virtio -machine virt-6.2 -nographic -accel tcg -cpu cortex-a57 -m 8192 -netdev bridge,id=hostnet0,br=virbr0,helper=/usr/lib/qemu/qemu-bridge-helper -device pcie-root-port,port=8,chassis=1,id=pci.1,bus=pcie.0,multifunction=on,addr=0x1 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=52:54:00:d9:d1:12,bus=pci.1,addr=0x0 -device ivshmem-doorbell,vectors=2,chardev=ivshmem -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem

Log into the VM with user/pass: root/abc123

# dmesg | grep uio

should show:

[    2.656367] uio_ivshmem 0000:00:02.0: ivshmem-mmr at 0x0000000010203000, size 0x0000000000001000
[    2.656931] uio_ivshmem 0000:00:02.0: ivshmem-shmem at 0x0000008000000000, size 0x0000000000400000
[    2.662554] uio_ivshmem 0000:00:02.0: module successfully loaded

In another console, clone and build Zephyr image from 'uio_ivhsmem' branch:

$ git clone -b uio_ivshmem --single-branch https://github.com/gromero/zephyr
$ west -v --verbose build -p always -b qemu_cortex_m3 ./samples/uio_ivshmem/

... and then start the arm VM + Zephyr image + ivshmem-flat device:

$ ./qemu-system-arm -machine lm3s6965evb -nographic -net none -chardev socket,path=/tmp/ivshmem_socket,id=ivshmem_flat -device ivshmem-flat,chardev=ivshmem_flat,x-irq-qompath='/machine/unattached/device[1]/nvic/unnamed-gpio-in[0]',x-bus-qompath='/sysbus' -kernel ~/zephyrproject/zephyr/build/qemu_cortex_m3/uio_ivshmem/zephyr/zephyr.elf

You should see something like:

*** Booting Zephyr OS build zephyr-v3.3.0-8350-gfb003e583600 ***
*** Board: qemu_cortex_m3
*** Installing direct IRQ handler for external IRQ0 (Exception #16)...
*** Enabling IRQ0 in the NVIC logic...
*** Received IVSHMEM PEER ID: 7
*** Waiting notification from peers to start...

Now, from the Linux terminal, notify the arm VM (use the "IVSHMEM PEER ID"
reported by Zephyr as the third arg, in this example: 7):

# ./zephyr_ivshmem_test /dev/uio0 7
MMRs mapped at 0xffff8fb28000 in VMA.
shmem mapped at 0xffff8f728000 in VMA.
mmr0: 0 0
mmr1: 0 0
mmr2: 6 6
mmr3: 0 0
Data ok. 4194304 byte(s) checked.
#

The arm VM should report something like:

*** Got interrupt at vector 0!
*** Writting constant 0xb5b5b5b5 to shmem... done!
*** Notifying back peer ID 6 at vector 0...


Cheers,
Gustavo


Gustavo Romero (4):
  Add ivshmem-flat device
  tests/qtest: Reorganize common code in ivshmem-test
  tests/qtest: Add ivshmem-flat test
  hw/misc/ivshmem: Rename ivshmem to ivshmem-pci

 docs/system/devices/ivshmem-flat.rst |  89 +++++
 hw/arm/mps2.c                        |   2 +
 hw/arm/stellaris.c                   |   5 +-
 hw/arm/virt.c                        |   2 +
 hw/core/sysbus-fdt.c                 |   1 +
 hw/misc/Kconfig                      |   5 +
 hw/misc/ivshmem-flat.c               | 477 +++++++++++++++++++++++++++
 hw/misc/{ivshmem.c => ivshmem-pci.c} |   0
 hw/misc/meson.build                  |   4 +-
 hw/misc/trace-events                 |  18 +
 include/hw/misc/ivshmem-flat.h       |  72 ++++
 tests/qtest/ivshmem-flat-test.c      | 319 ++++++++++++++++++
 tests/qtest/ivshmem-test.c           | 113 +------
 tests/qtest/ivshmem-utils.c          | 155 +++++++++
 tests/qtest/ivshmem-utils.h          |  56 ++++
 tests/qtest/meson.build              |   8 +-
 16 files changed, 1215 insertions(+), 111 deletions(-)
 create mode 100644 docs/system/devices/ivshmem-flat.rst
 create mode 100644 hw/misc/ivshmem-flat.c
 rename hw/misc/{ivshmem.c => ivshmem-pci.c} (100%)
 create mode 100644 include/hw/misc/ivshmem-flat.h
 create mode 100644 tests/qtest/ivshmem-flat-test.c
 create mode 100644 tests/qtest/ivshmem-utils.c
 create mode 100644 tests/qtest/ivshmem-utils.h

-- 
2.34.1


