Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C7E81AE7E
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 06:45:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGBqY-0001qH-Gc; Thu, 21 Dec 2023 00:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGBqV-0001q9-Cs
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 00:43:47 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGBqT-0005fU-Ot
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 00:43:47 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5bdb0be3591so334130a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 21:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703137423; x=1703742223;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Sg4XTORipdMJilZwtaZ1foO2eUm0Kr7Yfx7emFr720=;
 b=VIouFOJT7jMSjXR15m1aQMRoaNEQ7aYy/XdtUAoNq2lpexPbX60PvHZmGASfsZqWz1
 7iSc69ZrFZwMFc5mhcOKTYyFE3HHkV2CqmkwKgozjHIz0h60DXL0UDhVIx1CbzZx6aaY
 G9ocRMzkIjXestUIkB6mMR7Q5PvXQ/wviETdciH5Bo042BztjiyWSyXEPgSJUJJxZw8v
 rJEomC5S5kGDtBcPzab8NHnQSGLEFA5mnXhayo4+AJ8WspTCUCvv6GHTLrmde+7RqpBr
 4CYxcByhpyHjuLI1VvwvMBffTNMJQW1aWn/tX2YvhRznSNNTMpW0uwBv5SdKCz0ktPe6
 CRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703137423; x=1703742223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8Sg4XTORipdMJilZwtaZ1foO2eUm0Kr7Yfx7emFr720=;
 b=PBcPtEA4m7HzVrI2cOhXSsf0Bzp/SZ8KLUxIJc019Z11RMX0Ay/a2U7WPLX33yPCHm
 mwW8Lkn8rgr2XXOGV+mYI6LmNdvUpxUETomJ9s1UP/LJzEd8oX0012MLJuxZOJtYqrkK
 ThG1W3DOa9btp6gyrmbK6ppK+0BMMvySP0x86IRG/4KTZG02cdKDojUzoxpTcvmfWBMH
 odyV4gnVzD29/TWiOjhxK4fhSlGu7tCLhuZUwn2PgBgL9DGuKz7DesZSjggTn8z2zNPg
 IBIgkjjjeAU+poaz+uncPLsZAfiTEjehmrvWntN4Cd9geYqZU0GGNBvL0nh2MQyin4KH
 FjbQ==
X-Gm-Message-State: AOJu0Yy2ajm3vFFGhJoa7t0BBDAKYhStX5F1O4cJeRuiXZoNJhyTHA5I
 mKTB5QBAokbjKP2xPqXh2Z65NA==
X-Google-Smtp-Source: AGHT+IEIyTgUa9cBQ6ZLv2LyJbVU+SrLut2YfLaDggNwHO+ruZ5n7whxbib9TSEle6uK/7uxaE7klQ==
X-Received: by 2002:a05:6a20:2452:b0:194:cf29:1ca0 with SMTP id
 t18-20020a056a20245200b00194cf291ca0mr1050217pzc.93.1703137423445; 
 Wed, 20 Dec 2023 21:43:43 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 p14-20020aa7860e000000b006d7051f1fa4sm692309pfn.102.2023.12.20.21.43.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 21:43:43 -0800 (PST)
Message-ID: <c5d9e074-de7c-4056-becc-8fd1ce24f3e4@daynix.com>
Date: Thu, 21 Dec 2023 14:43:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] virtio-gpu: Introduce virgl_gpu_resource
 structure
Content-Language: en-US
To: Huang Rui <ray.huang@amd.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 "ernunes@redhat.com" <ernunes@redhat.com>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Stabellini, Stefano" <stefano.stabellini@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>,
 "Zhang, Julia" <Julia.Zhang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-6-ray.huang@amd.com>
 <3105531c-bfc4-4421-a197-4ab8ddb9f4a5@daynix.com> <ZYGaWs6OmZpaMH46@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZYGaWs6OmZpaMH46@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/19 22:27, Huang Rui wrote:
> On Tue, Dec 19, 2023 at 08:35:27PM +0800, Akihiko Odaki wrote:
>> On 2023/12/19 16:53, Huang Rui wrote:
>>> Introduce a new virgl_gpu_resource data structure and helper functions
>>> for virgl. It's used to add new member which is specific for virgl in
>>> following patches of blob memory support.
>>
>> The name is ambigious. It should tell that it's specific for virgl.
> 
> How about "virgl_resource" which inherits virtio_gpu_simple_resource? But
> this name is exactly same with the name in virglrenderer.

You can prefix it with virtio_gpu_virgl as virtio_gpu_virgl_init() and 
other functions do.

Regards,
Akihiko Odaki

