Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DB67A8683
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 16:27:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiy9d-00024g-FC; Wed, 20 Sep 2023 10:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qiy9Z-000242-OD
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:26:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qiy9W-0000JE-I9
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 10:26:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E32DC23AC7;
 Wed, 20 Sep 2023 17:26:10 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 150C429796;
 Wed, 20 Sep 2023 17:25:51 +0300 (MSK)
Message-ID: <bf16fac6-4ec4-15ea-56cf-f422024dbf0c@tls.msk.ru>
Date: Wed, 20 Sep 2023 17:25:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/3] hw/mem/cxl_type3: Add missing copyright and
 license notice
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Cc: linuxarm@huawei.com, Peter Maydell <peter.maydell@linaro.org>,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Warner Losh <imp@bsdimp.com>
References: <20230919101927.1470-1-Jonathan.Cameron@huawei.com>
 <20230919101927.1470-3-Jonathan.Cameron@huawei.com>
 <0569dafb-6100-632b-fe2b-94a7dc98ca45@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <0569dafb-6100-632b-fe2b-94a7dc98ca45@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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

20.09.2023 17:11, Philippe Mathieu-Daudé:
> Hi Jonathan,
> 
> On 19/9/23 12:19, Jonathan Cameron wrote:
>> This has been missing from the start. Assume it should match
>> with cxl/cxl-component-utils.c as both were part of early
>> postings from Ben.
>>
>> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I haven't suggested this license, I only reported these
> files are missing one (so eventually, Reported-by).

Fixed that one.

/mjt

