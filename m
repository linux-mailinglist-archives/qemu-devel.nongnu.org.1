Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFC378D634
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLQt-0007ES-Qm; Wed, 30 Aug 2023 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbLQm-00071r-1l
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:40:25 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbLQi-0007Z6-0b
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:40:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3ff1c397405so54982215e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693402817; x=1694007617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LFrOhKabnRctXDAtnKNqP3QF62HqkwnyAFa2BuN6wNI=;
 b=NrdTy3DudEC/KkZbhAQ+lkfwOLw3SEVP/v5Ll4tuWPTM5I5vNWnB7fEdhM+tKsQey2
 C5qPc8YeUshpAN7KWf/CrgkS4cHhupK1N5ZAPfKm5PeiH0v+IwRNDDj/ZsSTjzhkcTDD
 KlXAykJNxFxQwHPzCT8mAhFIdTnED9nHUYQl4XozYDE/zZZ0NZhdCBY/x1qIsKzoKmuc
 xOV7hM04Zml3h7duOz/gn8WykykZTLpVtLOGAZ10njrFPOT7VaAwDrXF+7PCo0eB0VnW
 R0dXj8GVO21OBAsABrHSSGPAUcgmPkMHN9RJaOvYPQzJ5xlCM9ReJlSn0t/3Oaavj44J
 jzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402817; x=1694007617;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LFrOhKabnRctXDAtnKNqP3QF62HqkwnyAFa2BuN6wNI=;
 b=L8mK4lgW/XaG0xr7Y4W0ZmqS/gSsjoJLHwhLxyt/772F+WJTEnqH7ajohxGmrxGhfM
 oGsFvA95jziBMGChl3jley91UBBj8bnwtgUSd0lvbiM4t4Ck/W1nMnVaW/jEU+CN5lBO
 lF/SCCocDOWOksGMiRaDagbECplikOfMrpLhNHSyhG+uGiaz3tZPP8y1PoIMcTCEQA3Q
 0nDkA+A/oVlVsXBsq6BVvfubl1KSAPokeZu1nV2kFdwn2d1n+EOC9sbq16hNcH9fP/cB
 ezsasa96HHh0JOXtHkG/5krkkzPcxMi776Xj1bpT/V4SNoajzS6LnGwLIVqWZeU6kvVJ
 psYg==
X-Gm-Message-State: AOJu0YzldnujhDjXIOFKE7REvC2XGz2tRWYn6xJ6dNBcyvivrYOo/TVv
 Okh0CO7cWefdJ9YVlWJ9bVlJBg==
X-Google-Smtp-Source: AGHT+IEBMI1C6viEsovDRGCbcF4z0Lre+LYqTrqRGVA48lKNyu5tKB44xAY9wpHhPz5Z53snaDIJSw==
X-Received: by 2002:a05:600c:28b:b0:401:daf2:2737 with SMTP id
 11-20020a05600c028b00b00401daf22737mr1948893wmk.30.1693402817314; 
 Wed, 30 Aug 2023 06:40:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a05600c280900b00401df304a7esm2317134wmb.28.2023.08.30.06.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 06:40:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 982F01FFBB;
 Wed, 30 Aug 2023 14:40:16 +0100 (BST)
References: <cover.1693252037.git.manos.pitsidianakis@linaro.org>
 <9a85da0dde1ff77021909e05b992bcdc76914eb1.1693252037.git.manos.pitsidianakis@linaro.org>
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
Subject: Re: [PATCH v8 11/12] virtio-sound: implement audio capture (RX)
Date: Wed, 30 Aug 2023 14:40:11 +0100
In-reply-to: <9a85da0dde1ff77021909e05b992bcdc76914eb1.1693252037.git.manos.pitsidianakis@linaro.org>
Message-ID: <878r9ssl6n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> To perform audio capture we duplicate the TX logic of the previous
> commit with the following difference: we receive data from the QEMU
> audio backend and write it in the virt queue IO buffers the guest sends
> to QEMU. When they are full (i.e. they have `period_bytes` amount of
> data) or when recording stops in QEMU's audio backend, the buffer is
> returned to the guest by notifying it.
>
> Signed-off-by: Emmanouil Pitsidianakis
> <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

