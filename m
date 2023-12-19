Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 112BB81898F
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 15:16:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFarx-0003je-VD; Tue, 19 Dec 2023 09:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFars-0003jM-Bv
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:14:45 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFarp-00077w-V3
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 09:14:43 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-553a45208ffso801212a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 06:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702995280; x=1703600080; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TZrVQU/xjd9KQVh7NuWIHyvOYXWE/j1hmbmx4pHhV9I=;
 b=dnOK+kaamu9rM1Q4obd0iLmm5lWROklu3FBOaOs6+X6PM4vAp2iRpRFY8LR/ZNL2FR
 JtgawlG8oEbkVLlxTdd0JfAzouA5Tmr33k8w/hlySytjZNtUR2/n8IVeBg3KAPmuBv/e
 /rXi/8FHp9S+zeM+DdTSZSlt2cGLbcJZsXqgXMJqrarGvBDB0sAyJwKNemRF5b3eFr4U
 8YRA6lj2qqknZs181kOoYvgBsuhlNLfj8vAoIDeSjkDnbCK4fgRqbIfpiwgjSILEwOpR
 twlnXIYbIyugwFhrnltu7dzZDGJHwgVeR+3yUhoEJUPTPEDee/fhSamm2qlO/4T7tXgB
 dERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702995280; x=1703600080;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZrVQU/xjd9KQVh7NuWIHyvOYXWE/j1hmbmx4pHhV9I=;
 b=ivHfGHZP1yswZ8+UcZxv1feY6FLDIVOLCg42Rr3ejVuKlm1jr8Z4Bjkp/wxJWJngF5
 m20LqYtWajqETMaVFioVrhz3N5qWlUeENSFSqHCs06ZeocNzoN8uHDGgV+Mjg4uTqX2y
 TsVjCt30Wcf+GRlzqySFPlrvRtpRQJMSyxwI/KF1QBKkNSxsMKzgLBlXBbzEcDAOs1XR
 /vy4mx5a/8B5dS81scAK4qTxqL0xyfnl2gsYYoQN3AR78tR7UBwUNiFpZu0UrgSiSgK/
 Xx9uLrlbasC61GROZ0VNCkxp0ZO53q7I5dZg8Lgpl3KTT2ua0cMj+y1vHn5G5KeO36sT
 dBRg==
X-Gm-Message-State: AOJu0YyzNEcqMoOizqVV093yUXe1xb/nzX1RF8NsRCPBRzlPAQAbqSRH
 qudryB3ScX1jkQVMakUdA2K+vOs9OlGbO/ybyBfxWA==
X-Google-Smtp-Source: AGHT+IFoIAEbqofqhy4721zESdE0+CFNnJQliL+b/I13sftgzhzrNkoJ6Q+Mhi/PaWdAQPcN0Xxyu+UY1l2GSHt5eBE=
X-Received: by 2002:a50:c082:0:b0:552:e74b:6412 with SMTP id
 k2-20020a50c082000000b00552e74b6412mr1850187edf.10.1702995280123; Tue, 19 Dec
 2023 06:14:40 -0800 (PST)
MIME-Version: 1.0
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-2-ray.huang@amd.com>
 <6adff6d2-7c58-4c78-93a5-5a4594a60d27@daynix.com> <ZYGe4GcFPt0k5PTM@amd.com>
In-Reply-To: <ZYGe4GcFPt0k5PTM@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Dec 2023 14:14:28 +0000
Message-ID: <CAFEAcA_=iedJw4BbNHrDALC4mL4g3ZEihsDbLkEzsy-1zAWFWw@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] linux-headers: Update to kernel headers to add
 venus capset
To: Huang Rui <ray.huang@amd.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
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
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Tue, 19 Dec 2023 at 13:49, Huang Rui <ray.huang@amd.com> wrote:
>
> On Tue, Dec 19, 2023 at 08:20:22PM +0800, Akihiko Odaki wrote:
> > On 2023/12/19 16:53, Huang Rui wrote:
> > > Sync up kernel headers to update venus macro till they are merged into
> > > mainline.
> >
> > Thanks for sorting things out with the kernel and spec.
> >
> > >
> > > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > > ---
> > >
> > > Changes in v6:
> > > - Venus capset is applied in kernel, so update it in qemu for future use.
> > >
> > > https://lore.kernel.org/lkml/b79dcf75-c9e8-490e-644f-3b97d95f7397@collabora.com/
> > > https://cgit.freedesktop.org/drm-misc/commit/?id=216d86b9a430f3280e5b631c51e6fd1a7774cfa0
> > Please include the link to the upstream commit in the commit message.
>
> So far, it's in drm maintainers' branch not in kernel mainline yet. Do I
> need to wait it to be merged into kernel mainline?

For an RFC patchset, no. For patches to be merged into QEMU
the headers change must be in the kernel mainline, and the
QEMU commit that updates our copy of the headers must be a
full-sync done with scripts/update-linux-headers.sh, not a
manual edit.

thanks
-- PMM

