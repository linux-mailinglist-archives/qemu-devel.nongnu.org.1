Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D30C67713D0
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 08:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSXeG-0005Fu-G0; Sun, 06 Aug 2023 02:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSXeE-0005Fl-3q
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 02:53:54 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSXeC-0000st-4w
 for qemu-devel@nongnu.org; Sun, 06 Aug 2023 02:53:53 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9649A18748;
 Sun,  6 Aug 2023 09:54:09 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 986161BB00;
 Sun,  6 Aug 2023 09:53:46 +0300 (MSK)
Message-ID: <2b3f3769-a047-374b-4609-a7add8737f30@tls.msk.ru>
Date: Sun, 6 Aug 2023 09:53:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 07/24] linux-user: Do not call get_errno() in do_brk()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Helge Deller <deller@gmx.de>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <20230806033715.244648-8-richard.henderson@linaro.org>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230806033715.244648-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

06.08.2023 06:36, Richard Henderson wrote:

> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c

> -        mapped_addr = get_errno(target_mmap(brk_page, new_alloc_size,
> -                                        PROT_READ|PROT_WRITE,
> -                                        MAP_ANON|MAP_PRIVATE, 0, 0));
> +        mapped_addr = target_mmap(brk_page, new_alloc_size,
> +                                  PROT_READ|PROT_WRITE,
> +                                  MAP_ANON|MAP_PRIVATE, 0, 0);

Can't we add spaces around "|" here at apply time to make checkpatch happy?
Just a nitpick really..  I thought this will be done in some of the Vn,
but it is not.

/mjt

