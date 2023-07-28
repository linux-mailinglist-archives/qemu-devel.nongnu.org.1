Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9625876692B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 11:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPJp5-0004KE-O3; Fri, 28 Jul 2023 05:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPJp2-0004I9-2y
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:31:44 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPJoz-00070P-H8
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 05:31:43 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4fe21e7f3d1so508754e87.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690536699; x=1691141499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NyBEkovnm5CPZLyTe0slOz72n5iKc55o4cTAsnZkFns=;
 b=mMtZnkyTzkYvV7HKXSOb2g+8rd6cbHDEK2d/wRFZ5MMRHrMLp84qumuE9/0bGSrRZ9
 zikNnR26PIv99uf6rC0lT/QRYdGIUuvdZiZUTAzCX1fcYAYs6mssVKHsEtIOSFDJo7/7
 7qGrJ9M2e8aZlcINYQYlNcDxJNCMSlDso4teuiJfbe9CC6J+yFvf3xq9KfGosabceO4Z
 RK4+GHNw0P+VDYXU108rJXhCKr8aJidzy4nuOB+wG92fKTth1MwXn6T5fUiff2lXoSU+
 FiCxOo+/OeaG88TAxM7Cl7FrExf1xfsedFxtBwvpogHZZ2cPFqo9NZBnzy71vXn1pssP
 zQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690536699; x=1691141499;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NyBEkovnm5CPZLyTe0slOz72n5iKc55o4cTAsnZkFns=;
 b=LSrP8KM9rcCGLQhSoe4v17ghs+foQjUqi2Us4MHP5W7mFwEBlO53gAL60AiMZExjCp
 1b1qFRmREAAiuZX3lFy3VA0/bDaMrt1fMHeQVqWKV349+YB/K93BP8GJlU0JQkcZtzM2
 DngSMB2cVSGOVTzArmoZT8niIi4wCp3RSHooGWl88MC0n+90ghdtW1j0CxkL90qvwz4L
 iEnqgoZlj9IiWQMDnhIxGi+8RRCwpeonKauDAZ6mkh72tvKVLmRsrv2ga7hxraJVdfOd
 fBBW4DqCRysTD6ozDXjehMcABFE3vNx75Ix1RR7vonpW19pW0w1Q1CVLzWfwnY37TZRD
 4lbA==
X-Gm-Message-State: ABy/qLZSoGRhXvsm2R1sdGgLleejllOWWngn1qXoT5HBuUG8PyEGBGue
 fvp1zj3cFHKTiKYRuv4dK7b1ouBypCjFRbHbfwAoEA==
X-Google-Smtp-Source: APBJJlGqPlo6ClCuk1BtPap/+oRyq5PZ/Mi1M5ZpWNSQFiVe65t9VgJUUj4OrUSO3jmqxofR6DquNnV5NvbPzM8/wuc=
X-Received: by 2002:a05:6512:3e7:b0:4f8:587e:cbe0 with SMTP id
 n7-20020a05651203e700b004f8587ecbe0mr1171494lfq.52.1690536699051; Fri, 28 Jul
 2023 02:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230726030450.757462-1-chris@laplante.io>
 <20230726030450.757462-4-chris@laplante.io>
 <CAFEAcA_K+Rzt8=0apiyO5tB3EwTRJMo8afKu3wkb2=jAsyLvmg@mail.gmail.com>
 <EEsgXkv-Wn8WPzAg07I02DqCvpurTMkc4Vvb1kwHcAPi7jCW9gCRK7C0psplsefPiOL4ltRhb27ipChaC-nrnwOqNjXOjbtJCH_wwLh2_iA=@laplante.io>
In-Reply-To: <EEsgXkv-Wn8WPzAg07I02DqCvpurTMkc4Vvb1kwHcAPi7jCW9gCRK7C0psplsefPiOL4ltRhb27ipChaC-nrnwOqNjXOjbtJCH_wwLh2_iA=@laplante.io>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 10:31:28 +0100
Message-ID: <CAFEAcA8GgY920QtMgj9EwjbrDey-GfiByOVGfgz-Aw7WABviYg@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] qtest: implement named interception of out-GPIO
To: Chris Laplante <chris@laplante.io>
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Thu, 27 Jul 2023 at 22:32, Chris Laplante <chris@laplante.io> wrote:
>
>
> > (g_strcmp0() can handle the NULL case without having
> > to special case it -- this is how qdev_get_named_gpio_list()
> > finds entries in the ngl list.)
> >
> > Apologies for not noticing that on the first round of review.
>
> No worries - it makes the code much simpler anyway. Should we bother factoring out qtest_install_gpio_out_intercept still? It is only used in one place now, as before.

I'd keep the function, I think, since you've already written
it. It's kind of usefully documenting of the intent.

-- PMM

