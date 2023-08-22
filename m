Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9473F78484D
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 19:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUyo-0000Au-Jf; Tue, 22 Aug 2023 13:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qYUyl-000091-RG
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:15:44 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jupham125@gmail.com>)
 id 1qYUyh-0005Ea-Hx
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 13:15:41 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-99c353a395cso630650666b.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 10:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692724537; x=1693329337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCcFHxGUdVGJQiSiHP74vFw25wdWzrnB87QlfWwzTK0=;
 b=YKFjKIuTG5hKBFZLIxZi5oillpi046XjGpC3plpJTe2FOEHkJDheLlrx5LV8HJKS7i
 GAVfrx3NluPK1gKvlu3oe4e7Bla6OiD7VNbWNX3mB2Sg7Nvj61U57P7c2JTr+3406EDa
 VtlC4vc4+sMjx2tsOqOLlnMWLVrU/6PK3zVjwhxvSMp4RmvIjf2BSkTKejk7mPM+EIOo
 cBWoLn+4Mw8BBD8fuc2tUMhbad3xeR11C3My/QaTJoUd1aNhCaHWqVeLfy+q7ubEQ1Mm
 8y3WVVeXauPbVY3Q35bRxYXB8cZkrTLnRP5m+bEcFtoPc0iXgyfzRIuho1uk4pSV953c
 GAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692724537; x=1693329337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCcFHxGUdVGJQiSiHP74vFw25wdWzrnB87QlfWwzTK0=;
 b=Ku/HK+mD5J3bDU/7YgbayL1m4s1Qsrdx0AKwiI5SbscXO6qBhUTKxC2nLY47h7dKR1
 26cc7BLkEkuiTryViQ/YVpGutV0ObOMSRkP69BIno9vTzq+9xIQYQLhHMwAiZclAqbO9
 sqUEjHy82N5ursWK4LENc0WI33JmcHkpFpGZlCI/mTx/0sB2pSEyvg1pFTDMEiv/YQQP
 Rq6xusfo8kc5ueIFAqtAErIP+i1jSiOOF5bq/yYBgmrPWn8EYexeVv5chO7y8VjG9Kok
 SrVOzNPHzkfQtYlqVACfmUSOvWx5MBhRnKjcMWyvNcDIiKrT7tIuEkeLxrA4KRRMLVeu
 2hBA==
X-Gm-Message-State: AOJu0YzDn2j1uHtZTLOuas58M1ipzrVbLhK0cFgMktqbiJW/9Q3Pi3MH
 QElp1hQkqiDIkScLpNnfRu8yvD+gdWc5MCdGFUbrQs6l
X-Google-Smtp-Source: AGHT+IFcz8EeHrWPeR+UIWZIeSlc+DWQPKAndCHIot6dLxNQX7JjQB4ZUvOjilkuLHFYvgARaHiGvVdV/+iMceeMQ0I=
X-Received: by 2002:a17:906:73da:b0:994:569b:61b8 with SMTP id
 n26-20020a17090673da00b00994569b61b8mr7375705ejl.58.1692724537402; Tue, 22
 Aug 2023 10:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1687278381.git.jupham125@gmail.com>
 <0b4adb4f-7a66-47a9-bb47-7c73a164a327@perard>
In-Reply-To: <0b4adb4f-7a66-47a9-bb47-7c73a164a327@perard>
From: Joel Upham <jupham125@gmail.com>
Date: Tue, 22 Aug 2023 13:15:26 -0400
Message-ID: <CADPhr0ns=_O=jqj72x16YdWgrAbpzJNssyexwYkiUjAavySd-A@mail.gmail.com>
Subject: Re: [PATCH v1 00/23] Q35 support for Xen
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c129800603862418"
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=jupham125@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000c129800603862418
Content-Type: text/plain; charset="UTF-8"

I was doing this for work and at the moment got pulled off to work on some
things for our release. Most of these patches will exist as they are,
except for Xen wanting to handle the PCIe PT code a bit differently. XC-PNG
is also working on getting patches for q35 and I have been sharing my code
with them, so I am hoping progress is moving forward on the Xen side. I
wish I could work on this full time to get everything as it needs to be
soon.

-Joel

On Tue, Aug 22, 2023 at 10:18 AM Anthony PERARD <anthony.perard@citrix.com>
wrote:

> Hi Joel,
>
> We had a design session about Q35 support during Xen Summit, and I think
> the result of it is that some more changes are going to be needed,
> right?
>
> So, is it worth it for me to spend some time on review this patch series
> in its current form, or should I wait until the next revision? And same
> question for the xen toolstack side.
>
> Cheers,
>
> --
> Anthony PERARD
>

--000000000000c129800603862418
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I was doing this for work and at the moment got pulled of=
f to work on some things for our release. Most of these patches will exist =
as they are, except for Xen wanting to handle the PCIe PT code a bit differ=
ently. XC-PNG is also working on getting patches for q35 and I have been sh=
aring my code with them, so I am hoping progress is moving forward on the X=
en side. I wish I could work on this full time to get everything as it need=
s to be soon.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">-Joe=
l</div><div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_=
attr">On Tue, Aug 22, 2023 at 10:18 AM Anthony PERARD &lt;<a href=3D"mailto=
:anthony.perard@citrix.com">anthony.perard@citrix.com</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hi Joel,<br>
<br>
We had a design session about Q35 support during Xen Summit, and I think<br=
>
the result of it is that some more changes are going to be needed,<br>
right?<br>
<br>
So, is it worth it for me to spend some time on review this patch series<br=
>
in its current form, or should I wait until the next revision? And same<br>
question for the xen toolstack side.<br>
<br>
Cheers,<br>
<br>
-- <br>
Anthony PERARD<br>
</blockquote></div></div>

--000000000000c129800603862418--

