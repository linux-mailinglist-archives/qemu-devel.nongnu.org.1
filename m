Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8CE79295D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdZGD-000175-4b; Tue, 05 Sep 2023 12:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdZGA-00016G-Ts
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:50:38 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.purdie@linuxfoundation.org>)
 id 1qdZG8-0003x1-Ar
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:50:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-402be83929eso27191685e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google; t=1693932634; x=1694537434; darn=nongnu.org; 
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=C8jKaWGbu4PyvRot4KpDeunpx2CrrqY5SPj3zqIwQRw=;
 b=Duqpx9IwxtuPN20Ifyj2ZyFI+Fpjqw4hWJOcaeNC8gOJw5L5tibcKewmKiTxitGZpD
 VZVzdJk/llV3X05O2h4SmSHCegOj+/lP5ZORQyGlV2SUwZDbcVPLl6lUkPJBzD+pvUJK
 qSuxs0fmivrdmyP74H2kpY7jTSgSLAfnA8S/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693932634; x=1694537434;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C8jKaWGbu4PyvRot4KpDeunpx2CrrqY5SPj3zqIwQRw=;
 b=KC/5XcD3bh9HDJB/U6QaIJiH8K+2RRqebiRriIGc9IeL0iIo8zNziPEyeM8pNvemzf
 1MUnqDWI6oZkgK/Vwsd2izeenKq4IwM6O/RARNcgN3WwvGGbJF4jBhR3N7tPdCw99Oov
 tSws6htsqjFjwUPgdAXJQGgzvzPmM+U4wry6fXbxob88gQfVwrU4/HCyaFjqSWu2VS8z
 YVB9gKT/TFLZm8+D5dkMf8hfmUVa+r71ApC4k+MOc/Tjqf6fWh5UIhz3QEbaX/kyONuc
 Pi02xHHpEaTrnl83M3BqOkepOlSgy02DcrX4A6P46PlmCvRaHipDUAM21qwaKfB5O1Gp
 6YXw==
X-Gm-Message-State: AOJu0Yxbme8XC632GD4NHMUNPkfSivYw8LSZVDJZ72dECFUoq9gOxpRq
 A5StLvzvOgfF64vC3MyzMrOx5A==
X-Google-Smtp-Source: AGHT+IHzaaMFe87uP2rFVdCRVWrUNUjJUqh8OgLhmoY3G6CVQJm5nya5ib7NsS/23YuKZUH6ikYyaQ==
X-Received: by 2002:a7b:ca48:0:b0:401:b53e:6c54 with SMTP id
 m8-20020a7bca48000000b00401b53e6c54mr244312wml.7.1693932634455; 
 Tue, 05 Sep 2023 09:50:34 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e?
 ([2001:8b0:aba:5f3c:9cbb:8ec6:1cb5:104e])
 by smtp.gmail.com with ESMTPSA id
 ay23-20020a5d6f17000000b003143add4396sm9246127wrb.22.2023.09.05.09.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:50:33 -0700 (PDT)
Message-ID: <5fb4ebef7387b58a83377b2ec679c62bac57f31c.camel@linuxfoundation.org>
Subject: Re: mips system emulation failure with virtio
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Alex
 =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Date: Tue, 05 Sep 2023 17:50:33 +0100
In-Reply-To: <932ee6f0-f8bb-f9eb-49bd-3ffee7afd265@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
 <d35f5c16-e75c-fc7f-57cb-c6f7a5e696fc@linaro.org>
 <58b3aa9437ac94d7665e7b93f4868f7e7d3f71b3.camel@linuxfoundation.org>
 <932ee6f0-f8bb-f9eb-49bd-3ffee7afd265@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=richard.purdie@linuxfoundation.org;
 helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 2023-09-05 at 18:46 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 5/9/23 17:53, Richard Purdie wrote:
> > On Tue, 2023-09-05 at 17:12 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Hi Richard,
> > >=20
> > > On 5/9/23 16:50, Richard Purdie wrote:
> > > > On Tue, 2023-09-05 at 14:59 +0100, Alex Benn=C3=A9e wrote:
> > > > > Richard Purdie <richard.purdie@linuxfoundation.org> writes:
> > > > >=20
> > > > > > With qemu 8.1.0 we see boot hangs fox x86-64 targets.
> > > > > >=20
> > > > > > These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (so=
ftmmu:
> > > > > > Use async_run_on_cpu in tcg_commit) but if I add that commit, m=
ips and
> > > > > > mips64 break, hanging at boot unable to find a rootfs.
> > >=20
> > > Are you testing mipsel / mips64el?
> >=20
> > No, it was mips/mips64, i.e. big endian.
>=20
> Sorry my question was not clear. I meant: Do you also
> test mipsel / mips64el guests, and if so, do they work?
> (IOW, is this bug only big-endian guest specific?)

Sorry, I misunderstood. We don't test mipsel/mips64el so I don't know
if that is working or not unfortunately.

Cheers,

Richard

