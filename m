Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 936087C5ED3
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqgHf-0005YW-Bh; Wed, 11 Oct 2023 16:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqgHb-0005YH-FQ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:58:19 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqgHZ-0008Si-E4
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:58:18 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57e4459aa29so124329eaf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697057896; x=1697662696; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NzUni2jjo7opdgSToRDZV4wea2SDovXWQEQPQLzntNk=;
 b=S/HiWcHWsXAZ7jqgIIMSgdLNFSxvXBN6QMVsVXAO+vvxKFY8XuPNW/0qAMnyE58hZR
 CQuib/jjzwAfmuKNWmavtR4APuk39KGir3hgD1Ky0pVBJrdg7AduNkzBOnLPUBoZLvMw
 PEDS1A0AvVIIisfMzFQhfATaWTYlTT3UJvEReYaoy5stYw/d5ANKXLNMaQscYod0OLTi
 woSsoOCldOCEh7lpX6pANaEgSKR7qT1pCQ6DigkEnZb2mWp9YjENUQGsbBBXP9if5kGC
 3s52av8cI1CScE6w0yyZO8MdnSV/dkLejOeajaF1HfDSNvVJKUNy2VvgZ7tRjh2Bir4E
 GUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697057896; x=1697662696;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NzUni2jjo7opdgSToRDZV4wea2SDovXWQEQPQLzntNk=;
 b=ap0P51k0BlJHw8NMjKhVPreV9R3dbTP2zJaoidChOOjiPJd0fHhJM+Ng1C1mAkJ7ZU
 hG70sk0PORw1A6vfM/IX5q5F6BWAPN26BC5PXuHWyJyrlezGbzZ+oB7/3nsT8jlHJ61J
 e+JMquNR+JRogpOb8Po+W1JSr+NLoC5l6twoqGqVN+3Cpw4lEKkgpNMgu23VHMhUwS+R
 OrWVU6xlTigVUogXxGI5JpRchDuyr0NiTX3uYkBZLsF2rt/Ghkcp4Nihiu8fpUttVnDV
 zI1Svts47zpi3KJRG6ZOYemoFfmckxtXzSAEIbro6vBEV4gwDVwpaB+AxEIg9Gu4h4ar
 tovQ==
X-Gm-Message-State: AOJu0YxMXSI3hl19Ye0eDhwMre08V6wsYu59d7B2xrnhb45lpGIZFJ7w
 gViaX4c8LtlAyZzaDtASiSf5RW6IT/qeDf64MbY=
X-Google-Smtp-Source: AGHT+IEzcw0E9nr5aIJ4hsHFGAooB2Byqv4yebxMfkkF8FLBI0mB9pqMind6vLf4yH2X6B5+ubz9KU3dE1Aky0ynxSU=
X-Received: by 2002:a4a:d858:0:b0:576:b301:a9b1 with SMTP id
 g24-20020a4ad858000000b00576b301a9b1mr11915596oov.0.1697057896075; Wed, 11
 Oct 2023 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130004.500601-1-pbonzini@redhat.com>
 <20230907130004.500601-51-pbonzini@redhat.com>
 <14ff27a8-284b-66f8-097a-5d49c94dcff8@linaro.org>
 <ZSZhCcnn2C37uZWH@redhat.com>
In-Reply-To: <ZSZhCcnn2C37uZWH@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Oct 2023 16:58:01 -0400
Message-ID: <CAJSP0QWZM9DuYOOzEP1hj5pF1e0T1bf8B__c79r+V7XSBWYuxw@mail.gmail.com>
Subject: Re: [PULL 50/51] subprojects: add wrap file for libblkio
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org, Tyler Fanelli <tfanelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

On Wed, 11 Oct 2023 at 04:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Oct 11, 2023 at 07:35:24AM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi Paolo,
> >
> > On 7/9/23 14:59, Paolo Bonzini wrote:
> > > This allows building libblkio at the same time as QEMU, if QEMU is
> > > configured with --enable-blkio --enable-download.
> > >
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > > ---
> > >   subprojects/libblkio.wrap | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >   create mode 100644 subprojects/libblkio.wrap
> > >
> > > diff --git a/subprojects/libblkio.wrap b/subprojects/libblkio.wrap
> > > new file mode 100644
> > > index 00000000000..f77af72210c
> > > --- /dev/null
> > > +++ b/subprojects/libblkio.wrap
> > > @@ -0,0 +1,6 @@
> > > +[wrap-git]
> > > +url =3D https://gitlab.com/libblkio/libblkio
> >
> > Tyler noticed this project isn't mirrored on QEMU gitlab namespace.
>
> Many other wraps aren't mirrored either, and I'm not convinced we
> need to, unless the project is on an obscure self hosted git service
> which is thought unreliable.

What if upstream deletes the repository or sets visibility to
"private"? Do GitHub and GitLab guarantee availability of previously
public repositories?

Stefan

