Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BEA81DF31
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 09:31:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHgLK-0006Xj-2D; Mon, 25 Dec 2023 03:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rHgLH-0006XG-6n; Mon, 25 Dec 2023 03:29:43 -0500
Received: from zproxy1.enst.fr ([137.194.2.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1rHgLE-0002i9-ST; Mon, 25 Dec 2023 03:29:42 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id C567DC059D;
 Mon, 25 Dec 2023 09:29:33 +0100 (CET)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id nQVnc2XBC4_U; Mon, 25 Dec 2023 09:29:33 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 6E5ECC0644;
 Mon, 25 Dec 2023 09:29:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr 6E5ECC0644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1703492973;
 bh=S4IdAE/gWNGpXafwJf5paQycM0wS3iNhpUrg/XTrMv4=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=zbp3EignbQZaaY/hLEwmhIm9oMpR7zTcTjxe4ZyXwzPG0/GoK2Tv+kajAfw2IqYFX
 DnW3yaLK0c6ORv60JOCl+rh3IqTxz02g4YXPltRJ3M3+U5iwDQFc7p29khYOMFguMh
 SA4cLI4v/QUR45wSzMObIWTnIE0YiDYK/eSiy1lg=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id OY28NMCdQPQM; Mon, 25 Dec 2023 09:29:33 +0100 (CET)
Received: from buffy (unknown [IPv6:2a01:e0a:a0e:d230:259b:5b8e:b52b:be4e])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 380F2C059D;
 Mon, 25 Dec 2023 09:29:33 +0100 (CET)
References: <20231123205742.630004-1-sam@rfc1149.net>
 <521bbe69-3ed2-4416-89b4-40efe1bc3055@tls.msk.ru>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/hexagon/idef-parser/prepare: use env to invoke bash
Date: Mon, 25 Dec 2023 09:15:26 +0100
In-reply-to: <521bbe69-3ed2-4416-89b4-40efe1bc3055@tls.msk.ru>
Message-ID: <87il4melcj.fsf@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=137.194.2.220;
 envelope-from=samuel.tardieu@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


Michael Tokarev <mjt@tls.msk.ru> writes:

>> -#!/bin/bash
>> +#!/usr/bin/env bash
>
> What's the reason for this indirection?  bash has been /bin/bash=20
> for decades,
> it is used this way in many other places in qemu code and in=20
> other projects.
> Yes I know about current move /bin =3D> /usr/bin etc, but the=20
> thing is that
> traditional paths like this one (or like /bin/sh) is not going=20
> away any time
> soon.  What's the matter here?

In addition to Stefan's answer, some modern systems use a per-user=20
file system hierarchy where each user (or even each environment=20
development for a user)  gets a global set of directories with=20
only the applications they want. This is done either through=20
adding each application directory into the user PATH or by using a=20
set of user-specific bin/lib/... directories full of symlinks to=20
the chosen applications.

In those environments, /usr/bin might only contain "env", such as=20
"/usr/bin/env application" works. This is the case for example on=20
NixOS, which is more and more used in research environments for=20
their easily reproducible build environments.

  Sam
--=20
Samuel Tardieu
T=C3=A9l=C3=A9com Paris - Institut Polytechnique de Paris

