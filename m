Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB870B33D
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 04:34:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0vLs-0003E4-Da; Sun, 21 May 2023 22:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q0vLo-0003Dv-VI
 for qemu-devel@nongnu.org; Sun, 21 May 2023 22:32:44 -0400
Received: from mail.loongson.cn ([114.242.206.163] helo=loongson.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q0vLl-0001l6-Kb
 for qemu-devel@nongnu.org; Sun, 21 May 2023 22:32:44 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8AxmOk_1GpkIskKAA--.18591S3;
 Mon, 22 May 2023 10:32:31 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxXrM+1GpkIXRuAA--.55113S3; 
 Mon, 22 May 2023 10:32:30 +0800 (CST)
Subject: Re: [PATCH 2/4] hw/intc/loongarch_ipi: Guard LoongArch only features
 with ifdef
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, philmd@linaro.org, chenhuacai@kernel.org,
 crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 maobibo <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-3-jiaxun.yang@flygoat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <a417d23a-1b9f-d730-a239-4ac359092764@loongson.cn>
Date: Mon, 22 May 2023 10:32:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230521102307.87081-3-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxXrM+1GpkIXRuAA--.55113S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoW7tFy8GFW7AryDAr15ArWfGrg_yoW8CFWfpr
 W3uF45Cr48tF17Wa9xC342gw1YqFn7JFySvF1fC340kayUXr97ua4kKr9Fva95C343Gr1U
 Zws7Kr1UuF47urDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
 x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
 IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4U
 McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487Mx
 AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
 Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwI
 xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8
 JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
 C2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUzZ2-UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=loongson.cn
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.098,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

在 2023/5/21 下午6:23, Jiaxun Yang 写道:
> IOCSR based send features are tied to LoongArch's CPU implmentation,
> ifdef them for LoongArch only so we can build loongarch_ipi on MIPS.
>
> Note that Loongson-3A4000 have IOCSR as well, so we may implement
> those features for MIPS in future.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/intc/loongarch_ipi.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
> index 3e453816524e..895a2ee96e1e 100644
> --- a/hw/intc/loongarch_ipi.c
> +++ b/hw/intc/loongarch_ipi.c
> @@ -50,6 +50,7 @@ static uint64_t loongarch_ipi_readl(void *opaque, hwaddr addr, unsigned size)
>       return ret;
>   }
>   
> +#ifdef TARGET_LOONGARCH64

How about adding one or three properties to LoongArchIPI?
and set these properties when starting the device.

This patch conflicts with patch [1], will it affect your patch?

[1]: 
https://patchew.org/QEMU/20230518014115.117869-1-gaosong@loongson.cn/20230518014115.117869-3-gaosong@loongson.cn/

Thanks.
Song Gao
>   static void send_ipi_data(CPULoongArchState *env, uint64_t val, hwaddr addr)
>   {
>       int i, mask = 0, data = 0;
> @@ -140,6 +141,25 @@ static void any_send(uint64_t val)
>       env = &cpu->env;
>       send_ipi_data(env, val, addr);
>   }
> +#else
> +static void ipi_send(uint64_t val)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented send 0x%" PRIx64 "\n",
> +                    __func__, val);
> +}
> +
> +static void mail_send(uint64_t val)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented send 0x%" PRIx64 "\n",
> +                    __func__, val);
> +}
> +
> +static void any_send(uint64_t val)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: Unimplemented send 0x%" PRIx64 "\n",
> +                    __func__, val);
> +}
> +#endif
>   
>   static void loongarch_ipi_writel(void *opaque, hwaddr addr, uint64_t val,
>                                    unsigned size)


