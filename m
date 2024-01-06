Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 148B3825D9A
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 02:19:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLvKd-0003Ux-Iv; Fri, 05 Jan 2024 20:18:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rLvKb-0003Uk-Iy
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 20:18:33 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rLvKY-0001ME-RF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 20:18:33 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx_7tgqphlMIsCAA--.699S3;
 Sat, 06 Jan 2024 09:18:24 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxG9xaqphlviIEAA--.10989S3; 
 Sat, 06 Jan 2024 09:18:21 +0800 (CST)
Subject: Re: [PULL 0/2] loongarch-to-apply queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240105011739.1217818-1-gaosong@loongson.cn>
 <CAFEAcA8oQN9Rq9NK+1pVE2g=-2YjDtGqSQNVL9t+RvSgJ4oNEA@mail.gmail.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <d1e23c4c-77c3-c7ed-04b5-eedab666ed9c@loongson.cn>
Date: Sat, 6 Jan 2024 09:18:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8oQN9Rq9NK+1pVE2g=-2YjDtGqSQNVL9t+RvSgJ4oNEA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxG9xaqphlviIEAA--.10989S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KrWftFWrZw48urWUXr1fuFX_yoW8GrW8pa
 43CFnIkr4UJryUJrs7Kw18Jr1Dtr1xJr4UXFn5Xry0yF1qvrn7Xr18KryfWFy7X34xGryr
 WFyrtw15ZF1UJ3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.854,
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

在 2024/1/5 下午9:34, Peter Maydell 写道:
> On Fri, 5 Jan 2024 at 01:30, Song Gao <gaosong@loongson.cn> wrote:
>> The following changes since commit d328fef93ae757a0dd65ed786a4086e27952eef3:
>>
>>    Merge tag 'pull-20231230' of https://gitlab.com/rth7680/qemu into staging (2024-01-04 10:23:34 +0000)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240105
>>
>> for you to fetch changes up to 0cd8b379081fa71c23836052feb65da4685f8ec7:
>>
>>    target/loongarch: move translate modules to tcg/ (2024-01-05 09:31:05 +0800)
>>
>> ----------------------------------------------------------------
>> pull-loongarch-20240105
>>
>> ----------------------------------------------------------------
>> Song Gao (2):
>>        target/loongarch/meson: move gdbstub.c to loongarch.ss
>>        target/loongarch: move translate modules to tcg/
> Hi; this fails to build, with
>
> ../target/loongarch/tcg/meson.build:1:3: ERROR: Unknown variable "config_all".
>
> (eg https://gitlab.com/qemu-project/qemu/-/jobs/5868662017)
>
> I think your pullreq has unfortunately got a conflict with the
> meson cleanup patches that I just applied from Paolo.
>
> Could you have a look at this and respin the pullreq, please?
Sure, I will.

Thanks.
Song Gao.


