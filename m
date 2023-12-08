Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A99DB809F59
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBXBC-00051Y-0r; Fri, 08 Dec 2023 04:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBXB9-00051E-9y
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:29:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBXB6-0004ci-R4
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:29:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c0f3a7717so21391665e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702027787; x=1702632587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MZ2NUAW9GBv4EhC+zX8wBBObpJHQmCYL3Kl2yTMxRqA=;
 b=nzh8NURlloh1GA+ytDUbUySBQrlYbRntz4JD+KT+NOeg32C/QoHuXYQ8BMl4a/G75i
 Vt22jV6WJM6ubHwkyzSGYElf4/9uwDVkqkKCzafhybXaDsZEVncJYStqx3/tlfjGfRva
 Vhcsmuna6H8Wakq9GiAIQ9p46o/F9DzAkKsYr96ynjbK8xItloILFttpdHPmelZBA+7m
 twlBuGAQsYXam0C3MhnPrbmQzisc3fCcF6VjODFK5ybS8bWAZ4vaLoekqAi+po8dZJ8h
 ei8gnsoA8xXWxnerl0g+2ZjhtEG5PGYWfLxlN6133RPfr/H0MSn5uFo2F4zETAz/floF
 Ba0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702027787; x=1702632587;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MZ2NUAW9GBv4EhC+zX8wBBObpJHQmCYL3Kl2yTMxRqA=;
 b=R3RVwGj9UXGNWUm6bg57n00Tzbqyx8Na7WDbmZmgoP/I/8m2t3mEbCsjRVy54/BYp4
 H60aZNnpmXpP7iwhwzzJ9caAFPJHc6JnPKMctAVT+Xq8vKmILy3zN5zJ3Kvzb7PGd/js
 3jfkZsDLm3PmGDdlRyHfehA/mum0m41UviMrxKH/BUi6p/IGLugMbN32bFfBpGpmGfwd
 Ra8ifuoAQ4YETE4ux45+RKuNYT7LejMDKDlqCccnkui7ZNPyK5WKUdxYubCxVbpt1ePK
 zyQt4zaFtrFOeajXBZHKH+DicKEPynwC5I6Ntnca9LP9W0IR414JAGuLiFEoJeI1YMAK
 hUQg==
X-Gm-Message-State: AOJu0YzH7od2KF8rQjNDYShEPH1mFXpFkZsq8dGMckYxy2B36ijI/lle
 SwD+k1fwiRMBdQ0U5BtpYo2nnw==
X-Google-Smtp-Source: AGHT+IGbxAGjc5kv13AxPcHQCAOYkcmgmmDN9RG4q7udjl/f+sRi0qwoeMIDjf64CemPziL33+j1/Q==
X-Received: by 2002:a05:600c:4da4:b0:40c:2305:ccfc with SMTP id
 v36-20020a05600c4da400b0040c2305ccfcmr972984wmp.160.1702027787025; 
 Fri, 08 Dec 2023 01:29:47 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fk10-20020a05600c0cca00b0040b3d8907fesm2273183wmb.29.2023.12.08.01.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 01:29:46 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5B3E85FB61;
 Fri,  8 Dec 2023 09:29:46 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Richard
 Henderson <richard.henderson@linaro.org>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  John Snow <jsnow@redhat.com>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>
Subject: Re: [PATCH 09/11] replay: stop us hanging in rr_wait_io_event
In-Reply-To: <31284d80-cad0-41f4-8f4b-d09f7146df19@ispras.ru> (Pavel
 Dovgalyuk's message of "Fri, 8 Dec 2023 11:32:47 +0300")
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-10-alex.bennee@linaro.org>
 <31284d80-cad0-41f4-8f4b-d09f7146df19@ispras.ru>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Fri, 08 Dec 2023 09:29:46 +0000
Message-ID: <87plzhxcs5.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru> writes:

> On 05.12.2023 23:41, Alex Benn=C3=A9e wrote:
>> A lot of the hang I see are when we end up spinning in
>> rr_wait_io_event for an event that will never come in playback. As a
>> new check functions which can see if we are in PLAY mode and kick us
>> us the wait function so the event can be processed.
>> This fixes most of the failures in replay_kernel.py
>
> Is there an effect for console QEMU only?
> I've tested this patch on Windows7 boot scenario and replay speed has
> not changed.

It was a lock up I was seeing (because once it was in this mode what was
going to wake it up). It could be outside of running in avocado some
other random event woke things up and allowed stuff to progress. However
I think this is a correctness issue, when would we ever wait for io
during playback?

>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2013
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> ---
>>   include/sysemu/replay.h      |  5 +++++
>>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>>   replay/replay.c              | 24 ++++++++++++++++++++++++
>>   3 files changed, 30 insertions(+), 1 deletion(-)
>> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
>> index 08aae5869f..83995ae4bd 100644
>> --- a/include/sysemu/replay.h
>> +++ b/include/sysemu/replay.h
>> @@ -70,6 +70,11 @@ int replay_get_instructions(void);
>>   /*! Updates instructions counter in replay mode. */
>>   void replay_account_executed_instructions(void);
>>   +/**
>> + * replay_can_wait: check if we should pause for wait-io
>> + */
>> +bool replay_can_wait(void);
>> +
>>   /* Processing clocks and other time sources */
>>     /*! Save the specified clock */
>> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
>> index 611932f3c3..825e35b3dc 100644
>> --- a/accel/tcg/tcg-accel-ops-rr.c
>> +++ b/accel/tcg/tcg-accel-ops-rr.c
>> @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>>   {
>>       CPUState *cpu;
>>   -    while (all_cpu_threads_idle()) {
>> +    while (all_cpu_threads_idle() && replay_can_wait()) {
>>           rr_stop_kick_timer();
>>           qemu_cond_wait_iothread(first_cpu->halt_cond);
>>       }
>> diff --git a/replay/replay.c b/replay/replay.c
>> index e83c01285c..042a6a9636 100644
>> --- a/replay/replay.c
>> +++ b/replay/replay.c
>> @@ -347,6 +347,30 @@ void replay_start(void)
>>       replay_enable_events();
>>   }
>>   +/*
>> + * For none/record the answer is yes.
>> + */
>> +bool replay_can_wait(void)
>> +{
>> +    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
>> +        /*
>> +         * For playback we shouldn't ever be at a point we wait. If
>> +         * the instruction count has reached zero and we have an
>> +         * unconsumed event we should go around again and consume it.
>> +         */
>> +        if (replay_state.instruction_count =3D=3D 0 && replay_state.has=
_unread_data) {
>> +            return false;
>> +        } else {
>> +            fprintf(stderr, "Error: Invalid replay state\n");
>> +            fprintf(stderr,"instruction_count =3D %d, has =3D %d, event=
_kind =3D %d\n",
>> +                    replay_state.instruction_count, replay_state.has_un=
read_data, replay_state.data_kind);
>> +            abort();
>> +        }
>> +    }
>> +    return true;
>> +}
>> +
>> +
>>   void replay_finish(void)
>>   {
>>       if (replay_mode =3D=3D REPLAY_MODE_NONE) {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

