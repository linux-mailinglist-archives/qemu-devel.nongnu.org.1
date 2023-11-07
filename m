Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E21157E48E9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:01:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RJw-0006A3-4z; Tue, 07 Nov 2023 14:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0RJt-00069T-A0
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:01:01 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0RJr-0004Ek-RX
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:01:01 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso947153266b.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 11:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699383658; x=1699988458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vuIo8mSUE+R7JNX64+WxpW3b0VRfxag/npZt3c1J3eY=;
 b=jVF4g5jZJDZMLKuiJ1l3bvsiKdRs4A3MOfRHEJpgBS7hzt6QRzsN8GZrAB1o4hlmCo
 cuEoiq2MpsfRKxWa8c3T+odhSWDxSMVtmRmKW2yvTkFb2nWtjT1h8bm3mPXbDog0ZCgk
 hx6dzduo7Z+i4R+wLIoEzkLYfLgNUJs2PRkhB7hMy8XMG5mSI6Eg1xpNDOX79StQdtAW
 GreN9nw/EUekqUWdVaClTY/QKhgvZ/BeCZSisLnSXa1JYTI84vqIHNPbk69K2iilBoq8
 KbK2E9Kqt8U3n3FD2Vh1hAv8v1FtYUwewouj9nGXe9FGzll3uFpoB4FsMQpz1i1LTxnY
 Ldgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699383658; x=1699988458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuIo8mSUE+R7JNX64+WxpW3b0VRfxag/npZt3c1J3eY=;
 b=cr2Ctss1hGdvokulbTRKba8o98uzDhUwedmKuB8LyFiOMNwOnh/dnQp5db2LHorxpx
 oWCTjuJfyJDoVWoNePEQAX4+QO1s9UuK9xh2dCtZSRA5ZY/Y5wwkTPQFn4OKOIJcPZ0u
 2oGrMr6DFE6LMH2er7ivoitp6yjR4TY/Pyu3rVS8ECh0mv1k45kX4dltzrEwYHYDl1Hq
 6/Dx1eO24BVuLV6v1cOU+kzEtnqYbSrImYbXHfb6GThNgmN9ZxlsklpgD6bbYIGX2yLA
 0R+7o5aiXs9pNTaAUB0Fdkzj+hsloLPiQ+nH7kkLZG8LDm855QbpybxTbDIpYm1Sa+Zf
 gPdg==
X-Gm-Message-State: AOJu0Yy1uIs+rq5un3ziW6j863eOfltwmjabNWxHPbV7rBpVp+Wv9BNJ
 Wb16/Jd0s65Up8Z4iPg3uw/1OA==
X-Google-Smtp-Source: AGHT+IHmWPQoLlHVt0gXOqcsfMZXJ+II790iruttP2Q/PTuIO4RFGVdvf2uQFYcj5jTcuC6ntygNNA==
X-Received: by 2002:a17:907:2d8b:b0:9d2:9dbe:a2f9 with SMTP id
 gt11-20020a1709072d8b00b009d29dbea2f9mr17816146ejc.50.1699383658234; 
 Tue, 07 Nov 2023 11:00:58 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 a25-20020a17090680d900b009a1a5a7ebacsm1344023ejx.201.2023.11.07.11.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 11:00:57 -0800 (PST)
Message-ID: <3ac31376-2f58-423d-b173-57f2a30f2795@linaro.org>
Date: Tue, 7 Nov 2023 20:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] docs/system: add a basic enumeration of vhost-user
 devices
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, virtio-fs@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>
References: <20231107180752.3458672-1-alex.bennee@linaro.org>
 <20231107180752.3458672-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231107180752.3458672-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/11/23 19:07, Alex Bennée wrote:
> Make it clear the vhost-user-device is intended for expert use only.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v5
>    - split vhost-user-device out of the table
>    - sort the table alphabetically
>    - add sound and scmi devices
> v6
>    - add note re vhost-user-device
> v7
>    - fix patching description
> ---
>   docs/system/devices/vhost-user-rng.rst |  2 +
>   docs/system/devices/vhost-user.rst     | 70 +++++++++++++++++++++++++-
>   2 files changed, 71 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


