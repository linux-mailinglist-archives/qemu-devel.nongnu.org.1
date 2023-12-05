Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABE0805861
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 16:17:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAX9f-0002Qy-T8; Tue, 05 Dec 2023 10:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAX9Z-0002Qc-Vp
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 10:16:06 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAX9W-00030w-Ov
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 10:16:05 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c09f4814eso33713445e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 07:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701789360; x=1702394160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FLnmuz9FhvBovi3ahpMQ5/kuAT4WJ7ncivqeKb68Kq0=;
 b=JF/HQMcSGmVXRFzJnAQ/M2mfIFuVtuvXWn4RlINX3jf6/IVSOF2PeVmxJpeOB70K0Q
 t1sgsVunlXSyg5sU+07OsWxQbTm4E4b/c9UASTbcUQEOzBilZ/IdOTq/gqtzB1LUhCZH
 ifS/pFc0TEMMl8kUAVosRyItM9VkW3XBHZXqnW3791zC8VO3XtZbFkKvhdPxbIxVQe8P
 qL7n/44UB/7x9qXV5a4PykgWYXje2+QUNikpdDQEmXGtQAU9la2ZoCPu+VMHY7MXMsoG
 Ss/QoHO036eIrza8LsWOexhwjU71Z/SEOp6N6OREhmim/CXqq4pcz6Cy5wt9UJPD/8gY
 hIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701789360; x=1702394160;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FLnmuz9FhvBovi3ahpMQ5/kuAT4WJ7ncivqeKb68Kq0=;
 b=Hyp2djSGVfQracWGp0p97FZCBl+6VVwCWvzQCPMzU28xRVOff1tTOuzxyUWHQmqw67
 1U63ceY1QGdfsrccgseXHiAWhaC2hNUDC1il5giXKVOw3Jhqf7tIX7WJwe3C4rIaDp5U
 BOUQswi2VBYwlLwjOVbvzd9mBu8IEzGKW1iZmZ5OI8z7CoSWvvhIIbn8kNXI2a3cW5yP
 R0A3VnJw6flSmexHBdjcIheVNCeDxBc6280RMFeQbpwPtTPmlqzUnCjKZlbPPCmJUwy7
 MzQtYzVDBNt/QzVVKmafnR/GT5izbG7y0Dl9hJHV2g81zhDhAgJntjbqGUQWwaHgaPlU
 RtGQ==
X-Gm-Message-State: AOJu0YxM5NfpydvpjnVLOXJLJlRW3ppDlOnBoJq5kWHMM01rgqWf18yv
 m10IcOHa4e62laXxLvbxdfF1/g==
X-Google-Smtp-Source: AGHT+IGCbc1F+eoOEff6DoEsQppIqIFxvQy99/RIZf6G5eS0s7Q873uoIsKNQJuoRPquQc7SkWy9ew==
X-Received: by 2002:a05:600c:1988:b0:40b:5e21:dd43 with SMTP id
 t8-20020a05600c198800b0040b5e21dd43mr655991wmq.113.1701789360613; 
 Tue, 05 Dec 2023 07:16:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bh12-20020a05600c3d0c00b0040b2976eb02sm19029498wmb.10.2023.12.05.07.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 07:16:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B56BA5FBB6;
 Tue,  5 Dec 2023 15:15:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] replay: stop us hanging in rr_wait_io_event
In-Reply-To: <CAFEAcA85p9C=D8QZ9Ew8xMSVZgtVAOgQ0h7xBkPAKMZFci5uPQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 5 Dec 2023 14:10:56 +0000")
References: <20231205121420.3287637-1-alex.bennee@linaro.org>
 <CAFEAcA85p9C=D8QZ9Ew8xMSVZgtVAOgQ0h7xBkPAKMZFci5uPQ@mail.gmail.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 05 Dec 2023 15:15:59 +0000
Message-ID: <871qc0fzo0.fsf@draig.linaro.org>
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 5 Dec 2023 at 12:15, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> A lot of the hang I see are when we end up spinning in
>> rr_wait_io_event for an event that will never come in playback. As a
>> new check functions which can see if we are in PLAY mode and kick us
>> us the wait function so the event can be processed.
>>
>> This fixes most of the failures in replay_kernel.py
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
>> ---
>>  include/sysemu/replay.h      |  5 +++++
>>  accel/tcg/tcg-accel-ops-rr.c |  2 +-
>>  replay/replay.c              | 24 ++++++++++++++++++++++++
>>  3 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sysemu/replay.h b/include/sysemu/replay.h
>> index 08aae5869f..83995ae4bd 100644
>> --- a/include/sysemu/replay.h
>> +++ b/include/sysemu/replay.h
>> @@ -70,6 +70,11 @@ int replay_get_instructions(void);
>>  /*! Updates instructions counter in replay mode. */
>>  void replay_account_executed_instructions(void);
>>
>> +/**
>> + * replay_can_wait: check if we should pause for wait-io
>> + */
>> +bool replay_can_wait(void);
>> +
>>  /* Processing clocks and other time sources */
>>
>>  /*! Save the specified clock */
>> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
>> index 611932f3c3..825e35b3dc 100644
>> --- a/accel/tcg/tcg-accel-ops-rr.c
>> +++ b/accel/tcg/tcg-accel-ops-rr.c
>> @@ -109,7 +109,7 @@ static void rr_wait_io_event(void)
>>  {
>>      CPUState *cpu;
>>
>> -    while (all_cpu_threads_idle()) {
>> +    while (all_cpu_threads_idle() && replay_can_wait()) {
>>          rr_stop_kick_timer();
>>          qemu_cond_wait_iothread(first_cpu->halt_cond);
>>      }
>> diff --git a/replay/replay.c b/replay/replay.c
>> index 0f7d766efe..e71cdbf819 100644
>> --- a/replay/replay.c
>> +++ b/replay/replay.c
>> @@ -338,6 +338,30 @@ void replay_start(void)
>>      replay_enable_events();
>>  }
>>
>> +/*
>> + * For none/record the answer is yes.
>> + */
>> +bool replay_can_wait(void)
>> +{
>> +    if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
>> +        /*
>> +         * For playback we shouldn't ever be at a point we wait. If
>
> This comment sounds like "this can't happen, but it does for
> some reason we don't understand" ... Is there some bug somewhere
> that we're papering over here ?

I don't think so - it really is just a difference in behaviour needed
here between record and playback. If we short cut earlier then that
would make the code harder to follow and introduce another potential
point of divergence.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

