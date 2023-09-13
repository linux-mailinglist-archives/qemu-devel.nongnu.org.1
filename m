Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B07879E2AA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:54:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLdI-0007mB-F1; Wed, 13 Sep 2023 04:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgLdG-0007lW-NF
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:53:58 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgLd1-0006Ii-4E
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:53:58 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-401bdff4cb4so70852625e9.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694595221; x=1695200021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaCDfbshZj02stCbL44BQ0+P3R5i6JmtaBXQZ2vXVRU=;
 b=tTWAB96S9gzGS4W0PuWtsj/f61OCrLZluIjwgqW8K96DaQwCfOICPLK2KJcsO0P0C8
 Hfy/rsS1Fw+bRqy0TZW2H+5S4TGIxJS98UhxGrvv0/PGaZ/IlIhfcXMsAwRAikNJ/lui
 78puv31B9fZ/O6nzyW/V2OhK6gkcxBJsiqWHiDR2w6lntZKp0iiJJBNhLck2L8bJpmE6
 Zzq6RimqwCbmYUXuSE586YZyzFIrsmEYp2NkVqqk2yL1CfhjYpSqh1Dfn0O5BQ53B/HW
 B/t2yRJkhKP+PtZwdXVAupYotks/CxlrQgdGA7QbrE1655yL+ipeuefMnuMHFHy1qY+Z
 0dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694595221; x=1695200021;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PaCDfbshZj02stCbL44BQ0+P3R5i6JmtaBXQZ2vXVRU=;
 b=p6KpCMHJe/IdfKw+dwXb7bkFYEa1CA9l4r4xxa/g9ZbMdSBc6MHB5RTErRlDFUgt/g
 dGv1LTTT8svMW+1B2+6xrRIPMg/knlLY6qSDTHgacQK4pHcRqAh4yTPaeL2fYlu8ntt4
 +1IKE+iWR8aCmbWxatJLuZK/CW8ddRso/GxEPUenYmMY7KluEIplZfqYuAa0HLpb3rx6
 9TZOZr0HYE77GQytVCl5booP7ieNPQaaCeYh6lUC43wxEJtpq4RbTa46k8zyGxf6HOuu
 bGb1ROhf01R/Ka+d8BGkz+jZoaqjQAWIWfya4bm2fCPWB390Bhr7ceR+OaOOyInxcNdp
 TgWw==
X-Gm-Message-State: AOJu0YwPy14jf4Qg2epNIJZTMkDdvBiSf7f2ugqRW0otJqtGhMFbT/bA
 qjxLB07ad/OtYlYxXeugD3nurA==
X-Google-Smtp-Source: AGHT+IGw0NUP2FP1GMXOy+FYv+kKDB2WVdwLvLhWjrn8OyYSTegRhBzRK/DgEF/+OTrhtgIPwpL04w==
X-Received: by 2002:a05:600c:2108:b0:401:b76d:3b8b with SMTP id
 u8-20020a05600c210800b00401b76d3b8bmr1409086wml.16.1694595221249; 
 Wed, 13 Sep 2023 01:53:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a5d69c1000000b0031aef72a021sm14876434wrw.86.2023.09.13.01.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 01:53:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 56DE91FFBB;
 Wed, 13 Sep 2023 09:53:40 +0100 (BST)
References: <20230912131340.405619-1-npiggin@gmail.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, Beraldo
 Leal <bleal@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/avocado: Fix console data loss
Date: Wed, 13 Sep 2023 09:51:23 +0100
In-reply-to: <20230912131340.405619-1-npiggin@gmail.com>
Message-ID: <87h6nytpwr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Nicholas Piggin <npiggin@gmail.com> writes:

> Occasionally some avocado tests will fail waiting for console line
> despite the machine running correctly. Console data goes missing, as can
> be seen in the console log. This is due to _console_interaction calling
> makefile() on the console socket each time it is invoked, which must be
> losing old buffer contents when going out of scope.
>
> It is not enough to makefile() with buffered=3D0. That helps significantly
> but data loss is still possible. My guess is that readline() has a line
> buffer even when the file is in unbuffered mode, that can eat data.
>
> Fix this by providing a console file that persists for the life of the
> console.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Queued to testing/next, thanks.

> ---
>
> For some reason, ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_192m
> was flakey for me due to this bug. I don't know why that in particular,
> 3 calls to wait_for_console_pattern probably helps.
>
> I didn't pinpoint when the bug was introduced because the original
> was probably not buggy because it was only run once at the end of the
> test. At some point after it was moved to common code, something would
> have started to call it more than once which is where potential for bug
> is introduced.

There is a sprawling mass somewhere between:

  - pythons buffering of IO
  - device models dropping chars when blocked
  - noisy tests with competing console output

that adds up to unreliable tests that rely on seeing certain patterns on
the console.=20

>
> Thanks,
> Nick
>
>  python/qemu/machine/machine.py         | 19 +++++++++++++++++++
>  tests/avocado/avocado_qemu/__init__.py |  2 +-
>  2 files changed, 20 insertions(+), 1 deletion(-)
>
> diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine=
.py
> index c16a0b6fed..35d5a672db 100644
> --- a/python/qemu/machine/machine.py
> +++ b/python/qemu/machine/machine.py
> @@ -191,6 +191,7 @@ def __init__(self,
>              self.sock_dir, f"{self._name}.con"
>          )
>          self._console_socket: Optional[socket.socket] =3D None
> +        self._console_file: Optional[socket.SocketIO] =3D None
>          self._remove_files: List[str] =3D []
>          self._user_killed =3D False
>          self._quit_issued =3D False
> @@ -509,6 +510,11 @@ def _early_cleanup(self) -> None:
>          # If we keep the console socket open, we may deadlock waiting
>          # for QEMU to exit, while QEMU is waiting for the socket to
>          # become writable.
> +        if self._console_file is not None:
> +            LOG.debug("Closing console file")
> +            self._console_file.close()
> +            self._console_file =3D None
> +
>          if self._console_socket is not None:
>              LOG.debug("Closing console socket")
>              self._console_socket.close()
> @@ -874,12 +880,25 @@ def console_socket(self) -> socket.socket:
>          Returns a socket connected to the console
>          """
>          if self._console_socket is None:
> +            LOG.debug("Opening console socket")
>              self._console_socket =3D console_socket.ConsoleSocket(
>                  self._console_address,
>                  file=3Dself._console_log_path,
>                  drain=3Dself._drain_console)
>          return self._console_socket
>=20=20
> +    @property
> +    def console_file(self) -> socket.SocketIO:
> +        """
> +        Returns a file associated with the console socket
> +        """
> +        if self._console_file is None:
> +            LOG.debug("Opening console file")
> +            self._console_file =3D self.console_socket.makefile(mode=3D'=
rb',
> +                                                              buffering=
=3D0,
> +                                                              encoding=
=3D'utf-8')
> +        return self._console_file
> +
>      @property
>      def temp_dir(self) -> str:
>          """
> diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avoca=
do_qemu/__init__.py
> index 33090903f1..0172a359b7 100644
> --- a/tests/avocado/avocado_qemu/__init__.py
> +++ b/tests/avocado/avocado_qemu/__init__.py
> @@ -137,7 +137,7 @@ def _console_interaction(test, success_message, failu=
re_message,
>      assert not keep_sending or send_string
>      if vm is None:
>          vm =3D test.vm
> -    console =3D vm.console_socket.makefile(mode=3D'rb', encoding=3D'utf-=
8')
> +    console =3D vm.console_file
>      console_logger =3D logging.getLogger('console')
>      while True:
>          if send_string:


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

