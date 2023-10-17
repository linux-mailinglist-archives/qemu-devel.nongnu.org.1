Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC6B7CBD19
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 10:10:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsf8r-00037w-Vm; Tue, 17 Oct 2023 04:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qsf8m-00035G-M6
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:09:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qsf8j-00012t-Df
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 04:09:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B7FA32AF32;
 Tue, 17 Oct 2023 11:09:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id ADBAE2F8E8;
 Tue, 17 Oct 2023 11:09:16 +0300 (MSK)
Message-ID: <bdbdc359-5264-482f-be44-a7d82240e688@tls.msk.ru>
Date: Tue, 17 Oct 2023 11:09:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 1/1] Switch memory management calls to new coding
 conventions
Content-Language: en-US
To: ~h0lyalg0rithm <surajshirvankar@gmail.com>, qemu-devel@nongnu.org
Cc: trivial@nongnu.org
References: <169752770397.22503.4110466793478679834-1@git.sr.ht>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <169752770397.22503.4110466793478679834-1@git.sr.ht>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

03.10.2023 15:45, ~h0lyalg0rithm wrote:
> From: Suraj Shirvankar <surajshirvankar@gmail.com>
> 
> Signed-off-by: Suraj Shirvankar <surajshirvankar@gmail.com>
> ---
>   contrib/elf2dmp/addrspace.c |  4 ++--
>   contrib/elf2dmp/main.c      |  6 +++---
>   contrib/elf2dmp/pdb.c       | 16 ++++++++--------
>   contrib/elf2dmp/qemu_elf.c  |  4 ++--
>   4 files changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
> index 64b5d680ad..3bfbb5093c 100644
> --- a/contrib/elf2dmp/addrspace.c
> +++ b/contrib/elf2dmp/addrspace.c
> @@ -72,7 +72,7 @@ int pa_space_create(struct pa_space *ps, QEMU_Elf *qemu_elf)
>           }
>       }
>   
> -    ps->block = malloc(sizeof(*ps->block) * ps->block_nr);
> +    ps->block = g_new(struct pa_block, ps->block_nr);
>       if (!ps->block) {
>           return 1;
>       }

g_new(), unlike malloc(), does not return NULL (unless n_structs, the second
argument, is 0).  So it seems all checks for return value of g_new &Co should
be dropped too, here and in all other places.

/mjt

