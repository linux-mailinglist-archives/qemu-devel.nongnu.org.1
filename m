Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ED376951C
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 13:41:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRHJ-0006HL-SN; Mon, 31 Jul 2023 07:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qQRHG-0005uV-Rx; Mon, 31 Jul 2023 07:41:30 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qQRHF-0005hy-2u; Mon, 31 Jul 2023 07:41:30 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 1F56240737A3;
 Mon, 31 Jul 2023 11:41:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1F56240737A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1690803687;
 bh=Wk5pgdN1dTTryelPNjaYpYlFwHsyAGKC2BDhG8qTcQQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BeHAY1ymIvK3sHqvslDENkExMKwWP+i4u9nfisPKPHpP1oPcJfIOb7lznr3iN33p4
 kzdidQZKjdeFX3r1KU7QIY6uCcJTS9Z/rANlkKC1TjZQvOdMpXe3TTj8AjOiDxxG0G
 B41ooHH6X0Dj50rS4Jr/8y8H6l+lkFKNJI0wek2M=
Message-ID: <37dd252d-53e0-ee53-bc0d-d1bc9a9c76fc@ispras.ru>
Date: Mon, 31 Jul 2023 14:41:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/7] tests/avocado: boot ppc64 pseries replay-record test
 to Linux VFS mount
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-6-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230726183532.434380-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 26.07.2023 21:35, Nicholas Piggin wrote:
> This the ppc64 record-replay test is able to replay the full kernel boot
> so try enabling it.
> 
> Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/avocado/replay_kernel.py | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel.py
> index 79c607b0e7..a18610542e 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -255,8 +255,7 @@ def test_ppc64_pseries(self):
>           kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>   
>           kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
> -        # icount is not good enough for PPC64 for complete boot yet
> -        console_pattern = 'Kernel command line: %s' % kernel_command_line
> +        console_pattern = 'VFS: Cannot open root device'
>           self.run_rr(kernel_path, kernel_command_line, console_pattern)
>   
>       def test_ppc64_powernv(self):


