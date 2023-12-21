Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B581B007
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:10:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGE7J-0001E0-Ai; Thu, 21 Dec 2023 03:09:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGE7H-0001Dm-LQ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:09:15 -0500
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGE7F-00042u-Vi
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:09:15 -0500
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-7b798e6f702so21396839f.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703146152; x=1703750952;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DFHtdbRBuHxh3sdDGxLPtxB6dXV5w1hZThhsj1oHuv8=;
 b=y7xr+RjCJRdPsepQsgzIxkJEIN6idOdt28G2Fot1mIEzRAgN+uKn14AHCbyu42+FVW
 lrX9GiHVoeIU3lfgoF571UQwc3Ps+y6SsSD18VF88Jv4kRzcCJua2gFmmKJF9KezfQQ+
 l+ukUgJb0QdtgDkUum5QN9/d/d5szK4BXPRVocrb4TInlpFP1+yVF6uLAZBpvFiT5TOr
 ltTIISERP7Nprjo/UttYd2MWWRZxpZYhtMM8zLMGm6TQX3fLz5f2RZwY+EIJyMNp7NYB
 OEos4FGDjXiyso0WzR4K+swaIzhqEiw4Vv3HPi2klV3WjmGsRJcbWYd2kjmC6+KXqHwH
 dQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703146152; x=1703750952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DFHtdbRBuHxh3sdDGxLPtxB6dXV5w1hZThhsj1oHuv8=;
 b=f+Wf5coPASMIqY3JjpbWT2idWMRb5fqyTpvncUy0jD2opskt510ADRucue9lbDgZso
 0OfcgvpyvdfjX/glQugaubqfFEtZDhbz4S/LvrFs0JJAqbHa0UbtZCJW04BKDE+ziBkI
 a6jX1F0ALkVg75GOLIPNTupPTVFVsE6on9IZY4mWYAsBfj7LSmNaDPINdHniAPqQNkPL
 Mh8y6ayfExklT414KD0sALeWEDZqV8+QDLCfOsxYYaHEQfz/hsVVHHMHzEfA0y+Kmdf8
 todHGleT9TLN+2R0f3d8QmdkPR91bXVL3bf+IPW3hMfAODfLIHrw2hg8l53IK06h73eY
 gsiQ==
X-Gm-Message-State: AOJu0YxNjb1ka1XqIET1cSoPdB2FkWp+bd5JnnOTbNNsdjZ62q7lBL/h
 BsBnsO1YsuCZCXRo4XwE5+mRgA==
X-Google-Smtp-Source: AGHT+IH9uE0kFetV0w0R6EKXS4SOYT/kfgC5SWiE3cSPeQAb9GdRshpM1twXSmGc4zg3gIC8XAqDeQ==
X-Received: by 2002:a05:6602:24c9:b0:7b7:5eeb:615e with SMTP id
 h9-20020a05660224c900b007b75eeb615emr19879747ioe.6.1703146152450; 
 Thu, 21 Dec 2023 00:09:12 -0800 (PST)
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a634d19000000b005c6617b52e6sm1004679pgb.5.2023.12.21.00.09.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 00:09:12 -0800 (PST)
Message-ID: <0d08a014-cdf5-4b4f-a683-171ae4c8b6e0@daynix.com>
Date: Thu, 21 Dec 2023 17:09:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/11] virtio-gpu: Handle resource blob commands
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
 <20231219075320.165227-8-ray.huang@amd.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231219075320.165227-8-ray.huang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d29;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd29.google.com
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
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Support BLOB resources creation, mapping and unmapping by calling the
> new stable virglrenderer 0.10 interface. Only enabled when available and
> via the blob config. E.g. -device virtio-vga-gl,blob=true

I have another concern about delaying virgl_renderer_resource_unref() 
until the resource gets unmapped; the guest will expect the resource ID 
will be available for a new resource immediately after 
VIRTIO_GPU_CMD_RESOURCE_UNREF, but it will break the assumption and may 
corrupt things.

