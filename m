Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE0281AEF9
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:56:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGCxk-00023o-N5; Thu, 21 Dec 2023 01:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGCxg-00023Y-J2
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:55:16 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rGCxe-0001XV-Kh
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:55:16 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5c66b093b86so1181343a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 22:55:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1703141713; x=1703746513;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CLzY5PdrM7K/wmvGqA4vWKhQk+AYxpxkLmOBtyv7qaE=;
 b=cmSB2R7HyAPXez/SomAIktEHfeuRcoDzBHTSaPZPCdLmvnErdASdUgkaDBbvNQF46I
 QqbHg9b6fQ76NGpnxKQh3UTOnmblr6Ln2nW4xs9pfTb5miYq7oAbNekILJeFN4LYKql2
 FfesyvB9WP5q5cjP5VD/fg1xoyWRt9MRCdRDW/cyO3XDEKLrffA6uqIKFmDqlxRzFkk5
 XmjFf06xLm9PtIdl32anoFvlB/6UWu1LW+3HYpe8dWQ8e/1spClwx2k3cNqjZAMykOB6
 ItAGwSS3bJQhUNFji6smk6gEHiPQcOhozk1JNIc1JX0BHTwkoPMWip6Is+u2NkfkeNIB
 yq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703141713; x=1703746513;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CLzY5PdrM7K/wmvGqA4vWKhQk+AYxpxkLmOBtyv7qaE=;
 b=cpEOxf5zsgm0poYh9tL9sy1PC8yKVrmmx0a64WxGy1LhJHeaEmAJiTlu485Muj9Geh
 6NqtB4Vd5b+ZwB+ZunNVFMconsKTYK1YDUwYi1O0PGpOXWSELJZbWqG831KNhWxm19S+
 QHFJiOcTW9/wGyrqe7HirKwukIsEKz8+JXABk/MOUCJz3+9dvugiuexBXNb+8bRMggUL
 1HyOIOxgUBVoYXCFwfZHcjjTzmJG57bD+gtkamFsa1SuuMXez4np1QPdIvXpVctgwuow
 7tUp/QDf0a1S/9/fCH/EYlruMvFCRhYp3n/R7zQRGvkHNYw5mwliBaQtrJs/X6EMAUvg
 /BdA==
X-Gm-Message-State: AOJu0YzLykYn0bw+KQnYWg5y1g81JzoWJ74eZ3ZELfEfgCVh3E31x5RU
 MOwX0PotUo/d1bq3OEwaOU09yA==
X-Google-Smtp-Source: AGHT+IEbwVl9Gzb6AFc1cuiyAWrCzGB+Iuh7dB4wVutX8k4xc8tuq+dN41LEMJ8tq7KTcYtz+FhJXg==
X-Received: by 2002:a17:90a:cb15:b0:28b:eed2:5990 with SMTP id
 z21-20020a17090acb1500b0028beed25990mr290395pjt.15.1703141712760; 
 Wed, 20 Dec 2023 22:55:12 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a17090a840f00b0028bad9b220fsm954956pjn.37.2023.12.20.22.55.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 22:55:12 -0800 (PST)
Message-ID: <af89f683-2b6e-4ca1-aa37-8bedd12a781d@daynix.com>
Date: Thu, 21 Dec 2023 15:55:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/11] linux-headers: Update to kernel headers to add
 venus capset
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Huang Rui <ray.huang@amd.com>
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
 <20231219075320.165227-2-ray.huang@amd.com>
 <6adff6d2-7c58-4c78-93a5-5a4594a60d27@daynix.com> <ZYGe4GcFPt0k5PTM@amd.com>
 <CAFEAcA_=iedJw4BbNHrDALC4mL4g3ZEihsDbLkEzsy-1zAWFWw@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAFEAcA_=iedJw4BbNHrDALC4mL4g3ZEihsDbLkEzsy-1zAWFWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
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

On 2023/12/19 23:14, Peter Maydell wrote:
> On Tue, 19 Dec 2023 at 13:49, Huang Rui <ray.huang@amd.com> wrote:
>>
>> On Tue, Dec 19, 2023 at 08:20:22PM +0800, Akihiko Odaki wrote:
>>> On 2023/12/19 16:53, Huang Rui wrote:
>>>> Sync up kernel headers to update venus macro till they are merged into
>>>> mainline.
>>>
>>> Thanks for sorting things out with the kernel and spec.
>>>
>>>>
>>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>>> ---
>>>>
>>>> Changes in v6:
>>>> - Venus capset is applied in kernel, so update it in qemu for future use.
>>>>
>>>> https://lore.kernel.org/lkml/b79dcf75-c9e8-490e-644f-3b97d95f7397@collabora.com/
>>>> https://cgit.freedesktop.org/drm-misc/commit/?id=216d86b9a430f3280e5b631c51e6fd1a7774cfa0
>>> Please include the link to the upstream commit in the commit message.
>>
>> So far, it's in drm maintainers' branch not in kernel mainline yet. Do I
>> need to wait it to be merged into kernel mainline?
> 
> For an RFC patchset, no. For patches to be merged into QEMU
> the headers change must be in the kernel mainline, and the
> QEMU commit that updates our copy of the headers must be a
> full-sync done with scripts/update-linux-headers.sh, not a
> manual edit.

Apparently the kernel change is unlikely to be merged to mainline before 
QEMU 9.0 so we need to come up with some idea to deal with this.

The release of Linux 6.7 is near and the development of 6.8 will start 
soon. So it was nice if the change made into 6.8, but unfortunately it 
missed the *probably last* drm-misc tree pull request for 6.8:
https://lore.kernel.org/all/aqpn5miejmkks7pbcfex7b6u63uwsruywxsnr3x5ljs45qatin@nbkkej2elk46/

It will still get into linux-next so we may retrieve headers from 
linux-next. Or we may add the definition to 
hw/display/virtio-gpu-virgl.c; the duplicate definition warning will 
tell when the definition becomes no longer necessary. I'm fine with 
either option.

Regards,
Akihiko Odaki

