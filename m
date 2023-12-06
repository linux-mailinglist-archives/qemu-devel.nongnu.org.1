Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 857F9806F49
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 12:58:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAqWa-0003Zk-1F; Wed, 06 Dec 2023 06:57:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAqWX-0003ZX-24
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:57:05 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rAqWU-0008Bm-HH
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 06:57:04 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c19f5f822so3092625e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 03:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701863820; x=1702468620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vuxNSu+oTHQhtygHH9yFYdd7YCL2+UIhzuJdQIpfBGw=;
 b=A8L+EDaS2fROAWQwn92La+5t2ChzPBXaXj9V5ajLI272fX0S9YyKo73eu8HnY9cOAA
 ifqH83jFSjC2esThUqos1Mcxwrw7VZ+zrmbKBZylIki65odmziuOcYe6uy6peWocunIO
 E9dusiOODNkuVus4hRMMhXMwee4e+AfgmUSiripvcRVwjZN+BmL6b+jGn4xqeyRLz1ZN
 0xClOyas1iCpTWfoKoDQyP38bpcVB3kEnFaPVlztu3Vo6gN3QupQsnS7UnEvhuLV1KU3
 5zutDAYaZX92WapS0Li3IxrU+ZNqF2HZZ6LsI4mZKRu6vZaqBO3P5HSaCoKNI/Q6cOjJ
 UCag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701863820; x=1702468620;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vuxNSu+oTHQhtygHH9yFYdd7YCL2+UIhzuJdQIpfBGw=;
 b=bwT6QQChyIbJGaCbtxV4BT84SBbOdUz2q3J6MiyhTl+ZhD9l97/ShFDeuICF1cu5Wi
 0C+l0X0d0fuNf918o0Saci5rJjc1QTdLb+OhcFrila7v2t0ATTb9BQoxrC37pijyFjED
 JpuQqo8X2niGbJ/5hf8mSBR+tTom+Udf/qDzAY7SAymr2vne9W+JVbozACfKeuVwN6ek
 L99IaDNioCS2HAi3gr/WcvKBMh0iaSeR2DsQXuHtlcJjlYlDhStlEKS+ny0RPpo1UVk+
 BIrB/Pecl23ir2gwd34Gw+Ub2DzB1Bjblq0UDrhPzcEEnMAbPuq0vB9aCV8qS0zMLSfY
 SW1A==
X-Gm-Message-State: AOJu0YzLVb83kikJ4W/ofbsSM2x56abaSOVTUvFE6TBBmajeYlW5Zl7J
 jr4lewnpp7XwUfLS22jYkDETuw==
X-Google-Smtp-Source: AGHT+IEQCpR/j33hqfVULzRE3JMz90+qi8Fm1hPPCohIub65NoMYjib1N/RIi9+yRd10gAj149BDkg==
X-Received: by 2002:a05:600c:6009:b0:40c:1de7:41d5 with SMTP id
 az9-20020a05600c600900b0040c1de741d5mr420208wmb.87.1701863820612; 
 Wed, 06 Dec 2023 03:57:00 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jg23-20020a05600ca01700b0040b30be6244sm21699578wmb.24.2023.12.06.03.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 03:57:00 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9C265FBC2;
 Wed,  6 Dec 2023 11:56:59 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Richard
 Henderson <richard.henderson@linaro.org>,  Wainer dos Santos Moschetta
 <wainersm@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?M?=
 =?utf-8?Q?arc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  John Snow <jsnow@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Subject: Re: [PATCH 06/11] replay: add proper kdoc for ReplayState
In-Reply-To: <b5868a4c-7711-46d8-ae6d-32595cec8e2d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 6 Dec 2023 12:27:56
 +0100")
References: <20231205204106.95531-1-alex.bennee@linaro.org>
 <20231205204106.95531-7-alex.bennee@linaro.org>
 <b5868a4c-7711-46d8-ae6d-32595cec8e2d@linaro.org>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Wed, 06 Dec 2023 11:56:59 +0000
Message-ID: <8734wfee7o.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 5/12/23 21:41, Alex Benn=C3=A9e wrote:
>> Remove the non-standard comment formatting and move the descriptions
>> into a proper kdoc comment.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>   replay/replay-internal.h               | 27 ++++++++++++++++----------
>
> ~~~
>
>>   roms/SLOF                              |  2 +-
>>   tests/tcg/i386/Makefile.softmmu-target | 19 ++++++++++++++++++
>>   3 files changed, 37 insertions(+), 11 deletions(-)
>> diff --git a/replay/replay-internal.h b/replay/replay-internal.h
>> index 516147ddbc..98ca3748ed 100644
>> --- a/replay/replay-internal.h
>> +++ b/replay/replay-internal.h
>> @@ -63,24 +63,31 @@ enum ReplayEvents {
>>       EVENT_COUNT
>>   };
>>   +/**
>> + * typedef ReplayState - global tracking Replay state
>> + *
>> + * This structure tracks where we are in the current ReplayState
>> + * including the logged events from the recorded replay stream. Some
>> + * of the data is also stored/restored from VMStateDescription when VM
>> + * save/restore events take place.
>> + *
>> + * @cached_clock: Cached clocks values
>> + * @current_icount: number of processed instructions
>> + * @instruction_count: number of instructions until next event
>> + * @data_kind: current event
>> + * @has_unread_data: 1 if event not yet processed
>> + * @file_offset: offset into replay log at replay snapshot
>> + * @block_request_id: current serialised block request id
>> + * @read_event_id: current async read event id
>> + */
>>   typedef struct ReplayState {
>> -    /*! Cached clock values. */
>>       int64_t cached_clock[REPLAY_CLOCK_COUNT];
>> -    /*! Current icount - number of processed instructions. */
>>       uint64_t current_icount;
>> -    /*! Number of instructions to be executed before other events happe=
n. */
>>       int instruction_count;
>> -    /*! Type of the currently executed event. */
>>       unsigned int data_kind;
>> -    /*! Flag which indicates that event is not processed yet. */
>>       unsigned int has_unread_data;
>> -    /*! Temporary variable for saving current log offset. */
>>       uint64_t file_offset;
>> -    /*! Next block operation id.
>> -        This counter is global, because requests from different
>> -        block devices should not get overlapping ids. */
>>       uint64_t block_request_id;
>> -    /*! Asynchronous event id read from the log */
>>       uint64_t read_event_id;
>>   } ReplayState;
>>   extern ReplayState replay_state;
>
> Up to here:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
> The rest doesn't belong to this commit:

Oops, I missed that when rushing this out last night... will delete.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

