Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9697771011
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 16:05:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSHuJ-0005pg-Dz; Sat, 05 Aug 2023 10:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSHuH-0005pW-N2
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 10:05:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSHuF-0003oD-Ek
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 10:05:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DB882185EF;
 Sat,  5 Aug 2023 17:05:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 21B321BA0E;
 Sat,  5 Aug 2023 17:05:20 +0300 (MSK)
Message-ID: <5024f65c-cc56-cb2b-00ac-c4f3071fb95e@tls.msk.ru>
Date: Sat, 5 Aug 2023 17:05:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v9 for-8.1 00/24] linux-user + tcg patch queue
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
 <7390dbf4-169f-5d79-da94-ebc0986f1580@tls.msk.ru>
 <5e1aef4b-65a0-e97e-17cc-d2ccd6a66dcc@tls.msk.ru>
 <b60a5670-17c8-f25d-fd56-e0970fe4017f@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <b60a5670-17c8-f25d-fd56-e0970fe4017f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

05.08.2023 17:01, Richard Henderson wrote:

>> Since it was kinda trivial to bisect, I just did. And here's the
>> result:
>>
>> commit 59b6b42cd3446862567637f3a7ab31d69c9bef51
>> Author: Richard Henderson <richard.henderson@linaro.org>
>> Date:   Tue Jun 6 10:19:39 2023 +0100
>>
>>      target/arm: Enable FEAT_LSE2 for -cpu max
>>
>> Reverting this patch on top of current master makes old linuxes
>> to work again.
> 
> What is your host?  That's probably the only relevant thing.

It's running on amd64 machine (AMD Ryzen 7 PRO 5750G), current debian
bookworm, kernel 6.1.0-10-amd64 (for qemu-user-static only architecture
and the kernel matters, I guess).

I noticed this while trying to reproduce
  https://gitlab.com/qemu-project/qemu/-/issues/1763

/mjt

