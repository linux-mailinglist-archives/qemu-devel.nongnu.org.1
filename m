Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C658801215
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 18:51:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r97f9-0003Tp-0F; Fri, 01 Dec 2023 12:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r97f6-0003TE-Te
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:50:48 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r97f5-0004RO-2p
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 12:50:48 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3316d3d11e1so1579727f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 09:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701453045; x=1702057845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRNrVLJKO+PKK7SETq6nCbHZ+DhdG7TfQIbEsz4A5Bk=;
 b=ic4sZ1s23v8r0Z87mCMyUhT6ykMGE+sVDwc5lfy7kh55sM7nkrH4W7Y/GlDNYRpNdd
 kK5vatQJLCpkpl4EGrSte0cjkHuX0XpA/Z/Hghl3CNJ88SQYdM+YsQvfkL1TTZhd3me5
 eOSeDrnPEhSUhMMkay8dVmEPW5NDtnsFFEr1RP0owOYAtcGfO+Rxk7fG9cLvUFA36TgM
 bp9cAUY1ekkbk2zk/mb7cEjUok5+6WXUEs6f5H7ULzDHHVRxv9TENuTvf/GI7wN7ilfr
 z++Ff88ub53PVDq8ZzpF1IlWXnl9+70tx6CgmQKim3lPpRr1nLDnIukaWHyXMqmu6/Ss
 zQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701453045; x=1702057845;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XRNrVLJKO+PKK7SETq6nCbHZ+DhdG7TfQIbEsz4A5Bk=;
 b=K5wBHL79QH+ybzjzmInNM0eDjXaSSiaCEOpMvvYv/D6OmMHBqH9zlsBa5CT97kDV+u
 5phaLXgUbQzBQuRAqW2qmEIyk8wTZ2Xc7cZQ0TF3z7eMb6jZCR3imDu0EdhFq/Fj0JwU
 85r+AY1Yv97Wg9DHIWcUyowtEBzM/fBPoDEGx4BhzwjIavsTrunPTZ2XAzi1XmuO70Bk
 d2Dj98VZM+03jKtyu7dSDAMijJd3KcqXC/7pb/8CfyVkN9R7V/kriA0VVmi/gPlSD4/y
 LMw9FtosIfZYToKJ8kUTKI5k+WSKzPupWubPyyMKnaOXnXqyU93zv9r0E5b4Pk6/3T57
 wy8g==
X-Gm-Message-State: AOJu0Yxcb/QyM/3504707vGx1ix8ricgTM5Sx7kwiQ/v7ypZZiT2M5ax
 JQVV/S39FssoCDV4O/kXuYHBMg==
X-Google-Smtp-Source: AGHT+IHpy8r9xFtcnDKxjNo85zHqvsJyddr+c+GUJe6iMJ35gGVT1l9G4rtDe3ACDtW7kfx3KE4CJA==
X-Received: by 2002:a5d:4112:0:b0:333:2fd7:95fe with SMTP id
 l18-20020a5d4112000000b003332fd795femr950988wrp.57.1701453045349; 
 Fri, 01 Dec 2023 09:50:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m7-20020adffa07000000b003330b139fa5sm4740535wrr.30.2023.12.01.09.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 09:50:45 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C96985FB5F;
 Fri,  1 Dec 2023 17:50:44 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 0/6] gdbstub, avocado and gitlab updates
In-Reply-To: <0ac3a8ef-894f-4405-b816-c06dbb62e051@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 1 Dec 2023 17:52:33
 +0100")
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
 <7727c4ad-b6a2-49f5-88bf-0ac83e93f570@linaro.org>
 <0ac3a8ef-894f-4405-b816-c06dbb62e051@linaro.org>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Fri, 01 Dec 2023 17:50:44 +0000
Message-ID: <874jh16ccr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 1/12/23 17:50, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Alex,
>> On 1/12/23 16:12, Alex Benn=C3=A9e wrote:
>>> The following changes since commit
>>> abf635ddfe3242df907f58967f3c1e6763bbca2d:
>>>
>>> =C2=A0=C2=A0 Update version for v8.2.0-rc2 release (2023-11-28 16:31:16=
 -0500)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://gitlab.com/stsquad/qemu.git tags/pull-more-8.2-fix=
es-011223-1
>>>
>>> for you to fetch changes up to a7a740cce1ec49568e7ebd8e776279e59e2fb5b6:
>>>
>>> =C2=A0=C2=A0 gitlab: add optional job to run flaky avocado tests (2023-=
12-01
>>> 14:12:05 +0000)
>>>
>>> ----------------------------------------------------------------
>>> Flaky avocado tests, gdbstub and gitlab tweaks
>>>
>>> =C2=A0=C2=A0 - gdbstub, properly halt when QEMU is having IO issues
>>> =C2=A0=C2=A0 - convert skipIf(GITLAB_CI) to skipUnless(QEMU_TEST_FLAKY_=
TESTS)
>>> =C2=A0=C2=A0 - drop mips malta cpio test as assets expire in Debian arc=
hive
>>> =C2=A0=C2=A0 - tag sbsa-ref tests as TCG only
>>> =C2=A0=C2=A0 - build the correct microblaze for avocado-system-ubuntu
>>> =C2=A0=C2=A0 - add optional flaky tests job to CI
>>>
>>> ----------------------------------------------------------------
>>> Alex Benn=C3=A9e (6):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gdbstub: use a better signal when =
we halt for IO reasons
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 docs/devel: rationalise unstable g=
itlab tests under FLAKY_TESTS
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/avocado: drop BootLinuxConso=
le.test_mips_malta_cpio test
>> This patch has been posted 5h ago and we are still discussing it...
>> I'm quite surprised you include it in your PR.
>
> Do you mind re-posting your PR without this patch? I don't
> mind to work on it during the WE and merge it let's say
> Sunday, if you want it in before this Monday.

I've sent v2 of the PR without the mips changes.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

