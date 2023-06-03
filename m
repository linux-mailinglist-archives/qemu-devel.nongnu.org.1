Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7C4721157
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 19:10:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5UkK-00057G-M2; Sat, 03 Jun 2023 13:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q5UkH-00056s-Ov
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 13:08:53 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q5UkF-0004m5-RF
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 13:08:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9CE3BA7D8;
 Sat,  3 Jun 2023 20:08:48 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 34CDB9372;
 Sat,  3 Jun 2023 20:08:47 +0300 (MSK)
Message-ID: <778fb9b6-08b5-0714-7b18-e084d5641f62@tls.msk.ru>
Date: Sat, 3 Jun 2023 20:08:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230602174806.2060683-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230602174806.2060683-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
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

02.06.2023 20:48, Peter Maydell wrote:
> Coverity doesn't like the way we might end up calling getgroups()
> with a NULL grouplist pointer. This is fine for the special case
> of gidsetsize == 0, but we will also do it if the guest passes
> us a negative gidsetsize. (CID 1512465)
> 
> Explicitly fail the negative gidsetsize with EINVAL, as the kernel
> does. This means we definitely only call the libc getgroups()
> with valid parameters.
> 
> Possibly Coverity may still complain about getgroups(0, NULL), but
> that would be a false positive.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I especially kept the negative case like this when initially writing
this code, thinking to return whatever error the kernel will return.
But I guess it doesn't really matter here, and the less fragile corner
cases, the better.

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

Thanks,

/mjt

