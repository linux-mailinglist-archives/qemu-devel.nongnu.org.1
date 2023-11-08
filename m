Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B487E54BA
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 12:08:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0gPh-0005nk-RZ; Wed, 08 Nov 2023 06:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0gPg-0005na-Bh
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:08:00 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r0gPd-0006lX-F7
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 06:08:00 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-41cbd2cf3bbso5741101cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 03:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699441675; x=1700046475; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7j3LPKXS6AwXDj/WYmzeNSt8sBpuxVWEVMrvY9kSY6Q=;
 b=AAbb4X8O0dshTyywFnwy+r7l8iIbdBvRdnz5BFVDE9VTl5YL3iqWHKYM7zGWltRlJ9
 z6+btlPwR5LjmTQASv/YqgLLFEdXuMxF2n9MnaYXty5hujgJBUbtCGT8LXtu4X4+qrxI
 yPwh9EMlg1fx4a80vn0B86gX+hCCLibMvQLxkwFj+pXHOLxRO1LqUHVHebP4jEk6h4Xd
 bDRMgJT8e1b5obt5N9xLobFVPNPyB5Cr3bleChT3GcsKQcaoseqsu2+ppLhZq9DVhA0Z
 Na4YBSkJPk76/oeqJM80L0xnLVH7WkRAbDYXSRcKQkPDIMPGlFrYWi+gy5MUuYlB1dhR
 9qZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441675; x=1700046475;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7j3LPKXS6AwXDj/WYmzeNSt8sBpuxVWEVMrvY9kSY6Q=;
 b=oIc3NOubQsIe5KoWVdoqapqLx7TbeRrZn0JrFJ1lmDtl1CxVah8YLDQBGuJK4YZ+7M
 kH19ygi+T6BnIzGfJbEMYVIJYteyifnhA3O9UZG0QseGclrzKhU0351n9+/5niRnaNNz
 sWF1c/57k+fDWqim91n7VOKC93fDKLwD3hqYuhJvb/FopnwVAZEQXWa5/YanA3KIApND
 d+S33UAARdo7laedPiuU3XrP1fP8WLWyQO/P1ih6Brzrjz9b/nIpXoO1QVAv66+qSJLi
 1hKXGIZXZsldRURNCsTJMMROO7sBfUsmoI7HXQqKNHuDLR+NaIheW8yXRJq/bYOxU9Un
 2fqQ==
X-Gm-Message-State: AOJu0YzZpHhunvInEgFnK7XJtj+2jqYyyIkar2PnhCoE7pZ1O8ggF0Zm
 Fqtqi7C+6EjHywHrCzVdQDY70zLPBEbNToRpghQ=
X-Google-Smtp-Source: AGHT+IHLLBPHoMNgtTorw2/S2Sfu19jtQoE0uE/22xTmjcWUiVfHssm4ON5J7bn2Zo+EJq1mkbSLCkeXQMxZeK1S/AU=
X-Received: by 2002:a05:622a:1756:b0:3f9:aa80:b48a with SMTP id
 l22-20020a05622a175600b003f9aa80b48amr1844832qtk.8.1699441675300; Wed, 08 Nov
 2023 03:07:55 -0800 (PST)
MIME-Version: 1.0
References: <65466251-5c0c-90d0-c482-29ebc4e16a20@keasigmadelta.com>
 <6c565178-f34c-57f9-90be-25b2c738b068@quicinc.com>
In-Reply-To: <6c565178-f34c-57f9-90be-25b2c738b068@quicinc.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 8 Nov 2023 15:07:43 +0400
Message-ID: <CAJ+F1CK6Y-DqHTfC4u7EUhdgK0T++KTvvus6mqnRz-a9v-HQyQ@mail.gmail.com>
Subject: Re: QEMU Virtio GPU features status & roadmap?
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: Hans de Ruiter <hans@keasigmadelta.com>, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Gert Wollny <gert.wollny@collabora.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

On Wed, Nov 8, 2023 at 1:04=E2=80=AFPM Antonio Caggiano
<quic_acaggian@quicinc.com> wrote:
>
> Hi Hans,
>
> +cc Gert and Dmitry
>
> On 17/10/2023 02:48, Hans de Ruiter wrote:
> > Hi,
> >
> > I'm working on Virtio GPU drivers for AmigaOS, and would like to know
> > what features are currently stable enough to use. Looking at the master
> > QEMU branch, both Virgl and blob resources are supported, but NOT at th=
e
> > same time. Is the ability to use both simultaneously coming soon?
> >
>
> Mmh, well, they should be compatible, I'll try sending a patch.
>
> > Also, what's the state of Venus/Vulkan support? Surveying various
> > forks/branches, it looks very experimental and subject to change.
> >
>
> I believe this is quite stable now:
> https://gitlab.freedesktop.org/virgl/venus-protocol/-/issues/5

The last patch series for QEMU is from Huang Rui:
https://patchew.org/QEMU/20230915111130.24064-1-ray.huang@amd.com/

>
> Virglrenderer 1.0.0 has been released as well. I wonder if that requires
> any change in QEMU. Gert or Dmitry might know the answer.

No changes required afaik.

>
> > I have the added difficulty that the AmigaOS Picasso96 driver API
> > expects direct CPU access to all of VRAM, and likes to peek/poke
> > directly into the bitmaps. That's clearly not possible without blob
> > resources, or shared memory (not entirely sure what the shared memory
> > feature is for). This is why I want to know what features are stable or
> > coming soon.
> >
>
> The shared memory feature is just a requirement which enables support
> for blob resources.

Now that we are in freeze, we won't merge new features until the end
of this year / next year. But we can already plan / test / review etc.

Antonio, do you have your work coordinated with Huang?

Huang, are you going to send a new version of the venus series?

It would be great to include docs/system/devices/virtio-gpu.rst
updates too. It's getting difficult to follow the various ways
virtio-gpu can be used nowadays.

thanks

--=20
Marc-Andr=C3=A9 Lureau

