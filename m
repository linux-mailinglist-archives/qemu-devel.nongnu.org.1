Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC607D5021
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 14:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvGjo-0008Hz-A5; Tue, 24 Oct 2023 08:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGjn-0008Hn-2P; Tue, 24 Oct 2023 08:42:23 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvGjl-0001HI-HB; Tue, 24 Oct 2023 08:42:22 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2c50906f941so67157361fa.2; 
 Tue, 24 Oct 2023 05:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698151339; x=1698756139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nleuh30f60jeiNJDPgerM6LHIyJSmfHjZNXbgUudLV0=;
 b=biAh4SEIQv1g1xRv7EkFWiJDYkh7YUbegozeYA7/OmX/tiHu9uPRSTpCu35jAFu02x
 Oy7emLc/HaLv6Np+wPIvUVgGv5M3FCPB8XNet5e1h48u0BtNgKAVoMUBrIzUr2eI/KCU
 LVM7/cHXnjt/wAdLcp3z9oBcuHXClYGgYqswQc5GPmZ/tE7YGak/kosLiOTdmO4PDaiB
 A93VxAR67xorSQ922qag53CeAlgwXVrgHK71yKRdkji1IUf8VGZ6lgdVsvaxnhGU+uGL
 rapwBnqkIbrGD7zDFbvWpaEgV1mL/3LnsLozE62h7LsOJqvDRyEvUAKoK/qlsEiU/MY1
 TPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698151339; x=1698756139;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nleuh30f60jeiNJDPgerM6LHIyJSmfHjZNXbgUudLV0=;
 b=I9VvyKpT4GlCCoSwgnEnc2uOw0ou/Umz2P2WR1oRrO/xvHDrD6PGvRlAMb3z+wQe99
 UPgv2hAgMoTqWnY4sKTqcdjd79vAtgLxpMb5mTcxUQNxA2vstw61XsbtGjvdV1qiJUaJ
 UiRAKJlSiybM1X0uFqydn5NAA6Cm9XNxJBZqnbRGuiOc2Eb1d7/uD7NmX49dC0fDAa+2
 jKNi8Ql/KdHtfyr/E1RtLi/+ZO+tBy7LOF6vXMRMHB8JmIYiGdNFM8AydmckqJ0FXMkb
 LiTjtG4iOySxppNXyiHJoZtQYt/cRuyoxBvGsAa1/+hXJ061iZz9QE1afLDdhQZtr/Ix
 ZNIg==
X-Gm-Message-State: AOJu0YzVF9SNzlQ+OyJ8UbtrRGRVWik3ZmAvY4URNegsY7I4U8veYKSs
 m6Qa7iSQjsoQvhG+FKmu3hA=
X-Google-Smtp-Source: AGHT+IG7xfJEIBpaao1AVHuot+7nF+K9gT+jAPeV2BLTz6q/or9dTrt+5Pf96dJ2k8c2f9XmlagJlQ==
X-Received: by 2002:a2e:aa28:0:b0:2be:54b4:ff90 with SMTP id
 bf40-20020a2eaa28000000b002be54b4ff90mr7826766ljb.53.1698151339104; 
 Tue, 24 Oct 2023 05:42:19 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-230.amazon.com. [54.240.197.230])
 by smtp.gmail.com with ESMTPSA id
 r9-20020a05600c320900b0040644e699a0sm16610990wmp.45.2023.10.24.05.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 05:42:18 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <5ef43a7c-e535-496d-8a14-bccbadab3bc0@xen.org>
Date: Tue, 24 Oct 2023 13:42:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] hw/xen: add get_frontend_path() method to
 XenDeviceClass
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-7-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-7-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x231.google.com
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

On 16/10/2023 16:19, David Woodhouse wrote:
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
>   hw/xen/xen-bus.c         | 10 +++++++++-
>   include/hw/xen/xen-bus.h |  2 ++
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
> index ece8ec40cd..cc524ed92c 100644
> --- a/hw/xen/xen-bus.c
> +++ b/hw/xen/xen-bus.c
> @@ -711,8 +711,16 @@ static void xen_device_frontend_create(XenDevice *xendev, Error **errp)
>   {
>       ERRP_GUARD();
>       XenBus *xenbus = XEN_BUS(qdev_get_parent_bus(DEVICE(xendev)));
> +    XenDeviceClass *xendev_class = XEN_DEVICE_GET_CLASS(xendev);
>   
> -    xendev->frontend_path = xen_device_get_frontend_path(xendev);
> +    if (xendev_class->get_frontend_path) {
> +        xendev->frontend_path = xendev_class->get_frontend_path(xendev, errp);
> +        if (!xendev->frontend_path) {
> +            return;

I think you need to update errp here to note that you are failing to 
create the frontend.

   Paul



