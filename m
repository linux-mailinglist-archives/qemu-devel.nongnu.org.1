Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 032A477FB75
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 18:06:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWfUP-0004aX-0o; Thu, 17 Aug 2023 12:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qWfUK-0004Yl-6I; Thu, 17 Aug 2023 12:04:44 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qWfUF-0004u9-Ak; Thu, 17 Aug 2023 12:04:43 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CF0221B2AA;
 Thu, 17 Aug 2023 19:04:41 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C20D82004F;
 Thu, 17 Aug 2023 19:04:33 +0300 (MSK)
Message-ID: <6fd3fa16-c8d7-adee-c90c-90e6dda68673@tls.msk.ru>
Date: Thu, 17 Aug 2023 19:04:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de, qemu-stable@nongnu.org
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230816181437.572997-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -108
X-Spam_score: -10.9
X-Spam_bar: ----------
X-Spam_report: (-10.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-4.01,
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

16.08.2023 21:14, Richard Henderson wrote:
> PIE executables are usually linked at offset 0 and are
> relocated somewhere during load.  The hiaddr needs to
> be adjusted to keep the brk next to the executable.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 1f356e8c013 ("linux-user: Adjust initial brk when interpreter is close to executable")

FWIW, 1f356e8c013 is v8.1.0-rc2-86, - why did you Cc qemu-stable@?

If this "Adjust brk for load_bias" fix isn't supposed to be part of 8.1.0 release,
sure thing I'll pick it up for stable-8.1, but it looks like it should be in 8.1.0.

Or are you saying 1f356e8c013 should be picked for stable-8.0, together with this one?

(We're yet to decide if stable-8.0 should have any recent linux-user changes).

/mjt

