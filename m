Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DBA682D8AD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 13:03:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLeP-0007ja-24; Mon, 15 Jan 2024 07:01:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPLdw-0007il-WE; Mon, 15 Jan 2024 07:00:41 -0500
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPLdt-0003zq-Ng; Mon, 15 Jan 2024 07:00:39 -0500
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-429d2e6c0dbso19467451cf.2; 
 Mon, 15 Jan 2024 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705320036; x=1705924836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=picFB31Ddzq/PWXrb7NL15UnWgPxesdY3a23UJn7tTI=;
 b=Q9Drv1axfILv4byEGYFfzD6gLVJGKW2LkTCat47CHkdjugA8mqUIoQNuetnmJ5bg/t
 t9SIbnArhKXhPZsDp15oy423w5LEqlrddNwVFJBjWz38/ZQoO7C4BhIGkcN6+OmqH5yz
 CNkItjYuS7FLjF0AFUtKHdQ/qG+myBDklDeT/T5+So+fNfpMcU4nze5CeieLykL1kscb
 +t3i8yxqiy9K+KTOwvZ09xOHVZiqOKQugBUgpfegH10WZYre3ZANbLwV/3VSe5lWypSt
 wD4mdcgbyozsm2ypZqu0t7asNp8tkr/VUM/nu8jbJKbL5TzhWhyiwJx8DGUqYZy1tm9C
 M8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705320036; x=1705924836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=picFB31Ddzq/PWXrb7NL15UnWgPxesdY3a23UJn7tTI=;
 b=P+iUtuY0znmEGBKfFYkHVhftv3WIVoqhIWl/DI7X0wmpinMYdghAvhswduyqvBUlmF
 xpsX7YCwTkwLHSIx/dnAJYDUNW+bkKvBDUbxfU61+EwW6BINviilvsbgLmCCGPaUObPS
 RCoYKPIVtqq/yzakHWST6fgJOo/GvgKBt3arUySAyruaJuCwHWA2ZAD5/rX0rtYi9Wit
 dtTki2phYko1+g4vdvgyIAs03inEghRZxU4hTWgAyB2cG7BCDYIWyRv+kaA6Hz+S/ZYv
 kfR34ydLIgsxlWRb9x33NX6uEnOV9YRmmKv+TrCV7h3vFeaN8ExFxb+DaJ0gM2Bfx93n
 t4AQ==
X-Gm-Message-State: AOJu0YyFBH4dClohkTeeHYQTWSWnHz6otHSv1Uiu15rHV4dgh1/DibAR
 5vMlwCic9F/zM1ggOGZZKeOXRz78S8w6J2zDMg4=
X-Google-Smtp-Source: AGHT+IFoKh4f1XuFW6BifJZehhtJIQIsbsGvaxQykNIser19Uut4uKWeaIJyQWRXO0Sq8SMPD/dCBcJ7eXGq6krVBlc=
X-Received: by 2002:ac8:5dcc:0:b0:429:f102:5512 with SMTP id
 e12-20020ac85dcc000000b00429f1025512mr1436980qtx.58.1705320035820; Mon, 15
 Jan 2024 04:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
 <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
 <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
 <ccd23263-f19f-401e-b476-a7eb1fd22571@proxmox.com>
 <CAJ+F1CJHKsRrxUcUijAVV2bv0EOtbz0BAmH1OEnmciwo7ACXLQ@mail.gmail.com>
 <0c2d35cb-cacf-4a81-9b6a-f07fdea9fc07@proxmox.com>
In-Reply-To: <0c2d35cb-cacf-4a81-9b6a-f07fdea9fc07@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jan 2024 16:00:23 +0400
Message-ID: <CAJ+F1CJ4F6Kv9Vx_4H+GJ0ME0Q0X4GTm2n6L1JGg-SWFgi18SA@mail.gmail.com>
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82e.google.com
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

