Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B782D865
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:35:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLEV-0007dp-8R; Mon, 15 Jan 2024 06:34:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPLES-0007d5-Uf; Mon, 15 Jan 2024 06:34:20 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rPLEP-0007sz-Fm; Mon, 15 Jan 2024 06:34:20 -0500
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6dec4b7b680so2661132a34.3; 
 Mon, 15 Jan 2024 03:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705318450; x=1705923250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2KpZjt0o+ezfg/+TXrvF5fto7FJQeosPNBjh1Bb4888=;
 b=e0z6zU2kseo7I/4sXYSmbej8f/y23Hg0m1YHTnZKWplVktHSnHIMGf80Hl0cLbCv4J
 /lV8IdzCK8KFB+L3PhI87VBThQIdeo/8OOPXKlzgIsbtZN2eoc5/vrkbAHlE5XdkN8qt
 hJ3ihdMaSG/Sac22f0hXjM+lpHKidXv+AlbEWEw41540rKrJzvuOMbtD9tbg3Kh9chDE
 VUhoQ7GkdVt2C1UFOGB5w9WgMoP0zcDW82oJRnKR6G1V0saZrSg89x1LEuMuvQYpx/gn
 U5XI94VWjaM/AQFpPD/8VtG7HVd9jTo2+V7vFtXER02RwBlQh3oFq8Jck1t6OxXtAsTm
 QEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705318450; x=1705923250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2KpZjt0o+ezfg/+TXrvF5fto7FJQeosPNBjh1Bb4888=;
 b=KXhRljkNh3ZaplIkYPQ+4BoBlT/KikPHei3NZ+FoQYvo2au9vTUW//x+YJYSUKetDm
 HtvFHmy9XRzkemBTS65GxZCkKfehP2rTvV4WKWITCj7A7xJyIdzv56vbmOY4QfVI2plA
 yb3f0zgWahTwJuFRybXugucn+VSTchKOgIYCxdrYroJCOfW6NbIJK+BKO0J8Q5OC0Bwf
 m0bBh/CyU1Al+Qz6dY4RLLYFBWQNztVSdJ4DMJkBPbSsfrs0XCCy6EdQTSR6BLH1P7O0
 bZPX4jY3WFU5odPUwJmRmnRVSumA9ee2nFfmRvd/EMUxSfONwrRCY0rVURwcb+tfFMu3
 goKQ==
X-Gm-Message-State: AOJu0Yxzlfd+4IYFN1e4UZeDmn+x4r7OSqYvKQ1LoYWMl9pRJubCrivo
 Gt5LYYD1JQV98KCSoRGB6CckjJ858v0yUKZ/9CI=
X-Google-Smtp-Source: AGHT+IHLR0B48A9Cq2zhs1W+mCTymffzUPfk85VA9/AYPnmAjfv50yeC/dCfQxFnrNcgkRAlCBpdnJu1+gXKOAKQTGk=
X-Received: by 2002:a9d:6319:0:b0:6dd:d611:da9c with SMTP id
 q25-20020a9d6319000000b006ddd611da9cmr5481185otk.30.1705318449940; Mon, 15
 Jan 2024 03:34:09 -0800 (PST)
MIME-Version: 1.0
References: <20240112135527.57212-1-f.ebner@proxmox.com>
 <CAJ+F1C+JXE9hSQ_oDNZvhpYDqPeeKayopB3x2L2YyJTxM8t+Yg@mail.gmail.com>
 <2150aa28-3eba-4e95-a301-d87377ba40a4@proxmox.com>
 <CAJ+F1CKQkXUiuQH+mNC7p00wWrznsgWJD4xjR-AzjJGPnsF8gw@mail.gmail.com>
 <ccd23263-f19f-401e-b476-a7eb1fd22571@proxmox.com>
