Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59547EEAA3
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 02:16:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3nRh-0000JD-Q7; Thu, 16 Nov 2023 20:14:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1r3nRe-0000In-QT
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 20:14:54 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1r3nRb-0008Bf-K1
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 20:14:54 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8CxNvF_vlZl_606AA--.49809S3;
 Fri, 17 Nov 2023 09:14:40 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxnd59vlZlwL1EAA--.21255S3; 
 Fri, 17 Nov 2023 09:14:39 +0800 (CST)
Subject: Re: [PATCH] linux-headers: Synchronize linux headers from linux
 v6.7.0-rc1
To: Thomas Huth <thuth@redhat.com>, gaosong <gaosong@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org,
 mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 lixianglai@loongson.cn, clg@redhat.com
References: <20231114015412.53135-1-zhaotianrui@loongson.cn>
 <be0da6a9-6f1e-11d9-f088-328ea33aee36@loongson.cn>
 <771dd5ff-45d0-40bd-87dd-40f666d3355d@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <257d6562-51fb-867a-e65c-13418c6ce888@loongson.cn>
Date: Fri, 17 Nov 2023 09:14:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <771dd5ff-45d0-40bd-87dd-40f666d3355d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxnd59vlZlwL1EAA--.21255S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrJF43CrW5tr1rAw4kCrW8Xwc_yoWxXFXEv3
 4UZ3s2gw1Dtw4UW3Z8tr4furnrJF18uwn7J34xXFs2gryfJFZ7JrWqkryxJF90gayxAFsI
 9r1YqrW5Aw1jqosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.193,
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

Thomas,

Linux 6.7-rc1 has already released, LoongArch KVM is supported in this 
version. LoongArch qemu KVM function depends on linux-headers and I do 
not know whether LoongArch qemu KVM can be merged in 8.2 cycle.

Regards
Bibo Mao


On 2023/11/16 下午9:19, Thomas Huth wrote:
> On 15/11/2023 11.07, gaosong wrote:
>> Hi,
>>
>> Can this patch be merged in during the 8.2 cycle?
> 
>   Hi!
> 
> We normally do linux-headers updates along with the patches that need 
> the new definitions ... so is there an urgent reason to push this 
> stand-alone
> patch into 8.2 without any patches that require these new definitions?
> 
>   Thomas