On Mon, Jan 15, 2024 at 3:48=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 15.01.24 um 12:33 schrieb Marc-Andr=C3=A9 Lureau:
> > Hi
> >
> > On Mon, Jan 15, 2024 at 3:26=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> Am 15.01.24 um 12:15 schrieb Marc-Andr=C3=A9 Lureau:
> >>> Hi
> >>>
> >>> On Mon, Jan 15, 2024 at 2:45=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.=
com> wrote:
> >>>>
> >>>> Am 14.01.24 um 14:51 schrieb Marc-Andr=C3=A9 Lureau:
> >>>>>>
> >>>>>> diff --git a/ui/clipboard.c b/ui/clipboard.c
> >>>>>> index 3d14bffaf8..c13b54d2e9 100644
> >>>>>> --- a/ui/clipboard.c
> >>>>>> +++ b/ui/clipboard.c
> >>>>>> @@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo =
*info,
> >>>>>>      if (info->types[type].data ||
> >>>>>>          info->types[type].requested ||
> >>>>>>          !info->types[type].available ||
> >>>>>> -        !info->owner)
> >>>>>> +        !info->owner ||
> >>>>>> +        !info->owner->request)
> >>>>>>          return;
> >>>>>
> >>>>> While that fixes the crash, I think we should handle the situation
> >>>>> earlier. A clipboard peer shouldn't be allowed to hold the clipboar=
d
> >>>>> if it doesn't have the data available or a "request" callback set.
> >>>>>
> >>>>
> >>>> Where should initialization of the cbpeer happen so that we are
> >>>> guaranteed to do it also for clients that do not set the
> >>>> VNC_FEATURE_CLIPBOARD_EXT feature? Can the vnc_clipboard_request
> >>>> function be re-used for clients without that feature or will it be
> >>>> necessary to add some kind of "dummy" request callback for those cli=
ents?
> >>>
> >>> qemu_clipboard_update() shouldn't accept info as current clipboard if
> >>> the owner doesn't have the data available or a "request" callback set=
.
> >>> This should also be assert() somehow and handled earlier.
> >>>
> >>
> >> The request callback is only initialized in vnc_server_cut_text_caps()
> >> when the VNC_FEATURE_CLIPBOARD_EXT is enabled. AFAIU, it's perfectly
> >> fine for clients to use the clipboard with non-extended messages and
> >> qemu_clipboard_update() should (and currently does) accept those.
> >>
> >>> In vnc_client_cut_text_ext() we could detect that situation, but with
> >>> Daniel's "[PATCH] ui: reject extended clipboard message if not
> >>> activated", this shouldn't happen anymore iiuc.
> >>>
> >>
> >> Daniel's patch doesn't change the behavior for non-extended messages.
> >> The problem can still happen with two VNC clients. This is the scenari=
o
> >> described in the lower half of my commit message (and why Daniel
> >> mentions in his patch that it's not sufficient to fix the CVE).
> >>
> >> In short: client A does not set the VNC_FEATURE_CLIPBOARD_EXT feature
> >> and then uses a non-extended VNC_MSG_CLIENT_CUT_TEXT message. This lea=
ds
> >> to vnc_client_cut_text() being called and setting the clipboard info
> >> referencing that client. But here, no request callback is initialized,
> >> that only happens in vnc_server_cut_text_caps() when the
> >> VNC_FEATURE_CLIPBOARD_EXT is enabled.
> >>
> >> When client B does set the VNC_FEATURE_CLIPBOARD_EXT feature and does
> >> send an extended VNC_MSG_CLIENT_CUT_TEXT message, the request callback
> >> will be attempted but it isn't set.
> >>
> >
> > The trouble is when qemu_clipboard_update() is called without data &
> > without a request callback set. We shouldn't allow that as we have no
> > means to get the clipboard data then.
> >
>
> In the above scenario, I'm pretty sure there is data when
> qemu_clipboard_update() is called. Just no request callback. If we'd
> reject this, won't that break clients that do not set the
> VNC_FEATURE_CLIPBOARD_EXT feature and only use non-extended
> VNC_MSG_CLIENT_CUT_TEXT messages?

If "data" is already set, then qemu_clipboard_request() returns.

Inverting the condition I suggested above: it's allowed to be the
clipboard owner if either "data" is set, or a request callback is set.

--=20
Marc-Andr=C3=A9 Lureau

