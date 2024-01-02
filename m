Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CC48216C7
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 04:59:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKVuu-0007Xt-Nu; Mon, 01 Jan 2024 22:58:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKVur-0007XA-2M
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 22:58:09 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKVul-0008NK-0T
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 22:58:07 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxbevEiZNl0gwBAA--.4362S3;
 Tue, 02 Jan 2024 11:57:56 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxyr3BiZNlv0AVAA--.36749S3; 
 Tue, 02 Jan 2024 11:57:55 +0800 (CST)
Subject: Re: [PATCH v3 9/9] target/loongarch: Add loongarch kvm into meson
 build
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20231228084051.3235354-1-zhaotianrui@loongson.cn>
 <20231228084051.3235354-10-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <999e9c55-7d8b-052f-c2c5-77b204cea351@loongson.cn>
Date: Tue, 2 Jan 2024 11:57:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231228084051.3235354-10-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxyr3BiZNlv0AVAA--.36749S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur1DGryUZF17JrW3uw1xZwc_yoW5JF47pF
 yxCa1DKF1kJrykJwn8XasYqas7Jr47Gr17Was3KryfCwsrJ3y7Xrs5tr97XF47t3Wvga40
 vrnak3WYvF4UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.014,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi,  TianRui

在 2023/12/28 下午4:40, Tianrui Zhao 写道:
> Add kvm.c into meson.build to compile it when kvm
> is configed. Meanwhile in meson.build, we set the
> kvm_targets to loongarch64-softmmu when the cpu is
> loongarch. And fix the compiling error when config
> is enable-kvm,disable-tcg.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   meson.build                  | 2 ++
>   target/loongarch/meson.build | 9 +++++----
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 445f2b7c2b..0c62b4156d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,6 +114,8 @@ elif cpu in ['riscv32']
>     kvm_targets = ['riscv32-softmmu']
>   elif cpu in ['riscv64']
>     kvm_targets = ['riscv64-softmmu']
> +elif cpu in ['loongarch64']
> +  kvm_targets = ['loongarch64-softmmu']
>   else
>     kvm_targets = []
>   endif
> diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
> index 18e8191e2b..4a59356d0f 100644
> --- a/target/loongarch/meson.build
> +++ b/target/loongarch/meson.build
> @@ -10,8 +10,10 @@ loongarch_tcg_ss.add(files(
>     'fpu_helper.c',
>     'op_helper.c',
>     'translate.c',
> -  'gdbstub.c',
>     'vec_helper.c',
> +  'tlb_helper.c',
> +  'iocsr_helper.c',
> +  'csr_helper.c',
>   ))
>   loongarch_tcg_ss.add(zlib)
this is  broken 'loongarch64-linux-user' build.

I had moved tcg code to target/loongarch/tcg.  see [1]
you just need rebase it.

[1]: 
https://lore.kernel.org/all/20240102020200.3462097-2-gaosong@loongson.cn/

>   
> @@ -19,14 +21,13 @@ loongarch_system_ss = ss.source_set()
>   loongarch_system_ss.add(files(
>     'loongarch-qmp-cmds.c',
>     'machine.c',
> -  'tlb_helper.c',
>     'constant_timer.c',
> -  'csr_helper.c',
> -  'iocsr_helper.c',
> +  'gdbstub.c',
>   ))
'gdbstub.c'  should move to  loongarch_ss,   because linus-user also 
need it.

I had send a patch [1]  to fix it .  see [2]

[2]: 
https://lore.kernel.org/all/20240102020200.3462097-1-gaosong@loongson.cn/

Thanks.
Song Gao

>   common_ss.add(when: 'CONFIG_LOONGARCH_DIS', if_true: [files('disas.c'), gen])
>   
> +loongarch_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
>   loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
>   
>   target_arch += {'loongarch': loongarch_ss}


