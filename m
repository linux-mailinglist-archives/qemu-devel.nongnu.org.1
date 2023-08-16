Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDB877E1C1
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFla-0002Vy-Eq; Wed, 16 Aug 2023 08:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qWFlX-0002SW-Pv
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:36:47 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qWFlT-0001C5-3d
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:36:47 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so60936155e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 05:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692189401; x=1692794201;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TjQbuH32ag2eELa188PsAWA1l1EubMN3+ZQaDgbTDE=;
 b=gBmJlx7g8i3XkGqk9GmbkleaVN9Io7TqPuLMnBkK0KpDeJxcUNmIhLt/Zp7cwxI/PV
 hR1ij6J2lA8/y70ARW6KSfk9I5OwpZ0VOcLMTBl/vd3oWOhOC94yD8cqA2wNxI8ekOo2
 nP2qN/T4l8qw7cAGJ/oTUEQJG1p/IAbqxYX6aT1LypGnEvlC3NPFoJ/bUfPc5JFiX7rF
 cwx0jmejHqfYoQJO9ZiR3pUoetM7OCWPkFt5JQoKF7OITvZekEawGGtMNzMEBFIV5V+R
 MUbK30M5AdZtJAvi4Nl9n7fAxJh3MLP2H4YnVZngDWBa5sKts5fVwiPXpzHRms9PUZij
 Y+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692189401; x=1692794201;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1TjQbuH32ag2eELa188PsAWA1l1EubMN3+ZQaDgbTDE=;
 b=PBTYON0waXjjOtuY5VBYRNAxA+Nc2OzTUwXaf2F7m2YbRVDfWIrH0P1LOafTUebmlz
 RAOJbLQ7agUqpbqjCi+t/eCoq3LXeeieOU5fV5CmbmOSWCesb95Abj9r/VV0zgvUb0dz
 irnr7veqKM7UNrigUXTM7kuBj81aG14Wv0vls0y1xVzoIdm/UoMiAEmYa/aa5ci0L2kP
 wkb7baCfKgP0+ZdXCKw8gAE7cQQlI+pS6HLjZComfUgP9pp0IEQqFSe+bG0zDlj2oOfJ
 QQd8v7aNyHBgGKn1A5llC3zcMuoiB/QKqFsEddJUZfjIp9k7h65OB+5W7JQT63SUpAEA
 1dxg==
X-Gm-Message-State: AOJu0YxwPkYLNDt8kMuaYfp8YqaFzChAeurAAtlgGjJKJqhds0GT5i6B
 akkjZUyzNd30O0VlQc7vcQRaMg==
X-Google-Smtp-Source: AGHT+IHI/5uDSqNmyiKa8M5M3eY7E3K/ibErlBnS81qls/9clExvCJh91525gUpMnwbJCiIJVcsSkQ==
X-Received: by 2002:a05:600c:2482:b0:3fe:15e7:c8a1 with SMTP id
 2-20020a05600c248200b003fe15e7c8a1mr1328287wms.16.1692189401322; 
 Wed, 16 Aug 2023 05:36:41 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t21-20020a1c7715000000b003fe0bb31a6asm20911776wmi.43.2023.08.16.05.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 05:36:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 39EDE1FFBB;
 Wed, 16 Aug 2023 13:36:40 +0100 (BST)
References: <20230815145126.3444183-1-alex.bennee@linaro.org>
 <20230815145126.3444183-5-alex.bennee@linaro.org>
 <130aa9ee49dffd9ecc1006b17b9e82734837d7d9.camel@linux.ibm.com>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Beraldo Leal <bleal@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Akihiko
 Odaki <akihiko.odaki@daynix.com>, Thomas Huth <thuth@redhat.com>, David
 Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 4/9] tests: remove test-gdbstub.py
Date: Wed, 16 Aug 2023 13:33:11 +0100
In-reply-to: <130aa9ee49dffd9ecc1006b17b9e82734837d7d9.camel@linux.ibm.com>
Message-ID: <87zg2rnoyv.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Ilya Leoshkevich <iii@linux.ibm.com> writes:

> On Tue, 2023-08-15 at 15:51 +0100, Alex Benn=C3=A9e wrote:
>> This isn't directly called by our CI and because it doesn't run via
>> our run-test.py script does things slightly differently. Lets remove
>> it as we have plenty of working in-tree tests now for various aspects
>> of gdbstub.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> =C2=A0tests/guest-debug/test-gdbstub.py | 177 --------------------------=
--
>> --
>> =C2=A01 file changed, 177 deletions(-)
>> =C2=A0delete mode 100644 tests/guest-debug/test-gdbstub.py
>
> There doesn't seem to be a hbreak test elsewhere, but according to a
> comment in tcg/multiarch/gdbstub/memory.py it would be mapped to a
> normal break anyway.

It is for TCG but for other accelerators there will be different
handling (although I'm fairly sure only x86 and aarch64 are currently
plumbed to use the CPUs hbreak bits on KVM).

However this particular script was a very early addition when I was
testing stuff manually with images I'd built on my system. If we want to
exercise the gdbstub for accelerators it might be better porting the
test to avocado?

>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

