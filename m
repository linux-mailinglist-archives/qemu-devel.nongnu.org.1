Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6397F773841
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 08:37:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTGKR-0002qA-AQ; Tue, 08 Aug 2023 02:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qTGKO-0002lz-Lo; Tue, 08 Aug 2023 02:36:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qTGKM-0000mJ-Ea; Tue, 08 Aug 2023 02:36:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A33B518D86;
 Tue,  8 Aug 2023 09:36:20 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B6E011C2A7;
 Tue,  8 Aug 2023 09:36:17 +0300 (MSK)
Message-ID: <c8bf0c5f-6cc8-cc1b-9b26-bcb2512bcc87@tls.msk.ru>
Date: Tue, 8 Aug 2023 09:36:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] linux-user/elfload: Set V in ELF_HWCAP for RISC-V
Content-Language: en-US
To: Nathan Egge <negge@xiph.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liweiwei@iscas.ac.cn>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20230803131424.40744-1-negge@xiph.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230803131424.40744-1-negge@xiph.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.809,
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

03.08.2023 16:14, Nathan Egge wrote:
> From: "Nathan Egge" <negge@xiph.org>
> 
> Set V bit for hwcap if misa is set.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1793
> Signed-off-by: Nathan Egge <negge@xiph.org>
> ---
>   linux-user/elfload.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index 861ec07abc..a299ba7300 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -1710,7 +1710,8 @@ static uint32_t get_elf_hwcap(void)
>   #define MISA_BIT(EXT) (1 << (EXT - 'A'))
>       RISCVCPU *cpu = RISCV_CPU(thread_cpu);
>       uint32_t mask = MISA_BIT('I') | MISA_BIT('M') | MISA_BIT('A')
> -                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C');
> +                    | MISA_BIT('F') | MISA_BIT('D') | MISA_BIT('C')
> +                    | MISA_BIT('V');

Is smells like a -stable material (incl. 7.2), is it not?

Thanks,

/mjt

