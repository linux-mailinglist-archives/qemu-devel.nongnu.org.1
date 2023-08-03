Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A993B76E1BC
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 09:37:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRSsG-0001Zb-0q; Thu, 03 Aug 2023 03:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRSsC-0001ZI-1D; Thu, 03 Aug 2023 03:35:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qRSs0-0000xM-Vj; Thu, 03 Aug 2023 03:35:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 65344179C0;
 Thu,  3 Aug 2023 10:35:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 905BD1AF05;
 Thu,  3 Aug 2023 10:35:19 +0300 (MSK)
Message-ID: <7f55bae1-10ab-f7a1-51d8-b894dd44a284@tls.msk.ru>
Date: Thu, 3 Aug 2023 10:35:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: sparc64 -- cannot get 'Hello World' to run
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 cauldwell.thomas@gmail.com
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
References: <CALtZhhPmFfMpGoCPtdEMjYES2c3WrwPYq==sj+HbwBLZ8ZYTgw@mail.gmail.com>
 <CALtZhhOwsquhcHK0aOEn89tu7DynEMeiDZ=aaropn8Hkiyy+qA@mail.gmail.com>
 <fd0112a7-6fdd-fd5a-bd25-f9adfe2ee140@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <fd0112a7-6fdd-fd5a-bd25-f9adfe2ee140@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.102,
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

03.08.2023 00:02, Philippe Mathieu-Daudé wrote:
> Hi Frederick,
> 
> On 2/8/23 22:36, Frederick Virchanza Gotham wrote:
>> On Wed, Aug 2, 2023 at 11:04 AM Frederick Virchanza Gotham wrote:
>>>
>>> I can't get sparc64 to work at all though. Even I make a simple 'Hello
>>> World' program in C using only "puts", if I try to use qemu-user to
>>> run it, it crashes.
>>
>>
>> You can try the following at the command line in Ubuntu 23.04:

Ubuntu 23.04, - I guess it is qemu 8.0, no?  8.0 has a few issues with
linux-user, some of them were there in 7.2 too.  And some of that has
additional patches (coming from upstream most of the time).

Please note also that there are quite a few fixes has been made to both
qemu 8.0 and 7.2 stable series, including linux-user area.

/mjt

