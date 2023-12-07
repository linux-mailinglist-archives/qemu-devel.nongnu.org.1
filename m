Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4793808359
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 09:40:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB9uL-0004R4-Bl; Thu, 07 Dec 2023 03:38:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rB9uH-0004Q9-Az
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:38:53 -0500
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rB9uC-0005yG-Jb
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 03:38:53 -0500
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 7599F40737A7;
 Thu,  7 Dec 2023 08:38:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 7599F40737A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1701938320;
 bh=RfzWKG4B4Y4qVOEoEexV21wxLqd6YUbYdOModQ6iLpg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=aWFJ6uFtVItcqVFdhktSPfl8lovZSRuIx6I9fpdj7G6vQyoT91k7tVSeFavrR/nTG
 CtyNOpXDmQ9uiiQYEQbLk/gVjMLi9lE7qkvZwS+8AAjDp0tSt//dDkcrMXdSBCNLye
 2aUInyZq0aa35a5Io75BVTZIFDjBFdaVU27SBWP4=
Message-ID: <f97a429d-bcc5-4a05-8adf-bd9c98182ecb@ispras.ru>
Date: Thu, 7 Dec 2023 11:38:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] replay: add proper kdoc for ReplayState
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
 <20231205204106.95531-7-alex.bennee@linaro.org>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20231205204106.95531-7-alex.bennee@linaro.org>
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
> Remove the non-standard comment formatting and move the descriptions
> into a proper kdoc comment.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   replay/replay-internal.h               | 27 ++++++++++++++++----------
>   roms/SLOF                              |  2 +-
>   tests/tcg/i386/Makefile.softmmu-target | 19 ++++++++++++++++++
>   3 files changed, 37 insertions(+), 11 deletions(-)
> 
> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
> index 516147ddbc..98ca3748ed 100644
> --- a/replay/replay-internal.h
> +++ b/replay/replay-internal.h
> @@ -63,24 +63,31 @@ enum ReplayEvents {
>       EVENT_COUNT
>   };
>   
> +/**
> + * typedef ReplayState - global tracking Replay state
> + *
> + * This structure tracks where we are in the current ReplayState
> + * including the logged events from the recorded replay stream. Some
> + * of the data is also stored/restored from VMStateDescription when VM
> + * save/restore events take place.
> + *
> + * @cached_clock: Cached clocks values
> + * @current_icount: number of processed instructions
> + * @instruction_count: number of instructions until next event
> + * @data_kind: current event
> + * @has_unread_data: 1 if event not yet processed
> + * @file_offset: offset into replay log at replay snapshot
> + * @block_request_id: current serialised block request id
> + * @read_event_id: current async read event id
> + */
>   typedef struct ReplayState {
> -    /*! Cached clock values. */
>       int64_t cached_clock[REPLAY_CLOCK_COUNT];
> -    /*! Current icount - number of processed instructions. */
>       uint64_t current_icount;
> -    /*! Number of instructions to be executed before other events happen. */
>       int instruction_count;
> -    /*! Type of the currently executed event. */
>       unsigned int data_kind;
> -    /*! Flag which indicates that event is not processed yet. */
>       unsigned int has_unread_data;
> -    /*! Temporary variable for saving current log offset. */
>       uint64_t file_offset;
> -    /*! Next block operation id.
> -        This counter is global, because requests from different
> -        block devices should not get overlapping ids. */
>       uint64_t block_request_id;
> -    /*! Asynchronous event id read from the log */
>       uint64_t read_event_id;
>   } ReplayState;
>   extern ReplayState replay_state;


Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>


