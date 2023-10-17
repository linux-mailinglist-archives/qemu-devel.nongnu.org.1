Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6207CC9C2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 19:21:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnkt-00076O-Bo; Tue, 17 Oct 2023 13:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsnkk-00072F-Tf
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:21:10 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsnkh-0004eM-SK
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 13:21:09 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so4727341f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 10:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697563266; x=1698168066; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+TYRNSqplKM+iToPLX2vOL24F4DY4NL0tV7Fv3/bqw=;
 b=A1W/f6UPsWWYPyvJ8ZzON5tuJ6KdzdeXf4GlssFSeAwWS/2fPgy4YqJrLREoGOiMin
 yMIiEf8sJnE+o9g/oNWcEtTPBkkv/Q9fxxE79o3e4qoJoqotSMgId8KzgD0q9KO2cc+5
 QbQBONIwmHZ60Fn/q25EtMWYopiccSpmOQgjAphItRhGjZiDK72nOGxZkW4ouFxgsSIj
 A6kMroP/JOvuA2yCckmocXYHTgFKdn2zp0O/oieiJqbTCvWb8Nfqq2Y72qCpX+H0LIpt
 wy0eikEIWyutqOcWYQShNHkPp12X68FR9AQXhOYH08zTzmbW2/6ZB9lcmJei0urKy54X
 pH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697563266; x=1698168066;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9+TYRNSqplKM+iToPLX2vOL24F4DY4NL0tV7Fv3/bqw=;
 b=G6RAGJz2QOdzkjVEazQ3eKeIWbiRL9Kv7WYWZXmuEbJgW29TuZOO2YCtSdTudBPQ7k
 nopnnyVyfsKXNVUtZGsa9Z6sXx8Y7sAz0Nl/5fFA65KdBc43n4Jxb86gWabN6aYkiw6/
 NDWslBVMBV6X92WwUuN1zdjAYpXT+YG9rIjSiB7WQC2HLBxCnMo/lea98VuqIadp6Fzi
 TAOgsLqHLrWA7i6t5GLNcjBTWB+Bm7wL30LcVKXPaDBiLLstB821X1YlITZgMO2iCGOU
 s6FhOvxXmMmL4Zkh2Y97XCzyemed2AARLsTy+3uncHOWQH/trrp9GbT5cKiKZU04xxfP
 vGnw==
X-Gm-Message-State: AOJu0Yyc1gR5MiaxAe4UpzjPWm9y+va29G2G1GLvfBog2Hk+KMXFH3U0
 4tYE6lXhvGmynBiZmYyzG/s5ig==
X-Google-Smtp-Source: AGHT+IEuw+zDJre1njCf0Jl4R8BoRuzmnIaWuVeaYrZQ+mxBMW9wvhT42dpZB1SKWFb49ZRiau5+4w==
X-Received: by 2002:a5d:6303:0:b0:32d:9a1b:5d7f with SMTP id
 i3-20020a5d6303000000b0032d9a1b5d7fmr2587981wru.29.1697563265710; 
 Tue, 17 Oct 2023 10:21:05 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a5d6808000000b0032d8ce46caasm196584wru.93.2023.10.17.10.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 10:21:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9F7B31FFBB;
 Tue, 17 Oct 2023 18:21:04 +0100 (BST)
References: <CAHhcV8-HHG36Ndv7Y-K5FrUTb-WwVoRW3PPzaiM4hEesGA-iWw@mail.gmail.com>
 <CAHhcV89tKJiFz6CW5Xm6XP5pDs1uLBew=kjC5qd-k+fNVmdt1g@mail.gmail.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Amit Kumar <amit251098@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [Beginner-Help] Help understanding the migration Code
Date: Tue, 17 Oct 2023 18:19:51 +0100
In-reply-to: <CAHhcV89tKJiFz6CW5Xm6XP5pDs1uLBew=kjC5qd-k+fNVmdt1g@mail.gmail.com>
Message-ID: <875y35b1xb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


Amit Kumar <amit251098@gmail.com> writes:

> Following up on the previous email I sent. I want to understand the migra=
tion code, I have read a couple of papers on
> how it works in theory, but I am finding it hard to find a starting
> point where I can start to understand the code.

Start looking at the VMStateDescription and what follows from there.
This is the principle source of serialisation information when saving
and restoring device state.

The VMSTATE_* macros wrap up a lot of the structures.

>
> Any help would be appreciated.
>
> Thank you
>
> On Wed, Oct 11, 2023 at 9:40=E2=80=AFAM Amit Kumar <amit251098@gmail.com>=
 wrote:
>
>  Hi
>  I am trying to understand how migration, more specifically live-migratio=
n works in QEMU. I've tried going
>  through the source code but didn't understand much, and couldn't find do=
cumentation either. I want to work on
>  live migration and need help getting to know the code.=20
>  More specifically I want to understand
>  - where the pre/post copy algorithms are implemented
>  - which files/data-structures that I should look at
>  - should I need to make changes, where and how should I start?
>
>  I am new to working with such large code bases, hence need some guidance.
>
>  Thanks
>
>  Amit Kumar


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

