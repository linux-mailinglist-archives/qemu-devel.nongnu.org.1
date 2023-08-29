Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4102A78D083
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nm-0001Bi-4D; Tue, 29 Aug 2023 19:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Tm-0007ru-8p
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:34:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb4Tj-0002tZ-LA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 15:34:21 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31aeee69de0so4070489f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693337657; x=1693942457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MT9vHpBPsF/CQRQ0vBBdw4cOgoQUUcaziX9DeMGBys=;
 b=q5uGz/vLuNVKbBH6Li9LGNAOLHfTEoK5j/j0dg2aX8CL0ppZukbpfZTjFqnr8R5wud
 eJ11xlYzPTLvxYEr/EjTvvSI1B8RrMqUWlXDhCuNE6XMZCp282LzdTSSBk1ZNmEn8bx8
 stLuJci7HHX3EtZWr6bq2iO/dFkqiSwRoz93SceZibgwNhR1TmbdBpOY8SoYOxle4Tyw
 O4EaZzzeuhhZN6Iq8/W9nPXAdvoO5YFeZx+zgqVPMNkJ/BBWp434/ElYYuzuj+ACrbfM
 VEvtGJwZezNgyOBrL8OlJLk65DaV3iDvVFr1J3bLhVId3hUABvwKrnDsW6NDEVYSOZXx
 m+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693337657; x=1693942457;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7MT9vHpBPsF/CQRQ0vBBdw4cOgoQUUcaziX9DeMGBys=;
 b=lvoAAJ+BkQlXyi7rqfA4XrbnQlEqVSGhOmvRBZP739YGfh1sV81zLIWd/g07oV9xTX
 9olAcv4r7VP4hg9mhJRUf058u8tfVgTi9KwHVwambsHMhbGEM7S6zz7kQTjV/RaZwhTy
 1v1WrJt5aCBNhFYKtL6yOkTFZ6Y0H/kTDs2zAaMzzcOg+hcEv74JZwTwU6YGsrc6h7Pz
 nbtiFOeH9Wbbc4cALEK3N5Arhs7qBjHeTrYlvUSfN/+g3PiK/SMaIrEc7dZE7thxEULY
 Jd12h1QY1RoWtuA9o2d42IjZBRF5lARIvnjW4qvTqZMqsYZaz65nO4wJApRu8x4aSc3S
 zPNw==
X-Gm-Message-State: AOJu0YyxfVF0pMLUGIoMIXoUtuCSOXmDFvIsr0l9HMtl2htMgmk/hHGw
 RaHGgbCet1Mb0ZYrRH2mELuujg==
X-Google-Smtp-Source: AGHT+IF6y5OVNiaROd/0ikVKSbBdiOR8Mi0pW3jACrkkDjidYkqzHF506iGr6iApMa3ThQSHQqXaVA==
X-Received: by 2002:adf:de04:0:b0:317:731a:6702 with SMTP id
 b4-20020adfde04000000b00317731a6702mr74334wrm.19.1693337657320; 
 Tue, 29 Aug 2023 12:34:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 p8-20020adfe608000000b003197efd1e7bsm14590842wrm.114.2023.08.29.12.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 12:34:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 817041FFBB;
 Tue, 29 Aug 2023 20:34:16 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <30ad4bc665d4bec363aa3bb5503417ce58169e41.1693252037.git.manos.pitsidianakis@linaro.org>
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
Subject: Re: [PATCH v8 09/12] virtio-sound: handle VIRTIO_SND_R_PCM_RELEASE
Date: Tue, 29 Aug 2023 20:34:11 +0100
In-reply-to: <30ad4bc665d4bec363aa3bb5503417ce58169e41.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <87ledtskw7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> Handle the PCM release control request, which is necessary for flushing
> pending sound IO. No IO is handled yet so currently it only replies to
> the request.
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

