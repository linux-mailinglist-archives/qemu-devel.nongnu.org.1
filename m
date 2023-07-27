Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F91765C0C
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 21:25:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP6MB-0005i6-Sx; Thu, 27 Jul 2023 15:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP6M9-0005hv-Gz
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1qP6M7-0001rH-UX
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 15:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690484939;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HL4cekXwXq74pfYYKzvVcEMRP0SHrzBd5RKM8Vn8FZo=;
 b=co11K5mqucRVI7Ig7RbSWTUzTx7ruRVEYXnHHZNENul6AtmzUWn+Ts2F79R4d+/t6FP9gp
 Obhbm+Qk6iaQnztL5NxEQlmyfN8/oT43DZucI+FpkzCbrlYcUe8E6WNM3xtOO1S72qYhCp
 1/pkeTlo/5CEfVX2KMqjDb1iydM12pc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-Kx7HmGi1PpmC2s4XIf8YnQ-1; Thu, 27 Jul 2023 15:08:57 -0400
X-MC-Unique: Kx7HmGi1PpmC2s4XIf8YnQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-55c79a5565aso812080a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 12:08:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690484936; x=1691089736;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HL4cekXwXq74pfYYKzvVcEMRP0SHrzBd5RKM8Vn8FZo=;
 b=WB86ycQ7bsN8CoFm/G5ie/HiM2JV8//hKneJPifvksY+qsoTo36XKvNNiHY6ljjom3
 k6doxU29Wec2bUGcb6dC64wJW+fPJKzjMHfFZpSvODEDFsnpctwVAwu/Xxvw6rcLneio
 8ddCsPx9Uk9VKxxKzUsVMyArnvWp6z6lY+qPNnoN1opFXER0QEU+rzGN4wOvrdcIFY2g
 2apldGBTNM+XCspmfzUA4au5NCuY++GAbkGiaD8DUbOTRHZG2iOJNac0vGPZRXn9nnAB
 3OwDh/CutrYMaG/2T8CuFaa3P5QGdPY6Yb1Zqw5p1J2IvW38vCktQNosl0QtwSFoB0ZC
 2wGg==
X-Gm-Message-State: ABy/qLYgNeu/EhPMLqvzaXyXMIW2VkavaT1i2jER1zl//IzkdPhJ6BrT
 nha5ffQK+v2gVfXIcQbBOEmbBV8aDhzS2bEdZi69GcOsztzoYq8cS/cVu5GIkBH3PPauxp1NupQ
 HA0SnyWzKvoX+PeK0M1pP4FxeMqSSnf4=
X-Received: by 2002:a17:903:247:b0:1b6:b445:36d4 with SMTP id
 j7-20020a170903024700b001b6b44536d4mr240562plh.43.1690484936036; 
 Thu, 27 Jul 2023 12:08:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzJSakyGNYc5Hmn3gXQIeUJaJ1fmt8oSa5gd/XQ1XA6JY6dCkTlGBFeI+vvP78a7G8qiyJtQ7vW061JQmwi5g=
X-Received: by 2002:a17:903:247:b0:1b6:b445:36d4 with SMTP id
 j7-20020a170903024700b001b6b44536d4mr240541plh.43.1690484935680; Thu, 27 Jul
 2023 12:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA--tJPhQO49W3BDO1MABQFHrr50MU=q54TFYpbkOxVWHw@mail.gmail.com>
 <CA+bd_6Krq9aCCQe01OjXxb+T-=3XrSnvVHrKs3F-3cwdZEGH8Q@mail.gmail.com>
 <CAFEAcA9txYV4GZQi-uRPWuXd1oOiVHB7ZUQ5-+=zA4T+Of-g1g@mail.gmail.com>
In-Reply-To: <CAFEAcA9txYV4GZQi-uRPWuXd1oOiVHB7ZUQ5-+=zA4T+Of-g1g@mail.gmail.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 27 Jul 2023 15:08:43 -0400
Message-ID: <CA+bd_6LsQw3ao1KQk8Jk-VvAb9SZ1ioxSdBsghtNqJK-cnMRXA@mail.gmail.com>
Subject: Re: avocado test failing INTERRUPTED for "Missing asset"
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jul 27, 2023 at 11:50=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> Ah, so the problem is that we are trying to download the asset
> file, and the remote server is stalling so it doesn't actually
> download the file in 90s, and Avocado doesn't distinguish
> "hit the timeout while trying to download assets" from
> "hit the timeout running the actual test" ?
>

Yes, exactly.  Once the test starts, that's the only timeout being
enforced.  The fetch_asset() (and all the download code path) is
simply part of the test and thus under the test timeout.  Also, right
now, avocado.Test.fetch_asset() doesn't provide a timeout parameter
(but the underlying avocado.utils.asset.Asset.fetch() does).

> This sounds to me like the ideal would be that there is a separate
> timeout for file downloads (which could then be a lot shorter than
> the overall test timeout), and "timeout during asset download"
> would be detected separately from "timeout while actually running
> test".  But maybe the separation-of-phases in newer Avocado achieves
> that already ?
>

The mechanism in newer Avocado will simply never attempt to run tests
that don't have the stated requirements fulfilled.  With regards to
timeouts, each of the different kinds of requirement implementations
(file downloads and cache, A.K.A. "assets", packages installation,
ansible module execution,  etc) are supposed to provide their own
features, including timeouts.

Anyways, I'll look into, and report back on:

1. expanding avocado.Test.fetch_asset() with a timeout parameter
2. making sure the newer implementation for the requirement types used
by QEMU respect a timeout (they don't need to be smaller than the
test, because they run completely outside of the test).

For now, are you OK with re-running those jobs if the servers stall
the transfers? Or would you rather see a patch that changes the
find_only parameter to True, so that if the pre-test attempt to
download the asset fails, the transfer is never attempted during the
test?

Thanks,
- Cleber.

> thanks
> -- PMM
>


