Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC737487F5
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:27:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4PA-0003CU-Iz; Wed, 05 Jul 2023 11:26:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qH4P5-00035U-DQ; Wed, 05 Jul 2023 11:26:51 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qH4P3-0004eY-1k; Wed, 05 Jul 2023 11:26:51 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C185B11ABE;
 Wed,  5 Jul 2023 18:26:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 84D89130BB;
 Wed,  5 Jul 2023 18:26:43 +0300 (MSK)
Message-ID: <d60d3c9b-9ba1-2833-6f6a-825b6c4f4f8c@tls.msk.ru>
Date: Wed, 5 Jul 2023 18:26:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] linux-user/syscall: Implement execve without execveat
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, richard.henderson@linaro.org, sir@cmpwn.com,
 philmd@linaro.org, qemu-stable <qemu-stable@nongnu.org>
References: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230705121023.973284-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

05.07.2023 15:10, Pierrick Bouvier wrote:
> Support for execveat syscall was implemented in 55bbe4 and is available
> since QEMU 8.0.0. It relies on host execveat, which is widely available
> on most of Linux kernels today.
> 
> However, this change breaks qemu-user self emulation, if "host" qemu
> version is less than 8.0.0. Indeed, it does not implement yet execveat.
> This strange use case happens with most of distribution today having
> binfmt support.
> 
> With a concrete failing example:
> $ qemu-x86_64-7.2 qemu-x86_64-8.0 /bin/bash -c /bin/ls
> /bin/bash: line 1: /bin/ls: Function not implemented
> -> not implemented means execve returned ENOSYS
> 
> qemu-user-static 7.2 and 8.0 can be conveniently grabbed from debian
> packages qemu-user-static* [1].
> 
> One usage of this is running wine-arm64 from linux-x64 (details [2]).
> This is by updating qemu embedded in docker image that we ran into this
> issue.
> 
> The solution to update host qemu is not always possible. Either it's
> complicated or ask you to recompile it, or simply is not accessible
> (GitLab CI, GitHub Actions). Thus, it could be worth to implement execve
> without relying on execveat, which is the goal of this patch.
> 
> This patch was tested with example presented in this commit message.
> 
> [1] http://ftp.us.debian.org/debian/pool/main/q/qemu/
> [1] https://www.linaro.org/blog/emulate-windows-on-arm/
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-stable@nongnu.org

Thanks!

/mjt

