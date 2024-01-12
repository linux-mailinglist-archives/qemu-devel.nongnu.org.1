Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F49882C49B
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 18:21:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOLCZ-0005hc-C3; Fri, 12 Jan 2024 12:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOLCX-0005ge-93
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:20:13 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOLCV-0005B5-I0
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 12:20:13 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40e69b3149fso2542825e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 09:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705080008; x=1705684808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HtsDhMYKOKsjd91F/+T1+Lyev80i16Rq3EWcOFNBNTQ=;
 b=I1nicZg043L1eK64Lj/Nl9detqQ7JyW9MepEz5fShBOaMr59eok1qpi7FVbfzz3Xn7
 hRME2doWk2l2zwKip8ny3FPKYTUYEX1rLDxojyqdR5/HC97n8rUOx/HC6P0IWzIB4j0Y
 oodFY6qUmZZPAgLEju7vQ2VuIRjmCn6tY06vgw+8kU4YVM9jTBa6LeYSTO2zQ4zjTWAA
 r+rC5lMmcrtj/0VYGG8bKbF7OnkPRLzfULBd3NtKOBSyBZrpfIbzfovqlRDwQ8FZaseB
 ckxgA4C1vgwdqaDXqLBtifkxwFcp/9TUns1LIHB1JaH6BRDMSBiwSN3/V/vFXpLnUJ6R
 1pNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705080008; x=1705684808;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HtsDhMYKOKsjd91F/+T1+Lyev80i16Rq3EWcOFNBNTQ=;
 b=N/XwqviLGwo+RG1BdnhKebTi7mln5z4bQR3y/JRyBiXa4An+JhGHnZfrl18XxQcp0e
 AJ7rq/trIjkh70lfq/0CBpNrMHYvjG7NA/AXYpPBRjxoVTMQgtr0e2O1fMiz6QZ8ED8s
 AR9TVs7s3RrxW/feeHln/FctGeXvjW2QntjxgNQux+/jk8PD0jDR6Yaboe4xGUSxF+HP
 bNQF1owebD2CopOnxknoYf2DkkwiLrnQpnjBcsbIsIlrgkr+nAjKiRuECVNED2l5CE0V
 K2Eg+JyqLHRz/d5YrH9cNy0GROHLro876hA0Y78upUDbQ8IuK27IncqVlPTR31tjQ6cu
 DbPw==
X-Gm-Message-State: AOJu0YzF28TVjyEmUPGMC3TN4h1iZeFv3cysasx2obApp70Np5PtwJd5
 eFssJF8/4MgICM79klEji0cS/5Gc80+3Ng==
X-Google-Smtp-Source: AGHT+IHWO+SI1kHVsXsALJ0XuUzbOhGXMcrQibGnVLuflujWOVfD5M4kKKfeWoL08In/Klye6LfcNw==
X-Received: by 2002:a05:600c:4d95:b0:40e:5577:17e with SMTP id
 v21-20020a05600c4d9500b0040e5577017emr1091309wmp.57.1705080008607; 
 Fri, 12 Jan 2024 09:20:08 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c310e00b0040e398f8cafsm6423311wmo.31.2024.01.12.09.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 09:20:08 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EA1D45F7A9;
 Fri, 12 Jan 2024 17:20:07 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH 03/12] tests/plugin: add test plugin for inline operations
In-Reply-To: <ae4227fc-58b5-4a6b-97d5-8fae34eb7514@linaro.org> (Pierrick
 Bouvier's message of "Thu, 11 Jan 2024 21:20:45 +0400")
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
 <20240111142326.1743444-4-pierrick.bouvier@linaro.org>
 <49bfa786-e549-43d4-ac03-9337b9342d16@linaro.org>
 <ae4227fc-58b5-4a6b-97d5-8fae34eb7514@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 12 Jan 2024 17:20:07 +0000
Message-ID: <87v87yv588.fsf@draig.linaro.org>
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 1/11/24 19:57, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Pierrick,
>> On 11/1/24 15:23, Pierrick Bouvier wrote:
>>> For now, it simply performs instruction, bb and mem count, and ensure
>>> that inline vs callback versions have the same result. Later, we'll
>>> extend it when new inline operations are added.
>>>
>>> Use existing plugins to test everything works is a bit cumbersome, as
>>> different events are treated in different plugins. Thus, this new one.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    tests/plugin/inline.c    | 183 +++++++++++++++++++++++++++++++++++++=
++
>>>    tests/plugin/meson.build |   2 +-
>>>    2 files changed, 184 insertions(+), 1 deletion(-)
>>>    create mode 100644 tests/plugin/inline.c
>>=20
>>> +#define MAX_CPUS 8
>> Where does this value come from?
>>=20
>
> The plugin tests/plugin/insn.c had this constant, so I picked it up
> from here.
>
>> Should the pluggin API provide a helper to ask TCG how many
>> vCPUs are created?
>
> In user mode, we can't know how many simultaneous threads (and thus
> vcpu) will be triggered by advance. I'm not sure if additional cpus
> can be added in system mode.
>
> One problem though, is that when you register an inline op with a
> dynamic array, when you resize it (when detecting a new vcpu), you
> can't change it afterwards. So, you need a storage statically sized
> somewhere.
>
> Your question is good, and maybe we should define a MAX constant that
> plugins should rely on, instead of a random amount.

For user-mode it can be infinite. The existing plugins do this by
ensuring vcpu_index % max_vcpu. Perhaps we just ensure that for the
scoreboard as well? Of course that does introduce a trap for those using
user-mode...

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

