Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A80A083051A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:21:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ4uL-00048n-7Z; Wed, 17 Jan 2024 07:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ4uI-000487-Sl; Wed, 17 Jan 2024 07:20:34 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rQ4uH-0006Wf-1V; Wed, 17 Jan 2024 07:20:34 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bd72353d9fso3027665b6e.3; 
 Wed, 17 Jan 2024 04:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705494031; x=1706098831; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnCQRHqYtczqK/F2G+qYC5kHOTkKavRx/3BEybeiSMU=;
 b=eCOW2fQwQPSHaTOl+URYdC/I+QUnAaDaUSXq0oxAlqMInutmY416j9ZiXD8NupJktg
 TGWJPo01dVq5CINj5JWp8O+NkHirvYu5kYCsGr27IbMtenPxMS0fpackamIo9oPqoY4+
 qCil3j95o+nUEdcsoWP0oLTpVXvPPIw2abdW5nDsyGdNnPAQr0Cy7x0tH2chjztXZqhe
 c5yalAVVigsgR97LlXPrQgilLfc5p5jyaP5boLFRjckX9xunluS6XyuhhXk/czjkOT20
 Lqnpbo/bT5AqXAXITj0QLZI5dekXWa0QWuys8hDbbkfc7N2WPIgGTDAzdyyjrFccMUDM
 Q/gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705494031; x=1706098831;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnCQRHqYtczqK/F2G+qYC5kHOTkKavRx/3BEybeiSMU=;
 b=YvQEonrF0QTmVOINqx4o9nl9/3m9+vY+bFDM4yvCPqLeJFBdR+QF1fcWrHNX/Ouwus
 Ktgw1YyiXG30w0FUqWZiImKxPiKPIz2g/tieXbcqqGp6uZP+IDkCT4Eg7VbN7uPFwJYI
 Lz3enwXF35Q3xCpzmHP51yfSD47h9uUaXgydlz+/mlYrRlxo9WuvHAiaFDmPfNEOVvNq
 RcmFk3eQ+JP0w9nB74zGYI5bfkp0A3EStOpMK3f9/RlCJiirs9qyUJ0Ta0NcD3fjYu03
 mORtfEI5zdP6dNof/8GsZK3Qzf02xRMdzwQY8wJ1iIjD1VMbh1nEJf+T/5SzsztCgxLs
 /biQ==
X-Gm-Message-State: AOJu0Yz4h4JIWb9+nC+Lk14DJqzrkuugjdbapuPwBxpQila0ra4UK8A8
 YNMMk7IVy47Srpry+X7Fg7auC3V3e6P2gRxEWag=
X-Google-Smtp-Source: AGHT+IEKF2AcyQvcv4//0QUbXhlpOPXakhseQ3Ok1zF4ivDJFsHLqIX5yCU0VmEPPFkDRukdETebE2F2nrJ+7IwSJQs=
X-Received: by 2002:aca:1e06:0:b0:3bb:d501:f531 with SMTP id
 m6-20020aca1e06000000b003bbd501f531mr8927502oic.96.1705494031405; Wed, 17 Jan
 2024 04:20:31 -0800 (PST)
MIME-Version: 1.0
References: <20240117110109.287430-1-f.ebner@proxmox.com>
 <CAMxuvayHZiXp=VRm=e=HT8u91p3MTut1KXyWOaooEUv7=wZwFg@mail.gmail.com>
 <4d6f1a47-3311-4a44-b47c-19035d6cfee0@proxmox.com>
 <CAJ+F1CJ4gF=kx1xedYsnU9MYqTS24xobYrf4ObOAgDnSFGFrnA@mail.gmail.com>
 <a34df4a7-1948-4e65-bec1-c86c1ce54280@proxmox.com>
