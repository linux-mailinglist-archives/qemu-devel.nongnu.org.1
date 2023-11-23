Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 395937F58A5
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 07:53:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r63Zg-0001NZ-BU; Thu, 23 Nov 2023 01:52:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r63Ze-0001NF-Pd; Thu, 23 Nov 2023 01:52:30 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r63Zd-0006eE-CR; Thu, 23 Nov 2023 01:52:30 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7789a4c01ddso29521385a.1; 
 Wed, 22 Nov 2023 22:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700722348; x=1701327148; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n11Gw2PV1xfk82dZAgPgMAItmU7yeMZLbZO/aP8npEs=;
 b=D/VYog/XhaxHwSjswwFa3k/UxW5rjsdaUX8yyU56sjLDwLavbcvk6T/X4S6rtcmQZV
 rb9xzfCgL0M33GCDLTvzgQUB90PNzKmSXZBRGQAiX9E3pX/i66VCSr38KxIm6TFAjjrg
 pcLFmeR7BG9F/GziPgnBuFPETj4CazkqcPZQICy4LRW6qx2O1zigvd4GTKJMsq9W5Z1C
 vjELhYGik6VlFzh/X7h3ncp6VjwL5EFlF2Gyy7h1u3tmqihseyTbcCkp44To7v7xhKRZ
 OKnLtb/E0skAk0yXMpk9AVWZ6fDpOEGuqjU7MkuF6e8IpSkyt6vNetBuGxAUqwVZdFhy
 rqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700722348; x=1701327148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n11Gw2PV1xfk82dZAgPgMAItmU7yeMZLbZO/aP8npEs=;
 b=SV1kaBnWWCyt0Hsowtx9DKdARadxJ8x5RcW76qCNBFa9JHWUGGRrV3TvRbx9IWteCb
 moza6/fKNnwEeGJtu+EVR3qPRZyTAbv0d7l2tbvV3+dSzsmo9wil+dNwcQTyjl5a9FRH
 oDlaW5iEmoK42ZMXp4+4FEeJkQLBxdjww8JFtzIzaptwMIS//KO79WV7xwqd0c4MT2Xs
 dS0jtuNiuhuy+3wlLHZxad9CBHP1Fdu1uCr2o7zqWrKQwmboIDjqvyegOlf0HAUCYUXf
 piLQKiwMucx0LIroIDFt0hlCQb1QljmTTbX0cxEj7YuMRwEwWTT6fsDLviemen/RNfi8
 kyiw==
X-Gm-Message-State: AOJu0YxoVLOjgEQ6BkVZ6AuWpP4LnwK1RjzAna080E7nCR2/JCG/TM1l
 h/d8Rqw7KZXKteF8fs3uMZQzi1tlb/tl+r8NCoI=
X-Google-Smtp-Source: AGHT+IG9a+zlavDBPHC+RQRTMNawZ6nf8Lx0ci692bxUCLvEbiekysiuCxXGuoaxx0sSOd2SBVpBpcp8drenURr/Uaw=
X-Received: by 2002:ae9:c218:0:b0:777:27f9:7e54 with SMTP id
 j24-20020ae9c218000000b0077727f97e54mr4082230qkg.50.1700722347852; Wed, 22
 Nov 2023 22:52:27 -0800 (PST)
MIME-Version: 1.0
References: <20231122125826.228189-1-f.ebner@proxmox.com>
 <CAJ+F1CLFAuKF7CgbiBYnKv+7sjkXfJ9tURNuMNGu9NLru059nQ@mail.gmail.com>
 <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
In-Reply-To: <b5419999-625f-45a3-9a61-b6cb8356cdbe@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 23 Nov 2023 10:52:16 +0400
Message-ID: <CAJ+F1C+CV-PbMAhw9V+OzDHnFiSyFW8+kFBZZ-n_7usoNP_S5w@mail.gmail.com>
Subject: Re: [PATCH for-8.2] ui/vnc-clipboard: fix inflate_buffer
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, kraxel@redhat.com, 
 mcascell@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Nov 22, 2023 at 5:25=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 22.11.23 um 14:06 schrieb Marc-Andr=C3=A9 Lureau:
> > Hi
> >
> > On Wed, Nov 22, 2023 at 5:00=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> Commit d921fea338 ("ui/vnc-clipboard: fix infinite loop in
> >> inflate_buffer (CVE-2023-3255)") removed this hunk, but it is still
> >> required, because it can happen that stream.avail_in becomes zero
> >> before coming across a return value of Z_STREAM_END in the loop.
> >
> > Isn't this an error from the client side then?
> >
>
> In my test just now I get Z_BUF_ERROR twice and after the second one,
> stream.avail_in is zero. Maybe if you'd call inflate() again, you'd get
> Z_STREAM_END, but no such call is made, because we exit the loop.

It should exit the loop after calling inflate() again though.

Or do you mean that it goes to Z_BUF_ERROR a second time with
stream.avail_in =3D=3D 0, thus exit the loop quickly after ?

That could mean that the input buffer is not complete.

"Note that Z_BUF_ERROR is not fatal, and inflate() can be called again
with more input..."

Something is fishy.. Is it easy to reproduce?

> Would it be better/more correct to ensure that inflate is called again
> in such a scenario?
>
> Best Regards,
> Fiona
>


--=20
Marc-Andr=C3=A9 Lureau

