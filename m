Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E73647E063F
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 17:19:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qywri-0001eY-TI; Fri, 03 Nov 2023 12:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qywrg-0001eN-OR
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:17:44 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qywrf-0000DM-5T
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 12:17:44 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5440f25dcc7so1800131a12.0
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 09:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699028261; x=1699633061; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sZLHBLm+x7vgaiIl/IfmPvgeiz0JOJ/CfI4jqHpK4Ag=;
 b=oWPKHwH+18D6quRP3KWF2LSodhB7fC10yYXXCqmp+FNrIFTkZ+i23cQMLmTmfaPoW1
 pKFgN6604ZxPAXX3cb0P9Vpivhup3medeG5CI/SEfDBTd7HdMkySRjiNlfPO3Y1nUirL
 253eQjUjE7dEnjcjb8BoFnyC42Gjq/g2xnv+ae7Z9LQMwx6Eo5cgJ9qe1DlaHhISeKyj
 q6zteghFbGkarX+KRNn6utwQuHWL5hTFL5Id+VXTuhtl+UDoCSN3aFPQjO8yEdLhHe5J
 K5FaxB4+5988D5tySyj5wiQfctAC1vnpP4xCi7I/cY6PI5nm9NWALNLmVlwidFwi/LAj
 lhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699028261; x=1699633061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sZLHBLm+x7vgaiIl/IfmPvgeiz0JOJ/CfI4jqHpK4Ag=;
 b=neiyxZaAgFGp4jpAyddmJZS0SfrXOfwPh1c+Ii6LMzh/P+6tlXz/Hpa13yNq0WDoqL
 TMO3j1H2kaY4fDX7I+C9uLQwvjAw9xWf6/iHLgMYd8bm03C7SxsyFsuJOJU66y82rpcH
 3DdqlSIf3v0G8kIbB8iSiiz97xmMPJnHzaugYoFLgKeiC9NT10jyDeEtKU4G4607g6Tx
 gNlCVH2mo0WzRY1dh8YFsVKaybxjuXsFFFvxbd2VPPkw1AJyYuEWjHucjAs2evIReqRu
 k56qENvI9d6bunhMvvFcvQWhc0145vINiM48VRVRNbfT+pamKl1aOkMMO8Hco1B1h2xU
 y6RQ==
X-Gm-Message-State: AOJu0YxLVrs4seW+mDfz4juNMIn8TFT8Gokzwo8AbnyO7gPehIUvtEd1
 ygwqvrBq9fQglGaPV7eYIdphp4Fmp8cNMpt226GJxA==
X-Google-Smtp-Source: AGHT+IFeEAhKyhLbNsdbR15P/7/m8eNkkKHdwaXUMWsTqbYXO/K4rvCsG37I5i/fZWJ1ruKz5oL7C7eK5RkMgn7t0Jg=
X-Received: by 2002:a50:cdd2:0:b0:543:abf3:7d9a with SMTP id
 h18-20020a50cdd2000000b00543abf37d9amr6891772edj.38.1699028260760; Fri, 03
 Nov 2023 09:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231025092159.1782638-1-armbru@redhat.com>
 <20231025092159.1782638-2-armbru@redhat.com>
 <CAFn=p-Y58FTVshF_y99bTOXJNRaec=_rGnJGrEtcRBMZbPq2LA@mail.gmail.com>
 <CAFEAcA8KaWXTinOLFitnYuTnqz2yXmgYdyUzE6FVFMvwwbLucA@mail.gmail.com>
 <878r7en7tx.fsf@pond.sub.org>
In-Reply-To: <878r7en7tx.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2023 16:17:27 +0000
Message-ID: <CAFEAcA9fDx6DjbFBVPRoObR2QGdkVrBh9mm_n=0axkuST2pGiA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sphinx/qapidoc: Tidy up pylint warning
 raise-missing-from
To: Markus Armbruster <armbru@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 3 Nov 2023 at 16:02, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Fri, 3 Nov 2023 at 03:08, John Snow <jsnow@redhat.com> wrote:
> >>
> >> On Wed, Oct 25, 2023 at 6:10=E2=80=AFAM Markus Armbruster <armbru@redh=
at.com> wrote:
> >> >
> >> > Pylint advises:
> >> >
> >> >     docs/sphinx/qapidoc.py:518:12: W0707: Consider explicitly re-rai=
sing using 'raise ExtensionError(str(err)) from err' (raise-missing-from)
> >> >
> >> > From its manual:
> >> >
> >> >     Python's exception chaining shows the traceback of the current
> >> >     exception, but also of the original exception.  When you raise a
> >> >     new exception after another exception was caught it's likely tha=
t
> >> >     the second exception is a friendly re-wrapping of the first
> >> >     exception.  In such cases `raise from` provides a better link
> >> >     between the two tracebacks in the final error.
> >> >
> >> > Makes sense, so do it.
> >> >
> >> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >>
> >> In this case it probably doesn't make a difference because Sphinx has
> >> its own formatting for displaying the errors, but it's good hygiene.
> >>
> >> Reviewed-by: John Snow <jsnow@redhat.com>
> >
> > Has somebody checked that the error Sphinx shows to the user
> > is still the friendly one? The only reason to raise
> > this error is so that Sphinx will catch it and display
> > the friendly string, so anything about tracebacks is a red
> > herring -- if the traceback is shown to the user then we got
> > something wrong.
>
> The exception type doesn't change, only the backtrace stored within the
> exception.  Can't see how its catching could be affected.
>
> To be sure, stick a '} at the beginning of qapi-schema.json and run
> sphinx-build.  Result:
>
>     Extension error:
>     /work/armbru/qemu/docs/../qapi/qapi-schema.json:1:1: expected '{', '[=
', string, or boolean
>
> Satisfied?

Yep, looks good, thanks. (That is, this change is purely
to shut up pylint, and it doesn't have any bad side effects.)

-- PMM

