Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 950067CFCF0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 16:38:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUA1-0005l4-2t; Thu, 19 Oct 2023 10:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtU9y-0005Y3-JR
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:38:02 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtU9w-00012K-Fs
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 10:38:02 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-50797cf5b69so8608371e87.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 07:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697726278; x=1698331078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=joBq233t7wX5Q6V2Jc6m/9uKDsqIT/4FKvuUIbEBG/8=;
 b=h6Z4xIWx1OkUC5olz0cc1Ipuic2e05I8xBlkMM9+Ib9FghwNIWe8iBas1oqe5BaKBl
 MTaOnN3aAfBucjN0hyqrHVfo7cxYpNQgeDvjI714V86+X7sZyatVZ7r6qZ6asybCcCfK
 n0x8VhjHOZvq4K0h2FCaXZhRvsrrWzRHQa5Sc9HiyDHQnyRVw8RES0H9EWCq3hGHEY32
 25wOvgFFgJLP4GODITGoBf8yuglqhwRCCx2k/9C4lcW6dAW1Y6l05SeulelQ2TPA8mSE
 93gUha4jldCARRP2pg2Dsl5/9EsXKkAIkUBcwI7+ELzM7C8S7nJ+Dg8QGGvRBJ/l8gTG
 0TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697726278; x=1698331078;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=joBq233t7wX5Q6V2Jc6m/9uKDsqIT/4FKvuUIbEBG/8=;
 b=b/wK5/4A2NX8GZwYzYMiPI/7fpDyLbRUfr+6v50S/k4mjQbp18ZXBVZ8PXLof7rpIf
 EUY2MzP8lNVdcfinna/FF3ZyBbbqnaJ6wstGbAQ1VBPxvv4T4SyW+J3BwZN2MuMh00ut
 HZg4Kn5ni2w4tmN7ViusJJ8KqCiOexYL+8ipsILj5Ag9/K0qgqJofQwsFKvEn8zRm9OR
 AeCNiUUQMss54l4EBAG60yQ4xCsXCrIFywvwMGQaKdU/JwnwTLSas9U8G7/e4iqP6cqq
 V9ARpT+liYTJLpJGnbGf4BCq3ZYc57OPWK+EDQddhZPMaxnyuuVs6MIJSwuX5cTq0Pdh
 zbHQ==
X-Gm-Message-State: AOJu0Yz0agG/X+EywcoHoN9tTJfe6t3sBH7jzrmPEMXy80GsoLlaNnBj
 PkZiuhRYjp6+7wwouqIhXiSiuw==
X-Google-Smtp-Source: AGHT+IF6g7Yl3/dc1zjXWAla2fmn6VNFRHGjWS9r2ZaLA2wuRMyJIN8xHg8GGOLSUR7UzF4J/crR9Q==
X-Received: by 2002:ac2:4c32:0:b0:506:8d2a:e31f with SMTP id
 u18-20020ac24c32000000b005068d2ae31fmr1547542lfq.46.1697726278644; 
 Thu, 19 Oct 2023 07:37:58 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n15-20020a5d4c4f000000b0032dc24ae625sm4603251wrt.12.2023.10.19.07.37.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 07:37:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C6D5D1FFBB;
 Thu, 19 Oct 2023 15:37:57 +0100 (BST)
References: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Igor Skalkin
 <Igor.Skalkin@opensynergy.com>, Anton Yakovlev
 <Anton.Yakovlev@opensynergy.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Volker =?utf-8?Q?R=C3=BCmelin?=
 <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v12 00/11] Add VIRTIO sound card
Date: Thu, 19 Oct 2023 15:37:17 +0100
In-reply-to: <cover.1697709630.git.manos.pitsidianakis@linaro.org>
Message-ID: <87pm1a8ypm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

> This patch series adds an audio device implementing the recent virtio
> sound spec (1.2) and a corresponding PCI wrapper device.
>
> v12 can be found online at:
>
> https://gitlab.com/epilys/qemu/-/tree/virtio-snd-v12
>
> Ref c660c8427853d90784a89b6f3b0c31e19cc3be95
>
> Main differences with v11 patch series [^v11]:
>
> - Moved devices from hw/virtio under hw/audio.


OK I've tested record and playback and everything seems to be working
fine so have a:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series.

Gerd,

Are you happy to merge?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

