Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB3B78180D
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 09:35:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXGTl-0004FE-Ey; Sat, 19 Aug 2023 03:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qXGTj-0004F3-C1
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 03:34:35 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qXGTf-0004gK-Pj
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 03:34:34 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxxPCFcOBkpxkaAA--.54405S3;
 Sat, 19 Aug 2023 15:34:29 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxDc+FcOBk9DReAA--.34086S3; 
 Sat, 19 Aug 2023 15:34:29 +0800 (CST)
Subject: Re: [PATCH v2 2/8] target/loongarch: Remove duplicated disas_set_info
 assignment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Jiajie Chen
 <c@jia.je>, Richard Henderson <richard.henderson@linaro.org>
References: <20230818172016.24504-1-philmd@linaro.org>
 <20230818172016.24504-3-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <80fec397-74e7-8faf-e0cf-c2b2cc06810a@loongson.cn>
Date: Sat, 19 Aug 2023 15:34:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230818172016.24504-3-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxDc+FcOBk9DReAA--.34086S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urWxAF47XF1xAryUKr1DCFX_yoW8JFyfpr
 Zxua4UtFW8J3ykZw1kW34rXFyDur17Gr429a17Kr97Cw13XryxWF18ta9FyF1DWayxCF12
 gF1rC3WUZa15JFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7tx6
 UUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.454,
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

在 2023/8/19 上午1:20, Philippe Mathieu-Daudé 写道:
> Commit 228021f05e ("target/loongarch: Add core definition") sets
> disas_set_info to loongarch_cpu_disas_set_info. Probably due to
> a failed git-rebase, commit ca61e75071 ("target/loongarch: Add gdb
> support") also sets it to the same value. Remove the duplication.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/cpu.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 7107968699..dc617be36f 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -723,7 +723,6 @@ static void loongarch_cpu_class_init(ObjectClass *c, void *data)
>       cc->disas_set_info = loongarch_cpu_disas_set_info;
>       cc->gdb_read_register = loongarch_cpu_gdb_read_register;
>       cc->gdb_write_register = loongarch_cpu_gdb_write_register;
> -    cc->disas_set_info = loongarch_cpu_disas_set_info;
>       cc->gdb_num_core_regs = 35;
>       cc->gdb_core_xml_file = "loongarch-base64.xml";
>       cc->gdb_stop_before_watchpoint = true;
> 

Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao


