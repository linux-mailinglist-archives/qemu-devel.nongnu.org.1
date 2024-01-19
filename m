Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 939678329CA
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 13:57:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQoPW-0005Xz-25; Fri, 19 Jan 2024 07:55:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQoPR-0005Uc-L5
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:55:46 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQoPO-00069u-AG
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 07:55:44 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-55a064e54a7so1389533a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 04:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705668940; x=1706273740; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UUp6XHOe5NjO/w1VOs0GzPXzwC8wYapn1Sl/UgtrtBQ=;
 b=XUbl5+NYz4HNzdg/qJJjwWTSbZso+nhnLeP4qoADWpCQFUXzDcP58tfry6QCUmX3rY
 20NYEBuToSlyz6cTgIhFnELHYlzO6xjqC+uwYdSHL1mFhwHpFuG8arx6Vmn6JKajFSP9
 QxOc6dsCuIjLt2ha4yU77yXXRpbtcR8p6uMyVjfOvY3ePgtiCbPHEy6UHMa2E2RkPC30
 o8ul1Mgbh0GS1IJVNc+Ukpi/qEkeNE1dSX2QThRJE5rF0hN7RtYIep9Zrcis4iiClRxd
 gJoPCySfXRw6ezU5BH9ZpmkRhE3P+zG07l1G1usknYbaiGr7ebv2ShOPNZyWx1GIvPqY
 E1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705668940; x=1706273740;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UUp6XHOe5NjO/w1VOs0GzPXzwC8wYapn1Sl/UgtrtBQ=;
 b=bKj4Wfu/tTQ9rUQtUNIrPCs/tPxrcOp7CB7Injq7dR744AC7DP/j9Nsfp/L3PkYCUq
 BhE7G6U67DGcLW1gquupU4ql1FZDMgTytG6XFU2Si6GEl6myw4ayFvRYLbsYhAruH3KP
 BN8cGKgpVwWjIoTsChI9zbR4lY1tD/ngoaN1mwqHcGXwbVefjmj3pfFQVX303UUWZtOG
 DlOauA/DVFtuGxNxmwjFuMF/N8u/zgtcFwzetFJ2j0G/ufWijZYmonNBUgAi+HIyncxx
 Kzf+y8E0e6BOMIbguJHg+mtCuNYABR+mHjXlXPWLkXeRUHERCsI/F4F4J1yrBvce/mnB
 ZpqQ==
X-Gm-Message-State: AOJu0Yz1clqQ7Ho3rMlnx5nv3/L3Y68YLJqXFZQheoMgPGP+WOGpcedE
 t/ahRLQ0L2+pn4Hal/3OQmWyQvI4jSpIhkoG7Zl5z2e0dvcK1xXNvddJgCBaNbH7+Phq976IxJC
 WGZIHGxiHXYI2Yk0RT9kGhlYXLr66eAKtR7VpFVZ+3XEZ2APB
X-Google-Smtp-Source: AGHT+IEIh1Ry7F0I1xU2oyfm99ghT0gBKUaAXkfbbEjpmQIOjIuErh0L23R/cSVTKZuin8qKEVJSPv21JTx7srdmmls=
X-Received: by 2002:a05:6402:1ca8:b0:55a:ea3:9c02 with SMTP id
 cz8-20020a0564021ca800b0055a0ea39c02mr1042004edb.18.1705668940324; Fri, 19
 Jan 2024 04:55:40 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 12:55:29 +0000
Message-ID: <CAFEAcA_7s=scvgYfG8kGmJ==5cKmvvA-ZqVkpt4M9jV6eS1Zow@mail.gmail.com>
Subject: how do the iotests pick a machine model to run on ?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

If you build QEMU with support for the sh4 target only
(configure --target-list=sh4-softmmu) then 'make check' fails
in the iotests, because some iotests, including for instance 040,
try to create a machine with a virtio-scsi device, but they don't
do anything to ensure that the machine they create actually
has a PCI bus to plug the virtio-scsi device into, and so the test
fails:

+Traceback (most recent call last):
+  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/qemu-iotests/040",
line 94, in setUp
+    self.vm.launch()
+  File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/python/qemu/machine/machine.py",
line 455, in launch
+    raise VMLaunchFailure(
+qemu.machine.machine.VMLaunchFailure: ConnectError: Failed to
establish session: EOFError
+       Exit code: 1
+       Command:
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/sh4/qemu-system-sh4
-display none -vga none -chardev socket,id=mon,fd=5 -mon
chardev=mon,mode=control -chardev socket,id=qtest,fd=3 -qtest
chardev:qtest -accel qtest -nodefaults -display none -accel qtest
-drive if=none,id=drive0,file=/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/sh4/scratch/qcow2-file-040/test.img,format=qcow2,cache=writeback,aio=threads,node-name=top,backing.node-name=mid,backing.backing.node-name=base
-device virtio-scsi -device scsi-hd,id=scsi0,drive=drive0
+       Output: [I 0.000000] OPENED
+qemu-system-sh4: -device virtio-scsi: No 'PCI' bus found for device
'virtio-scsi-pci'

(It happens that the default machine type for 'sh4'
does not have a PCI bus.)

How are the iotests supposed to select a machine model to run
on, and how are they intended to mark themselves as requiring
particular facilities, like PCI? Presumably some of the tests
are missing the appropriate annotations to ensure they're
skipped when the facilities required aren't present.

thanks
-- PMM

