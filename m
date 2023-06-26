Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6988A73D8E4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 09:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDh2C-0005bP-AI; Mon, 26 Jun 2023 03:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDh1r-0005TG-5z; Mon, 26 Jun 2023 03:52:57 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qDh1n-0003g5-F9; Mon, 26 Jun 2023 03:52:53 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id F176A40737AB;
 Mon, 26 Jun 2023 07:52:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F176A40737AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1687765964;
 bh=n+eMetsDhSvOTUX5kzVqe3hENZNnTDRExBirIMOvons=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IcGWQ9Kwc+FVwp9poFh8OzS9n6rlZvWCLb6ZAzYRoJnUJfKWJTFns6vROlsw+c1UP
 PJF7wEgzEKR9hQbHjNbxEAxKFvIJUAVgdwYdrrh2SIkzPJrNtCR48fbwC8TFUKYpGx
 x8nI0/48P3f2uzX+FEPa39Dn27bdT0LN2CR2l4ok=
Message-ID: <fea8df75-8836-de32-5a9e-1b63320bdc2d@ispras.ru>
Date: Mon, 26 Jun 2023 10:52:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/7] target/ppc: Fix timebase reset with record-replay
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230623125707.323517-1-npiggin@gmail.com>
 <20230623125707.323517-6-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230623125707.323517-6-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 23.06.2023 15:57, Nicholas Piggin wrote:
> Timebase save uses a random number for a legacy vmstate field, which
> makes rr snapshot loading unbalanced. The easiest way to deal with this
> is just to skip the rng if record-replay is active.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/ppc/ppc.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> index 82e4408c5c..7b7db30f95 100644
> --- a/hw/ppc/ppc.c
> +++ b/hw/ppc/ppc.c
> @@ -32,6 +32,7 @@
>   #include "qemu/main-loop.h"
>   #include "qemu/error-report.h"
>   #include "sysemu/kvm.h"
> +#include "sysemu/replay.h"
>   #include "sysemu/runstate.h"
>   #include "kvm_ppc.h"
>   #include "migration/vmstate.h"
> @@ -933,8 +934,14 @@ static void timebase_save(PPCTimebase *tb)
>           return;
>       }
>   
> -    /* not used anymore, we keep it for compatibility */
> -    tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
> +    if (replay_mode == REPLAY_MODE_NONE) {
> +        /* not used anymore, we keep it for compatibility */
> +        tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
> +    } else {
> +        /* simpler for record-replay to avoid this event, compat not needed */
> +        tb->time_of_the_day_ns = 0;
> +    }
> +
>       /*
>        * tb_offset is only expected to be changed by QEMU so
>        * there is no need to update it from KVM here


