Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3B0829280
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 03:48:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNOdV-0001G1-W8; Tue, 09 Jan 2024 21:48:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNOdU-0001Fn-K7
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:48:08 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNOdR-0008RY-RG
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:48:07 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx2elgBZ5lIbUDAA--.7095S3;
 Wed, 10 Jan 2024 10:48:01 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxid1eBZ5liw4KAA--.26803S3; 
 Wed, 10 Jan 2024 10:47:59 +0800 (CST)
Subject: Re: [PATCH v2 0/4] hw/loongarch/virt: Set iocsr address space
 per-board rather percpu
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org
References: <20231215100333.3933632-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <e6a57a0e-888b-3d1d-f601-083ba0f6469a@loongson.cn>
Date: Wed, 10 Jan 2024 10:47:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231215100333.3933632-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxid1eBZ5liw4KAA--.26803S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr4fZFy8JrW3JryxCFWUWrX_yoW8Jw43pr
 W3uwsIgr4kJr9xAwnag345Wr98GFn7Wr12q3W3K348Cr4avF1jvr18A3s5XFy7K34kGryv
 qr1rGw1UWF1DAwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UM
 pBfUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.045, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2023/12/15 ÏÂÎç6:03, Bibo Mao Ð´µÀ:
> On LoongArch system, there is iocsr address space simliar system io
> address space on x86. And each cpu has its separate iocsr address space now,
> with this patch, iocsr address space is changed with per-board, and
> MemTxAttrs.requester_id is used to differentiate cpu cores.
>
> ---
> Changes in v2:
>    1. Add num-cpu property for extioi interrupt controller
>    2. Add post_load support for extioi vmstate to calculate sw_ipmap/sw_coremap info
> ---
> Bibo Mao (4):
>    hw/intc/loongarch_ipi: Use MemTxAttrs interface for ipi ops
>    hw/loongarch/virt: Set iocsr address space per-board rather than
>      percpu
>    hw/intc/loongarch_extioi: Add dynamic cpu number support
>    hw/intc/loongarch_extioi: Add vmstate post_load support
>
>   hw/intc/loongarch_extioi.c         | 230 ++++++++++++++++++-----------
>   hw/intc/loongarch_ipi.c            | 191 +++++++++++++++---------
>   hw/loongarch/virt.c                |  94 ++++++++----
>   include/hw/intc/loongarch_extioi.h |  12 +-
>   include/hw/intc/loongarch_ipi.h    |   3 +-
>   include/hw/loongarch/virt.h        |   3 +
>   target/loongarch/cpu.c             |  48 ------
>   target/loongarch/cpu.h             |   4 +-
>   target/loongarch/iocsr_helper.c    |  16 +-
>   9 files changed, 358 insertions(+), 243 deletions(-)
>
Applied to loongarch-next.

Thanks.
Song Gao


