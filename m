Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C778051A
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 06:25:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWr3I-0003Bg-4D; Fri, 18 Aug 2023 00:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qWr36-0003BL-Tu
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 00:25:26 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qWr34-0003v0-8d
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 00:25:24 -0400
Received: from [192.168.8.104] (unknown [94.25.229.58])
 by mail.ispras.ru (Postfix) with ESMTPSA id 2566940F1DE1;
 Fri, 18 Aug 2023 04:25:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 2566940F1DE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1692332720;
 bh=g3sW/rv4STPmk0kfIfxoXmmWUxSSbc7vHYGv1NcJLUM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZRkWAEM0+cKXkTU3/tEuiOYKL4atIXSsf9AbifzU6QNUeWAhuDuN7QodqUpDVLqgT
 anxgE+NNrjlcBs9M6B2dncjFCUPDnjoPNyDUHFksbhJxUTIh6fPGMJAltk568sglKm
 kwKmmxRmayf/gY+yJSnlELn9eDNMCH2iwoXGCWbg=
Message-ID: <f7114265-8c24-2b7a-a1d0-8073ecd878d8@ispras.ru>
Date: Fri, 18 Aug 2023 07:25:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] replay: allow runstate shutdown->running when
 replaying trace
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?0JTQvtCy0LPQsNC70Y7QuiDQn9Cw0LLQtdC7?= <Pavel.Dovgalyuk@ispras.ru>
References: <20230814163135.187882-1-npiggin@gmail.com>
 <20230814163135.187882-4-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230814163135.187882-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.01,
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

Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 14.08.2023 19:31, Nicholas Piggin wrote:
> When replaying a trace, it is possible to go from shutdown to
> running with a reverse-debugging step. This can be useful if the
> problem being debugged triggers a reset or shutdown.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   include/sysemu/runstate.h |  1 +
>   replay/replay.c           |  2 ++
>   softmmu/runstate.c        | 19 +++++++++++++++++++
>   3 files changed, 22 insertions(+)
> 
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 7beb29c2e2..85a1167ccb 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -9,6 +9,7 @@ void runstate_set(RunState new_state);
>   RunState runstate_get(void);
>   bool runstate_is_running(void);
>   bool runstate_needs_reset(void);
> +void runstate_replay_enable(void);
>   
>   typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
>   
> diff --git a/replay/replay.c b/replay/replay.c
> index 0f7d766efe..e64f71209a 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -272,6 +272,8 @@ static void replay_enable(const char *fname, int mode)
>           /* go to the beginning */
>           fseek(replay_file, HEADER_SIZE, SEEK_SET);
>           replay_fetch_data_kind();
> +
> +        runstate_replay_enable();
>       }
>   
>       replay_init_events();
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index f3bd862818..9fd3e57485 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -174,6 +174,12 @@ static const RunStateTransition runstate_transitions_def[] = {
>       { RUN_STATE__MAX, RUN_STATE__MAX },
>   };
>   
> +static const RunStateTransition replay_runstate_transitions_def[] = {
> +    { RUN_STATE_SHUTDOWN, RUN_STATE_RUNNING},
> +
> +    { RUN_STATE__MAX, RUN_STATE__MAX },
> +};
> +
>   static bool runstate_valid_transitions[RUN_STATE__MAX][RUN_STATE__MAX];
>   
>   bool runstate_check(RunState state)
> @@ -181,6 +187,19 @@ bool runstate_check(RunState state)
>       return current_run_state == state;
>   }
>   
> +void runstate_replay_enable(void)
> +{
> +    const RunStateTransition *p;
> +
> +    assert(replay_mode == REPLAY_MODE_PLAY);
> +
> +    for (p = &replay_runstate_transitions_def[0]; p->from != RUN_STATE__MAX;
> +         p++) {
> +        runstate_valid_transitions[p->from][p->to] = true;
> +    }
> +
> +}
> +
>   static void runstate_init(void)
>   {
>       const RunStateTransition *p;


