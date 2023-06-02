Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 084EB72089F
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:53:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58xA-0002bu-Ge; Fri, 02 Jun 2023 13:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58x1-0002bQ-3V
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:52:35 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58wz-0000u2-A8
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:52:34 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4f4bdcde899so3158734e87.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685728351; x=1688320351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3OSxnm+w42Y5sZ2HpHySd47GiBNBLBE3GczcKlw1Re4=;
 b=aYAiksxc9EuMske6HoJrkchCocSQq49r/GKlxzA/tG2xS3QcfdIkCXMfdJOiWybCrN
 4Mki20hWw0sRQRukZS80/K/Z2cguNO5Idb0HZsCRcrP8knlepiXZGvrgLNCbU1kW+9iL
 Hqt2UXDRTeO9JyPwOIMsGKBqi0zt4ErTq/d4EO+/QWTI33mjZkdV9kCGkAzyjkcVD7bd
 o5YCCIEeKQr369PqLqsVogHU9anCBDC6h64PwhGIHvu1y9ctbcq93KqJD8HJYmKPiHCO
 zHIpfn4hR0sb2+C5DdoWddrdci65UWK5lCt5en2OoW+Mgo/22ZUlyR/Sq0C0EpXRP3x2
 59WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685728351; x=1688320351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3OSxnm+w42Y5sZ2HpHySd47GiBNBLBE3GczcKlw1Re4=;
 b=U6Rfyy5aFnrzuB2NoLFb1fKO9IzqkIUVXyOUlY79u0GEnCkc8ltMbjAPyMk5ievpX3
 fJtxRVQrId0LSM5QHTIdRzZNopdBsT4yL8as5knycBn8sFbA7lQfvQs7J0mOUl54Next
 kwvnXrOH9xLpQrEUONm72T0q1vinLlSyjPQWNp/OluuH+v1MBe618rs03/Zq7aLIWZ+/
 HGAJ3pd6f5lAVamiBThKpWu7GDlNjdf0DLH70qLoQXfl0dUCCSp5KOCYnRoRJjlOucCC
 vZNh/uU37WGTVlAy8FcHdaeiRquRxl/4rVM10Ddq2e4+5rl1TuuV1p5XVN3o1TxvrSrl
 9YYQ==
X-Gm-Message-State: AC+VfDztTLug1UVwSSTf3Pm1NlFJWlY2AREvxQ4PrvPlUXPdN+oT2RmK
 w5x4wVcD1pWeEwMwWtBN//wdcmMxXAUpGALYHR+XLQ==
X-Google-Smtp-Source: ACHHUZ5o7h6LZe+WXHjHecauVfInmAbW9xNSJO1XhpJVCw5PNE/wbhslphPTuqmMI7RuodyNYgIsTnpYg/ggTpV0c+4=
X-Received: by 2002:ac2:548e:0:b0:4f4:b0d0:63fb with SMTP id
 t14-20020ac2548e000000b004f4b0d063fbmr2232358lfk.35.1685728351241; Fri, 02
 Jun 2023 10:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230515160506.1776883-1-stefanha@redhat.com>
 <20230515160506.1776883-11-stefanha@redhat.com>
 <CAFEAcA9bDh12FSk8CjEkBZjQOEBVd6-=fVwnM9bx8aoXvQdMuw@mail.gmail.com>
 <CAAAx-8L4Z3tBzV5DMEy0WnG=3y67bp_1g-+2kUhrY+rp2knNKA@mail.gmail.com>
 <CAFEAcA-WMkcreH7csiNyMBXCsS5XhcPK0vdRKiL70M_r18oYYg@mail.gmail.com>
 <CAAAx-8LY9NX8veVhin=ThpqbpgP82GV4X9sXMzD9D0r2BqANxw@mail.gmail.com>
In-Reply-To: <CAAAx-8LY9NX8veVhin=ThpqbpgP82GV4X9sXMzD9D0r2BqANxw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 18:52:20 +0100
Message-ID: <CAFEAcA-2-70rwHCxcQvpE-tZRn4qytBSx4b31ZtFhZ97ZpHZNg@mail.gmail.com>
Subject: Re: [PULL v2 10/16] block: introduce zone append write for zoned
 devices
To: Sam Li <faithilikerun@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_PH_BODY_ACCOUNTS_PRE=0.001,
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

On Fri, 2 Jun 2023 at 18:35, Sam Li <faithilikerun@gmail.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> =E4=BA=8E2023=E5=B9=B46=E6=9C=88=
3=E6=97=A5=E5=91=A8=E5=85=AD 01:30=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Fri, 2 Jun 2023 at 18:23, Sam Li <faithilikerun@gmail.com> wrote:
> > > Thanks for spotting this. You are right that bs->wps is not checked i=
n
> > > this code path. I think the get_zones_wp() should handle a NULL
> > > bs->wps which is the function calling wps directly.
> > >
> > > Would you like to submit a patch for this? Or I can do it if you are
> > > not available.
> >
> > I don't know anything about this code, so I'm not really in
> > a position to write a patch. I'm just passing on the information
> > from the Coverity scanner -- it scales a lot better that way
> > than trying to write fixes for everything myself :-)
>
> I see. I'll fix it. Wish I had known more about this tool when I was
> testing this code.

Coverity is a bit awkward because the free online scanner only
runs on code that's already been committed to QEMU, so it doesn't
tell us about issues until we've already gone through the
whole code-review-test cycle. Plus it often complains about
things that aren't bugs, so you have to be a bit cautious
about interpreting its reports. But it's still a nice tool
to have.

The online UI is at https://scan.coverity.com/projects/qemu
and you can create an account and apply for permission to look
at the recorded defects if you like.

thanks
-- PMM