In-Reply-To: <a34df4a7-1948-4e65-bec1-c86c1ce54280@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 17 Jan 2024 16:20:19 +0400
Message-ID: <CAJ+F1CJ5ru_9EoenYLsEAc3jO5rvTbdvu15ocWy7nUT0AwOD+Q@mail.gmail.com>
Subject: Re: [PATCH v2] ui/clipboard: ensure data is available or request
 callback is set upon update
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x232.google.com
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

On Wed, Jan 17, 2024 at 3:56=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 17.01.24 um 12:33 schrieb Marc-Andr=C3=A9 Lureau:
> > Hi
> >
> > On Wed, Jan 17, 2024 at 3:30=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> Am 17.01.24 um 12:11 schrieb Marc-Andr=C3=A9 Lureau:
> >>> Hi
> >>>
> >>> On Wed, Jan 17, 2024 at 3:01=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.=
com> wrote:
> >>>>
> >>>> +    for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT && !missing_=
data; type++) {
> >>>> +        if (!info->types[type].data) {
> >>>> +            missing_data =3D true;
> >>>> +        }
> >>>> +    }
> >>>> +    /*
> >>>> +     * If data is missing, the clipboard owner's 'request' callback=
 needs to be
> >>>> +     * set. Otherwise, there is no way to get the clipboard data an=
d
> >>>> +     * qemu_clipboard_request() cannot be called.
> >>>> +     */
> >>>> +    if (missing_data && info->owner && !info->owner->request) {
> >>>> +        return;
> >>>> +    }
> >>>
> >>> It needs to check whether the type is "available". If not data is
> >>> provided, owner should be set as well, it should assert() that.
> >>>
> >>> That should do the job:
> >>>
> >>> for (type =3D 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
> >>>     /*
> >>>      * If data is missing, the clipboard owner's 'request' callback n=
eeds to
> >>>      * be set. Otherwise, there is no way to get the clipboard data a=
nd
> >>>      * qemu_clipboard_request() cannot be called.
> >>>      */
> >>>     if (info->types[type].available && !info->types[type].data) {
> >>>         assert(info->owner && info->owner->request);
> >>>     }
> >>> }
> >>>
> >>
> >> Okay, thanks! But we can't assert, because that doesn't resolve the CV=
E
> >> as it would still crash. The VNC client might not have the
> >> VNC_FEATURE_CLIPBOARD_EXT feature, and the request callback is current=
ly
> >> only set in that case. But we can return instead of assert to just avo=
id
> >> clipboard update. I'll send a v3.
> >
> > If it doesn't have VNC_FEATURE_CLIPBOARD_EXT, it shouldn't update the
> > clipboard without data. (ClientCutText/ServerCutText always have data,
> > even if 0-length)
> >
>
> But a buggy client should not be able to crash QEMU. With a
> VNC_MSG_CLIENT_CUT_TEXT message, when read_s32(data, 4) =3D=3D 0,
> vnc_client_cut_text() is called with zero length. Is that supposed to

Indeed. That case should be handled at the VNC server code level.. A
0-length text should set clipboard to "", not NULL.

With Ext, there is an explicit description of data ending with \0:
According to https://github.com/rfbproto/rfbproto/blob/master/rfbproto.rst#=
user-content-7727extended-clipboard-pseudo-encoding
"The text must be followed by a terminating null even though the
length is also explicitly given."

But we should still handle 0-length data cases.

> happen? The branch for an extended message is only taken when
> read_s32(data, 4) < 0 and Daniel's patch fixes that branch.
>
> I noticed in qemu_clipboard_set_data():
>
> > info->types[type].data =3D g_memdup(data, size);
>
> the g_memdup call will return NULL when size =3D=3D 0 even if data is
> non-NULL. Is that the actual problem in the above scenario?

Hmm, qemu_clipboard_set_data() shouldn't allow data =3D=3D NULL, or size =
=3D=3D 0.

When data is requested, the "peer" will call
qemu_clipboard_set_data(). But I can't see a good way for the peer to
return with no data, it should probably update the clipboard info with
available=3Dfalse.

What do you think?

--=20
Marc-Andr=C3=A9 Lureau

