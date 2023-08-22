Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A00D57838A4
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 05:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYIVg-0001xb-AZ; Mon, 21 Aug 2023 23:56:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qYIVd-0001xO-Iq
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 23:56:49 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qYIVa-0001Me-0q
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 23:56:49 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxruv3MeRk5MoaAA--.52162S3;
 Tue, 22 Aug 2023 11:56:40 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXSP2MeRkHQJgAA--.18882S3; 
 Tue, 22 Aug 2023 11:56:38 +0800 (CST)
Subject: Re: [PATCH v3 0/8] target/loongarch: Cleanups in preparation of
 loongarch32 support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20230821125959.28666-1-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d5281091-106a-df05-7514-45ca0f9aa1de@loongson.cn>
Date: Tue, 22 Aug 2023 11:56:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230821125959.28666-1-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXSP2MeRkHQJgAA--.18882S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxKF1xWrW5JF4xWF4Utrc_yoW8WF4rpr
 W3ur15KFW8KrZrJrn3Xa43Xrn0qr4xGr42g3Zxtry8C3yavry7ZF1xK39FqFyUJ34UGr1j
 gr10kw1UuF45XwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhF
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.374,
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

在 2023/8/21 下午8:59, Philippe Mathieu-Daudé 写道:
> Series fully reviewed.
> 
> v3:
> - Do not rename loongarch_la464_initfn (rth)
> - Added R-b
> 
> v2:
> - Do no rename loongarch_cpu_get/set_pc (rth)
> - Rebased Jiajie's patches for convenience
> - Added rth's R-b
> 
> Jiajie, this series contains few notes I took while
> reviewing your series adding loongarch32 support [*].
> 
> If your series isn't merged, consider rebasing it on
> this one.
> 
> Regards,
> 
> Phil.
> 
> [*] https://lore.kernel.org/qemu-devel/20230817093121.1053890-1-gaosong@loongson.cn/
> 
> Jiajie Chen (3):
>    target/loongarch: Add function to check current arch
>    target/loongarch: Add new object class for loongarch32 cpus
>    target/loongarch: Add GDB support for loongarch32 mode
> 
> Philippe Mathieu-Daudé (4):
>    target/loongarch: Log I/O write accesses to CSR registers
>    target/loongarch: Remove duplicated disas_set_info assignment
>    target/loongarch: Introduce abstract TYPE_LOONGARCH64_CPU
>    target/loongarch: Extract 64-bit specifics to
>      loongarch64_cpu_class_init
> 
> Song Gao (1):
>    target/loongarch: Fix loongarch_la464_initfn() misses setting LSPW
> 
>   configs/targets/loongarch64-softmmu.mak |  2 +-
>   target/loongarch/cpu.h                  | 12 +++++
>   target/loongarch/cpu.c                  | 60 ++++++++++++++++++++-----
>   target/loongarch/gdbstub.c              | 32 ++++++++++---
>   gdb-xml/loongarch-base32.xml            | 45 +++++++++++++++++++
>   5 files changed, 131 insertions(+), 20 deletions(-)
>   create mode 100644 gdb-xml/loongarch-base32.xml
> 
Thanks!

Applied to loongarch-to-apply queue

Thanks.
Song Gao


