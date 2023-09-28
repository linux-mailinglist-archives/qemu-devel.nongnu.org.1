Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE937B231F
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 19:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qluPG-0005er-AN; Thu, 28 Sep 2023 13:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qluOf-0005VR-9k
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:02:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qluOd-0005VQ-Lp
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:01:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3248e90f032so631070f8f.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 10:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695920507; x=1696525307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2EmDnQcnrIVv0Ammxw3nCtgNeglRs9YGrxYq/qRsdSQ=;
 b=glidwrVeq2zGu6sOfJHKXuwehDLomxHmfpd2rWMvvBDJ0jDoo3PaiFHlClCQEAT36d
 1SI6uoBc1xyhAgdczM7wGq2ikjuZPjrfH71PnuqqDNMfvU5+LPVFpmIAbx1z7UhNEchw
 P4GlH2/ka3EGMOCzxFX9el7VlU7tWkvbQpcsXbQhdwH1E1MglgVG6UnKUiPWNcQrpmOG
 zRzl6M64GgJv39vmkmAapDao6gWz1T2/bmgYLgzFBtjKvILntPIXCyU8WNuxrWfdm8IE
 4Ima3StvIS4qDtsMDrjsHJ+wo7p2r9okHYWwDSR0eLT5AqTCTNa90uhCCa4speDY77MS
 siIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695920507; x=1696525307;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2EmDnQcnrIVv0Ammxw3nCtgNeglRs9YGrxYq/qRsdSQ=;
 b=r7Lc2sN2gi6xCjIbLb6idUaDeTyTobtngEIdz+yvqV9aad4SP8ElR58IenJAiRHkr1
 8lw75dZe+tcMX3EKOFpSj+YHzuxqxuTk9DnOTokoMKLM+W1BJncZZ+eRFvC0Hz3sHfgl
 aOkEGxZoM1hyWsw1IIvuFpeOZebIaWdwV+0I2OgJxuiAyoO9h8xf0ZbOJLiS0V8ldI3D
 babKcIgkhs+UBkFcSRgt8ynmn/rejstLiHrp3YPHwC/AeCjoGG5HMQcivRSDPgI/g9m1
 j1GF3h8QJaDG4NdNbBeJiaOVbkanQDQwHe6lO8juMQDljqh1JbQHaqhryI8d1MMcz8LK
 VLNg==
X-Gm-Message-State: AOJu0YzZ1qWDLh+aqEGSUP4BZJCFjD/gjCQnpqLGIWa2p/zTBzy/NRUt
 dVJ0E5AHtecdLfJikHc3tWh2Kw==
X-Google-Smtp-Source: AGHT+IGrv7xoXXp8xARFz0hOiY93AzSn0VzcTncwaJ6LalyMQc8og0O2xltlZ42GU90zRh7o4FiNHA==
X-Received: by 2002:a5d:408f:0:b0:31a:d4d0:6e98 with SMTP id
 o15-20020a5d408f000000b0031ad4d06e98mr1902181wrp.8.1695920507038; 
 Thu, 28 Sep 2023 10:01:47 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o5-20020adfeac5000000b0031984b370f2sm19722383wrn.47.2023.09.28.10.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 10:01:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 43D9B1FFBB;
 Thu, 28 Sep 2023 18:01:46 +0100 (BST)
References: <20230928132519.26266-1-abelova@astralinux.ru>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Anastasia Belova <abelova@astralinux.ru>
Cc: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, Peter Maydell
 <peter.maydell@linaro.org>, sdl.qemu@linuxtesting.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hyperv: add check for NULL for msg
Date: Thu, 28 Sep 2023 17:56:05 +0100
In-reply-to: <20230928132519.26266-1-abelova@astralinux.ru>
Message-ID: <87r0mip6yt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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


Anastasia Belova <abelova@astralinux.ru> writes:

> cpu_physical_memory_map may return NULL in hyperv_hcall_post_message.
> Add check for NULL to avoid NULL-dereference.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 76036a5fc7 ("hyperv: process POST_MESSAGE hypercall")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  hw/hyperv/hyperv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
> index 57b402b956..61c65d7329 100644
> --- a/hw/hyperv/hyperv.c
> +++ b/hw/hyperv/hyperv.c
> @@ -588,7 +588,7 @@ uint16_t hyperv_hcall_post_message(uint64_t param, bo=
ol fast)
>=20=20
>      len =3D sizeof(*msg);
>      msg =3D cpu_physical_memory_map(param, &len, 0);
> -    if (len < sizeof(*msg)) {
> +    if (!msg || len < sizeof(*msg)) {
>          ret =3D HV_STATUS_INSUFFICIENT_MEMORY;
>          goto unmap;

What is the failure path that returns NULL but leaves len untouched? I
see in address_space_map():

    if (!memory_access_is_direct(mr, is_write)) {
        if (qatomic_xchg(&bounce.in_use, true)) {
            *plen =3D 0;
            return NULL;
        }

and in qemu_ram_ptr_length:

    if (*size =3D=3D 0) {
        return NULL;
    }

but the other paths can't fail AFAICT.

That's not to say its a bad thing to verify the ptr before attempting a
de-reference but I would like to understand the failure mode.

As an aside it would also be nice to add (as a fresh commit) a kdoc
comment for cpu_physical_memory_map() that documents the API.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

