Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7269E710C98
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 14:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2AWM-0002y7-Aj; Thu, 25 May 2023 08:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q2AWI-0002xg-Hv
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:56:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q2AWF-0004YO-8D
 for qemu-devel@nongnu.org; Thu, 25 May 2023 08:56:42 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Cx6fEBW29k1P8AAA--.2669S3;
 Thu, 25 May 2023 20:56:33 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxLL4BW29kZ4V3AA--.841S3; 
 Thu, 25 May 2023 20:56:33 +0800 (CST)
Subject: Re: [PATCH 4/5] hw/loongarch64: Use MachineClass->default_nic in the
 virt machine
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Max Filippov <jcmvbkbc@gmail.com>,
 Jason Wang <jasowang@redhat.com>
References: <20230523110435.1375774-1-thuth@redhat.com>
 <20230523110435.1375774-5-thuth@redhat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <cfabe205-fac7-1f94-af94-006b0c8545e5@loongson.cn>
Date: Thu, 25 May 2023 20:56:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230523110435.1375774-5-thuth@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxLL4BW29kZ4V3AA--.841S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7Kw48Zr4ftF1DuryDCF1ftFb_yoW8AF4kpF
 W5uF1kAFZ3XrWkJas7Z3s8Xr1rArs293yS9F17tr10ka4Durn8Wr48J3s0qFWqya93XF18
 Zr9Yk342qF1S9rJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
 8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
 IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4U
 McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcV
 C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8PCzJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/5/23 ÏÂÎç7:04, Thomas Huth Ð´µÀ:
> Mark the default NIC via the new MachineClass->default_nic setting
> so that the machine-defaults code in vl.c can decide whether the
> default NIC is usable or not (for example when compiling with the
> "--without-default-devices" configure switch).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/loongarch/virt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 2b7588e32a..ceddec1b23 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -474,6 +474,7 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
>   
>   static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *lams)
>   {
> +    MachineClass *mc = MACHINE_GET_CLASS(lams);
>       DeviceState *gpex_dev;
>       SysBusDevice *d;
>       PCIBus *pci_bus;
> @@ -528,7 +529,7 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
>           NICInfo *nd = &nd_table[i];
>   
>           if (!nd->model) {
> -            nd->model = g_strdup("virtio");
> +            nd->model = g_strdup(mc->default_nic);
>           }
>   
>           pci_nic_init_nofail(nd, pci_bus, nd->model, NULL);
> @@ -1038,6 +1039,7 @@ static void loongarch_class_init(ObjectClass *oc, void *data)
>       mc->default_boot_order = "c";
>       mc->no_cdrom = 1;
>       mc->get_hotplug_handler = virt_machine_get_hotplug_handler;
> +    mc->default_nic = "virtio-net-pci";
>       hc->plug = loongarch_machine_device_plug_cb;
>       hc->pre_plug = virt_machine_device_pre_plug;
>       hc->unplug_request = virt_machine_device_unplug_request;


