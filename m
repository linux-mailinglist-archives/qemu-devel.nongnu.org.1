Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 869617A43BF
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 10:01:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi9B1-0000WK-5s; Mon, 18 Sep 2023 04:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qi9Ar-0000Tx-LP
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:00:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qi9Ap-0006st-60
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 04:00:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-402cc6b8bedso47834925e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 01:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695024001; x=1695628801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6zeIurlH3uEU5f58WGLrTvbnPlsnb7onYC+BiTHDnjI=;
 b=x13YHY24tXnid+DfkOkb/OrH7bSv2ZR+jExltWKueWB5sEAUiticxOvAAX3/iXYHaU
 KTON/X6lVG8fJ63WLvF7L3gjCnkFRDtLu/O5QQeA88V+st3kjIZ1odh311CZEnfOJgWf
 0tBwc/AYwmhP/ggMwTvlvgbrRciwLG+USCiTryFudJeN1xL2j86EXMQV5ZbPaqNScWeE
 pq0BeQVLrfxGPG30rZFCWatDsS/11NnH4Hrs+pQckvZSXMKZSY6W37QLWJ1tpj/2UKkU
 D5itFISCFT6FKSch7g82fclA+8Hm/zLlxXx+c11lIVwllAHsq9ttTo803hVFZKi5kTMN
 Mjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695024001; x=1695628801;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6zeIurlH3uEU5f58WGLrTvbnPlsnb7onYC+BiTHDnjI=;
 b=huk97NeICkVMqToq7ckBniR44dsm+rxEsI6vypkC0/tew2/rvVMpg3OGdw9pYmsfPx
 BjLL7xGGk6k6bdJGj/5V/nxK4KEP9d3LZdhuijgcG2tn+TUWVJigBOjU5QAUAQOYqa/o
 7HZHqpp8cC0ZafKBWnFSucrqhkzz1mjcEopjXESvYZLVTpA+Ip2UEC+H4rn+4gLwjnYn
 XNrkQNs15qrL5Kqu++aQGi0tTC8SBQI7qux8VCN2S9mzxGj4hHO3RVFE/WlMEY2KrFDN
 248f+Vcgp3cAOA3pd9z/azEnXOY5CdxGqHYWa6DfJVrBD6FrbT8O50Al5YlKG1AVokA1
 yN7A==
X-Gm-Message-State: AOJu0Yz0ed4b+b+ikAr2VnptGnS2HeQLjX5RizwHMb2DBG/Qspz3oCJE
 JEJyFyRaNbfLldZhogVBvP2RDQ==
X-Google-Smtp-Source: AGHT+IFmtV/pBk7JkJFW2ooTX0Rm6bZhO7CftHTBPnofdLS4/ePKq9uG3LaPA1l/PG6CbxfR6YgwLw==
X-Received: by 2002:a5d:624b:0:b0:317:5849:c2e0 with SMTP id
 m11-20020a5d624b000000b003175849c2e0mr6478166wrv.9.1695024001054; 
 Mon, 18 Sep 2023 01:00:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a5d4645000000b003214fc12a30sm2464770wrs.106.2023.09.18.01.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 01:00:00 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 343371FFBB;
 Mon, 18 Sep 2023 09:00:00 +0100 (BST)
References: <20230916033011.479144-1-richard.henderson@linaro.org>
 <20230916033011.479144-2-richard.henderson@linaro.org>
 <CVLU8T2IALFW.1BIYIZ1T0NEJ6@wheely>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Ivan Warren
 <ivan@vmfacility.fr>, qemu-devel@nongnu.org
Subject: Re: [PULL 01/39] accel/tcg: mttcg remove false-negative halted
 assertion
Date: Mon, 18 Sep 2023 08:59:01 +0100
In-reply-to: <CVLU8T2IALFW.1BIYIZ1T0NEJ6@wheely>
Message-ID: <87v8c7x668.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


"Nicholas Piggin" <npiggin@gmail.com> writes:

> On Sat Sep 16, 2023 at 1:29 PM AEST, Richard Henderson wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> mttcg asserts that an execution ending with EXCP_HALTED must have
>> cpu->halted. However between the event or instruction that sets
>> cpu->halted and requests exit and the assertion here, an
>> asynchronous event could clear cpu->halted.
>>
>> This leads to crashes running AIX on ppc/pseries because it uses
>> H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted =3D 1 and
>> H_PROD sets other cpu->halted =3D 0 and kicks it.
>>
>> H_PROD could be turned into an interrupt to wake, but several other
>> places in ppc, sparc, and semihosting follow what looks like a similar
>> pattern setting halted =3D 0 directly. So remove this assertion.
>>
>> Reported-by: Ivan Warren <ivan@vmfacility.fr>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Message-Id: <20230829010658.8252-1-npiggin@gmail.com>
>> [rth: Keep the case label and adjust the comment.]
>
> Hey Richard,
>
> Thanks for picking this up.
>
> I think EXCP_HLT and EXCP_HALTED are effectively the same, so they could
> be merged after this.
>
> I couldn't quite decipher the intended difference between them, HLT is
> "hlt instruction reached", but it does tend to go into a mode where it
> is halted waiting for external event. Is there some useful difference in
> semantics we should retain (and at least try to find a way to assert)?

I always thought HALTED was where the system was halted (e.g. during a
shutdown) but I agree its less than clear.

Do both effectively end up in wait_for_io for some event to start the
loop again?

>
> I did look at how to avoid the halted race and keep the assert, e.g.,
> have the CPU only modify its own halted, and external events would have
> a wakeup field to set. In the end it wasn't clear that that was any
> simpler and you still have races to reason about, now between the two
> fields. So unless someone wants to keep both, should we merge?
>
> Thanks,
> Nick
>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  accel/tcg/tcg-accel-ops-mttcg.c | 9 ++-------
>>  1 file changed, 2 insertions(+), 7 deletions(-)
>>
>> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-m=
ttcg.c
>> index b276262007..4b0dfb4be7 100644
>> --- a/accel/tcg/tcg-accel-ops-mttcg.c
>> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
>> @@ -100,14 +100,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
>>                  break;
>>              case EXCP_HALTED:
>>                  /*
>> -                 * during start-up the vCPU is reset and the thread is
>> -                 * kicked several times. If we don't ensure we go back
>> -                 * to sleep in the halted state we won't cleanly
>> -                 * start-up when the vCPU is enabled.
>> -                 *
>> -                 * cpu->halted should ensure we sleep in wait_io_event
>> +                 * Usually cpu->halted is set, but may have already been
>> +                 * reset by another thread by the time we arrive here.
>>                   */
>> -                g_assert(cpu->halted);
>>                  break;
>>              case EXCP_ATOMIC:
>>                  qemu_mutex_unlock_iothread();


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

