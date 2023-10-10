Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1C77BF023
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 03:14:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq1J3-0004Ai-Ia; Mon, 09 Oct 2023 21:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1qq1J0-0004AJ-6e
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:13:02 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1qq1Ix-0007U7-D0
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 21:13:01 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Cx2eoRpSRlKXwwAA--.22553S3;
 Tue, 10 Oct 2023 09:12:49 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx7y8OpSRl8bgdAA--.61831S3; 
 Tue, 10 Oct 2023 09:12:48 +0800 (CST)
Subject: Re: qemu direct kernel boot on LoongArch
To: =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>
References: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
Cc: loongarch@lists.linux.dev, qemu-devel@nongnu.org
From: maobibo <maobibo@loongson.cn>
Message-ID: <49432aed-3ed7-2f07-7f65-311faef96197@loongson.cn>
Date: Tue, 10 Oct 2023 09:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1738d60a-df3a-4102-b1da-d16a29b6e06a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Cx7y8OpSRl8bgdAA--.61831S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uFWfXFy3Zr48Gr15Ary3ZFc_yoW8JFW7pr
 ZxursxArn5GFy8GFn0gws8uF4S9w1rWFW5Gr1rA34DGrnxA3Z2v34jqa15X34jq3s5GF10
 qay8W34jkayUZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jUsqXU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
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

Thomas,

Thanks for reporting this issue.

It is the problem of QEMU for LoongArch system, QEMU does not support 
booting vmlinux with elf format without UEFI bios now. We will add 
support to boot vmlinux directly on QEMU LoongArch side.

Regards
Bibo Mao

在 2023/10/10 上午4:13, Thomas Weißschuh 写道:
> Hi,
> 
> I'm trying to boot a LoongArch Linux via the direct kernel mode of qemu.
> ( qemu -kernel vmlinux -append "verbose" )
> This doesn't work so well.
> 
> A few problems I encoutered:
> 
> * Linux reads the cmdline from $a1 during boot, but qemu doesn't place it there.
> * Qemu puts a FDT at 1MiB but Linux doesn't use it.
> * Qemu does not put the cmdline into the FDT.
> * Linux panics in memory_present() because memblock_init() in
>    arch/loongarch/kernel/mem.c did not set up any memblocks.
> * Qemu has no support for initrds in direct kernel mode on LoongArch.
> 
> (All observations based on current git versions)
> 
> For the other architectures I'm using Linux/qemu with the direct kernel
> mode works nicely including cmdline and initrds.
> 
> Are these restrictions by design/intentional or is it just for somebody
> to do the necessary legwork?
> 
> The direct kernel mode is nice because it does not require the
> installation of the additional EFI binary.
> 
> 
> Thanks,
> Thomas
> 


