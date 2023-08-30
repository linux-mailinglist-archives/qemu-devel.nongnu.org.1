Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22F78D633
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLQN-0006lk-Vc; Wed, 30 Aug 2023 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbLQL-0006lK-LT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:39:57 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbLQJ-0007Fm-55
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:39:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-31c65820134so4636614f8f.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693402793; x=1694007593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzN/XuFhlJ00gjJCtI59eyw8EiOue6KOqy1LOGCZHjY=;
 b=xLBz/iiLdyq2+8W5wQkrohDMGfrjiNpzdefVyjlB85o2TM/glsLs8QHb9hYTszrlwL
 4YSUKf2u1uIrl+wNJQsxrteuH+Tp5Ta6uhO63H2IPLcW6ih5pR2fuIF+j/pIb85fA11J
 5f53DrznViGXFogRst2VfylrEPb33wCyq1c+A12cFGPm/WH6YQix9Ftc8sL2JZWmkX14
 DDI2qyEqk/mUMAthuhyuKOm6PHxvSZn8/kUYf0Ovvn4CZ56JKEPqwJCc5Xu7DSp6lyYH
 8xZ4bT6JuRukRtt3XpAbYXUhcG1CCuuI7Sdz01EXSwo5i3QCz/Smw7p8YvCqHodKmyhT
 QyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402793; x=1694007593;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wzN/XuFhlJ00gjJCtI59eyw8EiOue6KOqy1LOGCZHjY=;
 b=YAsDTnuhqXXNZSB25f65YUmea7jfwxJdZWLmNr687JNbVcZcftK+gwN2XsO1gObKtQ
 1KWVjjig8EqOx8fKBYoXMmdeTuM+U6WcpD2ONM4KLa4Fo9m1TDuk2jtzsWPP1MpaKk0q
 zVu1Y+cZaCj8/HmVNgU0sxhX4M/KHp/0fxiJPqT5gHilM/dVOboy8Qa+ZDbuEyDIFnI1
 DmG0qmnvHtjoJBfWQSpYaJyxpSkDA9r2cgpUmhXD2VNHaZOK5/A+kFjDjIaZUfqIxrUg
 O1Qv0z6UT2o/592B2WZ3NrABJHB/QqN6oRFk2aThGeVKkrN29jFDpJ1jWP0hgSf3708P
 3AVA==
X-Gm-Message-State: AOJu0YxHEQ5vPY8ZFB/US45ttIdWpuIpinuA+k7nKCTfEr/R6anyCRt+
 hTUNF/bwyr1eMATYsY1NIPD09LvXP9p5nWbp970=
X-Google-Smtp-Source: AGHT+IFnuNCUsXx3i0WIXv7rs/rOIy1MPA5rkC+8FkliErn7lU5cnhhHEGcHycN63W3J6fOxc1cYGg==
X-Received: by 2002:adf:f18f:0:b0:314:4c1d:1c0a with SMTP id
 h15-20020adff18f000000b003144c1d1c0amr1802022wro.46.1693402793090; 
 Wed, 30 Aug 2023 06:39:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a056000114b00b0031c6dc684f8sm16718157wrx.20.2023.08.30.06.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 06:39:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3125B1FFBB;
 Wed, 30 Aug 2023 14:39:52 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Volker =?utf-8?Q?R=C3=BCmelin?= <vr_qemu@t-online.de>, =?utf-8?B?S8WRdsOh?=
 =?utf-8?B?Z8OzLCBab2x0w6Fu?=
 <DirtY.iCE.hu@gmail.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v8 10/12] virtio-sound: implement audio output (TX)
Date: Wed, 30 Aug 2023 14:39:47 +0100
In-reply-to: <c94a9c1e65bb6bb43c58e5ccb982948424a3f3f2.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <87cyz4sl7b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Handle output IO messages in the transmit (TX) virtqueue.
>
> It allocates a VirtIOSoundPCMBlock for each IO message and copies the
> data buffer to it. When the IO buffer is written to the host's sound
> card, the guest will be notified that it has been consumed.
>
> The lifetime of an IO message is:
>
> 1. Guest sends IO message to TX virtqueue.
> 2. QEMU adds it to the appropriate stream's IO buffer queue.
> 3. Sometime later, the host audio backend calls the output callback,
>    virtio_snd_pcm_out_cb(), which is defined with an AUD_open_out()
>    call. The callback gets an available number of bytes the backend can
>    receive. Then it writes data from the IO buffer queue to the backend.
>    If at any time a buffer is exhausted, it is returned to the guest as
>    completed.
> 4. If the guest releases the stream, its buffer queue is flushed by
>    attempting to write any leftover data to the audio backend and
>    releasing all IO messages back to the guest. This is how according to
>    the spec the guest knows the release was successful.
>
> Based-on: https://github.com/OpenSynergy/qemu/commit/5a2f350eec5d157b90d9=
c7b40a8e603f4da92471
> Signed-off-by: Igor Skalkin <Igor.Skalkin@opensynergy.com>
> Signed-off-by: Anton Yakovlev <Anton.Yakovlev@opensynergy.com>
> Signed-off-by: Emmanouil Pitsidianakis
> <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

