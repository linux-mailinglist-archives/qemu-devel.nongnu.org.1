Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 111DB72942F
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 11:06:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Y3p-0005Pg-0B; Fri, 09 Jun 2023 05:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7Y3k-0005Os-MS; Fri, 09 Jun 2023 05:05:29 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7Y3i-0000m3-SL; Fri, 09 Jun 2023 05:05:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B3AF6BBCB;
 Fri,  9 Jun 2023 12:05:21 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 175BBAE56;
 Fri,  9 Jun 2023 12:05:21 +0300 (MSK)
Message-ID: <5e731008-a170-b6ef-e5af-2224aed1fe87@tls.msk.ru>
Date: Fri, 9 Jun 2023 12:05:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 05/17] parallels: Out of image offset in BAT leads to image
 inflation
Content-Language: en-US
To: "Denis V. Lunev" <den@virtuozzo.com>, Hanna Czenczek <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Alexander Ivanov <alexander.ivanov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230605154541.1043261-1-hreitz@redhat.com>
 <20230605154541.1043261-6-hreitz@redhat.com>
 <a6dca05c-aebf-fe39-6cfa-cd626475865e@tls.msk.ru>
 <fcd7669d-92ec-fd24-1485-e746c2e358c7@redhat.com>
 <6e75f538-443a-46bd-1471-1cf182c345f6@virtuozzo.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6e75f538-443a-46bd-1471-1cf182c345f6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

09.06.2023 11:54, Denis V. Lunev wrote:
> On 6/7/23 17:14, Hanna Czenczek wrote:
..>>> This, and a few other parallels changes in this series:
>>> Should these be applied to -stable too, or is it not important?
>>
>> Personally, I don’t think they need to be in stable; but I’ll leave the final judgment to Alexander.
>>
> I do not think that this needs to go to stable too.

Ok, excellent, thank you!

/mjt



