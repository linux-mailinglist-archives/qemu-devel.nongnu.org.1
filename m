Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9714C971C63
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Sep 2024 16:22:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfHj-0002uo-3x; Mon, 09 Sep 2024 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhou1@hisilicon.com>)
 id 1snfHf-0002nF-Uf; Mon, 09 Sep 2024 10:22:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangzhou1@hisilicon.com>)
 id 1snfHd-000471-TL; Mon, 09 Sep 2024 10:22:27 -0400
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X2TY26l7gz2Dbwl;
 Mon,  9 Sep 2024 22:21:42 +0800 (CST)
Received: from kwepemd200012.china.huawei.com (unknown [7.221.188.145])
 by mail.maildlp.com (Postfix) with ESMTPS id DF2E41400DC;
 Mon,  9 Sep 2024 22:22:09 +0800 (CST)
Received: from [10.67.121.115] (10.67.121.115) by
 kwepemd200012.china.huawei.com (7.221.188.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 9 Sep 2024 22:22:09 +0800
Message-ID: <447984db-8c52-c911-d7bd-6616edaaefa5@hisilicon.com>
Date: Mon, 9 Sep 2024 22:22:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
Subject: [Bug Report] smmuv3 event 0x10 report when running virtio-blk-pci
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.115]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200012.china.huawei.com (7.221.188.145)
Received-SPF: pass client-ip=45.249.212.190;
 envelope-from=wangzhou1@hisilicon.com; helo=szxga04-in.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Zhou Wang <wangzhou1@hisilicon.com>
From:  Zhou Wang via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi All,

When I tested mainline qemu(commit 7b87a25f49), it reports smmuv3 event 0x10
during kernel booting up.

qemu command which I use is as below:

qemu-system-aarch64 -machine virt,kernel_irqchip=on,gic-version=3,iommu=smmuv3 \
-kernel Image -initrd minifs.cpio.gz \
-enable-kvm -net none -nographic -m 3G -smp 6 -cpu host \
-append 'rdinit=init console=ttyAMA0 ealycon=pl0ll,0x90000000 maxcpus=3' \
-device pcie-root-port,port=0x8,chassis=0,id=pci.0,bus=pcie.0,multifunction=on,addr=0x2 \
-device pcie-root-port,port=0x9,chassis=1,id=pci.1,bus=pcie.0,addr=0x2.0x1 \
-device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=8,packed=on,bus=pci.1 \
-drive file=/home/boot.img,if=none,id=drive0,format=raw

smmuv3 event 0x10 log:
[...]
[    1.962656] virtio-pci 0000:02:00.0: Adding to iommu group 0
[    1.963150] virtio-pci 0000:02:00.0: enabling device (0000 -> 0002)
[    1.964707] virtio_blk virtio0: 6/0/0 default/read/poll queues
[    1.965759] virtio_blk virtio0: [vda] 2097152 512-byte logical blocks (1.07 GB/1.00 GiB)
[    1.966934] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
[    1.967442] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[    1.967478] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
[    1.968381] clk: Disabling unused clocks
[    1.968677] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
[    1.968990] PM: genpd: Disabling unused power domains
[    1.969424] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
[    1.969814] ALSA device list:
[    1.970240] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
[    1.970471]   No soundcards found.
[    1.970902] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
[    1.971600] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
[    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
[    1.971601] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
[    1.971602] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
[    1.971606] arm-smmu-v3 9050000.smmuv3: event 0x10 received:
[    1.971607] arm-smmu-v3 9050000.smmuv3:      0x0000020000000010
[    1.974202] arm-smmu-v3 9050000.smmuv3:      0x0000020000000000
[    1.974634] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
[    1.975005] Freeing unused kernel memory: 10112K
[    1.975062] arm-smmu-v3 9050000.smmuv3:      0x0000000000000000
[    1.975442] Run init as init process

Another information is that if "maxcpus=3" is removed from the kernel command line,
it will be OK.

I am not sure if there is a bug about vsmmu. It will be very appreciated if anyone
know this issue or can take a look at it.

Thanks,
Zhou



