Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA477E9CC8
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:13:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2WjE-0005Ed-UY; Mon, 13 Nov 2023 08:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2Wj7-0005Cs-Sq
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:11:43 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2Wj1-0000RJ-A7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:11:36 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso6707436a12.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 05:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699881093; x=1700485893; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZgTbo620SzKFbNfoBUClJikuB7okF3V9knnrZKTMLY8=;
 b=DsZ9XPupqAfJDaIJZ3AezRLULgtc9BkkWSbf3ECZ4dEQ1bMW/giIC6hmEeai7yqxZd
 scHAvsoXgC5BN+XsjzLAdfemmhszSsssS0+MkAmIaOOJnrzbWxJ3M6AL11kvQiIiq3TR
 4xwScjKpBlIYCGd9cvtl+PPIKMLM3PyalUvpsXbR+YmmaDvUQsQeS7zECCCsRgn1Ondj
 NBFO3c0sqOivMbkpgtcxFRa+M2YNwduxlpp+VNy+xiMpRFsayaAFIkbWw01qfAp1uiq6
 xftvebEHTAMDsajS/2vvHMP/+FbBgFQ4PslaPja+n4YZ2bADv+hpLpKZJrS8dvNuGd2T
 EH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699881093; x=1700485893;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgTbo620SzKFbNfoBUClJikuB7okF3V9knnrZKTMLY8=;
 b=V1eGHudALWhFC3gBo0ynrDSilf8kXulq2EcBeTZmUb01owLXtkZCfH+CPxjyLcRurn
 81pkhtx4JIo3Tp+Ok4H00+P70W+7jRRoke8SoYzgZHgIEbRoE6Y3M26If4jPdf698lr/
 DgbKs+1Yc0Ck0QKCdmt2ZmHPy9OVV7H8Y75GJTNoVvawYFeYXrDvm0beGQUZJZ7gPNfX
 zDoCRhbOf5GK4iwaUZrJbbpoX/EsxZx+gFQWHTMrVwhcx0zex5k0v2Dnqt/BZfI6g4BP
 nLjtLRU5AV7LR40p2FUrCIc6qc0zeI7MOeFFIJ/ajupj/yoJJCHe0TUD1fCu01X1frIH
 VzvA==
X-Gm-Message-State: AOJu0Yyblfc8RbstECoLy9P3Dne0oSana/MjaSpuIg5F1hUFK2/gHfIT
 p4WYf7saVswNJEgapT5Tv6H2ZmbM87I5WtLGocWqLw==
X-Google-Smtp-Source: AGHT+IGeHKTmo24CQjCp6K1A7yRD9bgbQEfImpd8W+JHoeSUbzXOKe3aMFQgnVQvNjRN5z50PvNl++uWDB8FEqC8tLI=
X-Received: by 2002:a05:6402:26c7:b0:530:77e6:849f with SMTP id
 x7-20020a05640226c700b0053077e6849fmr6012174edd.27.1699881093359; Mon, 13 Nov
 2023 05:11:33 -0800 (PST)
MIME-Version: 1.0
References: <20231109192814.95977-1-philmd@linaro.org>
 <CAFEAcA8MJeX1Jk_-ONP1nNgHYadL7Oa8P3jGQXwNoofQnJWk8g@mail.gmail.com>
 <4ffed8f5-6624-4488-a74f-567cbd926b78@linaro.org>
In-Reply-To: <4ffed8f5-6624-4488-a74f-567cbd926b78@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2023 13:11:22 +0000
Message-ID: <CAFEAcA_0BfGVDZWJUPs8hwYRKS8FmzppQgY+s83qxBXHjLJvnw@mail.gmail.com>
Subject: Re: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async) FIFO
 to avoid blocking the main loop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Gavin Shan <gshan@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Evgeny Iakovlev <eiakovlev@linux.microsoft.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 9 Nov 2023 at 20:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Hi Peter,
>
> On 9/11/23 20:29, Peter Maydell wrote:
> > On Thu, 9 Nov 2023 at 19:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro=
.org> wrote:
> >>
> >> Missing review: #10
> >>
> >> Hi,
> >>
> >> This series add support for (async) FIFO on the transmit path
> >> of the PL011 UART.
> >
> > Hi; what's the rationale for the "for-8.2" targeting here?
> > What bug are we fixing?
>
> The bug is on Trusted Substrate when the ZynqMP machine is used:
> https://linaro.atlassian.net/browse/TRS-149?focusedCommentId=3D149574

And have we confirmed that the async FIFO support fixes that problem?
That bug report seems to have mostly just speculation in it that
maybe this XXX comment is why...

-- PMM

