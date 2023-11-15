Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E77EBF2E
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 10:11:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3BuP-0008Kq-FD; Wed, 15 Nov 2023 04:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3BuJ-0008EA-FO; Wed, 15 Nov 2023 04:09:59 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r3BuC-00006v-1o; Wed, 15 Nov 2023 04:09:58 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B8D5336C5;
 Wed, 15 Nov 2023 12:10:06 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5E368353B3;
 Wed, 15 Nov 2023 12:09:45 +0300 (MSK)
Message-ID: <0dc785c6-c36a-4b0e-99bc-400e751ebe2a@tls.msk.ru>
Date: Wed, 15 Nov 2023 12:09:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] linux-user: Fix loaddr computation for some elf
 files
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-stable@nongnu.org
References: <20231114201742.183271-1-richard.henderson@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231114201742.183271-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

14.11.2023 23:17, Richard Henderson:
> The file offset of the load segment is not relevant to the
> low address, only the beginning of the virtual address page.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: a93934fecd4 ("elf: take phdr offset into account when calculating the program load address")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1952
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

> ---
>   linux-user/elfload.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 4cd6891d7b..cf9e74468b 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3308,7 +3308,7 @@ static void load_elf_image(const char *image_name, const ImageSource *src,
>       for (i = 0; i < ehdr->e_phnum; ++i) {
>           struct elf_phdr *eppnt = phdr + i;
>           if (eppnt->p_type == PT_LOAD) {
> -            abi_ulong a = eppnt->p_vaddr - eppnt->p_offset;
> +            abi_ulong a = eppnt->p_vaddr & TARGET_PAGE_MASK;
>               if (a < loaddr) {
>                   loaddr = a;
>               }