In-Reply-To: <ccd23263-f19f-401e-b476-a7eb1fd22571@proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 15 Jan 2024 15:33:58 +0400
Message-ID: <CAJ+F1CJHKsRrxUcUijAVV2bv0EOtbz0BAmH1OEnmciwo7ACXLQ@mail.gmail.com>
Subject: Re: [PATCH] ui/clipboard: avoid crash upon request when clipboard
 peer is not initialized
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, m.frank@proxmox.com, 
 berrange@redhat.com, mcascell@redhat.com, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ot1-x333.google.com
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

On Mon, Jan 15, 2024 at 3:26=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 15.01.24 um 12:15 schrieb Marc-Andr=C3=A9 Lureau:
> > Hi
> >
> > On Mon, Jan 15, 2024 at 2:45=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.co=
m> wrote:
> >>
> >> Am 14.01.24 um 14:51 schrieb Marc-Andr=C3=A9 Lureau:
> >>>>
> >>>> diff --git a/ui/clipboard.c b/ui/clipboard.c
> >>>> index 3d14bffaf8..c13b54d2e9 100644
> >>>> --- a/ui/clipboard.c
> >>>> +++ b/ui/clipboard.c
> >>>> @@ -129,7 +129,8 @@ void qemu_clipboard_request(QemuClipboardInfo *i=
nfo,
> >>>>      if (info->types[type].data ||
> >>>>          info->types[type].requested ||
> >>>>          !info->types[type].available ||
> >>>> -        !info->owner)
> >>>> +        !info->owner ||
> >>>> +        !info->owner->request)
> >>>>          return;
> >>>
> >>> While that fixes the crash, I think we should handle the situation
> >>> earlier. A clipboard peer shouldn't be allowed to hold the clipboard
> >>> if it doesn't have the data available or a "request" callback set.
> >>>
> >>
> >> Where should initialization of the cbpeer happen so that we are
> >> guaranteed to do it also for clients that do not set the
> >> VNC_FEATURE_CLIPBOARD_EXT feature? Can the vnc_clipboard_request
> >> function be re-used for clients without that feature or will it be
> >> necessary to add some kind of "dummy" request callback for those clien=
ts?
> >
> > qemu_clipboard_update() shouldn't accept info as current clipboard if
> > the owner doesn't have the data available or a "request" callback set.
> > This should also be assert() somehow and handled earlier.
> >
>
> The request callback is only initialized in vnc_server_cut_text_caps()
> when the VNC_FEATURE_CLIPBOARD_EXT is enabled. AFAIU, it's perfectly
> fine for clients to use the clipboard with non-extended messages and
> qemu_clipboard_update() should (and currently does) accept those.
>
> > In vnc_client_cut_text_ext() we could detect that situation, but with
> > Daniel's "[PATCH] ui: reject extended clipboard message if not
> > activated", this shouldn't happen anymore iiuc.
> >
>
> Daniel's patch doesn't change the behavior for non-extended messages.
> The problem can still happen with two VNC clients. This is the scenario
> described in the lower half of my commit message (and why Daniel
> mentions in his patch that it's not sufficient to fix the CVE).
>
> In short: client A does not set the VNC_FEATURE_CLIPBOARD_EXT feature
> and then uses a non-extended VNC_MSG_CLIENT_CUT_TEXT message. This leads
> to vnc_client_cut_text() being called and setting the clipboard info
> referencing that client. But here, no request callback is initialized,
> that only happens in vnc_server_cut_text_caps() when the
> VNC_FEATURE_CLIPBOARD_EXT is enabled.
>
> When client B does set the VNC_FEATURE_CLIPBOARD_EXT feature and does
> send an extended VNC_MSG_CLIENT_CUT_TEXT message, the request callback
> will be attempted but it isn't set.
>

The trouble is when qemu_clipboard_update() is called without data &
without a request callback set. We shouldn't allow that as we have no
means to get the clipboard data then.

--=20
Marc-Andr=C3=A9 Lureau

