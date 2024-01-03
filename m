Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED928229FE
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 10:12:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKxIb-0007VE-N8; Wed, 03 Jan 2024 04:12:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rKxIa-0007V6-Ft
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:12:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rKxIY-0002jT-Tn
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:12:28 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40d5d898162so48097825e9.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704273145; x=1704877945; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//ydq74TQCn8+GtWJABv+9zz/Hr3gsvOy1rW+luIY88=;
 b=Wop2l7YncFCC18757B70cOCZg/OH3dfrhCkEcxc9bHtHTiZGGuKvKK9WAbYKFprh3c
 mOgt31vA8o4mKuKX4qhZLSFrAQkDfH+W5y3WkorSH9qz19qVcRXU3WDv5YLYaC2rDwXG
 YikIKpFYRhFj89EF2Dms9e+APcGzrxFiVOtILRqKUXF1Dqmq+TZDavt27OvDKanwrcx6
 VKdEWRb2IlGD0mGOOjKe7SxM1c60Ep0M/jEvx/j0FY9SSxvjA9ivVUDtDkS65yN8yU7+
 3HA/SzWPwoAoQYyoG0qucDo1Pso1assGo1/vMFI4xn+KTKpkGHWk5Qr8tzEfHKkHgJB8
 KMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704273145; x=1704877945;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=//ydq74TQCn8+GtWJABv+9zz/Hr3gsvOy1rW+luIY88=;
 b=Ci/5aK0VVSHNzbbUK2TCDwy68W2FMF+zMNXr1jntyQeIZFcA+Odt9ArQ6vNgj70czo
 8u/IaTuxGoEY5r73/feXHWNq8JhXjjLNX45TZdbzaKfzuC5Mt4qc0zHwYu1rW/aoz6ai
 a4EIVF70rrfunXxJTdLBzcyZkVU+Ye6Tiq3XV1SpcjAAXvdXpSiQ1pIwsJrBdCjL5Skl
 1zP8X7NdlsJ+je4iAIpV/64h4w7xPNC5oSS8p8Vi/HGLg6gKw67HuP5WoelUBz0xqaP8
 fodM/rfiKkIVOypUwrLa7piN9esXGyhNBvN57bwA60CQZK/cJ7rtHO5rdtjqXkS46s9c
 UBOg==
X-Gm-Message-State: AOJu0Yzr1Ub+5VvOQY6Oh5OwmQjRP9vvnCmKulAgC2Z5u38hUyEl4NFs
 XoI1qmUdRX4F5oD8PcD86kuZmpjcf7k9Gw==
X-Google-Smtp-Source: AGHT+IFKNUJdt4borhqETCGEhYAemlYe6bdGuh60CQpZxdB6/bc5I5avkZ9pZgUTI9wRuzXViuwndw==
X-Received: by 2002:a7b:cd17:0:b0:40d:5c89:9f0f with SMTP id
 f23-20020a7bcd17000000b0040d5c899f0fmr6258585wmj.15.1704273145183; 
 Wed, 03 Jan 2024 01:12:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bg40-20020a05600c3ca800b0040d87b5a87csm1643993wmb.48.2024.01.03.01.12.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 01:12:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DEFB5F8B7;
 Wed,  3 Jan 2024 09:12:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 1/2] hw/i386/x86: Fix PIC interrupt handling if APIC
 globally disabled
In-Reply-To: <20240103084900.22856-2-shentey@gmail.com> (Bernhard Beschow's
 message of "Wed, 3 Jan 2024 09:48:59 +0100")
References: <20240103084900.22856-1-shentey@gmail.com>
 <20240103084900.22856-2-shentey@gmail.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 03 Jan 2024 09:12:24 +0000
Message-ID: <8734veixvr.fsf@draig.linaro.org>
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

Bernhard Beschow <shentey@gmail.com> writes:

> QEMU populates the apic_state attribute of x86 CPUs if supported by real
> hardware. Even when the APIC is globally disabled by a guest, this attrib=
ute
> stays populated. This means that the APIC code paths are still used in th=
is
> case. However, chapter 10.4.3 of [1] requires that:
>
>   When IA32_APIC_BASE[11] is 0, the processor is functionally equivalent =
to an
>   IA-32 processor without an on-chip APIC. The CPUID feature flag for the=
 APIC
>   [...] is also set to 0.
>
> Fix this by checking the APIC feature flag rather than apic_state when de=
ciding
> whether PIC or APIC behavior is required. This fixes some real-world BIOS=
es.
>
> Notice that presence of the CPUID_APIC flag implies that apic_state is no=
n-NULL.
>
> [1] Intel 64 and IA-32 Architectures Software Developer's Manual, Vol. 3A:
>     System Programming Guide, Part 1
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>  hw/i386/x86.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 2b6291ad8d..a753d1aeca 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -516,10 +516,10 @@ static void x86_nmi(NMIState *n, int cpu_index, Err=
or **errp)
>      CPU_FOREACH(cs) {
>          X86CPU *cpu =3D X86_CPU(cs);
>=20=20
> -        if (!cpu->apic_state) {
> -            cpu_interrupt(cs, CPU_INTERRUPT_NMI);
> -        } else {
> +        if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC) {

You could assert the relationship between the feature and ->apic_state with:

  g_assert(cpu->apic_state)

But probably unnecessary in the grand scheme of things. Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

