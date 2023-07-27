Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4B976585F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:12:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3GO-0002pP-6P; Thu, 27 Jul 2023 11:50:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3GJ-0002pH-1s
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:50:47 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP3GG-0006jq-Et
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:50:46 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-317786befa2so1147335f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690473043; x=1691077843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXopCWcoIkBqAmHk8EQGq50hih0jaCd+C7v1puPVUTE=;
 b=Spto+UPgWfimz+mkcVdTC27ydqnoswz7dS/MtKgxufyTrjnTF1zm09HmH1UssXeeBw
 cJRyWBofILOfUF+C19W7onU67VFaxmV2k2y9lF2Q76A9lyyxZEY42D5A3bhVLPzzNH9c
 psKeuc1rypMkVTO3dZP4Mj1MSksTMhquoo/1klzVvk2Wwr/HJ5jsb8BE4/KfPYjMJA2S
 nLiPsy1GenVv5rmIK4MiqWyhe2pXknBAr+2c9O+HKF735GhTgo6PCL2Ihwovcj4tFtMp
 BZqF5nyuf6au+smdC/GFuQ1Gu6S9DTTILJN3f9wOuIyRwWkeYgrU3Bo6jDgAtId3K7ry
 BfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690473043; x=1691077843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXopCWcoIkBqAmHk8EQGq50hih0jaCd+C7v1puPVUTE=;
 b=T3EBY3xxZYBnJ9IRYJ+/jeQNR1fXkRkETCSTR+7cTLJNs7qqxOYY18pzE5o6qB/j4p
 IOBfmI5CiRaDe54Y6HMCA1wPpYSTT8uQKe24h/0srpxKpwa6TQI30/p2JY6mqv1qJnnu
 yAsMIPSFe4yKDCQAo6SQt9oU8X7YFB16oIQWZ4blxFxkjp7fX2wm1QhlsDsE/CbzV8Ts
 xk0wpPR9uwou/awT4HO2r3NwbTKp1lbNKeMgGHuNQktaaYw8tjNZarqZb9XC3KYG8vz8
 1Xy3WBQz1W6FatcknX0n99sP+clHaP+LMa/tCcC8VdmjkqR2jjl569r2WXcVO1Y4pi3j
 t3nA==
X-Gm-Message-State: ABy/qLZ1mxUy83aVRidYaLmdd2IUpYHOaXaR4mSrzGriE2ks6amEq9mu
 mj/03AR9sjGfgkOTpurnCcL2bXSDo22e51FWXcoJNA==
X-Google-Smtp-Source: APBJJlFrWPJgFJQ9riIL6aaXpy+vTfviyEAt7XfxZpokCgVZksmCko3o0RnYXE5i6ChDt6fTTKGj/mZdXR5gnUv+Pkc=
X-Received: by 2002:a5d:4591:0:b0:313:f429:f6e9 with SMTP id
 p17-20020a5d4591000000b00313f429f6e9mr1905010wrq.60.1690473042717; Thu, 27
 Jul 2023 08:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <CA+bd_6Krq9aCCQe01OjXxb+T-=3XrSnvVHrKs3F-3cwdZEGH8Q@mail.gmail.com>
In-Reply-To: <CA+bd_6Krq9aCCQe01OjXxb+T-=3XrSnvVHrKs3F-3cwdZEGH8Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 16:50:31 +0100
Message-ID: <CAFEAcA9txYV4GZQi-uRPWuXd1oOiVHB7ZUQ5-+=zA4T+Of-g1g@mail.gmail.com>
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
To: Cleber Rosa <crosa@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

On Thu, 27 Jul 2023 at 16:20, Cleber Rosa <crosa@redhat.com> wrote:
>
> On Tue, Jul 25, 2023 at 1:13=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > Why is a "Missing asset" causing a timeout after 90 seconds,
> > rather than being accounted as a "SKIP" ("missing requirements
> > in the test environment" sounds like what we have here) ?
> >
>
> Hi Peter,
>
> First of all, I am sorry for the frustration you experienced while
> trying to understand all of this.  It tooke me a while too. Anyways,
> the 90 seconds timeout is set here[1].
>
> > I don't understand the debug.log, because it says all of
> >  * that it retrieved the URL
>
> That happens here[2], because Python's urllib.request.urlopen()[3]
> returned a response.  The message is clearly misleading, though,
> because:
>
> 1. the response may not indicate that the request was successful (even
> though the most common exception raised by unsuccessful operations,
> HTTPError,  is being handled)
> 2. that the file's content being pointed at by the URL has been transferr=
ed.
>
> I've opened an issue[4] to fix this misleading message.
>
> >  * that it wanted to cancel the test
>
> Yes, this is the default behavior set here[5] (cancel_on_missing=3DTrue).
>
> >  * that the test timed out
> >
>
> My understanding, up to this point, is that:
>
> Avocado signals to the test that it should be interrupted.  The
> handling of the exception gets to the attempt to fetch the asset,
> which fails and is thus considered missing.  Because of
> cancel_on_missing=3DTrue, It sets the status of the test, up to that
> point, to be CANCELed.
>
> But, Avocado "knows better", because it triggered the interruption of
> the test, so it overwrites that status of the test as INTERRUPTed.
> The whole thing may be complex and confusing, but IMO it seems
> coherent so far (minus the misleading "retrieved" message).

Ah, so the problem is that we are trying to download the asset
file, and the remote server is stalling so it doesn't actually
download the file in 90s, and Avocado doesn't distinguish
"hit the timeout while trying to download assets" from
"hit the timeout running the actual test" ?

This sounds to me like the ideal would be that there is a separate
timeout for file downloads (which could then be a lot shorter than
the overall test timeout), and "timeout during asset download"
would be detected separately from "timeout while actually running
test".  But maybe the separation-of-phases in newer Avocado achieves
that already ?

thanks
-- PMM

