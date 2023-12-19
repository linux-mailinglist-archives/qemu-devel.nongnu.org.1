Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C517F81874A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:21:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFZ5P-00089B-Ua; Tue, 19 Dec 2023 07:20:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFZ5M-000893-6x
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:20:32 -0500
Received: from mail-io1-xd30.google.com ([2607:f8b0:4864:20::d30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFZ5K-0000nT-Cn
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 07:20:31 -0500
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-7b71e389fb2so225141239f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 04:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702988429; x=1703593229;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wQA0RlwSqqyN9Wcw543mwNNgu5OHdx84OKgHRedGrS8=;
 b=htFxD65gqzkeahKkBFl3uRf5Eo361+m2HuuvNF2EJtnUgmrUXTBKZQXcTU3DKDgE9q
 /Bl3MHvW5N74mIpVd5hT15PRWE4/hJ0rC+6X8rBVQmHhOKgJlhzwXUvqitVr0WEVEbw2
 k2Dfaw2ULaVXfv25SBkuxg777PRSVlX9dQJp48q5ozfJkAfr4NtuDmxWFi6b+vdTWACw
 YXOIARpka5VswcrySrxkll8W6GsXNpyIUt2xV3avdPu3kEYVKbL8dJqcp5Bpunvq1xbi
 Sts0JhAxVycbAjAwfQuS581WrHqioo0toMBvdYqj8WLxIOBthAE5sxDWO1SZLyNePeVR
 p1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702988429; x=1703593229;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wQA0RlwSqqyN9Wcw543mwNNgu5OHdx84OKgHRedGrS8=;
 b=r1Ngaex8ojfNfWdOnijxFX5LsVDfdhXBwEjY0uCSeTq9Q3iwFGdybuejA4JDDbc3Vq
 VCXrSjmrSmmalEEOyPsNoT0K2wv0ybl69c7tESqVwms6QDn/eAmQJLOLZ3RzZx0gagvK
 OCB7FfXtbzJFN/HBojXdbjvh3bm3M4y6AT3saCBe69wjkv0NYi18GfvkmGbKl54ljEc9
 QGNBzvZct5hrdI9QYKJfKY7K5cZJriCkEp68SYLq2gBUvwzWRFfJ784eddLvL/0ASmad
 Kflw1oxJ1JPkMYxnMcCLSr1w8sqDnTqs/FxOlp3SdSiptyGvxmeqTGuScqhG7zYfAP1Z
 b1Qg==
X-Gm-Message-State: AOJu0YycJuWxde0f0I5aqoZx0p/27Kiv5Slo5lT+HHiIPdEY21iZk1fg
 vWJFqMDX7L7hqtW4GIaZirrv3A==
X-Google-Smtp-Source: AGHT+IFKfEaAOkSPqk6IsZ6SDxRqyf21egeIRYzz8LW68SmNcxq3Kf4hF2brQKO78npgJtIpDnKX/Q==
X-Received: by 2002:a6b:6105:0:b0:7b6:fc48:46d1 with SMTP id
 v5-20020a6b6105000000b007b6fc4846d1mr21755028iob.12.1702988429230; 
 Tue, 19 Dec 2023 04:20:29 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 b31-20020a631b5f000000b005bdf59618f9sm19014375pgm.69.2023.12.19.04.20.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 04:20:28 -0800 (PST)
Message-ID: <6adff6d2-7c58-4c78-93a5-5a4594a60d27@daynix.com>
Date: Tue, 19 Dec 2023 21:20:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] linux-headers: Update to kernel headers to add
 venus capset
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
 Chen Jiqian <Jiqian.Chen@amd.com>
References: <20231219075320.165227-1-ray.huang@amd.com>
 <20231219075320.165227-2-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-2-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d30;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd30.google.com
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

On 2023/12/19 16:53, Huang Rui wrote:
> Sync up kernel headers to update venus macro till they are merged into
> mainline.

Thanks for sorting things out with the kernel and spec.

> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
> 
> Changes in v6:
> - Venus capset is applied in kernel, so update it in qemu for future use.
> 
> https://lore.kernel.org/lkml/b79dcf75-c9e8-490e-644f-3b97d95f7397@collabora.com/
> https://cgit.freedesktop.org/drm-misc/commit/?id=216d86b9a430f3280e5b631c51e6fd1a7774cfa0
Please include the link to the upstream commit in the commit message.

