Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 978CD82CDE2
	for <lists+qemu-devel@lfdr.de>; Sat, 13 Jan 2024 18:17:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOhcQ-0006Gv-D9; Sat, 13 Jan 2024 12:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOhcJ-0006GU-Lc
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 12:16:19 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOhcG-0000YP-Cu
 for qemu-devel@nongnu.org; Sat, 13 Jan 2024 12:16:17 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40e6bf323e8so6267575e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Jan 2024 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705166169; x=1705770969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D83np26d29so0xKhh8+B47qA4sP5mVp3UG9FG1xy/NA=;
 b=bfPztIRnJlfp0xniZjDyfEAL6UW0CcG2Lr1j5PfEZXdDkO3BH+Y9ZmbG7+LeW2Idxx
 og32P8TitkKKqB2Pq5dmxVi2W0tOqDisoCIF3U2617+3ubOBKu7OEcMJz1SnIlBQXwvT
 S3D6XnaXccJL43zGsC3bYL1taYF34VlgEzXh4snBPg4U/w9Efv8m4kERazSYczrKcBj8
 89dVUVwIGA1Ln3NQkPW6SCPt8AbY7F8qGNGrlpI/0qL9uNeWaoDU+NjkPaNOexONmBfu
 NMjcA3jmcmbqqPEjHHQRSOe5DFSONiM5WcrBuCT3cuWZb13ZYuDDHf+XDGK5K5WrKuW/
 Jkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705166169; x=1705770969;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D83np26d29so0xKhh8+B47qA4sP5mVp3UG9FG1xy/NA=;
 b=REaMC9AMBk6mP5JZmFilq4L7NhiVeBcO01odYhrMP9LSWvOynA+zWRS8Abj47gYyB9
 j51b2Fw4yxtVkBF7+4r6W3FFGrn92lr/ZJAT4PnVvM7woAbL88mkc5pnCI2Ks9Muu2zG
 Wa0wbklXnXq6NpLHTJxKUV4yt7adpL5V7kuIuCYNogHEbuhW+HnKPfxLcMBQm6+irmy2
 +GngN8243PxcU03S+09bKpT6360er0MftPrdxJU8OlEAINSw2QdyMfwYXI2WdLhAoy0/
 f8mfAxZGvf4FTT8sjVtFlqCk+Ta2sUJoSOYIZTxVKfmRPOzTnGQbEgNC+MUPBAeK15Xn
 YtIg==
X-Gm-Message-State: AOJu0Yya29e2YNH2OU8xRe0Xq6zT3Y4O30NmDbUBvehB6mER6BNKF/NV
 gpwYT72xMFkvrmCv/vG3a46TVsEz0+90uw==
X-Google-Smtp-Source: AGHT+IHyUmGCpBBxhi4Im+x5tKWqKyMiMR6T3UMQq5vYi1WcN+hjwpls+o1BUG/UN0A0XUhh65XU/g==
X-Received: by 2002:a05:600c:1e16:b0:40e:6fb5:d6bd with SMTP id
 ay22-20020a05600c1e1600b0040e6fb5d6bdmr298438wmb.120.1705166168671; 
 Sat, 13 Jan 2024 09:16:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j7-20020a05600c190700b0040e52cac976sm13712340wmq.29.2024.01.13.09.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jan 2024 09:16:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CEE935F8A2;
 Sat, 13 Jan 2024 17:16:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
In-Reply-To: <58065fbd-84f9-4a21-beba-6eb2a18c3d0c@linaro.org> (Pierrick
 Bouvier's message of "Sat, 13 Jan 2024 09:16:27 +0400")
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
 <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
 <ae4227fc-58b5-4a6b-97d5-8fae34eb7514@linaro.org>
 <87v87yv588.fsf@draig.linaro.org>
 <58065fbd-84f9-4a21-beba-6eb2a18c3d0c@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Sat, 13 Jan 2024 17:16:07 +0000
Message-ID: <87ply5upbc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

> On 1/12/24 21:20, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
>>=20
>>> On 1/11/24 19:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Hi Pierrick,
>>>> On 11/1/24 15:23, Pierrick Bouvier wrote:
>>>>> For now, it simply performs instruction, bb and mem count, and ensure
>>>>> that inline vs callback versions have the same result. Later, we'll
>>>>> extend it when new inline operations are added.
>>>>>
>>>>> Use existing plugins to test everything works is a bit cumbersome, as
>>>>> different events are treated in different plugins. Thus, this new one.
>>>>>
<snip>
>>>>> +#define MAX_CPUS 8
>>>> Where does this value come from?
>>>>
>>>
>>> The plugin tests/plugin/insn.c had this constant, so I picked it up
>>> from here.
>>>
>>>> Should the pluggin API provide a helper to ask TCG how many
>>>> vCPUs are created?
>>>
>>> In user mode, we can't know how many simultaneous threads (and thus
>>> vcpu) will be triggered by advance. I'm not sure if additional cpus
>>> can be added in system mode.
>>>
>>> One problem though, is that when you register an inline op with a
>>> dynamic array, when you resize it (when detecting a new vcpu), you
>>> can't change it afterwards. So, you need a storage statically sized
>>> somewhere.
>>>
>>> Your question is good, and maybe we should define a MAX constant that
>>> plugins should rely on, instead of a random amount.
>> For user-mode it can be infinite. The existing plugins do this by
>> ensuring vcpu_index % max_vcpu. Perhaps we just ensure that for the
>> scoreboard as well? Of course that does introduce a trap for those using
>> user-mode...
>>=20
>
> The problem with vcpu-index % max_vcpu is that it reintroduces race
> condition, though it's probably less frequent than on a single
> variable. IMHO, yes it solves memory error, but does not solve the
> initial problem itself.
>
> The simplest solution would be to have a size "big enough" for most
> cases, and abort when it's reached.

Well that is simple enough for system emulation as max_vcpus is a bounded
number.

> Another solution, much more complicated, but correct, would be to move
> memory management of plugin scoreboard to plugin runtime, and add a
> level of indirection to access it.

That certainly gives us the most control and safety. We can then ensure
we'll never to writing past the bounds of the buffer. The plugin would
have to use an access function to get the pointer to read at the time it
cared and of course inline checks should be pretty simple.

> Every time a new vcpu is added, we
> can grow dynamically. This way, the array can grow, and ultimately,
> plugin can poke its content/size. I'm not sure this complexity is what
> we want though.

It doesn't seem too bad. We have a start/end_exclusive is *-user do_fork
where we could update pointers. If we are smart about growing the size
of the arrays we could avoid too much re-translation.

Do we want a limit of one scoreboard per thread? Can we store structures
in there?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

