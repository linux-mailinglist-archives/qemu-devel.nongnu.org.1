Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDFD74C6EB
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIYkr-0003XV-Km; Sun, 09 Jul 2023 14:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qIYkn-0003WX-SU; Sun, 09 Jul 2023 14:03:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qIYkl-0006Fo-W0; Sun, 09 Jul 2023 14:03:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E72CF12926;
 Sun,  9 Jul 2023 21:03:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 342B913B61;
 Sun,  9 Jul 2023 21:03:18 +0300 (MSK)
Message-ID: <eb703c74-f3cb-c8c5-055f-adfed7bbf6b6@tls.msk.ru>
Date: Sun, 9 Jul 2023 21:03:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/3] linux-user: Fix accept4(SOCK_NONBLOCK) syscall
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20230708054249.10245-1-deller@gmx.de>
 <20230708054249.10245-3-deller@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230708054249.10245-3-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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

08.07.2023 08:42, Helge Deller wrote:
> The Linux accept4() syscall allows two flags only: SOCK_NONBLOCK and
> SOCK_CLOEXEC, and returns -EINVAL if any other bits have been set.
> 
> Change the qemu implementation accordingly, which means we can not use
> the fcntl_flags_tbl[] translation table which allows too many other
> values.
> 
> Beside the correction in behaviour, this actually fixes the accept4()
> emulation for hppa, mips and alpha targets for which SOCK_NONBLOCK is
> different than TARGET_SOCK_NONBLOCK (aka O_NONBLOCK).
> 
> The fix can be verified with the testcase of the debian lwt package,
> which hangs forever in a read() syscall without this patch.

This smells like -stable material too.  Queued this one.

Thanks,

/mjt

