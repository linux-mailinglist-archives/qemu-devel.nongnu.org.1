Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE51F82D580
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:04:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPItW-0004kf-A3; Mon, 15 Jan 2024 04:04:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPItT-0004fR-5a
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:04:31 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPItR-0001e8-6Y
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:04:30 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e5afc18f5so43694485e9.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705309467; x=1705914267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4mCRq87oUZtRcqi8srS+YeJ1cxVCExFqlfMsoW0qviM=;
 b=UxcDagBksoAN3noGpw+Nud3ubDvu/xiDVighO0YYwT9OjtgHWo8vj96ZMMP+9x/XDs
 TB2gktU6I0UFDJTBi2yRnrmMpFhxbmxsoWGMRrDyhnk7KK9AygpB5CwiMjh0tLpisZR0
 EbUdx507A5/ColbMGFikCmoLbVVWL8ucbQcqD+oUwz5C9bU058mwMpjUu05WQLOO+GfN
 O87LJEHpZSFGGnwIZMlUTBMqMeu6MGWs+NSaMhuSSlbXnCia2CzUD8sOIh+j0ADCL4Cy
 YRnt/gcyfZA+/ZaGzGwZcM1fjiVVFxDwwuyb4mjk6n2Y8lZ0IiJccwVEba3XVhzziwk8
 mjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705309467; x=1705914267;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4mCRq87oUZtRcqi8srS+YeJ1cxVCExFqlfMsoW0qviM=;
 b=rX9IvUw29wEM1bN8U0G8O1fA5nNbkjpAEaGsdmEw9qYKT4s4fEMR7JK/s5O2DEm+5g
 RVQCQBiZ+eClpPI3LLmzFzM6w26NRPEBQDi4FsaKIl0jrZZtr9TU8XA6OgZD5ypj1hWd
 H2Z0LUeojmcahzm0lRM+H5I3Y0p02Cp+bsxAv6GRFOHNYym+iejOi8z4GpAxRLc+qtTD
 tV3dgaLgRwyCbsWIW6fa+DbmCn7GQuV6R9vz+6IgIQ+NxA4zYgWhz4u4W61udRvRz7WU
 LFqQJf8bYY6fvcrJoBu9FTXz3cHeKS+pRosTztyBqzwxvKf/ZB/6JV455hG1j6trRtQw
 hgBw==
X-Gm-Message-State: AOJu0YzPRqKY1454GA4XCB934a9A95duvebBZA99CDwnot7a88ugwkYT
 Bh1WPld60yg6BpeZ7ouQw6sIr7x6fz3S3w==
X-Google-Smtp-Source: AGHT+IGwjjP4jWVBPEy1iqa2XOhMaKVjiKyibKvcsrvHqMR0bY1Zn2bNILfX+en6dCLrDD8WAb3GPQ==
X-Received: by 2002:a05:600c:3541:b0:40e:530a:7cf2 with SMTP id
 i1-20020a05600c354100b0040e530a7cf2mr2714974wmq.6.1705309466645; 
 Mon, 15 Jan 2024 01:04:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 n10-20020a5d4c4a000000b003366e974cacsm11288976wrt.73.2024.01.15.01.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 01:04:26 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0BA05F756;
 Mon, 15 Jan 2024 09:04:25 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
