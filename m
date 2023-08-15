Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1D077CD8F
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 15:52:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVuSV-0005N0-3J; Tue, 15 Aug 2023 09:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qVuSS-0005Mc-6U
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 09:51:40 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qVuSP-0001ii-Ew
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 09:51:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 03C211A8DE;
 Tue, 15 Aug 2023 16:51:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CDDED1F5C1;
 Tue, 15 Aug 2023 16:51:23 +0300 (MSK)
Message-ID: <35fa0e0c-ca69-a84a-02a0-4edcac65adb6@tls.msk.ru>
Date: Tue, 15 Aug 2023 16:51:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 00/14] linux-user image mapping fixes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230808210856.95568-1-richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Akihiko Odaki <akihiko.odaki@daynix.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230808210856.95568-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

09.08.2023 00:08, Richard Henderson пишет:
> The following changes since commit 0450cf08976f9036feaded438031b4cba94f6452:
> 
>    Merge tag 'fixes-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-08-07 13:55:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/rth7680/qemu.git tags/pull-lu-20230808
> 
> for you to fetch changes up to dd55885516f42f718d0d121c59a5f7be5fdae3e6:
> 
>    linux-user: Rewrite non-fixed probe_guest_base (2023-08-08 13:41:55 -0700)
> 
> ----------------------------------------------------------------
> linux-user: Adjust guest image layout vs reserved_va
> linux-user: Do not adjust image mapping for host page size
> linux-user: Adjust initial brk when interpreter is close to executable
> util/selfmap: Rewrite using qemu/interval-tree.h
> linux-user: Rewrite probe_guest_base
> 
> ----------------------------------------------------------------
> Helge Deller (1):
>        linux-user: Adjust initial brk when interpreter is close to executable
> 
> Richard Henderson (13):
>        linux-user: Adjust task_unmapped_base for reserved_va
>        linux-user: Define TASK_UNMAPPED_BASE in $guest/target_mman.h
>        linux-user: Define ELF_ET_DYN_BASE in $guest/target_mman.h
>        linux-user: Use MAP_FIXED_NOREPLACE for initial image mmap
>        linux-user: Use elf_et_dyn_base for ET_DYN with interpreter
>        linux-user: Do not adjust image mapping for host page size
>        linux-user: Do not adjust zero_bss for host page size
>        linux-user: Use zero_bss for PT_LOAD with no file contents too
>        util/selfmap: Rewrite using qemu/interval-tree.h
>        linux-user: Remove duplicate CPU_LOG_PAGE from probe_guest_base
>        linux-user: Consolidate guest bounds check in probe_guest_base
>        linux-user: Rewrite fixed probe_guest_base
>        linux-user: Rewrite non-fixed probe_guest_base

Is there anything in there and in other linux-user late fixes which are applicable to 8.0?
Or should we declare 8.0 as semi-broken and be done with it?

Thanks,

/mjt


