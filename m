Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB17D7D8FE6
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHKA-0000Zh-Ex; Fri, 27 Oct 2023 03:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHK5-0000Xm-4r; Fri, 27 Oct 2023 03:32:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHK3-0006Ax-G0; Fri, 27 Oct 2023 03:32:00 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40859c466efso13535775e9.3; 
 Fri, 27 Oct 2023 00:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698391917; x=1698996717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=3WQCodtLeMa/vLM2901WzSloIhFtxV+9ehL3oSRrzfA=;
 b=VDr3XTosWK2VTzq/BFziHmfYtQM7ZEM8PI2DCT3d2fxgPpXxHfKj2KX9qWIvEVGRJC
 hNt8ykShSf9X8UgeRaxai2wVaxIDjictwfRtauBJ2gLc3BFKzdwz9FYsil4dP6tNTUqD
 plUn6usC6HuM3x2/2bFq+ZiIpsi9dKwA4UMtseQwsYiROgfIQkqo/8kLnBSNifvrFqkQ
 iQLl4inW0BkRH4C5uz93LptmX6oWgloGPmdyPumFof12QH0pv8kbI9F++EeMjph3Rbnu
 u1uI29IVoxCm2uIv4fOYZT7eYNfnJKVyeqAuBppN3p9QFZFIFkgkB2N+AfVnM8/fTWbi
 Jz0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698391917; x=1698996717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WQCodtLeMa/vLM2901WzSloIhFtxV+9ehL3oSRrzfA=;
 b=kNXz3YWpRAfxGvX+iBbtFRwel+Z4h2iZ/b7zPgbdlolY1Qo9LtK33NQOnZl7hdgOTQ
 5KdcT+rpHJvYflT5E00KTcA7tDLe5Ml6K6dcAjAziHPT7SFVeHutEk+wBiwUMdAicQzK
 QsHm/GPrlSTTuoRJVeI8DUf8QZIGDH/nJ+vWRnRXxcr0XYypvmuL1yC8DZ4Ck/yCxzGa
 QRETg+uGkUyUqhPLM6JwEc+OgonrgGMnMNOmyvYJ0oZJdsTTNA8Soe/uRGuEZOk3RVEO
 PLEjnTrjhEBuJlUptmTVExkcRhYhGmcjTpaPHVECZa9siy9XszMO2Ju/aOVhO5kpuf/p
 /e1w==
X-Gm-Message-State: AOJu0Yz9PhLjcNhwS3qm5RWI4+v8jHXXN5vZUBV57iAnt9gytoHb/rii
 pmEObEAYbtJFw5/ANx3rPTo=
X-Google-Smtp-Source: AGHT+IEMg/Tnlu8eq0BMbhOEZDo19OPcdSvp2reFdXjF66hF1stq7Cv3VhULPpUY2sBAaCOfyGVFVg==
X-Received: by 2002:a05:600c:2206:b0:409:295:9c6e with SMTP id
 z6-20020a05600c220600b0040902959c6emr1557480wml.30.1698391917503; 
 Fri, 27 Oct 2023 00:31:57 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-227.amazon.com. [54.240.197.227])
 by smtp.gmail.com with ESMTPSA id
 iv8-20020a05600c548800b003fefaf299b6sm929618wmb.38.2023.10.27.00.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:31:57 -0700 (PDT)
Message-ID: <72d847b6-1031-48fd-8155-1cd441f37f8e@gmail.com>
Date: Fri, 27 Oct 2023 08:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/28] hw/xen: add get_frontend_path() method to
 XenDeviceClass
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-15-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-15-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The primary Xen console is special. The guest's side is set up for it by
> the toolstack automatically and not by the standard PV init sequence.
> 
> Accordingly, its *frontend* doesn't appear in …/device/console/0 either;
> instead it appears under …/console in the guest's XenStore node.
> 
> To allow the Xen console driver to override the frontend path for the
> primary console, add a method to the XenDeviceClass which can be used
> instead of the standard xen_device_get_frontend_path()
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-bus.c         | 11 ++++++++++-
>   include/hw/xen/xen-bus.h |  2 ++
>   2 files changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


