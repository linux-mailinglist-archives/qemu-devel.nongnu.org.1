Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 536AA770DF3
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 07:48:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSA8W-0002oc-Re; Sat, 05 Aug 2023 01:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSA7Z-0002im-Ud
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 01:46:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSA7X-0007LA-Uh
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 01:46:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 048E61854F;
 Sat,  5 Aug 2023 08:46:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9F5671B934;
 Sat,  5 Aug 2023 08:46:29 +0300 (MSK)
Message-ID: <0adbfa43-719c-6d8e-9ec9-5d4a402be384@tls.msk.ru>
Date: Sat, 5 Aug 2023 08:46:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3] hw/cxl: Fix CFMW config memory leak
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, fan.ni@samsung.com,
 qemu-devel@nongnu.org
References: <20230531060706.11840-1-lizhijian@cn.fujitsu.com>
 <5ac2e71e-7bc0-ee84-fce2-8d0b6e137a3e@linaro.org>
 <20230531120823.00001a6c@Huawei.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230531120823.00001a6c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

31.05.2023 14:08, Jonathan Cameron via wrote:
> On Wed, 31 May 2023 09:51:43 +0200
> Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> 
>> On 31/5/23 08:07, Li Zhijian wrote:
>>> Allocate targets and targets[n] resources when all sanity checks are
>>> passed to avoid memory leaks.
>>>
>>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>> ---
>>> V3: allocte further resource when we can't fail # Philippe
>>
>> Thanks for the v3!
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks.  I've added this near the top of my queue so will send
> it out along with other similar fixes as a series for Michael
> to consider picking up.

Hi!

Has this been forgotten? Is it still needed?

/mjt

