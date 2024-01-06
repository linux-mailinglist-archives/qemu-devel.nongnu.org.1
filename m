Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB81C825F66
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 13:11:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rM5Ux-0003Pd-Sx; Sat, 06 Jan 2024 07:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rM5Uw-0003PV-Mx
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 07:09:54 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rM5Uv-0001R1-0Y
 for qemu-devel@nongnu.org; Sat, 06 Jan 2024 07:09:54 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5537dd673e5so319497a12.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jan 2024 04:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704542991; x=1705147791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YeD7f2OlxRrJ679VNegenw8yPupYRWwly1FFQKfYZEc=;
 b=TtpzkTRzYfHQc/AJ3ytKPnL2U3BB6HxmfAWYHxUa8It5WbFDu2XPPjjC2FaE/5QdU3
 BFmYiMgLcB20vtPRycribiCuTDtTmJ6whQxCamdU/9xZcaKUsTiDK5IpJYvAYt+1cB6V
 UwFrHUucpby06brXaRddYuPH291JHos4nQXqSW7WwlrW3xv3k/e1t2Si5FdcgX0NCmKS
 GAcRwYJwRTmPkEaokUms2F3tuAHd48U13M+SUiCk6RKMVQEv9ew3IGIl/Aq30RZDFSWH
 R9R+4ps3HW0fGVbH62ug87uDGVsH6yIqTikKkDHZ+EukCt/4kqLO/ZhC92XceULiKJZK
 tE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704542991; x=1705147791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YeD7f2OlxRrJ679VNegenw8yPupYRWwly1FFQKfYZEc=;
 b=rbmEjbgesusKJc7dI/NuowMXPy/HMMt8n1i4BfvAgCRZHNwxmSbbfQWTrnunYkJKlB
 saEaPn39XKyTQzMb8N3tQ5N1pwnsNDzUHW3900BIcLTePiHnD8/DHby/w3yB9MpAkTPL
 R9IeO44eGUP/VztlPg9MOWL8tMv4dayoDTX+slPRXQwyi5XA9RWOXZD3VeC9yQVw+kn9
 qaqaSeFPgbLLu6NACG4YhyJ5utvLK1vkU8LxF3+geNzk35Gbjncj4EngsgafljFG5tcD
 Bknu0UIa+DapnzkYAATUzjIp26piUqsoKfbnKju+cBBI9TobDIAykeAJ3FXaDPVIwfx/
 QZmA==
X-Gm-Message-State: AOJu0YwcqKrLVP2fHTlFr45wP4muS4/Td5efAXrAMUm/ih8ETiSFNdFG
 bDkomPjmpB4tVq3RcK5hK4JHzIulzn+pojsgUYlK2rzDboB2ig==
X-Google-Smtp-Source: AGHT+IFbjgYHjmp65cb1hwnmsDHUJMzCvfe9swUV8LQBfI5MXCLGJoxFSpTmGJ6+XhXaa1oXYcvuSgBuCPqSgVcTPgU=
X-Received: by 2002:a50:955c:0:b0:553:ad79:b7cb with SMTP id
 v28-20020a50955c000000b00553ad79b7cbmr448953eda.3.1704542990971; Sat, 06 Jan
 2024 04:09:50 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA_TGYZP2eV1C4Yn5a6vnAO-_1r98rY1Teahy_Pb1ocvjw@mail.gmail.com>
 <CAK3XEhM75DW+eUFrx=73xPycKvxccdT-Tg5mfFyuW_hAMJJ3+w@mail.gmail.com>
 <CAK3XEhNe4TO4oBavsuqJwP5e1nzB6+xpdWa-D0NEq_-rqXincw@mail.gmail.com>
In-Reply-To: <CAK3XEhNe4TO4oBavsuqJwP5e1nzB6+xpdWa-D0NEq_-rqXincw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 6 Jan 2024 12:09:17 +0000
Message-ID: <CAFEAcA-fjZw9x2RC+Czo8dQUuux1WUD6fDWCMJ-1xHdGevNWAw@mail.gmail.com>
Subject: Re: acpiBitsTest.test_acpi_smbios_bits test intermittently times out
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 6 Jan 2024 at 05:41, Ani Sinha <anisinha@redhat.com> wrote:
>
> On Sat, Jan 6, 2024 at 10:05=E2=80=AFAM Ani Sinha <anisinha@redhat.com> w=
rote:
> >
> > On Sat, Jan 6, 2024 at 12:11=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org> wrote:
> > >
> > > The avocado test acpiBitsTest.test_acpi_smbios_bits seems to be
> > > flaky in CI -- sometimes it appears to time out.
> > >
> > > https://gitlab.com/qemu-project/qemu/-/issues/2077
> > > has the details (including links to jobs etc).
> >
> > Do you have more data points in terms of the jobs that failed?
>
> I just noticed that you attached three examples of failed tests. In
> all of them the test seems to be stuck at the ami latency test.

OK, if you think that subtest is suspicious, could you send a
patch that disables just that subpart, and we'll see if it helps?

Thanks for looking into the issue.

-- PMM

