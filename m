Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD548CBC87
	for <lists+qemu-devel@lfdr.de>; Wed, 22 May 2024 10:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9gsg-0006mN-OY; Wed, 22 May 2024 03:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1s9gse-0006mA-8v
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:59:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1s9gsb-0006mE-F3
 for qemu-devel@nongnu.org; Wed, 22 May 2024 03:59:24 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxKOrVpU1mTpYCAA--.2059S3;
 Wed, 22 May 2024 15:59:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxjsfSpU1mjkYFAA--.15141S3; 
 Wed, 22 May 2024 15:59:16 +0800 (CST)
Subject: Re: [PATCH v3 0/6] hw/loongarch: Refine numa memory map
To: Bibo Mao <maobibo@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240515093927.3453674-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <268a7cf4-f651-a325-5757-566770605575@loongson.cn>
Date: Wed, 22 May 2024 15:59:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240515093927.3453674-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxjsfSpU1mjkYFAA--.15141S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF45JFWktrWDGFW5AF1fuFX_yoW8Xw4kp3
 yfZF13Kr4rKF9xJr1fA3srWr13tr1xK3ZrWFyakrykCr47Cry8ur1Iya4qvFyDJ348Jr1j
 93W8twnxWa18J3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
 38nUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2024/5/15 下午5:39, Bibo Mao 写道:
> One LoongArch virt machine platform, there is limitation for memory
> map information. The minimum memory size is 256M and minimum memory
> size for numa node0 is 256M also. With qemu numa qtest, it is possible
> that memory size of numa node0 is 128M.
>
> Limitations for minimum memory size for both total memory and numa
> node0 is removed here, including acpi srat table, fadt memory map table
> and fw_cfg memory map table.
>
> Also remove numa node about memory region, there is only low memory
> region and how memory region.
>
> ---
> v2 ... v3:
>    1. Modify numa test case for loongarch system.
>    2. Rebase the patch based on the latest version.
>
> v1 ... v2:
>    1. Refresh the patch based on the latest qemu version, solve the
> confliction issue.
>    2. Add numa test case for loongarch system.
> ---
> Bibo Mao (6):
>    hw/loongarch: Refine acpi srat table for numa memory
>    hw/loongarch: Refine fadt memory table for numa memory
>    hw/loongarch: Refine fwcfg memory map
>    hw/loongarch: Refine system dram memory region
>    hw/loongarch: Remove minimum and default memory size
>    tests/qtest: Add numa test for loongarch system

Patches 1 -5  queued to loongarch-next, thanks.

Thanks.
Song Gao
>   hw/loongarch/acpi-build.c |  58 +++++++------
>   hw/loongarch/virt.c       | 166 +++++++++++++++++++++++++++-----------
>   tests/qtest/meson.build   |   2 +-
>   tests/qtest/numa-test.c   |  53 ++++++++++++
>   4 files changed, 206 insertions(+), 73 deletions(-)
>
>
> base-commit: dafec285bdbfe415ac6823abdc510e0b92c3f094


