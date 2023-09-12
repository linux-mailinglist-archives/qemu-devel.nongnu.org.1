Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 487F879D949
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 21:02:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8cp-0004d9-Gb; Tue, 12 Sep 2023 15:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg8cc-0004cM-Mi; Tue, 12 Sep 2023 15:00:28 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg8cU-0001at-9i; Tue, 12 Sep 2023 15:00:20 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-573ac2fa37aso3623295eaf.3; 
 Tue, 12 Sep 2023 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694545216; x=1695150016; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=piu0eHKYmcAc4W9uppF+EeQSMzIi9xiD6eKhcA2ryU0=;
 b=AijSRNt2J7kYD+JDq7tw6L89UmyxLO3L/MrQQzuzcwflUbx/1d1sgE59X0vUQxT538
 Yaulz+cd4sxUE2gQn6ktrhPVV8H0gIVx5Aw/Kq/5fbJ3aJ3fWwDjDCqSarG/KHWlqKcU
 Q4NEOaJJastqrKLvaA9dE+Hiy78B/XP/7gMf54QAATyWQj/YPTqmG6YHoveAhl8Jql3A
 m+Rn8Z228Mw20g+xMJ5qf9mmoA4edRnLTF8bojGYl7c1Wy+pn0tRcDgH4hvEJH7BBHRC
 j+H8J1lov26ZgIJ6EN/yg+LTHn/coxUzcGeoGitIGk2RhIR0HiCBE9/etct3oB+y3wRL
 +Igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694545216; x=1695150016;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=piu0eHKYmcAc4W9uppF+EeQSMzIi9xiD6eKhcA2ryU0=;
 b=p8oWTmZoPl90S2283jZkIA1PP3UJtaacMUhSjbV+7dJKnP0wH75SQlraw0imBfXiRE
 u4JzECGNJj0mNN0zwf9mG5TWxxZwdmOSMQpluHcetUZY5hlldOispkRLMLB5VsfvJYzv
 5SrQ3yxeobTgj4OMH+63xLd+UZZwVToksqcqMH/wK1BAJkcX6e9Tq690tcTpNUPqP1jl
 CM9kJFpxNLErRWsItLR1+1YRJKFQmOgO1/YBYJlNm4GoE3vD6FbJTJhFfL3ha0Tpcrpv
 wmNgQLkXHj8yNm1zgtgpDZ3wr6XyNzfdNbMhYDuvxiYAhis+vMcIGu/qifGG+7RB/W4C
 nG8Q==
X-Gm-Message-State: AOJu0YwhWu0F/vKcU02T9nytMS3TFU5zyvUoU/wYaY+UIrPZjf+CqEFZ
 j6zNHIuefTbHs5cODxhghWsN6cVSaZOL33LTu4w=
X-Google-Smtp-Source: AGHT+IHV93FpCnhqVsit2bwizRL6P5PzDuK2CadshF9ddMo+or4565E1M0joWr2fG669upfbvHKfrjYxDystHhJ8X/s=
X-Received: by 2002:a4a:7452:0:b0:570:c8fa:4ad7 with SMTP id
 t18-20020a4a7452000000b00570c8fa4ad7mr508407ooe.1.1694545216659; Tue, 12 Sep
 2023 12:00:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230912184130.3056054-1-berrange@redhat.com>
In-Reply-To: <20230912184130.3056054-1-berrange@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 15:00:04 -0400
Message-ID: <CAJSP0QW_Oa2w-WdSeSkHnd6kFN6OxAkPr03_UO_rDWDhpT7Wxg@mail.gmail.com>
Subject: Re: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
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

On Tue, 12 Sept 2023 at 14:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> This addresses
>
>   https://gitlab.com/qemu-project/qemu/-/issues/1882
>
> Which turned out to be a genuine flaw which we missed during merge
> as the patch hitting master co-incided with the FreeBSD CI job
> having an temporary outage due to changed release image version.
>
> Daniel P. Berrang=C3=A9 (4):
>   microbit: add missing qtest_quit() call
>   qtest: kill orphaned qtest QEMU processes on FreeBSD
>   gitlab: make Cirrus CI timeout explicit
>   gitlab: make Cirrus CI jobs gating
>
>  .gitlab-ci.d/cirrus.yml       | 4 +++-
>  .gitlab-ci.d/cirrus/build.yml | 2 ++
>  tests/qtest/libqtest.c        | 7 +++++++
>  tests/qtest/microbit-test.c   | 2 ++
>  4 files changed, 14 insertions(+), 1 deletion(-)

Thank you!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

