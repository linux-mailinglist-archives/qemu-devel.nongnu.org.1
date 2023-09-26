Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99897AF42D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:32:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDlz-000302-TC; Tue, 26 Sep 2023 15:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlDlw-0002zT-MP
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:31:06 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlDlu-0004aS-Sm
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:31:04 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c4bf619b57so4673884a34.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695756660; x=1696361460; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1kuldS5meDUlBVUbaZd7WrrihYFiRKnvLa+X7UK/0Q=;
 b=E+uM9+0iIFLZd+3bqH+LbPKKJ4exfWiLW3t/VjFpEkkRH6Pp6ACJoQWXd6ilgL0M04
 zYQQ+LNfvalz109ei9yRZDooR/L+6fNM3OQDoBtfsHppUpvqscpBia3jWgep+grOrMwC
 TGVfeIvHHjQMLWlOX2FLsAS2xyGqBF/v7uwa5cOwJ4rbxBWevyTK7OnIPsLjpcshZx61
 e/nlUgJXMk/V8iCNg1gQ4vCkuRE2reBzMI6+stdPvth3C6As4DXOou0oG6/AtX2odLGd
 oetObH3jGGAgGxZq1IiuTWHYTVki+YLe6nYFmcLNmvWgUfE0nePrToD2mH888PzWUyM4
 KJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695756660; x=1696361460;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1kuldS5meDUlBVUbaZd7WrrihYFiRKnvLa+X7UK/0Q=;
 b=rGbRO0M+pBOMQkOXNGw4OwzVIUV1sM9+3uERBaw/XYoIr0d3mhTB6UY//+d09avS9e
 IcLBiScD+mQiU1yY03L2hm/uieaSv9qCeq6qDRkwd1Lt+73zSw5+XJ4Wbal+9fLb/Hdl
 594r6KW1UsMzpu0C9AE2BlZPWesZTNG6Ty5HhpbBf0LwwdB5eHz/hqqaotu9TECLVQSk
 GkWM6iVj/yIPkfQonqXKmW0eIQd2463cwf/vAn2VcHxQAQzxbdveYcMJdczNwyYbXDf8
 R3V+DzUir9axzlPHEea5vbf51ujLU/5MbPV1jx/xcmW39RergS3GUva4zbMIdSLXIlD/
 me0w==
X-Gm-Message-State: AOJu0Yy00QWceND7V7rTCmVSujJnHuDArWwlgTHGBfDQbl5Wsu4ygGhu
 fZf6UBzq3KtIGTr4Y8kYTezf499zbkmBicOp3+/G0YaH9o4=
X-Google-Smtp-Source: AGHT+IH9bGEC/eq49qXUHBwZVGF0jOuRroXVX4tgRZ9OuUCh0le1Slj74m9Xh68BGByypSVr8f2LZmaFCyaHe+GjppM=
X-Received: by 2002:a05:6830:2004:b0:6b8:f730:7ab4 with SMTP id
 e4-20020a056830200400b006b8f7307ab4mr12940337otp.0.1695756660186; Tue, 26 Sep
 2023 12:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230915102531.55894-3-hreitz@redhat.com>
 <20230925191508.GC323580@fedora>
 <de0387fc-0342-a3bf-7d72-3130e94c50cd@redhat.com>
In-Reply-To: <de0387fc-0342-a3bf-7d72-3130e94c50cd@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 Sep 2023 15:30:47 -0400
Message-ID: <CAJSP0QWPHejS96Jyb0rYnO39R0EDTc4yhxfkzmBkAOJQdY0NnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] vhost-user.rst: Clarify enabling/disabling vrings
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 virtio-fs@redhat.com, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 German Maglione <gmaglione@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=stefanha@gmail.com; helo=mail-ot1-x32d.google.com
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

