Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D226280868E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 12:20:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBCQB-00045T-Eu; Thu, 07 Dec 2023 06:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1rBCQA-000456-2i
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 06:19:58 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1rBCQ8-00073x-KI
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 06:19:57 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50bf69afa99so648083e87.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 03:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701947994; x=1702552794; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fg0VYjKrublsvKpwNr67XzN6VScsSeVC1/Mnnq36/8Y=;
 b=j5tJ3ReuhJJ3goRuj9lVe9M+uNnndGOKcWzW60mqgGdtFY+WedfbgEICiqUyTGIDtm
 9G4uxaNd0LnWdd5rS73GDqlm2z+80ZArCbbi2bwPY3kTAzXmqSu5QMPJmemPywJndwye
 q5ydojvSkB+nArqEi57cv6e+lrUYYU+r2WJAnGzxNNe5bPKrd+1TXIW3zWXPS8wJZQ3Q
 w+mo+XzQm45u/LwBtpSk4+TweX+doL2rFIfTPIHkPFuod3HhDliQJqWWj04DuNOzRE8D
 Vnb3ZsXXuU9UHKbT6kiNTsbaFo549miIMvJ/NJ/umXAT3zhPdFj+QinExIZqiGrKtvgl
 IKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701947994; x=1702552794;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fg0VYjKrublsvKpwNr67XzN6VScsSeVC1/Mnnq36/8Y=;
 b=H99JfTHezOCAYfrbbw7jPeh5ZpKwHtwm7jDvBrUV6oYGRuExEmFUfgiU/0ElOj6A+6
 jtJlrL36dgGCdAvv2DpzTwrPKo7ppstwKz3v4QbuaNVZlQGpry1EaBSLAE/tJaWwaLg7
 SjUUvNfosC79uOH95aS21iOAJGkZ3+Ny415h2nPVvO5YT/erw757qGJ3/7wiy1RnyiIM
 iSAOPIWjraejvbRaGlcrAqrjNnhnjJzGUkHo69V7ZZYaTJUiehUCrQnmDLmpvV/N3dlA
 0dt8oF7BmwlhptXC0zQbGqaV/vparJDqep6pwcQkUdYv0nruU6OHeF3AGtipHoKpM9/a
 kcgg==
X-Gm-Message-State: AOJu0Yyk3/0HXo4rwdxUlsxpHZGtsHMPyb7tVyPiUR4wtqGRI9u4/d2X
 52EGzuUpDTOZJZ4b5mnAHO+0ud6dDRtqHZ+o30NZ8XlaPQCEsgs=
X-Google-Smtp-Source: AGHT+IE/qluzCViDOCGlHOAQZtWZrtwvL7Mq14TrMnkyiWpENenWnhALkH2Y/tvV8vCmQN2etrjzwX8vfc8D1NKtTMw=
X-Received: by 2002:a2e:7816:0:b0:2c9:f68f:541f with SMTP id
 t22-20020a2e7816000000b002c9f68f541fmr1467095ljc.10.1701947993526; Thu, 07
 Dec 2023 03:19:53 -0800 (PST)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Thu, 7 Dec 2023 19:20:56 +0800
Message-ID: <CAOYM0N27HbO8wOumn_xxNSS8Zg-Rsc6tSj9U1oU3sSAARBoCwQ@mail.gmail.com>
Subject: make: *** No rule to make target 'i386/fp87.c', needed by
 'i386/fp87.o'. Stop.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000949822060be9a5d3"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000949822060be9a5d3
Content-Type: text/plain; charset="UTF-8"

qemu checkout tag "initial" version, then
$ make

report error, like this:
make: *** No rule to make target 'i386/fp87.c', needed by 'i386/fp87.o'.
Stop.

How or where can I get the resource about folder "i386", just like OBJS in
Makefile

OBJS= i386/fp87.o i386/interp_main.o i386/interp_modrm.o
i386/interp_16_32.o \
      i386/interp_32_16.o i386/interp_32_32.o i386/emu-utils.o \
      i386/dis8086.o i386/emu-ldt.o

--000000000000949822060be9a5d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>qemu checkout tag &quot;initial&quot; version, then <=
br></div><div>$ make</div><div><br></div><div>report error, like this:</div=
><div>make: *** No rule to make target &#39;i386/fp87.c&#39;, needed by &#3=
9;i386/fp87.o&#39;.=C2=A0 Stop.</div><div><br></div><div>How or where can I=
 get the resource about folder &quot;i386&quot;, just like OBJS in Makefile=
</div><div><br></div><div>OBJS=3D i386/fp87.o i386/interp_main.o i386/inter=
p_modrm.o i386/interp_16_32.o \<br>=C2=A0 =C2=A0 =C2=A0 i386/interp_32_16.o=
 i386/interp_32_32.o i386/emu-utils.o \<br>=C2=A0 =C2=A0 =C2=A0 i386/dis808=
6.o i386/emu-ldt.o</div></div>

--000000000000949822060be9a5d3--

