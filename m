Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D37829277
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 03:38:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNOSj-0003lh-3T; Tue, 09 Jan 2024 21:37:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNOSf-0003lK-FD
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:36:57 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNOSc-0002Ic-QD
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 21:36:57 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxkOm7Ap5lsrQDAA--.7255S3;
 Wed, 10 Jan 2024 10:36:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNy4Ap5ltgoKAA--.26664S3; 
 Wed, 10 Jan 2024 10:36:42 +0800 (CST)
Subject: Re: [PATCH v4 9/9] target/loongarch: Add loongarch kvm into meson
 build
To: Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org, yangxiaojuan@loongson.cn,
 xianglai li <lixianglai@loongson.cn>
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
 <20240105075804.1228596-10-zhaotianrui@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <fffa2980-b5b8-18ed-517e-960f37e57319@loongson.cn>
Date: Wed, 10 Jan 2024 10:36:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240105075804.1228596-10-zhaotianrui@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxbNy4Ap5ltgoKAA--.26664S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4kWF4fKw4UXF4rXryDCFX_yoW8Cw4rpw
 n7C3WUKF48JrZrJr98Gas5XrZ3Jw17Gw17WayfKryfCwsxta43XF97KF9IgFW7Z3W0kFyr
 XFn3C3WjgF4UJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU1Ha0PUUUUU==
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

ÔÚ 2024/1/5 ÏÂÎç3:58, Tianrui Zhao Ð´µÀ:
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
>   meson.build                      | 2 ++
>   target/loongarch/kvm/meson.build | 1 +
>   target/loongarch/meson.build     | 1 +
>   3 files changed, 4 insertions(+)
>   create mode 100644 target/loongarch/kvm/meson.build

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/meson.build b/meson.build
> index 445f2b7c2b..0c62b4156d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -114,6 +114,8 @@ elif cpu in ['riscv32']
>     kvm_targets = ['riscv32-softmmu']
>   elif cpu in ['riscv64']
>     kvm_targets = ['riscv64-softmmu']
> +elif cpu in ['loongarch64']Reviewed-by: Song Gao <gaosong@loongson.cn>
> +  kvm_targets = ['loongarch64-softmmu']
>   else
>     kvm_targets = []
>   endif
> diff --git a/target/loongarch/kvm/meson.build b/target/loongarch/kvm/meson.build
> new file mode 100644
> index 0000000000..2266de6ca9
> --- /dev/null
> +++ b/target/loongarch/kvm/meson.build
> @@ -0,0 +1 @@
> +loongarch_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))
> diff --git a/target/loongarch/meson.build b/target/loongarch/meson.build
> index 18e8191e2b..7f86caf373 100644
> --- a/target/loongarch/meson.build
> +++ b/target/loongarch/meson.build
> @@ -31,3 +31,4 @@ loongarch_ss.add_all(when: 'CONFIG_TCG', if_true: [loongarch_tcg_ss])
>   
>   target_arch += {'loongarch': loongarch_ss}
>   target_system_arch += {'loongarch': loongarch_system_ss}
> +subdir('kvm')


