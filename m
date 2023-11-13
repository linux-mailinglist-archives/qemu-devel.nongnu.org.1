Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AE77EA528
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 21:59:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2e13-0003gK-4O; Mon, 13 Nov 2023 15:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r2e11-0003f8-9C
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 15:58:39 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r2e0z-00031m-Nu
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 15:58:39 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-407da05f05aso36377415e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 12:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699909115; x=1700513915; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBelecFYBtrmBk8y0jdQcFKeVZWrMTzcnwnM92VKGKU=;
 b=MFietOFmrqZw6DXzfCHFwuWoMFcU4/BJzfeKSBDhbLEJ+u1KrTni2HJ2QeUb+GmA6h
 m9PuSgFR70QpfYMXPnW1jLyQHB/9ImaXyZlChpz9KaGwaAkbUB+WD9O01AojulDhc+8t
 xpCeyohVOJ4w+963XabR3AOpNbvEIvwxdHrw4QkoSuUwl/8lvd+uLdZTB+r8Sk7VUKB4
 nf4W+gkMeO1OmdOz8kOEnNWHDTys3Af3Atd+iNLY+jE8SsnVGPmEiAGSfc+PZ69FkHoE
 +Xk6X/d+hKPqTcZsbF7BYCMbH+rbssZhscYIrWZVc0eSfTdUV4ij0HbOFjuuK3EodC2z
 e/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699909115; x=1700513915;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zBelecFYBtrmBk8y0jdQcFKeVZWrMTzcnwnM92VKGKU=;
 b=lB0u2Sqm08J3ZIri67xfFy6ZRR6p1Jx9TyBseGK2YGu83zTpRMCEN2yZN8AdLQWv1P
 Ad76GWEopfJG2lQZJkabKdbwhKjmPajPYZP7yw+Nicx5R1AlZSwWkCHEfkxbEYqI89Mo
 x9bMFJ0fAyKFAlBs6dYc8z4fLDfOiKYQWeXvbR7+w8l11C3z80B6DGytHa0K8MPUX5rD
 mxfudB2eedimHwv0f37sR2yqzIAARV45nJffZblt6oZmX6Wb7O2Noyf0jIBsTV7y5tYB
 wAnLeIg2KtMfQjNJ7FTS2IQ1a7/c1JNJySsqfPQuswMA25PE0CcaMAp3qZCWVrq5YqnZ
 P38w==
X-Gm-Message-State: AOJu0YwvUnneo5TPmT9ZfficHZqh4tcO0JM7qWE9urWnjSdeiFkOZgjP
 lpUaVEFap5868TQXAXHY43Fcwg==
X-Google-Smtp-Source: AGHT+IF9HlHPW+JdZYjQ27oc7SAdlNq/phUWAlEvRVtIvOa17DZDrsLyXE5ukirbpvkNo4IXfqkfGg==
X-Received: by 2002:a05:600c:45c6:b0:40a:4436:e037 with SMTP id
 s6-20020a05600c45c600b0040a4436e037mr5560480wmo.35.1699909115503; 
 Mon, 13 Nov 2023 12:58:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c231a00b004064741f855sm9029195wmo.47.2023.11.13.12.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 12:58:35 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 96A035F787;
 Mon, 13 Nov 2023 20:58:34 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: Re: Instruction virtual address in TCG Plugins
In-Reply-To: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com> (Mikhail Tyutin's
 message of "Mon, 13 Nov 2023 18:33:48 +0000")
References: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Mon, 13 Nov 2023 20:58:34 +0000
Message-ID: <87leb1xtdx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

Mikhail Tyutin <m.tyutin@yadro.com> writes:

> Greetings,
>
> What is the right way to get virtual address of either translation block =
or instruction inside of TCG plugin? Does
> plugin API allow that or it needs some extension?
>
> So far I use qemu_plugin_tb_vaddr() inside of my block translation callba=
ck to get block virtual address and then
> pass it as 'userdata' argument into qemu_plugin_register_vcpu_tb_exec_cb(=
). I use it later during code execution.
> It works well for user-mode emulation, but sometimes leads to
> incorrect addresses in system-mode emulation.

You can use qemu_plugin_insn_vaddr and qemu_plugin_insn_haddr. But your
right something under one vaddr and be executed under another with
overlapping mappings. The haddr should be stable though I think.

> I suspect it is because of memory mappings by guest OS that changes virtu=
al addresses for that block.
>
> I also looked at gen_empty_udata_cb() function and considered to extend p=
lugin API to pass a program counter
> value as additional callback argument. I thought it would always give me =
valid virtual address of an instruction.
> Unfortunately, I didn't find a way to get value of that register in archi=
tecture agnostic way (it is 'pc' member in
> CPUArchState structure).

When we merge the register api you should be able to do that. Although
during testing I realised that PC acted funny compared to everything
else because we don't actually update the shadow register every
instruction.

>
> ---
> Mikhail

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

