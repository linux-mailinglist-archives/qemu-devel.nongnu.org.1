Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F6178CFED
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nb-00019I-Kd; Tue, 29 Aug 2023 19:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4N6-000791-Qm
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:27:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4N4-0001gg-DC
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:27:28 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31aeee69de0so4065867f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337244; x=1693942044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXSjBnuLNvhAknYHQ52EsMe5Kqh1jqoAklEikbb6BJw=;
 b=uyU18uiuPt8b0jSypdjInOgyArJj2sdkv+qhyTzs+t14z10SgVner5cFY1SBr9M9Je
 +qaUlN3ZxzMBlhYa6aPsOilZJf/s62CWv5fPGHI6Ax9GJhyGaygw69h9HgZZMm82icyr
 z1Ys8kMDpIn+DsTlp4Af3Qxp5x9Zc0gKctnszq9nQymX9JpCZZrpkAIjW7Dx2ntlVRmM
 9rw7Urdo/2yQv3vII2CM8xanfmGayCHkMhyIC+UfzuvTJp/OzDzBLq1kdD6JsHpzS0Hz
 +hlYoVKB0LwCvGesO2bPFIuELyW50ypFEQ7a23sabN9JYi+MIYHX/DSnYffMyCjxjzf1
 Td0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337244; x=1693942044;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VXSjBnuLNvhAknYHQ52EsMe5Kqh1jqoAklEikbb6BJw=;
 b=WsxH21t0rB63vdr3h5zIFzK31eLrwTXqxXv+PRBpH1tilVPoiEpg/3bmgIsLmpZa50
 LgEv7RELoauNBJlAjM/EYZ2NBqMU4CUrin0EzR3VQMwBGieYW3W1z6u7n3QTMYiSsz2l
 k0q8YLgqHaoKf385sbryKUY4ojFBBlK+P2vADHeFVsqF4E+GGYIlgfvPMOhvsu8csBKh
 wvq2/JGYnovb6vy3NSDB7D0HgCx25Im9PaxeWL92ttasiZERkW2JeOM3psy7fwQFfjo1
 RGluF9gg9wU0EaZ0fJkDb0cQFjh8OxXEDljkf6VYsyg/2/hf/RodH9HznMwsTTMLNcUL
 X0tg==
X-Gm-Message-State: AOJu0YxEdyRB2vR9kDaYMEq0K75VpLsN1aYJ2Je5C7EQxLMnxk+hTL+M
 qC6qDmvn1WLoJ0+gwsuQI76gfw==
X-Google-Smtp-Source: AGHT+IEuOpzFqSRWNC390ZqAQVsz51DChL/wfPmdCtxl/P4x3CK3BUCrfF4sLOQue+h9gS/K+g/6yQ==
X-Received: by 2002:adf:e390:0:b0:313:f5f8:a331 with SMTP id
 e16-20020adfe390000000b00313f5f8a331mr56217wrm.34.1693337244199; 
 Tue, 29 Aug 2023 12:27:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w4-20020adfde84000000b003143b14848dsm14535133wrl.102.2023.08.29.12.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:27:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 556291FFBB;
 Tue, 29 Aug 2023 20:27:23 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <6b3f8d8206d4ec73703ce100c0b08002391e0bae.1693252037.git.manos.pitsidianakis@linaro.org>
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
Subject: Re: [PATCH v8 04/12] virtio-sound: set PCM stream parameters
Date: Tue, 29 Aug 2023 20:27:18 +0100
In-reply-to: <6b3f8d8206d4ec73703ce100c0b08002391e0bae.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <877cpdtzs4.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

> This commit sets the virtio-snd device's default PCM parameters in
> virtio_snd_pcm_set_params_impl(). The same function will be used to set
> parameters from the guest with VIRTIO_SND_R_PCM_SET_PARAMS in a
> follow-up commit.
>
> PCM parameters describe the sound card parameters that the guest's
> kernel sees as an ALSA device.
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

