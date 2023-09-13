Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57E79EB13
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 16:29:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgQqA-0005cd-GK; Wed, 13 Sep 2023 10:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgQq3-0005cJ-Dq
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:27:31 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qgQq1-0000tf-BC
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 10:27:31 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3ab244e7113so4723779b6e.3
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694615248; x=1695220048; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XfxJEEgBf2tsDTx23xuJtSfn6KoYgOv3m+bMHJpxUwE=;
 b=fKkMpS/RG1j5ykogDmPUJ/vanqRbzZwJ/JvI9G+DVPpN/wh+VeMtu3eUmeMNPKtqcI
 GNNYUHbxY0S8c97sBKF9/cTM10o2Ud4OCtBl7qq5whVaQUUT4gGK3WFV6u0qF+nobHIN
 b3gzjT7rloYOritTIE5jeF8Fsf4n60cQsdPcVMQcPx+dHUXHUgegBOi6xFy6rdc2Z0Kg
 +EogAWqqHN6w95tqOnSa3Xx5yHQshRN1pdaLlRp6XlDyHGeJ5ZdwzwNR0NzsYi8bmYIO
 CpVAA1jYGxaNRoGKquX8vFe1CtLhWUNyaDs7TNFoYJe7zscQLOMhNDCac/exKjFVsvxx
 12Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694615248; x=1695220048;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XfxJEEgBf2tsDTx23xuJtSfn6KoYgOv3m+bMHJpxUwE=;
 b=wijQuzRj2MxY7mvb+TmyykVt46MQUdIlygIhLulhNciFnfKbKSKmZJSu6zCXaLqYqi
 grl+6OZscp/HbuMNTCZwmzrGnwpH1wsqPyMdlpJpTDSzCpK+CQmd4TA+RQyQglzqhTOj
 HtEXBO3i6Lv9ZOLiRQumU2EHIMEXCFxevtn9OE3hI1mCTM5r23T5X+b0EfZEJd5r+o5/
 fnwpp8NRFK/0EklnfG3tnzZz5dc7TAauukueXsPUKT3lfrWYDDqTCQHx6NkHKMxLENWL
 IwAsIulcRfZeG8IWFH8hgF6ujByu2L3SeQLPqkHSVLwdudgVhZO+EqqegmvT4vT4lC6Y
 C2Ug==
X-Gm-Message-State: AOJu0YwCUXNqTalwBQGiZ50TFbQctRZfVPDAHpNHEQeM6LdMeABhHgmm
 oBRb+QYVFWcp7wbObXUw+1WDa0CV7Yi87ZKsamY=
X-Google-Smtp-Source: AGHT+IFBtWMweoLGb5Kr8n92XVJ1FSVqkhDNKHlq6qr6J8KEeDThOfoslZMIswUaLQPbpfRuNucZbsrtS3Ei6J5J3Fw=
X-Received: by 2002:a05:6808:14c7:b0:3a7:4b9a:43ca with SMTP id
 f7-20020a05680814c700b003a74b9a43camr3428253oiw.53.1694615247949; Wed, 13 Sep
 2023 07:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <70f869ab-3e87-92c4-3df3-6aa5a0e9e1f0@tls.msk.ru>
In-Reply-To: <70f869ab-3e87-92c4-3df3-6aa5a0e9e1f0@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 13 Sep 2023 10:27:15 -0400
Message-ID: <CAJSP0QWT9FsGaiTXnionp8FhADxtn1haQ-e1id933HwEcTvgPA@mail.gmail.com>
Subject: Re: Various changes "backportability"
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x232.google.com
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

On Wed, 13 Sept 2023 at 04:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> [Added some more active patch reviewers to Cc]
>
> Hi!
>
> Yesterday I wrote email about picking up changes from master
> for previous stable release(s).  What's interesting is that
> yesterday, basically in a single day, we've faced numerous
> examples of subsystem changes which makes such backporting
> significantly more difficult than might be.
>
> For example, recent tpm bugfix, which is trivial by its own,
> uses RETRY_ON_EINTR helper which were introduced recently and
> which is now used everywhere.  coroutine_fn et al markers is
> another example, translator_io_start is yet another, and so
> on and so on.
>
> When adding such subsystems/helpers which are to be used widely,
> please split the initial implementation patch out of a single
> "introduce foo; convert everything to use it" change.  Instead,
> add the feature in a small patch first, and convert all users
> tree-wide to it in a second, subsequent patch, maybe removing
> the old version in that second patch too.  Where it makes sense
> ofcourse, - sometimes it is not possible or just complicated to
> do that, like when old and new implementations can't be supported
> in parallel.
>
> Just by splitting "introduce" from "convert", especially for
> something simple which will be used all around, you'll greatly
> simplify stable trees maintenance.

The general concept makes sense to me but I'm not sure what the
specific issue with adding (?) coroutine_fn was. Can you link to the
patch that caused difficulties so I can review it?

Thanks,
Stefan

