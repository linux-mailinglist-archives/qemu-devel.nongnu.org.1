Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C74A87EA748
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 01:12:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2h1g-000812-MK; Mon, 13 Nov 2023 19:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bambooza@gmail.com>)
 id 1r2h1e-00080l-P7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:11:30 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bambooza@gmail.com>)
 id 1r2h1d-0002WM-4r
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 19:11:30 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso738436966b.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 16:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699920686; x=1700525486; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8bUUlKQsUThPcBWPoZuhT7LezMx+soc7Pjzk7EHGgew=;
 b=gZzjGNELGrqAsDI1Qcntlgk07D1QBq6Qahi/14u1tsDY4mSyeGTlxYkiySneXrLvn7
 265N2eeHk345Ajab6ndoYWersPoz2Nr+1YRDOFn1NxhgcTMwdE8mshpdss05x+CTI9Eb
 TFnUY4azQkMhhycDmDVMWEdhWOtpo5xdxGLZDJfZlZlWlyieJe5whBCrH4/Rze3aJG3D
 z+YARFPX3dlvgjUbOyx9yQPhELl6Ro0fEBrrEEc9zJWhuOibMFFXSqdlZFk+hEiqGmqk
 38k+V7857jBS3D65lLc9n24k31g0N8n8fLA/rXTvqSW0zS9rJn3oZaJ8FRagFBS8cJGC
 L9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699920686; x=1700525486;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8bUUlKQsUThPcBWPoZuhT7LezMx+soc7Pjzk7EHGgew=;
 b=jsKbudJNTjgWQRw06KX7htdN5PFrp2Otw1mfLt7H1nDHqVtMINn5Ns0N0aVpJsvJEU
 zzEBByNS9KH3Y5wjG3LVGKiP0EdiV3mdyEsSHV8dsD3qSLa7GvjLgrtOYi6GoyI0xeEo
 STng685lDGiN38prwCEoJqKH7gpXQ59PXrDCGzsvVIa2Vx3ZEZY/9B++moaLVqA7j0aa
 KhGNyC5ga8QjseCeTkdKW39QMRvF0mnFTymCLSZXvTwM4xBsH0ZY3hQ13r6Y1xxkC+3w
 exausJmNQjqWxODQ+jTzHDkxVshC/Y0eM1J3K0ESFNPWspXni4UFaf8S7m4h21H3e1/2
 VN3Q==
X-Gm-Message-State: AOJu0YzLHc1Wv8Hirfa5jV6aLQQ1ZzJhDOf4lVkX8AcMz20k8SCV6WB/
 zOfIzU5MEaJ/BF4FkUe7o3/fQ0/UgvMIPLbCzvDB7MI3
X-Google-Smtp-Source: AGHT+IEPV9/3pNi17NJ2PWzwC8Q4BvHIkUUgNpwjLTwF5y9xbfWUiNw5cAzXRoM/vpvjDM7sJ4y+LRSzBtYgh56FE3M=
X-Received: by 2002:a17:906:d217:b0:9be:3c7e:7f38 with SMTP id
 w23-20020a170906d21700b009be3c7e7f38mr5534706ejz.10.1699920686488; Mon, 13
 Nov 2023 16:11:26 -0800 (PST)
MIME-Version: 1.0
From: bambooza@gmail.com
Date: Mon, 13 Nov 2023 16:11:15 -0800
Message-ID: <CAJPDN+CaOmAf6Qis4oSLP9vkqCVpYWsqoR6CyT6VspXKNbT5aA@mail.gmail.com>
Subject: Add new qmp json is not setting command errp
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000aa1e46060a11a055"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=bambooza@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

--000000000000aa1e46060a11a055
Content-Type: text/plain; charset="UTF-8"

I am attempting to add a new json file for qmp.  My issue is that errp is
null so when I call error_setg qemu crashes.

Specifically

QEMU: F0000 00:00:1699907518.054094 2802908 logging.cc:57] assert.h
assertion failed at qemu/util/error.c:59 in void error_setv(Error **, const
char *, int, const char *, ErrorClass, const char *, struct __va_list_tag
*, const char *): *errp == NULL
I am not sure what I'm missing.  The generated files for command, event,
types, visit and view are created.

The function gets called and the passed in value is correctly populated
just errp is null.

--000000000000aa1e46060a11a055
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I am attempting to add a new json file for qmp.=C2=A0 My =
issue is that errp is null so when I call error_setg qemu crashes.<div dir=
=3D"auto"><br></div><div dir=3D"auto">Specifically=C2=A0</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div style=3D"font-size:12.8px" dir=3D"aut=
o"><div style=3D"width:352px;margin:16px 0px"><div><div dir=3D"ltr">QEMU: F=
0000 00:00:1699907518.054094 2802908 logging.cc:57] assert.h assertion fail=
ed at qemu/util/error.c:59 in void error_setv(Error **, const char *, int, =
const char *, ErrorClass, const char *, struct __va_list_tag *, const char =
*): *errp =3D=3D NULL<br></div></div></div><div style=3D"height:0px"></div>=
</div>I am not sure what I&#39;m missing.=C2=A0 The generated files for com=
mand, event, types, visit and view are created.=C2=A0=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">The function gets called and the pass=
ed in value is correctly populated just errp is null.=C2=A0=C2=A0</div></di=
v>

--000000000000aa1e46060a11a055--

