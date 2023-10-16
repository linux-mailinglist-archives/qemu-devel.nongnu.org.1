Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8A47C9D94
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 05:02:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsDrs-0001wG-Oc; Sun, 15 Oct 2023 23:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qsDrp-0001w8-0M
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 23:02:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qsDrl-0006ht-LB
 for qemu-devel@nongnu.org; Sun, 15 Oct 2023 23:02:04 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxqOicpyxl5jsyAA--.60723S3;
 Mon, 16 Oct 2023 11:01:48 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bx7tyYpyxl3gsmAA--.14760S3; 
 Mon, 16 Oct 2023 11:01:47 +0800 (CST)
Subject: Re: [PATCH 0/4] tcg: Optimize loads and stores to env
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <8ea9dbf1-d563-8d08-48c8-b2cb204a9c88@loongson.cn>
Date: Mon, 16 Oct 2023 11:01:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230831025729.1194388-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bx7tyYpyxl3gsmAA--.14760S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWxtr17WF18JF1rZr1DJwc_yoW8GrWDp3
 95Gw1Ykr1DJFn3Jr13Gw1DWr9xWFyFkF45Xas7J3s5JrZ0vFn2qw1IgrWUCFy7Gw4fuFyj
 qF4Fyr18Ca45AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
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

在 2023/8/31 上午10:57, Richard Henderson 写道:
> This is aimed at improving gvec generated code, which involves large
> numbers of loads and stores to the env slots of the guest cpu vector
> registers.  The final patch helps eliminate redundant zero-extensions
> that can appear with e.g. avx2 and sve.
>
>  From the small amount of timing that I have done, there is no change.
> But of course as we all know, x86 is very good with redundant memory.
> And frankly, I haven't found a good test case for measuring.
> What I need is an algorithm with lots of integer vector code that can
> be expanded with gvec.  Most of what I've found is either fp (out of
> line) or too simple (small translation blocks with little scope for
> optimization).
>
> That said, it appears to be simple enough, and does eliminate some
> redundant operations, even in places that I didn't expect.
>
>
> r~
>
>
> Richard Henderson (4):
>    tcg: Don't free vector results
>    tcg/optimize: Pipe OptContext into reset_ts
>    tcg: Optimize env memory operations
>    tcg: Eliminate duplicate env store operations
>
>   tcg/optimize.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++--
>   tcg/tcg-op-gvec.c |  39 ++------
>   2 files changed, 225 insertions(+), 40 deletions(-)
>
Patch 1 and Patch 3,    s  -i  "/cpu_env/tcg_env/g "

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


