Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 932E3AA7345
	for <lists+qemu-devel@lfdr.de>; Fri,  2 May 2025 15:19:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAqHT-00049X-8J; Fri, 02 May 2025 09:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uAqHR-00049F-EP
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:18:17 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uAqHP-00038s-Hw
 for qemu-devel@nongnu.org; Fri, 02 May 2025 09:18:17 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2bdea5a38so289879466b.0
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 06:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746191893; x=1746796693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDnEZaw1i50J3F1JCHo9UkiE+YykqkVLRZGQGvOgAdU=;
 b=hTjAKNwJV5/M9nfT8lMRNjxTEh8uY7hlslvkYGMO4pydZRbgwgIqoBK+MwxXoqXFnt
 vAcErl+Vs69wsUdf9pTDI5Pp+9RMtPJYiP3IOP89ep7aeYKTyTgScOdxjAh4e5l2o4as
 wBqG9HCzOVecFADhAxF8Xvyjv8lZ/B2/HL8bNzq3ipr5AfUAjmK6ZYTzVQLd9RNQOGPp
 CJK0/plR4sQPH9qQiGx3MPKobsyBw7Bi1WjAfdLP2AaTyjmWPyykH4DKnZ25zN6KPh84
 wTWY3ROdUOPFtZHlaBxCPrNrLy4C27Kjqy3gAwQ5e2dWgPqjSgHYlFuZTkuWZb9irn1y
 Tr4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746191893; x=1746796693;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDnEZaw1i50J3F1JCHo9UkiE+YykqkVLRZGQGvOgAdU=;
 b=ZzxJdTSgnRgnMP855Lr4Caxonban9/5/fjQQhYt2GrJ6Iq6jIrNSrK4hmZxa2SCViY
 DVGYtCMoCmIA4zOld7p5Y10LYOPFa0mdaNNvRA0g60lX7L+lnfoiZ1zytDpvQAGo/wIT
 gxjlS9CkFJUA7ESFBgKUHVuU+gyiMea6HFhBVr93IvuEuKoL4G35W1qRrtibRxFKYdn1
 UA7lEH2BNS9U6A5RIOHeTifQsFc84saH35x+/zIRi4cBTcmMXiLV1U7/Ea64mQtV1skN
 mx6drcFszs7fecDonszZBPmOT0tQlhV7ih+capF+TvPUy417guGYmDBVXOuctv1QiPym
 RKiw==
X-Gm-Message-State: AOJu0YyVCBAdWS84yujtDOvKfbYEDuNKDngZrXDrEp0V2nFyiAG4GWRN
 A/LmAImzCBnPELzD8AbnWdKIN9O0lpbeyF52mMnO5sELmWizIEOrBU4q34cSSpQ=
X-Gm-Gg: ASbGncs3oDH+BiD0IZCpTG2xVFL/9i2FwJJuf0MOHiSdS7vN0q5t6yefoMdkHfirLxu
 u4w1NHh+Ui3Rv2m+dMAbuEMO7/hLpftxAo56TY8OTsK+QIY/s1OoUPLpLq2Tng+fNqzf/CDYmDL
 aP/4yetXFC1cNZBfpDhrA84q4F+N9T9HkF4f4WTBCTmNssUSe3JzKM+2RGTHDekm4/gXjmk7pMs
 ZaOwNoTtAAUwWkmb7SblGxmVS0UfF9UyVZNZTjqtcotkgCrv8oun//8h0b97IJaUkqs8CzhYh52
 YvaaQQquK2BqmMoF9rDyFOjzXBB/xws0RBngskJStpw=
X-Google-Smtp-Source: AGHT+IFNnoNtGM40HwIJYvzVqN6Q4Su3kIxI+LciIEnbW/lhxcN0T6yFBzWpTE5qhC57L1FW6SoesA==
X-Received: by 2002:a17:907:3f8a:b0:aca:d6f0:af0c with SMTP id
 a640c23a62f3a-ad17afb8178mr301974566b.59.1746191893193; 
 Fri, 02 May 2025 06:18:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1894c02a8sm47726066b.122.2025.05.02.06.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 06:18:12 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B64745F86B;
 Fri,  2 May 2025 14:18:11 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
Cc: qemu-devel@nongnu.org,  gustavo.romero@linaro.org,
 richard.henderson@linaro.org,  philmd@linaro.org,
 manos.pitsidianakis@linaro.org,  Patryk 'patryk4815' Sondej
 <patryk.sondej@gmail.com>
Subject: Re: [PATCH] gdbstub: Implement qqemu.Pid packet
In-Reply-To: <20250404102603.59936-1-dominik.b.czarnota@gmail.com> (Dominik
 Czarnota's message of "Fri, 4 Apr 2025 12:26:03 +0200")
References: <20250404102603.59936-1-dominik.b.czarnota@gmail.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Fri, 02 May 2025 14:18:11 +0100
Message-ID: <87ecx7w3qk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com> writes:

> This patch adds support for the `qqemu.Pid` packet to the qemu
> gdbstub which can be used by clients to get the QEMU process PID.
>
> This is useful for plugins like Pwndbg [0] or gdb-pt-dump in order to
> inspect the QEMU process memory through the /proc/self/{maps,mem}
> interfaces. Without this feature, they have to rely on doing an
> unreliable pgrep/ps output processing.

That seems a little thin a reason for QEMU to expose its own PID. For
user-mode you can already get that detail through anything using
gdb_append_thread_id().

For system-mode leaking QEMU's own pid seems like an information leak at
best. There are modes like semihosting which give a remote even more
power but you need to at least opt in to that.

>
> This patch has been developed by Patryk, who I included in the
> Co-authored-by and who asked me to send the patch.
>
> [0] https://github.com/pwndbg/pwndbg
> [1] https://github.com/martinradev/gdb-pt-dump
>
> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
> Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.=
com>
> ---
>  gdbstub/gdbstub.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 282e13e163..a077c2c5ed 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1746,6 +1746,12 @@ static void handle_query_qemu_supported(GArray *pa=
rams, void *user_ctx)
>      gdb_put_strbuf();
>  }
>=20=20
> +static void handle_query_qemu_pid(GArray *params, void *user_ctx)
> +{
> +    g_string_printf(gdbserver_state.str_buf, "F%x", getpid());
> +    gdb_put_strbuf();
> +}
> +
>  static const GdbCmdParseEntry gdb_gen_query_set_common_table[] =3D {
>      /* Order is important if has same prefix */
>      {
> @@ -1902,6 +1908,10 @@ static const GdbCmdParseEntry gdb_gen_query_table[=
] =3D {
>          .handler =3D handle_query_qemu_supported,
>          .cmd =3D "qemu.Supported",
>      },
> +    {
> +        .handler =3D handle_query_qemu_pid,
> +        .cmd =3D "qemu.Pid",
> +    },
>  #ifndef CONFIG_USER_ONLY
>      {
>          .handler =3D gdb_handle_query_qemu_phy_mem_mode,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

