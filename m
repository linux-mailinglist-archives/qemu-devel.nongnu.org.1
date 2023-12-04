Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53266802CB7
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 09:08:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA3zb-0000Df-Uy; Mon, 04 Dec 2023 03:07:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rA3zX-0000Cn-9e
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:07:48 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rA3zU-0005g8-Ap
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 03:07:46 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a1a0fedd3a1so307423766b.1
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 00:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701677261; x=1702282061; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wV6A0EmMKh4+HzlIaBDSeQcTL0MCBjOxX5tp2skyJk4=;
 b=uJ3JGQtVyoa1/lo/YSBapOhQCwNo3VXFJ3EXwZzAcF6gvGwbN+jjcoulO9Aadjb1on
 aL3NZvI5dA1kI8YxPS9bDtk7XC7xt/w+HNnkyNrwL9+yvik+H70tyYqlGzQEYTJJamQl
 u4xyTmomKjSLbK3mp8FKV6WixPnXnfh8GEXDfpBXnQLbn1z8Hy3lO8vPlCGw6uTKMloz
 +6Qu8vXGBmv1QMDHd3uDObNO3M+Nax0aOPSGPPqONIQSjn8sQph482gtLAzAxKhaLeA9
 PJDRImiJBWRVTVjEkP7d6EppQONjf7+3SD5jMU/vrU8GIhSpIWHMSVmT7Bb8SeJt2u33
 JdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701677261; x=1702282061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wV6A0EmMKh4+HzlIaBDSeQcTL0MCBjOxX5tp2skyJk4=;
 b=t5ybXIprsnJFDX5l0P3Xs/ozmm3a4Smd1R3ZoCohX6ccgkSxZehXouMTmVi4wfjqPK
 5SDE2a6ClaIV1Mh6oGn2g8rODwp2kEaG9/czLER+MykHWltp3vFlMOoD6iRQ77mOq8fr
 Pi8eX9ekHp/xWGVPZBKt7Hn5o2Z/zOt3hA+MBBcF0uhNeLYcbMtp6Yk0k/m8mpQj4Zk2
 w1AhzR3pYkd2pgULd7k8Vfwvczp+2oe2T8IbxPoK0s3/LmrW3CCO9YJxf71w80P7V/nD
 rQtGH1gFJDr1McfUxwvMYwQj6PSmpmYtQmAWAixZXzwaAs/o9KmeZXgZMAXbaG32YR8k
 5Y1Q==
X-Gm-Message-State: AOJu0YwpgDKRmbH+nG8a3oQQQaC18oHvsrK1syFjwiJbSgZmbQL+8MvT
 IZICqjCRAnWLYM8HL5WVIy6TwKToZ6r11lDiFoA8dQ==
X-Google-Smtp-Source: AGHT+IFhKPkktsFZXwWmG9naGfjucJykHnYXjeSFXQ1UZyoBQ+Ag1k9fQHOFKpZoGNFIyNuyiJ942EPmrrlqFv9WXpo=
X-Received: by 2002:a17:906:74d8:b0:a09:7c04:461f with SMTP id
 z24-20020a17090674d800b00a097c04461fmr4849385ejl.65.1701677260989; Mon, 04
 Dec 2023 00:07:40 -0800 (PST)
MIME-Version: 1.0
References: <20231204072837.6058-1-vr_qemu@t-online.de>
In-Reply-To: <20231204072837.6058-1-vr_qemu@t-online.de>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 4 Dec 2023 10:07:24 +0200
Message-ID: <CAAjaMXaKWh4Lbq1ECmycbCGcZ3cUzV9fO1y9jZuXYof7wsp2Fw@mail.gmail.com>
Subject: Re: [PATCH for 8.2] hw/audio/virtio-sound: mark the device as
 unmigratable
To: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Mon, 4 Dec 2023 at 09:29, Volker R=C3=BCmelin <vr_qemu@t-online.de> wrot=
e:
>
> The virtio-sound device is currently not migratable. QEMU crashes
> on the source machine at some point during the migration with a
> segmentation fault.
>
> Even with this bug fixed, the virtio-sound device doesn't migrate
> the state of the audio streams. For example, running streams leave
> the device on the destination machine in a broken condition.
>
> Mark the device as unmigratable until these issues have been fixed.
>
> Signed-off-by: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> ---
>  hw/audio/virtio-snd.c | 1 +
>  1 file changed, 1 insertion(+)

Hello Volker!

I don't have the slightest clue on how migration works, but if this is
enough to prevent those bugs from happening, it sounds good to me.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