On Tue, 26 Sept 2023 at 09:55, Hanna Czenczek <hreitz@redhat.com> wrote:
>
> On 25.09.23 21:15, Stefan Hajnoczi wrote:
> > On Fri, Sep 15, 2023 at 12:25:27PM +0200, Hanna Czenczek wrote:
> >> Currently, the vhost-user documentation says that rings are to be
> >> initialized in a disabled state when VHOST_USER_F_PROTOCOL_FEATURES is
> >> negotiated.  However, by the time of feature negotiation, all rings ha=
ve
> >> already been initialized, so it is not entirely clear what this means.
> >>
> >> At least the vhost-user-backend Rust crate's implementation interprete=
d
> >> it to mean that whenever this feature is negotiated, all rings are to
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
> >> This interpretation does not suffer the problem of unintentionally
> >> halting the device whenever features are set or cleared, so it seems
> >> better and more reasonable.
> >>
> >> We should clarify this in the documentation.
> >>
> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>   docs/interop/vhost-user.rst | 20 ++++++++++++++------
> >>   1 file changed, 14 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
> >> index bb4dd0fd60..9b9b802c60 100644
> >> --- a/docs/interop/vhost-user.rst
> >> +++ b/docs/interop/vhost-user.rst
> >> @@ -409,12 +409,20 @@ and stop ring upon receiving ``VHOST_USER_GET_VR=
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
> >> +If ``VHOST_USER_SET_FEATURES`` does not negotiate
> >> +``VHOST_USER_F_PROTOCOL_FEATURES``, rings are enabled immediately whe=
n
> >> +started.
> >> +
> >> +If ``VHOST_USER_SET_FEATURES`` does negotiate
> >> +``VHOST_USER_F_PROTOCOL_FEATURES``, each ring will remain in the disa=
bled
> >> +state until ``VHOST_USER_SET_VRING_ENABLE`` enables it with parameter=
 1.
> >> +
> >> +Back-end implementations that support ``VHOST_USER_F_PROTOCOL_FEATURE=
S``
> >> +should implement this by initializing each ring in a disabled state, =
and
> >> +enabling them when ``VHOST_USER_SET_FEATURES`` is used without
> >> +negotiating ``VHOST_USER_F_PROTOCOL_FEATURES``.  Other than that, rin=
gs
> >> +should only be enabled and disabled through
> >> +``VHOST_USER_SET_VRING_ENABLE``.
> > The "Ring states" section starts by saying there are three states:
> > "stopped", "started but disabled", and "started and enabled". But this
> > patch talks about a "disabled state". Can you rephrase this patch to us=
e
> > the exact state names defined earlier in the spec?
>
> I would not want to do that.  We had the exact problem that the spec
> wanted to remain high-level, and was not reflecting exactly what
> existing implementations did, which resulted in confusion (at least for
> me and the vhost Rust crates authors).
>
> Notably, the existing implementations I=E2=80=99m aware of track
> enabled/disabled even before the ring is started, exactly as formulated
> here.
>
> If we changed this to read something like =E2=80=9CIf VHOST_USER_SET_FEAT=
URES is
> ever called without negotiating VHOST_USER_F_PROTOCOL_FEATURES, the ring
> must be enabled immediately when it is started; otherwise, when the ring
> is started and VHOST_USER_F_PROTOCOL_FEATURES has always been set in
> every VHOST_USER_SET_FEATURES call, the ring should be disabled when
> started.=E2=80=9D then this would conflict with the existing implementati=
ons:
>
> We never disallow VHOST_USER_SET_VRING_ENABLE when the ring is stopped.
> Existing implementations track enabled/disabled before the rings are
> started, and they initialize this state to =E2=80=9Cdisabled=E2=80=9D, se=
tting it to
> =E2=80=9Cenabled=E2=80=9D on receiving VHOST_USER_SET_FEATURES without
> VHOST_USER_F_PROTOCOL_FEATURES, as described above.  Therefore, if you
> call VHOST_USER_SET_VRING_ENABLE 1 before the ring is started, the ring
> will start enabled even with VHOST_USER_F_PROTOCOL_FEATURES.  This is
> not possible if you only have three states.
>
> Maybe we should rather clarify that enabled/disabled is tracked even
> while the ring is stopped.

Yes, please. The beginning of the "Ring states" section is confusing
because it claims there are three states but later text doesn't use
those states. Instead it treats started/stopped and enabled/disabled
as independent.

If the entire "Ring states" section consistently talks about
started/stopped and enabled/disabled as independent, then that would
make it easier to understand.

Stefan

