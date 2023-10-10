Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F10D37C4261
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 23:23:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqKAz-0006Ap-NF; Tue, 10 Oct 2023 17:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqKAx-0006AK-9x; Tue, 10 Oct 2023 17:21:59 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qqKAu-00074F-Vd; Tue, 10 Oct 2023 17:21:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c8a1541232so27992115ad.0; 
 Tue, 10 Oct 2023 14:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696972915; x=1697577715; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hEjlr5ptLr0UTZ62TWZw4aNo0XZa4tZlP8fMhAloroo=;
 b=KTS0HUUOrUBsgQEkw9aYmh4FPA8esqgJ6nn3herIGHVjK/qZn+874G7+SMDxcNLow4
 WhsuFlU4mG9GY+ZxvwhGShlRdIn2TwLukxKfeJhepI1HME3Ioo2eFPIbmZOw01rBTMT+
 keHF4Cdbs5Wb8PpUvkS2MP5PZenZ4PbDCvzUs04qbGInK7fClLABOz5VY7Mos9Er+GPK
 RY8jeY7IYLsopxCb1tDQiqjPuRZ7RO+hP85XGSJjmLCjma1MS2qtLjyuAPNPFOeQxSEV
 s9jPRj2rV45HXsN4cmZf/yuqDxf7rRTOwBObG9t0YG8x2wDkB3CdHTtM6ci6k1wXXZPv
 /A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696972915; x=1697577715;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hEjlr5ptLr0UTZ62TWZw4aNo0XZa4tZlP8fMhAloroo=;
 b=RvYFOyP0q7ATLcGjZjE8SQpU79jNAQGbkTFJdFEWtspzeVizAk1Pz9qhyjIZCqqICz
 dv2s/ZpS8NqymGwj0+s9fl73jGTSWPyfr+aK7WcRvcWQFhFr1sq1PUEqU0u8D4TD2fYW
 l2fKoxpHLmpQUOAce5cW8nRtvFjIbnPL8sabKkYClxgSvEWcbUPPbR4YTUEWGPur0J5T
 r+fPY3c6+56JpgzkNUn7RAfcGRJ0HZ+2VucTIG/t815QQYO978ByNNUBRFmMILifVtad
 y/92bcyFpTRCMe/yuXw6Bl9w+mVB1uWePDtUNldQU6QzjmCn20pnWblSSenSfdBo5P2T
 T0Ag==
X-Gm-Message-State: AOJu0Ywqfdefx6XPWvO4ZPThbvJSsDGUMhRBGIx4VlXlxBZegzwHg1vq
 ByltTooXxzOZCHFDolY4Ffk=
X-Google-Smtp-Source: AGHT+IHQEQP8+gDSQaXrRbFr+M0mg0FPTHHkcFk30Iv87IRaYpRpOf/ina6qgRPol5rpnborDlkEGg==
X-Received: by 2002:a17:903:230b:b0:1c6:a0b:7b9a with SMTP id
 d11-20020a170903230b00b001c60a0b7b9amr24705667plh.3.1696972915071; 
 Tue, 10 Oct 2023 14:21:55 -0700 (PDT)
Received: from localhost (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 jb5-20020a170903258500b001c0c86a5415sm12371708plb.154.2023.10.10.14.21.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 14:21:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Oct 2023 07:21:49 +1000
Message-Id: <CW52OWKBHGW2.NCXUFO464ZE7@wheely>
Cc: <qemu-ppc@nongnu.org>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH 07/11] tests/avocado: Add ppc boot tests for
 non-free AIX images
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
X-Mailer: aerc 0.15.2
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-8-npiggin@gmail.com> <87h6mypryo.fsf@linaro.org>
 <d854691d-e133-c8cd-a785-959720114100@linaro.org>
In-Reply-To: <d854691d-e133-c8cd-a785-959720114100@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Oct 10, 2023 at 10:49 PM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> On 10/10/23 14:43, Alex Benn=C3=A9e wrote:
> >=20
> > Nicholas Piggin <npiggin@gmail.com> writes:
> >=20
> >> An AIX image can be provided by setting AIX_IMAGE environment
> >> variable when running avocado.
> >>
> >> It's questionable whether we should carry these in upstream QEMU.
> >> It's convenient to see how to run these things, but simple enough
> >> to maintain in out of tree branch. I just wanted to see opinions
> >> about it.
> >=20
> > Yeah there is no point adding a test no one else can run. We already
> > have tests that utilise dead URLs that can only run if you happen to
> > have the image in the avocado cache which should arguably be removed.
>
> This isn't quite the same problem. This test image can possibly be
> shared among developers within the IBM realm.

Yeah, and other people can have AIX and MacOS legally by other means
(IIRC you could register an acount and get AIX, but that may have
changed).

We do have some people not at IBM who test AIX against upstram and
report bugs. Not too sure if they would find these avocado tests useful
though.

Thanks,
Nick

