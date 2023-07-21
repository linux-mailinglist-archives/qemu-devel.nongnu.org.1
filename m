Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96E75C2EB
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 11:22:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMmKl-0000Ud-Jf; Fri, 21 Jul 2023 05:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qMmKj-0000UV-I2
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:21:57 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qMmKf-0000zh-Vq
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 05:21:57 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxnuslTrpk8vUHAA--.18005S3;
 Fri, 21 Jul 2023 17:21:42 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxB80lTrpkSBE2AA--.10610S3; 
 Fri, 21 Jul 2023 17:21:41 +0800 (CST)
To: qemu-devel@nongnu.org
From: lixianglai <lixianglai@loongson.cn>
Subject: [BUG][CPU hot-plug]CPU hot-plugs cause the qemu process to coredump
Message-ID: <f3cd66ab-9680-0873-8f2c-9893a91c59fa@loongson.cn>
Date: Fri, 21 Jul 2023 17:20:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxB80lTrpkSBE2AA--.10610S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Xr18Kw48ArWrJryxCr47Jrc_yoWkJFg_Wr
 1vyF98Xr48Ja42vF1jyw15Aws3WF1akFZYqw4fXwsF93WxGrZ8XFykAr1qqr17trn7KrnI
 qwnrJ3Zxua129osvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzsqW
 UUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello,Recently, when I was developing CPU hot-plugs under the loongarch 
architecture,

I found that there was a problem with qemu cpu hot-plugs under x86 
architecture,

which caused the qemu process coredump when repeatedly inserting and 
unplugging

the CPU when the TCG was accelerated.


The specific operation process is as follows:

1.Use the following command to start the virtual machine

qemu-system-x86_64 \
-machine q35  \
-cpu Broadwell-IBRS \
-smp 1,maxcpus=4,sockets=4,cores=1,threads=1 \
-m 4G \
-drive file=~/anolis-8.8.qcow2  \
-serial stdio   \
-monitor telnet:localhost:4498,server,nowait


2.Enter QEMU Monitor via telnet for repeated CPU insertion and unplugging

telnet 127.0.0.1 4498

(qemu) device_add 
Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1

(qemu) device_del cpu1
(qemu) device_add 
Broadwell-IBRS-x86_64-cpu,socket-id=1,core-id=0,thread-id=0,id=cpu1


3.You will notice that the QEMU process has a coredump

# malloc(): unsorted double linked list corrupted
Aborted (core dumped)


