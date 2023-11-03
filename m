Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DD57E0193
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 11:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyrT4-00077Z-6A; Fri, 03 Nov 2023 06:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyrSo-00076P-J9
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:31:42 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyrSn-0007DE-4k
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 06:31:42 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso3030951a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 03:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699007499; x=1699612299; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eys/IWnb3DxbpIl3NRnotg/vXnqsWHId75uMKpeHbIc=;
 b=n6MCnmziOdZS4mta7d9Y7EnfaCrJPDWlgsymmwxGLCA1vUiek/2FBWD0cxFQSVOp6d
 DceRE72sRyvmQFyN8adj/ohILYl8PJOez/rQ2UEsNiQ2F8AQGx4jvDitNd92eXgY/TwJ
 2W+WoNBkgHAIBVHK+FJkD31WN0zoSd14cVPuym8rkY09TrfCTXZEJykldKRTisSQwz6Y
 XSf8rH6QKOebg+dd6Ork0yvokD/apmJ4CW3MlBkCc5VEV86vrDX/A4klcO28GrM8eX1l
 ym6qt9785Hlv8S3LnoDP8Oz3zhIVvDIiLAgW/kTzBgoqGo8ufaWOVMRBWzh62nI0LMcw
 IxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699007499; x=1699612299;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eys/IWnb3DxbpIl3NRnotg/vXnqsWHId75uMKpeHbIc=;
 b=BZMu4OKkjCFTV09BY/716AN1AsB9SKBasPkQptWYOQHkFzRbfypUvah4rOYL9B7Kbl
 sLkanNQQ4lLAGRCS8CL8zrWwfeK/ZfG6/SeNuY7Of2XcojfxdenSA20skYF79vDprTZG
 ek4OIfy/QDfMmXA/nkpH4DylzuCGyZTbxo11b5TJ+5uIit7zM7kBISG0NFmSIWhfTUd5
 y4yOGkwqeyhk7FDLvb5jElqkCyYUw13NV1UnhuUiFICOfkjTjVlpuf3Il9czG5wPnh3G
 E1q5ohkxskxBM1/z9TbvTEr84TEQeVvOxrSEUqwegQHRXzIElH9GciX6dZKRqCA3Rlap
 9+Vg==
X-Gm-Message-State: AOJu0Yyc+Lp1wEJRpgdNblwepgsSjGZvqeEzGWTkLJmiKi5VUgBX6J/5
 c6PXlJQkgeHRYFGG13n9hOLB/IgwUtX5/ZHH3bS3cMAu3+xVPNJZ
X-Google-Smtp-Source: AGHT+IFLRptqH3jBSKnV0mkNkD2mwuNQU3tLYJhu7GabuIWFdOwZw9YjAynfoZ6jf9CH4hrQmVYxrYYfEIOBLfY3hjY=
X-Received: by 2002:aa7:c550:0:b0:53e:5957:aa4e with SMTP id
 s16-20020aa7c550000000b0053e5957aa4emr18445076edr.20.1699007499212; Fri, 03
 Nov 2023 03:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231025092159.1782638-1-armbru@redhat.com>
 <20231025092159.1782638-2-armbru@redhat.com>
 <CAFn=p-Y58FTVshF_y99bTOXJNRaec=_rGnJGrEtcRBMZbPq2LA@mail.gmail.com>
In-Reply-To: <CAFn=p-Y58FTVshF_y99bTOXJNRaec=_rGnJGrEtcRBMZbPq2LA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 10:31:27 +0000
Message-ID: <CAFEAcA8KaWXTinOLFitnYuTnqz2yXmgYdyUzE6FVFMvwwbLucA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sphinx/qapidoc: Tidy up pylint warning
 raise-missing-from
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 3 Nov 2023 at 03:08, John Snow <jsnow@redhat.com> wrote:
>
> On Wed, Oct 25, 2023 at 6:10=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
> >
> > Pylint advises:
> >
> >     docs/sphinx/qapidoc.py:518:12: W0707: Consider explicitly re-raisin=
g using 'raise ExtensionError(str(err)) from err' (raise-missing-from)
> >
> > From its manual:
> >
> >     Python's exception chaining shows the traceback of the current
> >     exception, but also of the original exception.  When you raise a
> >     new exception after another exception was caught it's likely that
> >     the second exception is a friendly re-wrapping of the first
> >     exception.  In such cases `raise from` provides a better link
> >     between the two tracebacks in the final error.
> >
> > Makes sense, so do it.
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> In this case it probably doesn't make a difference because Sphinx has
> its own formatting for displaying the errors, but it's good hygiene.
>
> Reviewed-by: John Snow <jsnow@redhat.com>

Has somebody checked that the error Sphinx shows to the user
is still the friendly one? The only reason to raise
this error is so that Sphinx will catch it and display
the friendly string, so anything about tracebacks is a red
herring -- if the traceback is shown to the user then we got
something wrong.

thanks
-- PMM

