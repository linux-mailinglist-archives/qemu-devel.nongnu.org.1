Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB117A63CC
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 14:52:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiaCY-0007dr-Rx; Tue, 19 Sep 2023 08:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiaCW-0007di-Ct
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:51:36 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qiaCU-0005CQ-Se
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 08:51:36 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ab7fb1172cso3262605b6e.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 05:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695127893; x=1695732693; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nadKGyncMStLqhxXw1S/c1fIv/H1K43gEuiLoGXg6Zs=;
 b=H8fwYpJS+sAyqoxJiqabzYtseq0CdORDOcFJmmc5yaNRlaquze9mgETKoTi3DMJPNn
 Mz669RlhQiw+XWQhAcs2L5pL0TO4fMmyKYFA5XKy5egf2+pl4nFDXTIyY0Zy+5QyOwLJ
 OmFiO7k1oCgBTphNuLB0GwBc5aEOfYCoBDJV3p/+Ph4UjcorMUnp1FrvRZfNBvc/Kq/4
 wo01lx00aXWaAVWtFk2fiYxethDmoj0m3KJdUh9J4rO1msxpTBDov3z0dijDXxgDvMlP
 8TGFH1gslxpUlrc21w7r7MsmkzDgEJmH3wsyK8OarijuKCKpIWDLDRudcO7JFuKowYxl
 PWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695127893; x=1695732693;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nadKGyncMStLqhxXw1S/c1fIv/H1K43gEuiLoGXg6Zs=;
 b=u3zHRMicKPGqpSvbOCaD2uPQhj8jYYTpah7cHVr1IJGuer1DIhv2aDlwRacQtvFjhT
 FbgN2Imi60lxzeeWNS95qXHPsD5OZ2G8wQm5eNPNfAOR60OLFmAejS4P/IrwJ8oRxmFO
 VaycG1H8Wg29N0vwMMNgNgxMNKuQ4f32OCS8j7vus7jNMM4ieAuK3npLZz9n67VHgBh6
 4v7YwlK641f5TjfzFCScRtVU+sWALH16TMTJMtgbj6x8+yVl6omn4DeP4FCkfiLoD9UQ
 yE0Qi2I9qZT3B/JgnS9yGC9g2HjCSeb/xUk1UwvWiWHoy3oDdDlIZ6z/qynjePgampST
 4blw==
X-Gm-Message-State: AOJu0YwA4Fog4JEqTaRlLjTqdPafigBdVEIlW8msl+KKDINAgYzWXI+S
 oMyNX+c3wvmjq68b7WdyC/gnI+5R+Nj91IhdMnWpOSvAgJ4=
X-Google-Smtp-Source: AGHT+IGpB0yeUrIU0dorEDi9MqWCOzrepieSXAn9UMgPtlBK58KngNhiX0ojG1kK/PhAo9E/bpxoyUxY7JO8BcP/ASs=
X-Received: by 2002:a05:6808:2a68:b0:3a7:72e2:f6be with SMTP id
 fu8-20020a0568082a6800b003a772e2f6bemr10648542oib.2.1695127892687; Tue, 19
 Sep 2023 05:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130936.767722-1-marcandre.lureau@redhat.com>
In-Reply-To: <20230907130936.767722-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Sep 2023 16:51:21 +0400
Message-ID: <CAJ+F1CLUM+XRZppN2P6Z_c107HEKOGNE3r_ivfMqcOz2oOO6ag@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] virtio-gpu: add blob migration support
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, kraxel@redhat.com,
 Juan Quintela <quintela@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22b.google.com
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

Hi

On Thu, Sep 7, 2023 at 5:15=E2=80=AFPM <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Hi,
>
> This is a follow-up of the previous patch "[PATCH] virtio-gpu: block migr=
ation
> of VMs with blob=3Dtrue". Now that migration support is implemented, we c=
an decide
> to drop the migration blocker patch, or apply and revert it, so that
> backporting of a quick fix is made easier.
>
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2236353
>
> Marc-Andr=C3=A9 Lureau (5):
>   virtio-gpu: block migration of VMs with blob=3Dtrue
>   virtio-gpu: factor out restore mapping
>   virtio-gpu: move scanout restoration to post_load
>   virtio-gpu: add virtio-gpu/blob vmstate subsection
>   Revert "virtio-gpu: block migration of VMs with blob=3Dtrue"
>
>  hw/display/virtio-gpu.c | 174 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 146 insertions(+), 28 deletions(-)
>
> --
> 2.41.0
>

ping



--=20
Marc-Andr=C3=A9 Lureau

