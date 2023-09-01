Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21F978FB9D
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:11:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc17b-0005bj-C9; Fri, 01 Sep 2023 06:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qc17Y-0005b5-Vz
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:11:21 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qc17V-00014Y-GP
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 06:11:19 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401da71b85eso17812695e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693563076; x=1694167876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2YJNZCt9lI1XeJTjnfy7zPv2jocTeo7aZtGMkDUFySw=;
 b=EJEzR7UXr7IFWBabf941zW0aB+s9Zlo/9jYrx+lEzTI7Mi4121JOopCqo2VyB+Cpkr
 kgDA09lBahutOx5pdiyxeuUGAAIXZcazk2wU7sEWpUWmOfS78ZtT+DP6ebh5UYvlmobL
 ziq6Zcmf0c+ubUYU9S3M//R6+Y9cIkwg4QBr4Zq9Sd/ubwUvISdXkQPBKqXt2vEcQF3b
 tIZtB1oxvcKsdg33rnf0QGqMVEEtArCJWOhI8zaDb8ebgy+poO3WCjBK0Rxbd8Wl4FAg
 xbp50vgR5oRobAJkQnueX0kng1PV3XzlOE/RMciWTP9JUs9eboJkk554ryoXDSZa1cmT
 fKGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693563076; x=1694167876;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2YJNZCt9lI1XeJTjnfy7zPv2jocTeo7aZtGMkDUFySw=;
 b=A1MqnbpIwJ8zQHmlJjMCizR6XfdLA1jLxqvw7Vm/87Lhqz/Mxu6O15vLwMpj430ndk
 aDC9+v1C6MQd8mkfMwrgox53JIPUuEjxvUj5TnsXbR+4i3GxKZKPLNBkKjd2Dd0YoxNf
 /obCZYk9DyS2hg5BYv3wXetYy3mOD8D/Ybb/pvsZoTLIMxJDqD+1lWoiuhW4sEFhc6YV
 TvUwm5qGBU4WAHRD3ZWStv15/yCEj7/d8fEOQAse8y4aSUw/+te3qGLrNKTPTpDQR726
 9MttP7fVbk+oMkx/bImH55edg9M0HXem19yNP/OO/UlInTtLKx8+zT2yN7qDdW6XOuwt
 Xp0Q==
X-Gm-Message-State: AOJu0YxC1kxqE0fRMmzPnxQnjkOxTs9lntBOViBaB8pLGR2hho5fTC7i
 3qHGL2vAoInSu0CJN3yQJDIvmA==
X-Google-Smtp-Source: AGHT+IEstr2GNfWNzl+jAk7DDHthJRLDIL+4DQ3Ep2hZpbwr2fcxFw+YKAPNmluIGAVvKWY4mDyrGw==
X-Received: by 2002:adf:fa05:0:b0:313:f235:cd17 with SMTP id
 m5-20020adffa05000000b00313f235cd17mr1378875wrr.40.1693563075875; 
 Fri, 01 Sep 2023 03:11:15 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a056000137400b003142c85fbcdsm4799057wrz.11.2023.09.01.03.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:11:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CF6EF1FFBB;
 Fri,  1 Sep 2023 11:11:14 +0100 (BST)
References: <20221117172532.538149-1-alex.bennee@linaro.org>
 <20221117172532.538149-7-alex.bennee@linaro.org>
 <82434e83-d156-1a29-fb82-d6127162c185@linaro.org>
 <1aae8aab-8f92-e30a-7b40-e090aecdcd8e@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, fam@euphon.net, berrange@redhat.com,
 f4bug@amsat.org, aurelien@aurel32.net, pbonzini@redhat.com,
 stefanha@redhat.com, crosa@redhat.com, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 06/13] docs/devel: simplify the minimal checklist
Date: Fri, 01 Sep 2023 11:08:15 +0100
In-reply-to: <1aae8aab-8f92-e30a-7b40-e090aecdcd8e@linaro.org>
Message-ID: <87edjip5j1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Ping?
>
> On 5/7/23 13:44, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Alex,
>> On 17/11/22 18:25, Alex Benn=C3=A9e wrote:
>>> The bullet points are quite long and contain process tips. Move those
>>> bits of the bullet to the relevant sections and link to them. Use a
>>> table for nicer formatting of the checklist.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Message-Id: <20221111145529.4020801-8-alex.bennee@linaro.org>
>>> ---
>>> =C2=A0 docs/devel/submitting-a-patch.rst | 75 ++++++++++++++++++++-----=
------
>>> =C2=A0 1 file changed, 49 insertions(+), 26 deletions(-)
>>=20
>>> @@ -314,10 +320,12 @@ git repository to fetch the original commit.
>>> =C2=A0 Patch emails must include a ``Signed-off-by:`` line
>>> =C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> -For more information see `SubmittingPatches 1.12
>>> -<http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/SubmittingPatches?id=3Df6f94e2ab1b33f0082ac22d71f66385a60d8157=
f#n297>`__.
>>> -This is vital or we will not be able to apply your patch! Please use
>>> -your real name to sign a patch (not an alias or acronym).
>> Revisiting this patch, asking for some real name instead of alias
>> was at least helpful during patch review, we could address the
>> contributor by its name. Addressing an acronym is socially weird
>> (at least in my culture netiquette).

Is it that weird? We use nicks all the time on IRC.

The only driver for real names for the signoff is its harder to have
confidence the contribution is valid because you might not be able to
find who is behind an anonymous nick if something comes up later.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

