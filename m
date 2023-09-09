Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C70579989F
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Sep 2023 15:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qexwP-0001N5-OA; Sat, 09 Sep 2023 09:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qexwN-0001Mp-Eg
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 09:23:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qexwL-0008Ni-0U
 for qemu-devel@nongnu.org; Sat, 09 Sep 2023 09:23:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 133B620631;
 Sat,  9 Sep 2023 16:24:46 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D2D1026E51;
 Sat,  9 Sep 2023 16:23:54 +0300 (MSK)
Message-ID: <f7656ee0-586a-a89d-6815-d2d378195811@tls.msk.ru>
Date: Sat, 9 Sep 2023 16:23:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] scripts/qemu-binfmt-conf.sh: refresh
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230721115031.3224648-1-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230721115031.3224648-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

A friendly ping?

Thanks,

/mjt

21.07.2023 14:50, Michael Tokarev wrote:
> Currently qemu-binfmt-conf.sh does a number of strange things.
> 
> 1. --systemd requires an argument - the CPU type to register,
>     while --debian (which is actually --binfmt-support) does not
>     accept such an argument, so it is not possible to specify which
>     CPU(s) to register for debian.
> 
> 2. Why this "ALL" at all?
> 
> 3. it just ignores extra command-line arguments.  It would be
>     logical to specify which CPUs to register (multiple!) as the
>     additional arguments.
> 
> 4. Even if a CPU is explicitly requested, it does not register
>     anything if this CPU is of the same family as host one. But
>     this is wrong, since quite often it *is* desirable to do this
>     registration, - like, when running in i386 when the system is
>     not capable of running x86-64 binaries, and countless other
>     examples
> 
> 5. It ignores errors
> 
> 6. It ignores wrong command line arguments
> 
> Fix this, and simplify things a bit.
> 
> 1. Stop accepting an argument for --systemd.  With getopt_long,
>     this argument, if given, will be returned as a non-optional
>     parameter so compatibility with current version is preserved.
> 
> 2. Accept optional arguments and generate registration for the
>     given CPUs only.  In case no extra arguments are given, register
>     for all supportd CPUs except of the same family as host.
> 
> 3. Recognze "ALL" "CPU" to keep compatibility with current version
>     (but do not document it).
> 
> 4. Warn but perform registration anyway if a cpu of the same family
>     has been requested.
> 
> 5. In help text, use --debian and --systemd as alternatives to each
>     other, to make it clear the two can not be used at the same time.
> 
> 6. Tiny optimization of eval expression.
> 
> 7. Fold the list of supported CPUs to fit in 80 columns.
> 
> 8. Exit with non-zero code in case registration fails or the command
>     line is wrong.
> 
> 9. Remove explicit checking for writability of various things.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   scripts/qemu-binfmt-conf.sh | 89 +++++++++++++++++--------------------
>   1 file changed, 40 insertions(+), 49 deletions(-)


