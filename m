Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7D745B6D
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:44:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHyk-00085b-Hv; Mon, 03 Jul 2023 07:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qGHya-0007rh-Pf
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:44:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qGHyW-0005o1-Fb
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 07:44:15 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8BxFsWEtKJkYDYFAA--.8652S3;
 Mon, 03 Jul 2023 19:44:04 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c6EtKJks9oZAA--.14978S3; 
 Mon, 03 Jul 2023 19:44:04 +0800 (CST)
Subject: Re: [PATCH v2 06/46] target/loongarch: Implement xvaddi/xvsubi
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230630075904.45940-1-gaosong@loongson.cn>
 <20230630075904.45940-7-gaosong@loongson.cn>
 <4ef7e66d-d473-5aae-6a72-2c013c047e06@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <64d8506c-cca4-29f2-2094-22890817fc19@loongson.cn>
Date: Mon, 3 Jul 2023 19:43:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4ef7e66d-d473-5aae-6a72-2c013c047e06@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax3c6EtKJks9oZAA--.14978S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ur4DCw1DCF45KFWxuw1Utwc_yoW8XrWfpr
 10yr1UArW8Xr18Jr4vyw15Jay7KrnrJw1jyr15GF1rZF1UuFn0qry8XrWj93y7Xrs5AFyU
 Kry7JrWUZrZ5twcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTm
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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



在 2023/7/2 下午1:59, Richard Henderson 写道:
> On 6/30/23 09:58, Song Gao wrote:
>> @@ -1315,3 +1315,17 @@ xvreplgr2vr_b 0111 01101001 11110 00000 ..... 
>> .....    @vr
>>   xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
>>   xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
>>   xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
>> +
>> +xvaddi_bu        0111 01101000 10100 ..... ..... ..... @vv_ui5
>> +xvaddi_hu        0111 01101000 10101 ..... ..... ..... @vv_ui5
>> +xvaddi_wu        0111 01101000 10110 ..... ..... ..... @vv_ui5
>> +xvaddi_du        0111 01101000 10111 ..... ..... ..... @vv_ui5
>> +xvsubi_bu        0111 01101000 11000 ..... ..... ..... @vv_ui5
>> +xvsubi_hu        0111 01101000 11001 ..... ..... ..... @vv_ui5
>> +xvsubi_wu        0111 01101000 11010 ..... ..... ..... @vv_ui5
>> +xvsubi_du        0111 01101000 11011 ..... ..... ..... @vv_ui5
>> +
>> +xvreplgr2vr_b    0111 01101001 11110 00000 ..... .....    @vr
>> +xvreplgr2vr_h    0111 01101001 11110 00001 ..... .....    @vr
>> +xvreplgr2vr_w    0111 01101001 11110 00010 ..... .....    @vr
>> +xvreplgr2vr_d    0111 01101001 11110 00011 ..... .....    @vr
>
> Rebase error?  It looks like you've duplicated the xvreplgr2vr patterns.
>
Oh,   I will correct it on v3.

Thanks.
Song Gao


