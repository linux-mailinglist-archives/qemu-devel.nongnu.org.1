Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89704826F14
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:57:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpBu-00056c-NI; Mon, 08 Jan 2024 07:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMpBr-00054q-Cs
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:57:15 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMpBp-0007L7-Hv
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:57:15 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2cd46e7ae8fso15411911fa.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704718631; x=1705323431; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oZyuVWGCu5K0Mnt6tPHwff3ZIwKlT3vQXX5uqiUTKkg=;
 b=N/XQF3YOyYWQMeq2vX4CSSFtMtJUB/CVWrVNiR73qUpr83qc0I2FkE/yhUr0Elxoi/
 pimOmGuQLE4tIs2bc8weYJXGdG8tKToyLDCUczknvKvvIFlti1ZenQq/v+pYlN+x0rBZ
 /4sdVm/O4socFOncf/mYWsJAuovHWUZvT02hWDN9b3ZxEmA2z9x+ypwyYENOWiGqIUng
 pGyi5d1CAi+bb6pA2L2MODPNqxL+oqxO8wllRW6rYiRjXup/iIW3qqskHniJmKP0ezcN
 MESCD8jxWkt8F9srxDbrNVGIjQNMzmYKnyjXctuj3OAphmjo+5LtnlGmeSlIOXqMMyEs
 OHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704718631; x=1705323431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oZyuVWGCu5K0Mnt6tPHwff3ZIwKlT3vQXX5uqiUTKkg=;
 b=kpBqdFr2zoF+2RnY9v8ESZQ77aierVKhZEI0BswqAN3w28aer6IT0ivX5du/RPYKMe
 oKKyBbR9OYNmp3a6m1KMWPCiCFLhtdeehv/xMg8KpjzjAYCSCj1p5UuuOnWY8eEI1yVm
 KWZvfKngqIlGHyTl3s26fQL5JT0tsf392x54GuouvkWK2hC6sKigb2DHH1t81Y9O0RR6
 N+9gJFjrKq3vf+i8KlzE8BkdcHe+cywAzlnOsdNMgHtaLG36rOxfudOK9aG4Bsf4lU32
 oG7DreNIJayewM974NRpNGYV/jy7TVgtaJrMWrDAbuNbITOA7crv1M09G11Ng2Rbt8Tf
 9ObQ==
X-Gm-Message-State: AOJu0YygXp2rym+4MhvzjvpIxfcZ1Ag7sQ6XdxpfZ/7WRtcOaV0iZ+LZ
 E70SN38ICVJXA8bEpToAyK93f8LqcLFmNEijB5xiWtYnw+WOzA==
X-Google-Smtp-Source: AGHT+IEqy+IcPzjWhCoQMzVqp+WxAUCpOuMrvkqSSyhgXKb6IKKZokrDAthxPXgDCJH91KtPji28c78ywMac6uLTjxs=
X-Received: by 2002:a2e:a48d:0:b0:2cd:35d6:d84d with SMTP id
 h13-20020a2ea48d000000b002cd35d6d84dmr683700lji.150.1704718631241; Mon, 08
 Jan 2024 04:57:11 -0800 (PST)
MIME-Version: 1.0
References: <CAFEAcA93kpreNOOKz6-qbVE_9Kg6tgZNaMowNLwc+G_47MXLHg@mail.gmail.com>
 <9f0615dc-c162-4ac6-9ead-7f9d28e5d318@redhat.com>
 <CAFEAcA8j3aKMWzb2zSZ5gUaV4uosa2GLBaEKTcqf93iU42FbDA@mail.gmail.com>
In-Reply-To: <CAFEAcA8j3aKMWzb2zSZ5gUaV4uosa2GLBaEKTcqf93iU42FbDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 12:57:00 +0000
Message-ID: <CAFEAcA8iz--o+mYZWwzT7BNxJZPjwBE5Qo3Jsu-5HAdQ7-UfSA@mail.gmail.com>
Subject: Re: CI "pages" job failing with incomprehensible error message from
 htags
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Bui Quang Minh <minhquangbui99@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x236.google.com
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

On Mon, 8 Jan 2024 at 12:34, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 8 Jan 2024 at 11:03, Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 05/01/2024 20.11, Peter Maydell wrote:
> > > https://gitlab.com/qemu-project/qemu/-/jobs/5871592479
> > >
> > > failed with
> > >
> > > $ htags -anT --tree-view=filetree -m qemu_init -t "Welcome to the QEMU
> > > sourcecode"
> > > htags: Negative exec line limit = -371
> > >
> > > Does anybody have any idea what this is about ?
> >
> > In case you haven't spotted it yet:
> >
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg1014394.html
> >
> > Is anybody already already creating a patch to clear CI_COMMIT_MESSAGE when
> > invoking htags ?
>
> As a first step, I filed a bug for us for it:
> https://gitlab.com/qemu-project/qemu/-/issues/2080
>
> We should probably report this upstream, I suppose.

I've now sent an email to the bug-global list to do that.

-- PMM

