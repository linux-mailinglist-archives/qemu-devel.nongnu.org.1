Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D881AE9B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:04:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGC9v-0005k2-1b; Thu, 21 Dec 2023 01:03:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGC9r-0005jS-Sn
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:03:48 -0500
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGC9h-0007Xv-RX
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:03:47 -0500
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-593ea4c2baaso326171eaf.3
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 22:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703138616; x=1703743416;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fHToyja4NOHxEQaCqApSgLT7a7lMQLL0/3uq9tFGO2I=;
 b=LBB9x4Bs60ViS+XtOPe9E5eplgpxK9B8qY5rk1nUVSBfDTl13wxMM6RR/NfqF5KbUI
 j93YVDdjm3D63GwTUgVhUw5hgIwFa/K6bC16C7B3ixzPXk71ELMauZmYgbxscrcc+mdd
 Nagd1j1lDdYUnd6nzPnJ15LWiH4orrzhH2Y/oQ/nRWVmj2DklT7RPtM3oD+VJF4B++ki
 4XM2m3OJTPvAliSH/ed6DJ0bcHt9um7leiaCzLRf5NGSUFHZDGGQWOnxu3sgXMLLgRXH
 DZDTEIW63uc6Tf8wT97wCv4db9Qj93knPfn+774xAC+qV0yeEfV1VeEwzOFoyk2nzaiW
 fFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703138616; x=1703743416;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fHToyja4NOHxEQaCqApSgLT7a7lMQLL0/3uq9tFGO2I=;
 b=JRELKecOw1puv1Gro6RiD3e5iQXKjxvZIhl7dQk9v4ugCDaBXJpIJN/Kfp0vkU2ifG
 HpRiwuwR4wPcMSpsm1zS8E1RwC//+owhRUUcGnU5hW97jn+6LTVh681CHqX06FLaOg0s
 km5hSSGroZnkG5Zb+4obJdqmbydJZdD/jgNL1hzeShzWYfNFATZzWQooBVPcT+tS3Ra/
 NmsDHrnebhlC7MwizHRUitOmwxC0200B4APrE/c4+o+YfYtT4UVEKtKy7WaLom09+pNX
 N6W/765Ip90GsG1aShVi4QKhjR9/XUzbSkcCPilK9ycCXI+X4Cq9CeIs4i9TbKI6bCzh
 S0RQ==
X-Gm-Message-State: AOJu0Yz/Fusa2uVkeOU28EYYN7a4TQh0pf3GzCcxhq7KQ1KK90JByLOq
 aHBKAw0tc1RchPPjp4tLQcnl2w==
X-Google-Smtp-Source: AGHT+IEMQ5PuC83SBrlBqTQNw0uBmtZ5FakIl34HWWckWSPLVEFbAQ9LAiZ5cJX3NGm7MZHHgdpsTw==
X-Received: by 2002:a05:6359:45a1:b0:170:2c94:31c8 with SMTP id
 no33-20020a05635945a100b001702c9431c8mr666680rwb.47.1703138616039; 
 Wed, 20 Dec 2023 22:03:36 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 h16-20020a635310000000b005c200d6486asm792604pgb.72.2023.12.20.22.03.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 22:03:35 -0800 (PST)
Message-ID: <14c9ad8c-512d-4fd4-ae63-5a44d7565a01@daynix.com>
Date: Thu, 21 Dec 2023 15:03:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/11] virtio-gpu: Resource UUID
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, ernunes@redhat.com,
 Alyssa Ross <hi@alyssa.is>, =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
 <roger.pau@citrix.com>, Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>,
 Antonio Caggiano <antonio.caggiano@collabora.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-9-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-9-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/12/19 16:53, Huang Rui wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Enable resource UUID feature and implement command resource assign UUID.
> This is done by introducing a hash table to map resource IDs to their
> UUIDs.

What about putting QemuUUID in struct virtio_gpu_simple_resource?

