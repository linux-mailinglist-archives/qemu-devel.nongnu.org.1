Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1652809E30
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 09:34:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBWIP-00036s-BT; Fri, 08 Dec 2023 03:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBWIN-00036i-GB
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:33:15 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rBWIK-0001ed-Uy
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 03:33:15 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 6B04740F1DF1;
 Fri,  8 Dec 2023 08:32:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6B04740F1DF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1702024367;
 bh=1HQ/ti44f7IhMh36hnPSfYoTd6+22qLPyTiOGnBu6Q8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=qHjf5vlRk5DXeKUN+fuSe4/YMJBMK71NzBefD7I2KAZk69S1sqUorifbO+pexBCN7
 07jXearCD5U/InUoc1ZrD0l5z/yG4QTn75cUsyEi9kOaxChFd531Fttu8EHeGXxB6Q
 pakDbkYGydZCMAgGLkpJ3E0fO/Z1jLDwGn9OAEjs=
Message-ID: <31284d80-cad0-41f4-8f4b-d09f7146df19@ispras.ru>
Date: Fri, 8 Dec 2023 11:32:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] replay: stop us hanging in rr_wait_io_event
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-10-alex.bennee@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231205204106.95531-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05.12.2023 23:41, Alex Bennée wrote:
> A lot of the hang I see are when we end up spinning in
> rr_wait_io_event for an event that will never come in playback. As a
> new check functions which can see if we are in PLAY mode and kick us
> us the wait function so the event can be processed.
> 
> This fixes most of the failures in replay_kernel.py

Is there an effect for console QEMU only?
I've tested this patch on Windows7 boot scenario and replay speed has 
not changed.

> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2013
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> ---
>   include/sysemu/replay.h      |  5 +++++
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   replay/replay.c              | 24 ++++++++++++++++++++++++
>   3 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
> index 08aae5869f..83995ae4bd 100644
> --- a/include/sysemu/replay.h
> +++ b/include/sysemu/replay.h
> @@ -70,6 +70,11 @@ int replay_get_instructions(void);
>   /*! Updates instructions counter in replay mode. */
>   void replay_account_executed_instructions(void);
>   
> +/**
> + * replay_can_wait: check if we should pause for wait-io
> + */
> +bool replay_can_wait(void);
> +
>   /* Processing clocks and other time sources */
>   
>   /*! Save the specified clock */
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 611932f3c3..825e35b3dc 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>   {
>       CPUState *cpu;
>   
> -    while (all_cpu_threads_idle()) {
> +    while (all_cpu_threads_idle() && replay_can_wait()) {
>           rr_stop_kick_timer();
>           qemu_cond_wait_iothread(first_cpu->halt_cond);
>       }
> diff --git a/replay/replay.c b/replay/replay.c
> index e83c01285c..042a6a9636 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -347,6 +347,30 @@ void replay_start(void)
>       replay_enable_events();
>   }
>   
> +/*
> + * For none/record the answer is yes.
> + */
> +bool replay_can_wait(void)
> +{
> +    if (replay_mode == REPLAY_MODE_PLAY) {
> +        /*
> +         * For playback we shouldn't ever be at a point we wait. If
> +         * the instruction count has reached zero and we have an
> +         * unconsumed event we should go around again and consume it.
> +         */
> +        if (replay_state.instruction_count == 0 && replay_state.has_unread_data) {
> +            return false;
> +        } else {
> +            fprintf(stderr, "Error: Invalid replay state\n");
> +            fprintf(stderr,"instruction_count = %d, has = %d, event_kind = %d\n",
> +                    replay_state.instruction_count, replay_state.has_unread_data, replay_state.data_kind);
> +            abort();
> +        }
> +    }
> +    return true;
> +}
> +
> +
>   void replay_finish(void)
>   {
>       if (replay_mode == REPLAY_MODE_NONE) {


