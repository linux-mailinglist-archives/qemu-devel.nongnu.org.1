Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F617597AE
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:04:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM7mC-0004Nr-7T; Wed, 19 Jul 2023 10:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qM7m7-0004NG-Ri
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:03:32 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qM7m6-0000ED-4G
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:03:31 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1ba5cda3530so3670416fac.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689775408; x=1690380208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lMBagV75Vmw+DbcEiRde+E1FzeI3jMx+uPXH2x2JoFU=;
 b=B3Xf3vqm7KmKNuPR4CT4Xx4xZFjEK6rslXdJ+1Yjmvx3b7Dj/Dko40W+w73KJc22Zq
 ggjjfF6YjciDu62/EaZMp+ZYLQKEhZvgLJp9XlpsXiyBOLShDawM6iajdngwEiJ1DHAs
 6nw0z8+9EM+NxKZgamgcEWSbq6TMYMJJDR226e//Pb5Iiy+fG9RLfWafLjp5471v7kVg
 pA+56YeravM/QQ2nQ6Mv0nX5LVygqCFn5IkasI+/110f6GG3dk+qLD6gXxZ5WaVSGaLS
 M7dn97rmIznCVesQcYuqyW24nExK1KRcmDSvnC+gpl/1tz81+McjIsMbOGHY9IfX+1Ha
 fjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689775408; x=1690380208;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lMBagV75Vmw+DbcEiRde+E1FzeI3jMx+uPXH2x2JoFU=;
 b=TrMqwPd0KN5Br3V1iWekW5nK3BKegHfgtTNU10vqUjEIMhzWrHE9++DMfiS5zAi4fd
 tV+n9luFev0Ahlp6QAmX71Y0/0DU6c4JP8BMMFBA2Id4Qo7W4k7MsHo1rXKIcODofs3a
 L4wEAnmK1uvDlTRy8ooCXgnxlPGtiqO9gaLHjjBMWem8huQFsLrnHX/mCEG6FWjiIomZ
 dpsL0fAmKj6MUD7lvSozicBx2OIM1RZqOsM+I09w3rX5WwPiClRUmQ5HjQenhpTVDN90
 u96f/5joHELJy+c7MYpYgFH0AFlgj6ivUdFBOECG5rlEqEtPZCGPigng3kblsTggGKBL
 +tig==
X-Gm-Message-State: ABy/qLbsB1fbWJSX1E+OyNxi5PPYhuES0V8iV4PwpnNIoAC/+4cRGPqE
 lo7/Y+FzwatOXJRyyNrneuf4101BgPuZ4vEF158=
X-Google-Smtp-Source: APBJJlEj4JyjUpV541WSEFi72aeQNK5Im9L5g+Y7ZbWrNjYxKWAPSzr5Sz69Bm5ge9SSsPecjlRti16A4B97CFtGVQY=
X-Received: by 2002:a05:6870:b694:b0:19e:b8e0:1434 with SMTP id
 cy20-20020a056870b69400b0019eb8e01434mr21446476oab.8.1689775407820; Wed, 19
 Jul 2023 07:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230712091704.15589-1-hreitz@redhat.com>
 <20230718152607.GI44841@fedora>
 <5576e59a-55c4-97bc-7fe7-e2d22cded8e8@redhat.com>
In-Reply-To: <5576e59a-55c4-97bc-7fe7-e2d22cded8e8@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 19 Jul 2023 10:03:15 -0400
Message-ID: <CAJSP0QWOVhFR1w+cx5AMdfVoLe=tHZ8ieo7iZgYoW2_qxe4n4Q@mail.gmail.com>
Subject: Re: [PATCH] vhost-user.rst: Clarify enabling/disabling vrings
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Michael S . Tsirkin" <mst@redhat.com>, German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x33.google.com
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

On Wed, 19 Jul 2023 at 09:34, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 18.07.23 17:26, Stefan Hajnoczi wrote:
> > On Wed, Jul 12, 2023 at 11:17:04AM +0200, Hanna Czenczek wrote:
> >> Currently, the vhost-user documentation says that rings are to be
> >> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
> >> negotiated.  However, by the time of feature negotiation, all rings ha=
ve
> >> already been initialized, so it is not entirely clear what this means.
> >>
> >> At least the vhost-user-backend Rust crate's implementation interprete=
d
> >> it to mean that whenever this feature is negotiated, all rings are to =
be
> >> put into a disabled state, which means that every SET_FEATURES call
> >> would disable all rings, effectively halting the device.  This is
> >> problematic because the VHOST_F_LOG_ALL feature is also set or cleared
> >> this way, which happens during migration.  Doing so should not halt th=
e
> >> device.
> >>
> >> Other implementations have interpreted this to mean that the device is
> >> to be initialized with all rings disabled, and a subsequent SET_FEATUR=
ES
> >> call that does not set VHOST_USER_F_PROTOCOL_FEATURES will enable all =
of
> >> them.  Here, SET_FEATURES will never disable any ring.
> >>
> >> This other interpretation does not suffer the problem of unintentional=
ly
> >> halting the device whenever features are set or cleared, so it seems
> >> better and more reasonable.
> >>
> >> We should clarify this in the documentation.
> >>
> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>   docs/interop/vhost-user.rst | 23 +++++++++++++++++------
> >>   1 file changed, 17 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index 5a070adbc1..ca0e899765 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -383,12 +383,23 @@ and stop ring upon receiving ``VHOST_USER_GET_VR=
ING_BASE``.
> >>
> >>   Rings can be enabled or disabled by ``VHOST_USER_SET_VRING_ENABLE``.
> >>
> >> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has not been negotiated, the
> >> -ring starts directly in the enabled state.
> >> -
> >> -If ``VHOST_USER_F_PROTOCOL_FEATURES`` has been negotiated, the ring i=
s
> >> -initialized in a disabled state and is enabled by
> >> -``VHOST_USER_SET_VRING_ENABLE`` with parameter 1.
> >> +Between initialization and the first ``VHOST_USER_SET_FEATURES`` call=
, it
> >> +is implementation-defined whether each ring is enabled or disabled.
> > What is the purpose of this statement? Rings cannot be used before
> > feature negotiation (with the possible exception of legacy devices that
> > allowed this to accomodate buggy drivers).
>
> Perfect :)
>
> > To me this statement complicates things and raises more questions than
> > it answers.
>
> OK.  The context for the statement is as follows: When the back-end
> supports F_PROTOCOL_FEATURES, it is supposed to initialize all vrings in
> a disabled state, so that when the flag is indeed negotiated, that will
> be the state they=E2=80=99re in.  In contrast, older back-ends that don=
=E2=80=99t
> support that flag will initialize them in an enabled state (because they
> won=E2=80=99t have support for disabled vrings).
>
> The statement was intended to make it clear that this difference in
> behavior is OK, and that the front-end must not rely on either of the
> two.  Only after SET_FEATURES will and must the state be well-defined.
>
> But if you find it just confusing because enabled/disabled has no
> meaning before a virt queue is started anyway, and they mustn=E2=80=99t b=
e
> started before negotiating features, I=E2=80=99m happy to drop it without
> replacement.

Yes, dropping this statement sounds good.

Stefan