In-Reply-To: <1b976012-7670-4086-88bb-c5097c8fbe0b@linaro.org> (Pierrick
 Bouvier's message of "Mon, 15 Jan 2024 11:06:01 +0400")
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
 <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
 <ae4227fc-58b5-4a6b-97d5-8fae34eb7514@linaro.org>
 <87v87yv588.fsf@draig.linaro.org>
 <58065fbd-84f9-4a21-beba-6eb2a18c3d0c@linaro.org>
 <87ply5upbc.fsf@draig.linaro.org>
 <1b976012-7670-4086-88bb-c5097c8fbe0b@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 15 Jan 2024 09:04:25 +0000
Message-ID: <87wmsbj7c6.fsf@draig.linaro.org>
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/13/24 21:16, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 1/12/24 21:20, Alex Benn=C3=A9e wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>>>
>>>>> On 1/11/24 19:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>>>>> Hi Pierrick,
>>>>>> On 11/1/24 15:23, Pierrick Bouvier wrote:
>>>>>>> For now, it simply performs instruction, bb and mem count, and ensu=
re
>>>>>>> that inline vs callback versions have the same result. Later, we'll
>>>>>>> extend it when new inline operations are added.
>>>>>>>
>>>>>>> Use existing plugins to test everything works is a bit cumbersome, =
as
>>>>>>> different events are treated in different plugins. Thus, this new o=
ne.
>>>>>>>
>> <snip>
>>>>>>> +#define MAX_CPUS 8
>>>>>> Where does this value come from?
>>>>>>
>>>>>
>>>>> The plugin tests/plugin/insn.c had this constant, so I picked it up
>>>>> from here.
>>>>>
>>>>>> Should the pluggin API provide a helper to ask TCG how many
>>>>>> vCPUs are created?
>>>>>
>>>>> In user mode, we can't know how many simultaneous threads (and thus
>>>>> vcpu) will be triggered by advance. I'm not sure if additional cpus
>>>>> can be added in system mode.
>>>>>
>>>>> One problem though, is that when you register an inline op with a
>>>>> dynamic array, when you resize it (when detecting a new vcpu), you
>>>>> can't change it afterwards. So, you need a storage statically sized
>>>>> somewhere.
>>>>>
>>>>> Your question is good, and maybe we should define a MAX constant that
>>>>> plugins should rely on, instead of a random amount.
>>>> For user-mode it can be infinite. The existing plugins do this by
>>>> ensuring vcpu_index % max_vcpu. Perhaps we just ensure that for the
>>>> scoreboard as well? Of course that does introduce a trap for those usi=
ng
>>>> user-mode...
>>>>
>>>
>>> The problem with vcpu-index % max_vcpu is that it reintroduces race
>>> condition, though it's probably less frequent than on a single
>>> variable. IMHO, yes it solves memory error, but does not solve the
>>> initial problem itself.
>>>
>>> The simplest solution would be to have a size "big enough" for most
>>> cases, and abort when it's reached.
>> Well that is simple enough for system emulation as max_vcpus is a
>> bounded
>> number.
>>=20
>>> Another solution, much more complicated, but correct, would be to move
>>> memory management of plugin scoreboard to plugin runtime, and add a
>>> level of indirection to access it.
>> That certainly gives us the most control and safety. We can then
>> ensure
>> we'll never to writing past the bounds of the buffer. The plugin would
>> have to use an access function to get the pointer to read at the time it
>> cared and of course inline checks should be pretty simple.
>>=20
>>> Every time a new vcpu is added, we
>>> can grow dynamically. This way, the array can grow, and ultimately,
>>> plugin can poke its content/size. I'm not sure this complexity is what
>>> we want though.
>> It doesn't seem too bad. We have a start/end_exclusive is *-user
>> do_fork
>> where we could update pointers. If we are smart about growing the size
>> of the arrays we could avoid too much re-translation.
>>
>
> I was concerned about a potential race when the scoreboard updates
> this pointer, and other cpus are executing tb (using it). But this
> concern is not valid, since start_exclusive ensures all other cpus are
> stopped.
>
> vcpu_init_hook function in plugins/core.c seems a good location to add
> this logic. We would check if an update is needed, then
> start_exclusive(), update the scoreboard and exit exclusive section.

It might already be in the exclusive section. We should try and re-use
an existing exclusive region rather than adding a new one. It's
expensive so best avoided if we can.

> Do you think it's worth to try to inline scoreboard pointer (and flush
> all tb when updated), instead of simply adding an indirection to it?
> With this, we could avoid any need to re-translate anything.

Depends on the cost/complexity of the indirection I guess.
Re-translation isn't super expensive if we say double the size of the
score board each time we need to.

>> Do we want a limit of one scoreboard per thread? Can we store structures
>> in there?
>>=20
>
> From the current plugins use case, it seems that several scoreboards
> are needed.
> Allowing structure storage seems a bit more tricky to me, because
> since memory may be reallocated, users won't be allowed to point
> directly to it. I would be in favor to avoid this (comments are
> welcome).

The init function can take a sizeof(entry) field and the inline op can
have an offset field (which for the simple 0 case can be folded away by
TCG).

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

