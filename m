Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B4E7E9751
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:07:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Rxt-0001uS-0s; Mon, 13 Nov 2023 03:06:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1r2Rxm-0001ty-S4
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:06:31 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1r2Rxj-0004Mo-TQ
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:06:30 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxh+j52FFlU3w5AA--.11926S3;
 Mon, 13 Nov 2023 16:06:17 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxE+Tv2FFl_IVAAA--.11895S3; 
 Mon, 13 Nov 2023 16:06:09 +0800 (CST)
Subject: Re: [risu PATCH 0/5] Add LoongArch LSX/LASX instructions
From: gaosong <gaosong@loongson.cn>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 alex.bennee@linaro.org, maobibo@loongson.cn
References: <20231025092915.902814-1-gaosong@loongson.cn>
Message-ID: <07f56184-5b40-fb9f-ee96-6d963d362b4c@loongson.cn>
Date: Mon, 13 Nov 2023 16:06:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231025092915.902814-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxE+Tv2FFl_IVAAA--.11895S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFWUZr4xGr4xAF1xKr47ZFc_yoW3Kwb_WF
 y3tryxCr4UK3ZYka4jgr1fXFWrGFs5tF95AFyqqFWrWrn3Xa9xAr4Uuw1rZ3WYkr4rXFn3
 Jr1vqr1fAry7JosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.553, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Ping !

ÔÚ 2023/10/25 ÏÂÎç5:29, Song Gao Ð´µÀ:
> Hi, Peter!
>
> This series adds LSX/LASX instructions.
>
> We tested 10 million instructions without any problems.
>
> client:
> x86 host  QEMU + patches [1].
>
> server:
> 3A5000 host.
>
>
> [1] https://patchwork.kernel.org/project/qemu-devel/list/?series=791633
>
>
> Please review!
>
> Thanks.
> Song Gao
>
> Song Gao (5):
>    loongarch: Add LSX instructions
>    loongarch: Add LASX instructions
>    loongarch: reginfo suport LSX/LASX
>    loongarch: init LASX registers
>    loongarch: Add block 'clean' and clean_lsx_result()
>
>   loongarch64.risu           | 2309 +++++++++++++++++++++++++++++++++++-
>   risu_reginfo_loongarch64.c |  107 +-
>   risu_reginfo_loongarch64.h |    3 +-
>   risugen                    |    2 +-
>   risugen_loongarch64.pm     |   30 +
>   5 files changed, 2418 insertions(+), 33 deletions(-)
>


