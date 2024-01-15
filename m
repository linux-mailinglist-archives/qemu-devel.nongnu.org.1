Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEB182D82C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:16:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKw5-0000jS-Se; Mon, 15 Jan 2024 06:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPKw3-0000if-0C; Mon, 15 Jan 2024 06:15:19 -0500
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPKw1-0001oy-ED; Mon, 15 Jan 2024 06:15:18 -0500
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-429915eefa5so61532231cf.1; 
 Mon, 15 Jan 2024 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705317316; x=1705922116; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zAhwdWPmyCzEiOdByHxbKdWYfP5mXOzH8/3mvI9Olc=;
 b=HFzhNjPXoDmTYZg8YFIPLOPXwcZScbtgYwAID6XmK9iz/kteawU8cBm/HO3XFYto8K
 XC9TGxik5jakn14mIkay/gr45/0mTig20gnJMIz/oHhzo/5NCDj4XhqH4kPEKxRxGrLz
 4ZBbLjLQJmeYM9VldF7DBGqd1SqjfSQFcYAcR103KjKNYIQrN0B+JylpZCee4gPfveWb
 HK/ZSOefQUFlMbK02tCUJHPeri0aEC4Pq4ePho0S6mLBUfGW+JDjYTXC83jBVCTqEI/j
 zSQNhHoEC42QpdaTW6Qe+LblwqZtzfWA8ZxLemKS97MFVH3FZQDMwlGwdUBVjP5Ha4XR
 PiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705317316; x=1705922116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zAhwdWPmyCzEiOdByHxbKdWYfP5mXOzH8/3mvI9Olc=;
 b=A2D9Cjr0InbhJTf3ny+InZ+I0dXrogRBd+LAoewZlYtnvha0ZdBQrdmfPuiWQLgzBb
 ekOGCaxR1V/lSoPs8YcxoU7prRYdZxA0pQX5zS4NgPknBCPidCyT1oHd+2meStanM+ps
 deLfBqkV2nXJxzo2JZfGAhBvYqGthO8/q6yutRonq9+ssrt7+6HNEcH2VcFQtv89EUyu
 bHMH26JSCCesY0lGISLB8n/bSHeDEohGWBOK+kX88/RR3bJLNcBomqQaMFNGP8NLUWIl
 0GP4x94/6C3WblIiDTyZwr/s6QPnUFU32uUG98T3dluX5pqvuuO6aVBsoszqhwHdleLq
 RdFQ==
X-Gm-Message-State: AOJu0YwE/m0ITLnv8htW+2mcIF5rW3fX8FxkQbakcgIQdtW/FK8U6tln
 vlJV0SYQqfkffKPqrhQtZIk4Eg2nk/xBvjJMBC4=
X-Google-Smtp-Source: AGHT+IGwj6Bbdsj+lDYmqhDfyhEQhdBrcgQf+agakROWYP7EfRN1Y1TEMVXvqbrIj5svbSUT0MDrJ2c/RYGIGQFpqKQ=
X-Received: by 2002:a05:622a:391:b0:429:9a6f:b0bf with SMTP id
 j17-20020a05622a039100b004299a6fb0bfmr8403175qtx.16.1705317316068; Mon, 15
 Jan 2024 03:15:16 -0800 (PST)
MIME-Version: 1.0
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
 <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
In-Reply-To: <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jan 2024 15:15:04 +0400
Message-ID: <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
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

On Mon, Jan 15, 2024 at 2:45=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 14.01.24 um 14:51 schrieb Marc-Andr=C3=A9 Lureau:
> >>
> >> diff --git a/ui/clipboard.c b/ui/clipboard.c
> >> index 3d14bffaf8..c13b54d2e9 100644
> >> --- a/ui/clipboard.c
> >> +++ b/ui/clipboard.c
> >> @@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo *inf=
o,
> >>      if (info->types[type].data ||
> >>          info->types[type].requested ||
> >>          !info->types[type].available ||
> >> -        !info->owner)
> >> +        !info->owner ||
> >> +        !info->owner->request)
> >>          return;
> >
> > While that fixes the crash, I think we should handle the situation
> > earlier. A clipboard peer shouldn't be allowed to hold the clipboard
> > if it doesn't have the data available or a "request" callback set.
> >
>
> Where should initialization of the cbpeer happen so that we are
> guaranteed to do it also for clients that do not set the
> VNC_FEATURE_CLIPBOARD_EXT feature? Can the vnc_clipboard_request
> function be re-used for clients without that feature or will it be
> necessary to add some kind of "dummy" request callback for those clients?

qemu_clipboard_update() shouldn't accept info as current clipboard if
the owner doesn't have the data available or a "request" callback set.
This should also be assert() somehow and handled earlier.

In vnc_client_cut_text_ext() we could detect that situation, but with
Daniel's "[PATCH] ui: reject extended clipboard message if not
activated", this shouldn't happen anymore iiuc.

>
> > Iow, we should have an assert(info->owner->request !=3D NULL) here inst=
ead.
> >
> Your choice of course, but it would be a crash again should the issue
> ever re-appear. Would error message (so the issue gets noticed) + return
> be an option too?
>
> Best Regards,
> Fiona
>


--=20
Marc-Andr=C3=A9 Lureau

