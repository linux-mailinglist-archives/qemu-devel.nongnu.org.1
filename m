Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDC37DA55D
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 08:45:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwd2m-0006IB-9Q; Sat, 28 Oct 2023 02:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <louai.khanji@gmail.com>)
 id 1qwd2k-0006Hk-87
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 02:43:34 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <louai.khanji@gmail.com>)
 id 1qwd2i-0005oV-L6
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 02:43:34 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-507a5f2193bso3110679e87.1
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 23:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698475410; x=1699080210; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A8KsATW6+W7rXp9FJu21/fbnUaJGmrBHx9xD2vPjDQk=;
 b=DPfnAqt9XBOtSW2vypb5MDwJ16hK1oCMDw9xUKyUQvYF35Wz+QLn6lKdckjyAOkRqn
 0yIzSYuwbp2Aeayuz3EOD78oRY7S8RDG/Rp1wW1q9bexM7oOCbsCsETpwYkdnTk2WKCU
 PQA+bHkU2OM6seQjC+Y4tF8gy+q7t2AX17yPGShTSKQwuMEhQ5cwHegLpUQWAw2K5in0
 fvmzFAxMIedGUnJjRnWgSe6Si2DsGm5QbzeIbtsbOA+ZTLa2Z2aB6x0yyF5QrHwr/v6C
 VE1htspxBDgmcfKnNY9I5bJCmfQObL7i+CQmGax8LcKZ75UCU1jo+Ve4s7u8/4WpfWXz
 20gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698475410; x=1699080210;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A8KsATW6+W7rXp9FJu21/fbnUaJGmrBHx9xD2vPjDQk=;
 b=rfvbzJngy4RUg9/Lm1plOrYJpAE/2FoGahzgY1OT7Wpq41c5Q+SswpKZe2rXuT3Ggk
 f8GY4xtOMneAT2V4eXfwppYK5TOl9fY1r1zt4MqxCwIXT4q8HdGEJqmpaoxKiG4clzbr
 wy1c/xZm7hFDW4NrcWLtP3JNk5/maSOH1VKD+RIsA/NHJmRWEKniOQMqCPQOOegrRsSq
 splLmZPXywRe7FkqI2qaX0Y/XkNK07LhmptVFpvx2Y/fUfOfbs1FhsGK1eloj9BRpuQM
 ROzHntD+nz+SQp56zutUlt1kBYeH0cIP+fRmqAyHZ3yaGJ/JRLJSQEj1ncqLzdM+LHe2
 gAaQ==
X-Gm-Message-State: AOJu0Yx9Xpt9bBr93C2eywPVWehAdB1ULVp/rxsVQRfTfn+7ZLi+U2au
 PShXUcNEbtNwTyD4wEnU7WxWXaof4C9tZnj3sy7yFlrPKEQ=
X-Google-Smtp-Source: AGHT+IGSbqLnf+tcrBfmADFXdgGu1FaaoFC88wHv4s7mcfY35HWTJhxCqYu27Zh7ONgTZjb0CxWXk+T8ow6JbxeQloE=
X-Received: by 2002:ac2:4c8c:0:b0:4fb:7d09:ec75 with SMTP id
 d12-20020ac24c8c000000b004fb7d09ec75mr1597632lfl.4.1698475409669; Fri, 27 Oct
 2023 23:43:29 -0700 (PDT)
MIME-Version: 1.0
From: Louai Al-Khanji <louai.khanji@gmail.com>
Date: Fri, 27 Oct 2023 23:43:17 -0700
Message-ID: <CAHdnXhDZMgAKZyhucJ8QsFJHiO5xqdQq9zVn5X2SSL0-Q12-Jg@mail.gmail.com>
Subject: udp guestfwd
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007423900608c11f83"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=louai.khanji@gmail.com; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000007423900608c11f83
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm interested in having the guestfwd option work for udp. My understanding
is that currently it's restricted to only tcp.

I'm not familiar with libslirp internals. What would need to be changed to
implement this? I'm potentially interested in doing the work.

I did a tiny amount of digging around libslirp and saw this comment in
`udp.c':

        /*
         * XXXXX Here, check if it's in udpexec_list,
         * and if it is, do the fork_exec() etc.
         */

I wonder whether that is related. In any case any help is much appreciated.

Thanks,
Louai Al-Khanji

--0000000000007423900608c11f83
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I&#39;m interested in having the gu=
estfwd option work for udp. My understanding is that currently it&#39;s res=
tricted to only tcp.</div><div><br></div><div>I&#39;m not familiar with lib=
slirp=C2=A0internals. What would need to be changed to implement this? I&#3=
9;m potentially interested in doing the work.</div><div><br></div><div>I di=
d a tiny amount of digging around libslirp and saw this comment in `udp.c&#=
39;:<br clear=3D"all"><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* XXXXX Here, check if it&#39;s in udpex=
ec_list,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* and if it is, do the fork_e=
xec() etc.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br></div><div><br></div>=
<div>I wonder whether that is related. In any case any help is much appreci=
ated.</div><div><br></div><span class=3D"gmail_signature_prefix">Thanks,</s=
pan><br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature">Louai Al-Khanji<br></div></div></div>

--0000000000007423900608c11f83--

