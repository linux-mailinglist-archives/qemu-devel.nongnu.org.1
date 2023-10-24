Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED677D51C5
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 15:27:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvHLv-0003qo-8K; Tue, 24 Oct 2023 09:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvHK3-0001K9-2W; Tue, 24 Oct 2023 09:19:51 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvHK1-0002ZL-9Z; Tue, 24 Oct 2023 09:19:50 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7b5fd0b7522so1213235241.0; 
 Tue, 24 Oct 2023 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698153587; x=1698758387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8uz4/aKpiq6hPOqfpQF/xQFDhJm3XWJwzBC0Qx2lRx0=;
 b=kTw7HbRzNfINjdmr1RCxN02z2Nz9KTHwqMvCb2Q9K4WIF7MMCvadr5S/qFJZnx7od9
 NWQ9tchp1K1bZUMB9OTRshN0m77RYYyaxqcSKWuMvSg/nfW8jMecZGUPAvDUW/2/89Zr
 XfNkNFGHPKTr0irmD7nlUQUOiZecl2JApgVT4iP1MXjCQ1IzhfdyC1layvOdnv520O4v
 B8XNWCTU8+7yfuYiYPZuf0uTQDGhVD5VSk3EJrjoM4iLUpdm5uSmpu4ZxYy/HGzNnPPj
 8pM97KBziP60fFZiXZy/CG70EBK7lf+EORpSL3OyoOjk/WgSfnl2nZAAFpthWNJwwUNg
 pXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698153587; x=1698758387;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8uz4/aKpiq6hPOqfpQF/xQFDhJm3XWJwzBC0Qx2lRx0=;
 b=I8bHRHt25F+CY2uH3jk5ikPWtvSUfHo2rS4fXTXggFVHfkt80GxgwWodkPpnjC2Usz
 ux7zg4Lcd9IkLC2tdJEkAtd68874VRbf1lkjRuM6onZJQxoF0xrjdmXB6ems3dI14Vhz
 QCsDm2qBB8DbRQvOwzFSl7BXWKsuT/2jnrZyGtbdZphfku2UuTo+a13wxBwvfQmXo28T
 vDE7PQpD2URKXPCYvpr1lj4mYCdnWwk6KMJU4JbbNRzd4iSK8BvKykHrpAZ7FhIKXXZD
 wCaX9nC6GZKFZzD3SbaRo6qhAcYj8rWURMrjzKHQKAFbssSiINd0XWQPxzJLdyEJNDki
 s09A==
X-Gm-Message-State: AOJu0YyqCu7HpdDeH8f/900Nd0MTHuWWuGO6HwFdaYRi10nR+08C7bjM
 9yxqiLkTvrxL1i2tho9/ucY=
X-Google-Smtp-Source: AGHT+IGnWoo4jNnLB6831fFx3CoKgHFT0A9Kla2MaDjWE9V1b5hkBs1aVIykQqV5tvtiP+hHD7VG/Q==
X-Received: by 2002:a05:6122:243:b0:4a0:8a35:6686 with SMTP id
 t3-20020a056122024300b004a08a356686mr7068725vko.11.1698153586115; 
 Tue, 24 Oct 2023 06:19:46 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 f7-20020ac5c9a7000000b0049d6e5e8610sm1109415vkm.19.2023.10.24.06.19.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 06:19:45 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <8f51963a-1875-4f11-939e-e7b6c7429da5@xen.org>
Date: Tue, 24 Oct 2023 14:19:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] hw/xen: do not repeatedly try to create a failing
 backend device
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
 <20231016151909.22133-9-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-9-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=xadimgnik@gmail.com; helo=mail-ua1-x932.google.com
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
> If xen_backend_device_create() fails to instantiate a device, the XenBus
> code will just keep trying over and over again each time the bus is
> re-enumerated, as long as the backend appears online and in
> XenbusStateInitialising.
> 
> The only thing which prevents the XenBus code from recreating duplicates
> of devices which already exist, is the fact that xen_device_realize()
> sets the backend state to XenbusStateInitWait. If the attempt to create
> the device doesn't get *that* far, that's when it will keep getting
> retried.
> 
> My first thought was to handle errors by setting the backend state to
> XenbusStateClosed, but that doesn't work for XenConsole which wants to
> *ignore* any device of type != "ioemu" completely.
> 
> So, make xen_backend_device_create() *keep* the XenBackendInstance for a
> failed device, and provide a new xen_backend_exists() function to allow
> xen_bus_type_enumerate() to check whether one already exists before
> creating a new one.
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/xen/xen-backend.c         | 27 +++++++++++++++++++++------
>   hw/xen/xen-bus.c             |  3 ++-
>   include/hw/xen/xen-backend.h |  1 +
>   3 files changed, 24 insertions(+), 7 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


