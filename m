Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2337A99D0
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 20:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjOMa-00009X-Tj; Thu, 21 Sep 2023 14:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjOMV-000069-9u
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 14:25:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qjOMT-0000sc-KJ
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 14:25:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id EF0852408B;
 Thu, 21 Sep 2023 21:25:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E105229D96;
 Thu, 21 Sep 2023 21:25:10 +0300 (MSK)
Message-ID: <fcadf562-1946-0dc0-9f68-95785aacb2c0@tls.msk.ru>
Date: Thu, 21 Sep 2023 21:25:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] accel/tcg: mttcg remove false-negative halted assertion
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Ivan Warren <ivan@vmfacility.fr>
References: <20230829010658.8252-1-npiggin@gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230829010658.8252-1-npiggin@gmail.com>
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

29.08.2023 04:06, Nicholas Piggin wrote:
> mttcg asserts that an execution ending with EXCP_HALTED must have
> cpu->halted. However between the event or instruction that sets
> cpu->halted and requests exit and the assertion here, an
> asynchronous event could clear cpu->halted.
> 
> This leads to crashes running AIX on ppc/pseries because it uses
> H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted = 1 and
> H_PROD sets other cpu->halted = 0 and kicks it.
> 
> H_PROD could be turned into an interrupt to wake, but several other
> places in ppc, sparc, and semihosting follow what looks like a similar
> pattern setting halted = 0 directly. So remove this assertion.
> 
> Reported-by: Ivan Warren <ivan@vmfacility.fr>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

This one also smells like a stable material, is it not?

Thanks,

/mjt

> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index b276262007..d0b6f288d9 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -98,17 +98,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
>               case EXCP_DEBUG:
>                   cpu_handle_guest_debug(cpu);
>                   break;
> -            case EXCP_HALTED:
> -                /*
> -                 * during start-up the vCPU is reset and the thread is
> -                 * kicked several times. If we don't ensure we go back
> -                 * to sleep in the halted state we won't cleanly
> -                 * start-up when the vCPU is enabled.
> -                 *
> -                 * cpu->halted should ensure we sleep in wait_io_event
> -                 */
> -                g_assert(cpu->halted);
> -                break;
>               case EXCP_ATOMIC:
>                   qemu_mutex_unlock_iothread();
>                   cpu_exec_step_atomic(cpu);


