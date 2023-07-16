Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09825754E8E
	for <lists+qemu-devel@lfdr.de>; Sun, 16 Jul 2023 14:06:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qL0VQ-0001sH-R4; Sun, 16 Jul 2023 08:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0VH-0001rt-43; Sun, 16 Jul 2023 08:05:31 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qL0VC-0003yR-A5; Sun, 16 Jul 2023 08:05:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D79761425D;
 Sun, 16 Jul 2023 15:05:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D973D14F35;
 Sun, 16 Jul 2023 15:05:17 +0300 (MSK)
Message-ID: <02d123c8-92c6-c7e2-02df-d9ed9d9ba980@tls.msk.ru>
Date: Sun, 16 Jul 2023 15:05:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/6] trivial-patches for 2023-07-16
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
References: <20230716115801.1505288-1-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230716115801.1505288-1-mjt@tls.msk.ru>
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

16.07.2023 14:57, Michael Tokarev пишет:
> The following changes since commit 7d07a21ec003724475566073404c5893e36de5e5:
> 
>    tree-wide spelling fixes in comments and some messages: hw/9pfs (2023-07-16 13:59:17 +0300)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git/ tags/trivial-patches-pull
> 
> for you to fetch changes up to 7d07a21ec003724475566073404c5893e36de5e5:
> 
>    tree-wide spelling fixes in comments and some messages: hw/9pfs (2023-07-16 13:59:17 +0300)
> 
> ----------------------------------------------------------------
> trivial-patches for 2023-07-16
> 
> This contains a doc fix for riscv and reviewed spelling fixes.
> ----------------------------------------------------------------

This meant to be a PULL request, not PATCH series.. :)

Thanks,

/mjt

