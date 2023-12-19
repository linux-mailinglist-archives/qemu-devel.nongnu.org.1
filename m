Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDDF818F86
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 19:17:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFedA-0008JD-86; Tue, 19 Dec 2023 13:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rFed7-0008Iy-H6
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:15:45 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>) id 1rFed4-00008w-Sc
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 13:15:45 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 7BD3E80024;
 Tue, 19 Dec 2023 19:15:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1703009736; bh=7jEVjjfiachAnB1fvZMhQgp8cq+B+fv3/JDDOi/FxAE=;
 h=References:From:To:Cc:Subject:Date:In-reply-to;
 b=DFganMiKesLuF6XA9CP8PLEZnWHeq/vKRJKRsMXE+3hJQux+4chd6hqlUMOIlwZn8
 yDvKzJpojRoWyGPqvB8uXA3uKW3NKQOAN9TVnf+T/gpMB6zo/muAFiuGOrL7SluB2c
 SHYfX39EODqlH0bou8D8cPDklkTUVGhv+lpmtfRUJ7qu01cekiv4MngnUSBIBh12Is
 zSTPaDqKzSugGLVqPf6nwv0jpYFCMGqDMQT0MRmOSoGEDIQ4j8DNWOYks2nPIP4IuJ
 MOfRAg238ne5p/0jRRfxFS+vF5jd2qZ1Z4QFgM5E71Qa6+a1uTz/D5qlOLjLSk1jo7
 UM1UzuWry5e2w==
References: <20231214233055.2505387-1-sam@rfc1149.net>
 <20231214233055.2505387-3-sam@rfc1149.net>
 <CAFEAcA_f93-Siwmc_5hVrz=A5Rva_d6bWFXYoRcb90AXZXJhmg@mail.gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <sam@rfc1149.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 2/2] tcg: Jump after always false condition
Date: Tue, 19 Dec 2023 18:55:59 +0100
In-reply-to: <CAFEAcA_f93-Siwmc_5hVrz=A5Rva_d6bWFXYoRcb90AXZXJhmg@mail.gmail.com>
Message-ID: <871qbiys6w.fsf@rfc1149.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
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


Peter Maydell <peter.maydell@linaro.org> writes:

> So, well, all of this is definitely removing dead
> code, but on the other hand it's also moving away
> from the coding-style pattern the function has at
> the moment, which is "there is a fail-and-exit
> codepath which is robust against wherever you might
> choose to jump to it, and so if we need to add new
> code to this function then it also can jump to 'fail'
> without any further updates to that error-exit path".
> Instead we end up with an "every error-exit check
> does its own tidyup" idiom. For the sake of not having
> a static checker say "this is technically dead code",
> is that worth doing, or does it make the code a little
> less readable and less amenable to future modification?
> I'm not sure...

Hi Peter.

I see your point and I agree with you. Perhaps we could get the=20
best of both worlds by:

- renaming `fail_rx` as `fail`, so that we get a unique exit block=20
  =E2=80=94 not only will the compiler optimize the jump if it can, and=20
  this is the slow path anyway
- adding a one-line comment saying that `buf_rx` is always=20
  `MAP_FAILED` =E2=80=93 that will let people know that they might need to=
=20
  add a cleanup if they add another jump to `fail`
- calling `error_setg_errno()` at the right place before jumping=20
  to `fail`

I will produce a v2 to make this proposal clearer.

  Sam
--=20
Samuel Tardieu

