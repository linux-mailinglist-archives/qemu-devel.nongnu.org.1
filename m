Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1214E82EB27
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 09:51:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPf9I-0007yy-Ma; Tue, 16 Jan 2024 03:50:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezengruan@huawei.com>)
 id 1rPf9C-0007yP-Pe; Tue, 16 Jan 2024 03:50:14 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezengruan@huawei.com>)
 id 1rPf9A-0008TL-DS; Tue, 16 Jan 2024 03:50:14 -0500
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TDjNV5lTFzWmYZ;
 Tue, 16 Jan 2024 16:48:58 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
 by mail.maildlp.com (Postfix) with ESMTPS id ECFEA180071;
 Tue, 16 Jan 2024 16:49:58 +0800 (CST)
Received: from [10.174.185.33] (10.174.185.33) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 16 Jan 2024 16:49:58 +0800
To: <qemu-devel@nongnu.org>, <qemu-stable@nongnu.org>, <qemu-arm@nongnu.org>
CC: yuzenghui <yuzenghui@huawei.com>
Subject: [Qemu-arm] Windows11 guest Fast startup cannot work
Message-ID: <6dad82d6-2722-3a07-03ee-6dea6d74ba47@huawei.com>
Date: Tue, 16 Jan 2024 16:49:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.185.33]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500001.china.huawei.com (7.192.104.163)
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=yezengruan@huawei.com; helo=szxga02-in.huawei.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=1.999 autolearn=ham autolearn_force=no
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
Reply-to:  yezengruan <yezengruan@huawei.com>
From:  yezengruan via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi,

I want to improve the startup speed of Windows VM. On the x86 
architecture, QEMU's Windows11 VM can enable the Fast startup function, 
but it cannot work on the ARM architecture. By the way, the Fast startup 
function of Windows on ARM physical machines can work normally.

Is there anything missing in QEMU's ARM architecture for Windows guest?

My environmental information:
Linux 5.10
QEMU 6.2.0
Guest: Windows11 ARM

QEMU command line:
qemu-system-aarch64 -nodefaults -machine 
virt,kernel-irqchip=on,virtualization=off,gic-version=3,its=off -accel 
kvm -cpu host -m 6144 -smp 6 -bios 
/usr/share/edk2/aarch64/QEMU_EFI-pflash.raw -drive 
if=none,id=system,format=qcow2,file=/data/images/win11_disk.qcow2 
-device virtio-blk-pci,drive=system -device 
nec-usb-xhci,msix=off,msi=off -device usb-kbd -device usb-tablet -device 
ramfb -display gtk -name Windows -qmp unix:/tmp/qmp.socket,server,nowait 
-d all -D /tmp/qemu.log -msg timestamp=on

Refer to the Fast startup link below:
https://learn.microsoft.com/en-us/windows-hardware/test/weg/delivering-a-great-startup-and-shutdown-experience

Thank you.
Zengruan Ye


