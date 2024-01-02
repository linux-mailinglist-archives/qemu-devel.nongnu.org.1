Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B3821A3C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKcEf-0006lw-Nb; Tue, 02 Jan 2024 05:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKcEd-0006kg-6z
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:42:59 -0500
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rKcEb-0003yb-I7
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:42:58 -0500
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4281bcaf321so8921271cf.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704192176; x=1704796976; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JTlbJfG49FXk96s4oJ9RThaa8t9INNDD3eL8LRERVLc=;
 b=EB8nIGM4YpTCAXyKVsqFyIXARrr9Ycv99E76ojtcmgGrkmJGTibxBMWK3GmHlJ/Mno
 9rhxQgV6Ev5nM/0rJOSmSGMqUfaO7rkC2+7NfjQbDcTVRzyiR/3hZquqHQLHa8lg7asT
 liGOCDIyc9trCOy0H/tIhG+LQODU+hfvVJOZ6zbOBQaHaCjfvpPhB9zod1nupPBwAGXS
 awqlCiJc3QExZDgIpkWX9EvxQ4hg9m1o4CxtPqS0/M9Rku/k5B1jyNz2X9NbixYySzt0
 154ym0mLyg73FFJ+njQeZSyV/60vwX69coB0l98qum4K216Hcd23JY5FfpsbenEFj4MH
 9iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704192176; x=1704796976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JTlbJfG49FXk96s4oJ9RThaa8t9INNDD3eL8LRERVLc=;
 b=VEqE2OAhx93z7hlhsJ1cYl1XHHlhFl/zDDEoaE660cDvooRh75G14CkI2BTbdMFkh8
 2QCn868Kr5GWJzdLlErX++ip+ByKsRaw+D1ZrNMiyX1oRyVtIfk6wBX7MXSlvwtxA6eb
 /kHWOag+DD3xjo2LM4kddeygvzVP89vggj611eVDTjgt/ukVFTppg8ZDzvQDtKOW+VTI
 imhDwU6qmvBkmdBOOtOk/9RPF32SluO9cF2cCPYwQHu7gCO0aqty5grLTyzp0azx6mA4
 s98yNucHhmHlMbuEHi6w3+Oiy0bOCeirb7GuUADFeQ0ZRQOzsmvhQGU0uJxdLWMER2t0
 jEnw==
X-Gm-Message-State: AOJu0YyEZVCGo1jUz5et3QTDhVvS2cGAhomsvjgQVmrSKg8edDWGQIiC
 JX0uxEOu/DYDkc5fIP4Sb3lWrQfr+ohaHKd9IBU=
X-Google-Smtp-Source: AGHT+IG+dGscGnQcQ2gYtf0pCV3DKsQ9eE3HvQS3itcI+yz2wtXVsk/iLEAUfGLvkZme1TcR2oyjULRqJRtAhKJddTM=
X-Received: by 2002:a05:622a:1646:b0:427:860c:40b2 with SMTP id
 y6-20020a05622a164600b00427860c40b2mr21410322qtj.49.1704192176122; Tue, 02
 Jan 2024 02:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-2-ray.huang@amd.com>
 <6adff6d2-7c58-4c78-93a5-5a4594a60d27@daynix.com> <ZYGe4GcFPt0k5PTM@amd.com>
 <CAFEAcA_=iedJw4BbNHrDALC4mL4g3ZEihsDbLkEzsy-1zAWFWw@mail.gmail.com>
 <af89f683-2b6e-4ca1-aa37-8bedd12a781d@daynix.com>
In-Reply-To: <af89f683-2b6e-4ca1-aa37-8bedd12a781d@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Jan 2024 14:42:44 +0400
Message-ID: <CAJ+F1CJnanuw_VQ0DDwUMfRjwHwQAZ3yif4FANcKVHMZXH3dyg@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] linux-headers: Update to kernel headers to add
 venus capset
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Huang Rui <ray.huang@amd.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>, 
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, 
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gert Wollny <gert.wollny@collabora.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "Stabellini, Stefano" <stefano.stabellini@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>, 
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>, 
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang,
 Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
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

On Thu, Dec 21, 2023 at 10:55=E2=80=AFAM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> On 2023/12/19 23:14, Peter Maydell wrote:
> > On Tue, 19 Dec 2023 at 13:49, Huang Rui <ray.huang@amd.com> wrote:
> >>
> >> On Tue, Dec 19, 2023 at 08:20:22PM +0800, Akihiko Odaki wrote:
> >>> On 2023/12/19 16:53, Huang Rui wrote:
> >>>> Sync up kernel headers to update venus macro till they are merged in=
to
> >>>> mainline.
> >>>
> >>> Thanks for sorting things out with the kernel and spec.
> >>>
> >>>>
> >>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
> >>>> ---
> >>>>
> >>>> Changes in v6:
> >>>> - Venus capset is applied in kernel, so update it in qemu for future=
 use.
> >>>>
> >>>> https://lore.kernel.org/lkml/b79dcf75-c9e8-490e-644f-3b97d95f7397@co=
llabora.com/
> >>>> https://cgit.freedesktop.org/drm-misc/commit/?id=3D216d86b9a430f3280=
e5b631c51e6fd1a7774cfa0
> >>> Please include the link to the upstream commit in the commit message.
> >>
> >> So far, it's in drm maintainers' branch not in kernel mainline yet. Do=
 I
> >> need to wait it to be merged into kernel mainline?
> >
> > For an RFC patchset, no. For patches to be merged into QEMU
> > the headers change must be in the kernel mainline, and the
> > QEMU commit that updates our copy of the headers must be a
> > full-sync done with scripts/update-linux-headers.sh, not a
> > manual edit.
>
> Apparently the kernel change is unlikely to be merged to mainline before
> QEMU 9.0 so we need to come up with some idea to deal with this.
>
> The release of Linux 6.7 is near and the development of 6.8 will start
> soon. So it was nice if the change made into 6.8, but unfortunately it
> missed the *probably last* drm-misc tree pull request for 6.8:
> https://lore.kernel.org/all/aqpn5miejmkks7pbcfex7b6u63uwsruywxsnr3x5ljs45=
qatin@nbkkej2elk46/
>
> It will still get into linux-next so we may retrieve headers from
> linux-next. Or we may add the definition to
> hw/display/virtio-gpu-virgl.c; the duplicate definition warning will
> tell when the definition becomes no longer necessary. I'm fine with
> either option.

The second option seems better to me, as it can avoid pulling unwanted chan=
ges.

thanks

--=20
Marc-Andr=C3=A9 Lureau

