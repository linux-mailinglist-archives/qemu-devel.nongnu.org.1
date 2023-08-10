Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E11777CFF
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 17:58:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU83V-0008QK-K1; Thu, 10 Aug 2023 11:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU83T-0008PO-HE
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:58:31 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qU83R-0007ct-Q7
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 11:58:31 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4fe2d152f62so1699934e87.0
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691683107; x=1692287907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MVy0qRrVryPm5pUGMlP2xUZofAO7F8EQp9yGVBbD7gc=;
 b=UeAPvk0HnRVSqKOdQW2KEwaMRXvm9GCTfUjGeAafgtkceC3UK9q+5p/oUBe7jPOyA3
 g5b3JOnvCBVSqKjgO5UgBSejCgNinhh48wqxIb/5PaDKYwtCAWMyLI2PhVlnfIm62ANc
 s0Zu0mlDwQKWk85r8hUg9LhyIRebCRAb0PK+kDFCYHbrf90c7RA9nYCVgunA1tpp66oS
 dvgq++l3PVa9kXulQz/72Sva9wGwlxYB9tAm3Bu7yWjFo1fp6nv3Divf+W3cn1DFBCTj
 JsDGxCOmObvnZE39LyfAfzJfTpy2dRReIrGGKAv243a9PHrsXa0UQxozDMGM7LoCQqkA
 pUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691683107; x=1692287907;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MVy0qRrVryPm5pUGMlP2xUZofAO7F8EQp9yGVBbD7gc=;
 b=Pllpn/GQ0a4Ba0QiVuGoJ2OKJU4q2YrjMVBIFURCnFXL83AEz4+5CIUrPQzIh/bZba
 tA3y+2gLEi4oKcpkxaEy7xr9pW6juIzsyqSft8XI6HkEcZBa0kFXzBAUI+87sUS4OQvX
 ux9e6xYTgzo4SUJ1lpGoHRnn8ShjPFlRkveSPA8FjX4H3mhGRW7OEYfTo0C3bD99tFBn
 0vc3EHUraLtGbGxprZ8VrqeyMNk2dcS3fjefXN9D7YhVC8If/L16S/wDR4ATQUKheDK5
 eyg4sbwLjMO8Tn2SdwRkVnt6bhJQKr9ilYha9oEDt03XZ1sqfPvhbaTrrYhlurj8cLPJ
 5B3w==
X-Gm-Message-State: AOJu0YzDtV4jAGfjBT4krfEhFrdjOKP8Z8ZhIiPZfkkzL6k33IvsFHL2
 yI93SV7/weGfIoY/1US6CoPMFtsDOrWOJF9LOMMJ/g==
X-Google-Smtp-Source: AGHT+IGYEGIUqx27S9WcJgHf6DRwRpIeCAN94mDinMoCMzb4w81urpg2OwO8lyW0MEGmEsoHuiYwtvkoB+N4BiW81tU=
X-Received: by 2002:a05:6512:313c:b0:4fe:7df0:41ab with SMTP id
 p28-20020a056512313c00b004fe7df041abmr1697661lfd.17.1691683107104; Thu, 10
 Aug 2023 08:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230810153640.1879717-1-alex.bennee@linaro.org>
In-Reply-To: <20230810153640.1879717-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Aug 2023 16:58:15 +0100
Message-ID: <CAFEAcA9bOS7tJDe_TRKOUGFcCDq_CjUfzAF7dYYRJbZA=5hvqw@mail.gmail.com>
Subject: Re: [PATCH 0/8] some testing and gdbstub fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Yonggang Luo <luoyonggang@gmail.com>, Beraldo Leal <bleal@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-arm@nongnu.org, 
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Thu, 10 Aug 2023 at 16:36, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This is mostly gdbstub focused but I cleaned up some bits while I was
> in the testing makefiles. This is mostly to make the "check-tcg"
> output as clean as possible without ugly line wraps. I tried to
> eliminate the gdbstub info() output but sadly this is harder than
> expected.
>
> I've tweaked the gdbstub handling for Ctrl-c packets as suggested by
> Matheus. While I was there I also noticed we were being a bit precious
> about gdb sending preemptive ACKS so I fixed that as well.
>
> I don't know if this is all late 8.1-rc material but its fairly simple
> testing updates and the ccache stuff from Daniel should help as well.

At this point in the cycle I would favour putting in
the minimum that actually fixes bugs / test failure issues.

thanks
-- PMM

