Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3688226F4
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 03:25:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKqvS-0004Ri-Lf; Tue, 02 Jan 2024 21:24:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rKqvM-0004Ra-CZ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 21:24:04 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rKqvJ-00048d-VK
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 21:24:04 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLOs5xZRl_F0BAA--.5503S3;
 Wed, 03 Jan 2024 10:23:54 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxPL43xZRlHoQXAA--.42320S3; 
 Wed, 03 Jan 2024 10:23:53 +0800 (CST)
Subject: Re: [PATCH v3 4/9] target/loongarch: Implement kvm get/set registers
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20231228084051.3235354-1-zhaotianrui@loongson.cn>
 <20231228084051.3235354-5-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <78c4024d-b124-1283-c98a-d5a06e02d25a@loongson.cn>
Date: Wed, 3 Jan 2024 10:23:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231228084051.3235354-5-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxPL43xZRlHoQXAA--.42320S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtr1kuw17tr48KFyxGFyfGrX_yoWktFb_ur
 4fu3Z7ur45uanrtFy5tw18A347WF40qF1Yyr1kZ34qkwnrXa4a9r4kKa1fGw4IgrnYyFs3
 CrWvk397Aws7XosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbakYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAF
 wI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
 CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnI
 WIevJa73UjIFyTuYvjxU2F4iUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.762,
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

在 2023/12/28 下午4:40, Tianrui Zhao 写道:
> +static int kvm_loongarch_get_regs_fp(CPUState *cs)
> +{
> +    int ret, i;
> +    struct kvm_fpu fpu;
> +
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    ret = kvm_vcpu_ioctl(cs, KVM_GET_FPU, &fpu);
> +    if (ret < 0) {
> +        trace_kvm_failed_get_fpu(strerror(errno));
> +        return ret;
> +    }
> +
> +    env->fcsr0 = fpu.fcsr;
> +    for (i = 0; i < 32; i++) {
> +        env->fpr[i].vreg.UD[0] = fpu.fpr[i].val64[0];
> +    }
> +    for (i = 0; i < 8; i++) {
> +        env->cf[i] = fpu.fcc & 0xFF;
> +        fpu.fcc = fpu.fcc >> 8;
> +    }
> +
Use  write_fcc(env, fpu.fcc)
> +    return ret;
> +}
> +
> +static int kvm_loongarch_put_regs_fp(CPUState *cs)
> +{
> +    int ret, i;
> +    struct kvm_fpu fpu;
> +
> +    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> +    CPULoongArchState *env = &cpu->env;
> +
> +    fpu.fcsr = env->fcsr0;
> +    fpu.fcc = 0;
> +    for (i = 0; i < 32; i++) {
> +        fpu.fpr[i].val64[0] = env->fpr[i].vreg.UD[0];
> +    }
> +
> +    for (i = 0; i < 8; i++) {
> +        fpu.fcc |= env->cf[i] << (8 * i);
> +    }
> +
Use fpu.fcc = read_fcc(env)
> +    ret = kvm_vcpu_ioctl(cs, KVM_SET_FPU, &fpu);
> +    if (ret < 0) {
> +        trace_kvm_failed_put_fpu(strerror(errno));
> +    }
> +
> +    return ret;
> +}


