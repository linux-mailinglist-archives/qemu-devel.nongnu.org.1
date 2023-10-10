Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7DD7BFD4E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 15:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqCiP-0003sC-Ig; Tue, 10 Oct 2023 09:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqCiM-0003re-QC
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:23:58 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qqCiL-00030i-4z
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 09:23:58 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4054496bde3so52237355e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 06:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696944235; x=1697549035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oSbEU/VKtsZhPVFseW39qTts4UXpxYlWLqx6piOYmBg=;
 b=N6lXSIq0hpsi22UFjqlYzaHnykQ3q2vxvlXuFkjjn7cQSa4xPGK8jlaLG4lxwHvteo
 ZoPyYwX82ffG6fpEeIJjg7cjzA+N3CwcdQpavso8Ci9s449gFzn1sO+dth5U6uyudSzq
 HM5mM+PV/ffKG0d/2ZyBo8+nV/MRWMEIQ8DJFyxXH8aDgSFLwjwVzykTbOnmefkMXwaM
 88pPPMNchJPtibAHSZVyJqXE0sPAfKtC3kVK0HWtaWtU1qWLlrcFPyAhfp+6NSnqJCN1
 U7dbpZBZFVh+r7il/5QfLMMIS8BcQZgVIGWkkmBGef0JcCbGrPMzAZ0PaqaddJh+z8uO
 7STQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696944235; x=1697549035;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oSbEU/VKtsZhPVFseW39qTts4UXpxYlWLqx6piOYmBg=;
 b=vi25G9VBQE5Byr5Tsuwa6QfVWvDYDy3uoVck8HlsT3y2O5piHTyoC9HjtIiAE/VtzP
 vg2Yloqs7hUvW012hFCphOUTQkZxNjlW3gN/1NLm2BshFOXqD5Jse8BX3uOeFeR/b3Tv
 4DT//LpjjViXvEf1HztRlxbdCyyDu5B5KF6EhBuwPW87gl8NMWmelsHdIreY+GzOsfhI
 2QTf4aKSOcsmgSTW9JjxNhhg0ukvDLHu8s77YtkO1bXMxquEIj6ClwTVjQ1v5jPt/NNA
 FRFMMx8I1FwNa1JK3MMlZFUuJPmqH0h7pVNFT98xN/oiGmi6KU8iQVsUYzClF9tKnnnk
 M62w==
X-Gm-Message-State: AOJu0YzjvS7Xbf7dtyxnctSQFgnpw6UFcWvuhX+n1nbRqbpIy5OqUGwK
 JNxUkz1hdVnFkfBcZ7ZPDKw2+w==
X-Google-Smtp-Source: AGHT+IFGYpRQSZMVrVV2nJ7MmVqnwhcNgsTUSjzKl7oLjQvSPRsH+KCzv35C3BekIOQPqkxLCRIRTA==
X-Received: by 2002:a1c:6a17:0:b0:401:db82:3edf with SMTP id
 f23-20020a1c6a17000000b00401db823edfmr16145868wmc.39.1696944235143; 
 Tue, 10 Oct 2023 06:23:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e24-20020a05600c219800b004013797efb6sm16419018wme.9.2023.10.10.06.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 06:23:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2630D1FFBB;
 Tue, 10 Oct 2023 14:23:54 +0100 (BST)
References: <20231003183058.1639121-1-richard.henderson@linaro.org>
 <20231003183058.1639121-17-richard.henderson@linaro.org>
 <b8911ed0-9eae-a0d0-1b32-61876d4ee55a@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, fei2.wu@intel.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v17 16/16] accel/tcg: Dump hot TBs at the end of the
 execution
Date: Tue, 10 Oct 2023 14:23:25 +0100
In-reply-to: <b8911ed0-9eae-a0d0-1b32-61876d4ee55a@linaro.org>
Message-ID: <87cyxmpq51.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 3/10/23 20:30, Richard Henderson wrote:
>> From: Fei Wu <fei2.wu@intel.com>
>> Dump the hottest TBs if -d
>> tb_stats:{all,jit,exec}[:dump_num_at_exit]
>> Signed-off-by: Fei Wu <fei2.wu@intel.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   bsd-user/bsd-proc.h    |  2 ++
>>   include/tcg/tb-stats.h | 10 +++++++++-
>>   accel/tcg/monitor.c    |  8 +++++---
>>   accel/tcg/tb-stats.c   | 27 ++++++++++++++++++++++++++-
>>   linux-user/exit.c      | 10 ++++++----
>>   softmmu/runstate.c     |  2 ++
>>   stubs/tb-stats.c       |  6 +++++-
>>   util/log.c             | 20 ++++++++++++++++----
>>   8 files changed, 71 insertions(+), 14 deletions(-)
>
>
>> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
>> index 1652ed0439..2c6fb9bff1 100644
>> --- a/softmmu/runstate.c
>> +++ b/softmmu/runstate.c
>> @@ -59,6 +59,7 @@
>>   #include "sysemu/runstate-action.h"
>>   #include "sysemu/sysemu.h"
>>   #include "sysemu/tpm.h"
>> +#include "tcg/tb-stats.h"
>>   #include "trace.h"
>>     static NotifierList exit_notifiers =3D
>> @@ -846,6 +847,7 @@ void qemu_cleanup(void)
>>       /* No more vcpu or device emulation activity beyond this point */
>>       vm_shutdown();
>>       replay_finish();
>> +    tb_stats_dump_atexit();
>>         /*
>>        * We must cancel all block jobs while the block layer is drained,
>> diff --git a/stubs/tb-stats.c b/stubs/tb-stats.c
>> index ceaa1622ce..f9e4ef5d04 100644
>> --- a/stubs/tb-stats.c
>> +++ b/stubs/tb-stats.c
>> @@ -11,6 +11,10 @@
>>   #include "qemu/osdep.h"
>>   #include "tcg/tb-stats.h"
>>   -void tb_stats_init(uint32_t flags)
>> +void tb_stats_init(uint32_t flags, uint32_t atexit)
>> +{
>> +}
>> +
>> +void tb_stats_dump_atexit(void)
>>   {
>>   }
>
> The stub isn't needed using:
>
> -- >8 --
> diff --git a/softmmu/runstate.c b/softmmu/runstate.c
> index 2c6fb9bff1..d05e2b8e1c 100644
> --- a/softmmu/runstate.c
> +++ b/softmmu/runstate.c
> @@ -52,6 +52,7 @@
>  #include "qom/object.h"
>  #include "qom/object_interfaces.h"
>  #include "sysemu/cpus.h"
> +#include "sysemu/tcg.h"
>  #include "sysemu/qtest.h"
>  #include "sysemu/replay.h"
>  #include "sysemu/reset.h"
> @@ -847,7 +848,9 @@ void qemu_cleanup(void)
>      /* No more vcpu or device emulation activity beyond this point */
>      vm_shutdown();
>      replay_finish();
> -    tb_stats_dump_atexit();
> +    if (tcg_enabled()) {
> +        tb_stats_dump_atexit();
> +    }

Why be different from replay_finish() which is a stub?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

