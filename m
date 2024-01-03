Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A15368226F5
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 03:25:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKqwI-0004iN-AS; Tue, 02 Jan 2024 21:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKqwG-0004i6-GH
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 21:25:00 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKqwE-0005bB-NB
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 21:25:00 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxaep3xZRlA14BAA--.1328S3;
 Wed, 03 Jan 2024 10:24:55 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxmb13xZRl24QXAA--.42108S3; 
 Wed, 03 Jan 2024 10:24:55 +0800 (CST)
Subject: Re: [PATCH v3 7/9] target/loongarch: Implement kvm_arch_handle_exit
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20231228084051.3235354-1-zhaotianrui@loongson.cn>
 <20231228084051.3235354-8-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <a5e93a5c-bf7e-251c-b30c-02f7715ae460@loongson.cn>
Date: Wed, 3 Jan 2024 10:24:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231228084051.3235354-8-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxmb13xZRl24QXAA--.42108S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ury5Kr45tr48KrWfGrWxGrX_yoW8KrW7pa
 y2y3Z8KrW8J39rt3ZIq3WUXr1UJrWxWFW2vayxt34furs8X3s3Wr48twnxtFW5t3yxWa10
 qF18ur1DKF1qqwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ
 57UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.762, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2023/12/28 ÏÂÎç4:40, Tianrui Zhao Ð´µÀ:
> Implement kvm_arch_handle_exit for loongarch. In this
> function, the KVM_EXIT_LOONGARCH_IOCSR is handled,
> we read or write the iocsr address space by the addr,
> length and is_write argument in kvm_run.
>
> Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
> Signed-off-by: xianglai li <lixianglai@loongson.cn>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/kvm.c        | 24 +++++++++++++++++++++++-
>   target/loongarch/trace-events |  1 +
>   2 files changed, 24 insertions(+), 1 deletion(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/kvm.c b/target/loongarch/kvm.c
> index 85e7aeb083..d2dab3fef4 100644
> --- a/target/loongarch/kvm.c
> +++ b/target/loongarch/kvm.c
> @@ -723,7 +723,29 @@ bool kvm_arch_cpu_check_are_resettable(void)
>   
>   int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>   {
> -    return 0;
> +    int ret = 0;
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +    MemTxAttrs attrs = {};
> +
> +    attrs.requester_id = env_cpu(env)->cpu_index;
> +
> +    trace_kvm_arch_handle_exit(run->exit_reason);
> +    switch (run->exit_reason) {
> +    case KVM_EXIT_LOONGARCH_IOCSR:
> +        address_space_rw(&env->address_space_iocsr,
> +                         run->iocsr_io.phys_addr,
> +                         attrs,
> +                         run->iocsr_io.data,
> +                         run->iocsr_io.len,
> +                         run->iocsr_io.is_write);
> +        break;
> +    default:
> +        ret = -1;
> +        warn_report("KVM: unknown exit reason %d", run->exit_reason);
> +        break;
> +    }
> +    return ret;
>   }
>   
>   void kvm_arch_accel_class_init(ObjectClass *oc)
> diff --git a/target/loongarch/trace-events b/target/loongarch/trace-events
> index 937c3c7c0c..021839880e 100644
> --- a/target/loongarch/trace-events
> +++ b/target/loongarch/trace-events
> @@ -11,3 +11,4 @@ kvm_failed_get_counter(const char *msg) "Failed to get counter from KVM: %s"
>   kvm_failed_put_counter(const char *msg) "Failed to put counter into KVM: %s"
>   kvm_failed_get_cpucfg(const char *msg) "Failed to get cpucfg from KVM: %s"
>   kvm_failed_put_cpucfg(const char *msg) "Failed to put cpucfg into KVM: %s"
> +kvm_arch_handle_exit(int num) "kvm arch handle exit, the reason number: %d"


