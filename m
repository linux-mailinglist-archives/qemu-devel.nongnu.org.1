Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8E677DA5E
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 08:18:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW9rB-0002t7-0x; Wed, 16 Aug 2023 02:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qW9qt-0002ik-He
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 02:17:56 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qW9qr-0002t6-23
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 02:17:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 29E461AAE3;
 Wed, 16 Aug 2023 09:17:51 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AE1A81F7A1;
 Wed, 16 Aug 2023 09:17:45 +0300 (MSK)
Message-ID: <cdd7ad12-d05d-e710-38c7-f36c63433793@tls.msk.ru>
Date: Wed, 16 Aug 2023 09:17:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 00/14] linux-user image mapping fixes
Content-Language: en-US
To: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230808210856.95568-1-richard.henderson@linaro.org>
 <35fa0e0c-ca69-a84a-02a0-4edcac65adb6@tls.msk.ru>
 <59d8d261-be68-dd60-f3d2-547b4e8dca94@linaro.org>
 <6d7e7c36-b892-abd2-0d5c-9e9882f1acf5@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <6d7e7c36-b892-abd2-0d5c-9e9882f1acf5@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -78
X-Spam_score: -7.9
X-Spam_bar: -------
X-Spam_report: (-7.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.045,
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

16.08.2023 00:42, Helge Deller wrote:
> On 8/15/23 23:09, Richard Henderson wrote:
...
>> Let's wait a bit and see if we're not just exchanging one set of bugs for another.
> 
> Yes, and I think 8.0 isn't in that bad shape?

Well, I dunno. It all started with 8.0 bugs, after I uploaded 8.0 to debian
and things started breaking there, like building stuff in a qemu-user-based
chroots.  arm commpage mapping issue affects 8.0, klibc issue is now re-
open, something else I forgot already... :)

But I agree, let's wait for a bit more.  It was a large amount of changes.
Myself, I tend to think about 8.0 having quite broken linux-user.

/mjt

