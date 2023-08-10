Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5665D7777B0
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU4Hj-0004xz-6w; Thu, 10 Aug 2023 07:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qU4Hh-0004xg-CN
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qU4Hf-0008Vf-Pw
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691668614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pAANHwSE4oXsr2PaJoMWRudsz0vqHg8l1+KHI7xzJ4E=;
 b=chPKJ0Y0KjEPsyf7lykWSbJgafCNWhXYrAkMfuj77TF4zBCmxJ5mDscn9WtSl6OTX4lngV
 cGikY9ge8ZYXwQ5LsCkiQVEMNXVhBzJZ/yABbme61hReyIcUHTEt9Ch9JTirboiKSHVD2p
 0VuTLoY/POa9CbUqQ5DQIN3ESQNAi0I=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-nm8nuAQ7Ooi1VoCOtGygTw-1; Thu, 10 Aug 2023 07:56:53 -0400
X-MC-Unique: nm8nuAQ7Ooi1VoCOtGygTw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-79a0010dd40so292483241.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691668612; x=1692273412;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pAANHwSE4oXsr2PaJoMWRudsz0vqHg8l1+KHI7xzJ4E=;
 b=EW9p4O82aTrpH4jPiRgJFxUTtiiQsa+9Ve43+SguybEwyFXhEcWgF+jwX0SSJBmzEg
 uEDkQ302uStsuqoGrhXf4sBEOzSao+erZtVaJphr0I7cknIls9It3N2f0bLh0D1PSmi5
 0f+j2PSEuO62LXdGH1EoiIi+fua0aZNM/ey3oyk47Q7r98ahuzt01SQPkWSSbhyP3pbP
 uK1KR4lyEzG3nB/O0ddZB9aG/6uxmTRGmFNErWn+ooKlVsn4TFffBGWjBwWaBHuSG+Vu
 jrlPeghMpElLX3/2eGKBuE12Jbbwmgjrc+lHBSO8+iRPUjpAVpYkG5PvHWND4zg+NotL
 E9rA==
X-Gm-Message-State: AOJu0YzBZiqjyQWUYJMgSqzmjFZchpE6qOXZkVS6oJUhHrqJr7Dw26yS
 M3M0pQT0XuOmrM02PFjvxhBQeeLrWef9tUQatKl+LnkPfX3KAu/usI/NbEB27Z31z5HjAJ/3YPI
 358Ah4op/7sKKXw5Kv6NRQNoKiYZC9r8=
X-Received: by 2002:a05:6102:3031:b0:443:7e93:641f with SMTP id
 v17-20020a056102303100b004437e93641fmr1375772vsa.9.1691668612795; 
 Thu, 10 Aug 2023 04:56:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6MScJCMt8/D8jWN27dlllUX2cG6L/OZl2jFY7yH20OA0H6bpJiLZxMTZHZDx5prlvPgLrMBfp/XHrk8pOY2o=
X-Received: by 2002:a05:6102:3031:b0:443:7e93:641f with SMTP id
 v17-20020a056102303100b004437e93641fmr1375759vsa.9.1691668612577; Thu, 10 Aug
 2023 04:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230809092933.761524-1-pbonzini@redhat.com>
 <c8d32a26-b749-01b3-0b36-98e374947427@linaro.org>
In-Reply-To: <c8d32a26-b749-01b3-0b36-98e374947427@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 10 Aug 2023 13:56:40 +0200
Message-ID: <CABgObfYAeAnUNW=x+qE=dearKg7pKtSvRRsXaSKaHBgnVS7NuQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] Use known good releases when installing in pyvenv
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, Jan Richter <jarichte@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 10, 2023 at 1:52=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
> Does this fix the second point of commit eaf245becd ("Revert
> "tests/requirements.txt: bump up avocado-framework version to 101.0"")
>
>   > Second, the recent changes to Python handling mean that there is
>   > a single virtual environment for all the build, instead of a separate
>   > one for testing.

This was reverted and Avocado has a separate venv than pyvenv/ (which
is the one created by configure). This series makes it possible to
have again a single virtual environment for all the build.

>   > Avocado is not logging of command lines or terminal output, and
>   > not collecting Python logs outside the avocado namespace.
>
> This seems to be fixed in Avocado 102.0:

Correct.

> Assuming this is enough for macOS, what would be the next change,
> moving to 102.0 or integrate 102.0 in the current set? I.e.:
>
>    avocado-framework =3D { accepted =3D "(>=3D88.1, <93.0, 102.0)", ... }

The plan is to:

1) wait for the next LTS release of Avocado (103.0)

2) wait for it to be packaged in Fedora

3) change "accepted" to be "~=3D 103.0"

Users of Fedora will have to switch from the 92.0 module to the 103.0
module if they want to use the system avocado.

Paolo


