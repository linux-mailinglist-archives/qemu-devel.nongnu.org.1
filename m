Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6C57F6602
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 19:12:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6EA4-0007Qh-3F; Thu, 23 Nov 2023 13:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r6EA2-0007QW-2Q
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:10:46 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r6EA0-0007WK-Et
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 13:10:45 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso1649583a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700763043; x=1701367843; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ya8oe24fMHKrP3IngNSuMZIDTQZtqVBsygu4ZD751YA=;
 b=KyRU/voc8+cLgjf8ov85inE2OiFyWE1Fz+0ZvgWZxWsXmnixZuSP0TPZMkHeN58juk
 jeuS4So7w1UzCbugHrXQURHvcNM17POAyxvs0AP+s088tF4oLXQ5CNYM3W5ShBcN2CFd
 ii6fTXWRlQ748wRJRY9Z7mESNtlRaHTejIMUHdI6S+cSTggaVINX4jXD6IFFhKQtkx2k
 qD7E32UWIwsoY6nCHRN+Ccc5KyOfquHGlXXmjSxIX6xfL2+2xmC0KgssVvxmuiQdlCF6
 utznwcJBKvsOG+Uyt8VuY38NAzI/24PaMYWBtT+jc+S5cM8pq38T3XTch0cb1ai+Vfrz
 DbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700763043; x=1701367843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ya8oe24fMHKrP3IngNSuMZIDTQZtqVBsygu4ZD751YA=;
 b=esPhNmHHeRS0hibyczrXW4WIna8owHmw4fDRwe+EQ7+ok3u8Hw0wNfrlAaOUcxMLQ4
 PRZ6tMAGf9HciggcNRVPDwsxomvvdTz78TXEOwwMTITieRZbBj1eG7zUq6kAuOjCg43V
 mPKoF8N/VDTwzVvYkD9TzyF0Mu5ec7+8xwk8Xz1LSAE59APC3yZSZhhm5AmBb88OF1z5
 wy7zGzSXtFlevsEi9QSO8c73cSlAb/kiaAy/swIcHe+jzQQl3SnK1Imp06qzbSY+K9D5
 D2VX09YvOUejMi3qmsH3iegSOeFzYO2zjHO0jl7PS0MNA5f5zTdX9g5i1YSsiVRxHOys
 /kbg==
X-Gm-Message-State: AOJu0YzNInDSuYZc2JswUI7niEVnm/6iWrhQjnY7NbBOlyXkCIepFhD5
 pg1SwA7iqhdgq6p9r5gLzzIpIgra1+MeF9oLvm+vJA==
X-Google-Smtp-Source: AGHT+IH4t3IDjvdxIe3J3idIufXc8DaQZ/4QbGXgGW8yNsUYYuhTZEad3oE26g6AEuXpTrxhcLSPcSzcBs7sJgi80lE=
X-Received: by 2002:a50:d55e:0:b0:53d:b839:2045 with SMTP id
 f30-20020a50d55e000000b0053db8392045mr24585edj.25.1700763042837; Thu, 23 Nov
 2023 10:10:42 -0800 (PST)
MIME-Version: 1.0
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <20231123092523-mutt-send-email-mst@kernel.org>
 <4l0it.9kkxe9s135lg@linaro.org> <ZV-TsSJOVyhR5_ev@redhat.com>
In-Reply-To: <ZV-TsSJOVyhR5_ev@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2023 18:10:31 +0000
Message-ID: <CAFEAcA9bjKCVGp7_Ar_Q3unsrzNXBJzaCocJUCK6adb3byrdTQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM code
 generators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9_e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Phil_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 23 Nov 2023 at 18:02, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Nov 23, 2023 at 04:56:28PM +0200, Manos Pitsidianakis wrote:
> > On Thu, 23 Nov 2023 16:35, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Nov 23, 2023 at 11:40:26AM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > +Examples of tools impacted by this policy includes both GitHub CoP=
ilot,
> > > > +and ChatGPT, amongst many others which are less well known.
> > >
> > >
> > > So you called out these two by name, fine, but given "AI" is in scare
> > > quotes I don't really know what is or is not allowed and I don't know
> > > how will contributors know.  Is the "AI" that one must not use
> > > necessarily an LLM?  And how do you define LLM even? Wikipedia says
> > > "general-purpose language understanding and generation".
> > >
> > >
> > > All this seems vague to me.
> > >
> > >
> > > However, can't we define a simpler more specific policy?
> > > For example, isn't it true that *any* automatically generated code
> > > can only be included if the scripts producing said code
> > > are also included or otherwise available under GPLv2?
> >
> > The following definition makes sense to me:
> >
> > - Automated codegen tool must be idempotent.
> > - Automated codegen tool must not use statistical modelling.
>
> As a casual reader, I would find this somewhat unclear to interpet
> and relate to.

It's also not really relevant to what we're trying to rule out.
A non-idempotent codegen tool is fine, if the code it generates
is clearly under a license that's compatible with QEMU's.
A codegen tool that uses statistical modelling is also fine,
if (for example) it's only doing statistical modelling of the
data in the single file it's adding code to and doesn't use
any external data set.

> > I'd remove all AI or LLM references. These are non-specific, colloquial=
 and
> > in the case of `AI`, non-technical. This policy should apply the same t=
o a
> > Markov chain code generator.
>
> The fact that they are colloaquial is, IMHO, a good thing is it makes
> the policy relatable to the casual reader who hears the terms "AI" and
> "LLM" in technical press articles/blogs/etc all over the place.

Yes, I think that the most important thing about the wording
of this policy (assuming we agree on it) is that it should be
immediately very clear to anybody reading it that ChatGPT,
Copilot, etc type tools aren't permitted. Because in practice
the most likely case is somebody who wants to use those, and we
don't want to make them have to go through "read an abstract
definition of what isn't permitted and apply that abstract
definition to the concrete tool they're using".

thanks
-- PMM

