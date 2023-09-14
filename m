Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 154727A019F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjWN-0007oJ-Pp; Thu, 14 Sep 2023 06:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qgjWM-0007o5-3N
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qgjWK-0002I6-PS
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694687063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hNAE41tWAaXLhaoVtG6wrRtiDEAUXhu3VZpI1JNzG+E=;
 b=DO5RCGzFAvcLXm8XoxIAianAz2Z7bzfjLE2RAtcTIxKIK5shc1/dtq05qdzUvCymlJyAkc
 EA1MqnpH1z/m+hcouTyFhtekfqwdT9BxmVwvelSiKDxOYJqC0iOqihWgcg6MewPrzYqBGi
 LDK2HHi6w1OD/gB7Xo3RpY02iONZq9w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-hyKAMkPPN-uwGCJ5OmheUw-1; Thu, 14 Sep 2023 06:24:22 -0400
X-MC-Unique: hyKAMkPPN-uwGCJ5OmheUw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so6082435e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 03:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694687061; x=1695291861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hNAE41tWAaXLhaoVtG6wrRtiDEAUXhu3VZpI1JNzG+E=;
 b=tcwtJS2CiKByliiwyiA57+YE2r6dcME/10SD0Erv6uWq/IWxiohKG9WexE40fC5Q4A
 o0uF5b45YVg5TvjVAA3QNpcND41eDBfPB4zjJtRD9rex/AyS1UrQgadYo8qN36pD+ZJq
 23EYz0Ih7ytE0T4CDesatmw2pnEMgWajo4d3TRjDXCNDuKlmPiK19xGO3Ug01K0x2/7M
 xpQYBqkzrkkgOf1bvFOgDqMaQrAzGpGyQRkmxo0fD538+XbsaUK6fQn3V5pdIi7bj4mJ
 FNF18CGn4Ouyn/wRvFyFmaoRq0fzC+blu1Q2IvRLKDkxtGRDoJMxNL+suc53IdBVyIQl
 ZYcw==
X-Gm-Message-State: AOJu0YyUqq/buWttMu4KQCp0sPIw4G/AMU6C8TSygBq7I5BLGLPPWlU2
 iNdfG173kGGln9i18z15t3cBge63GlN4qv/stava09NjDploPBYp6+DmaA9dunttVFUPdedmVsi
 T208VFp7Hyzp/yrc=
X-Received: by 2002:a7b:cb97:0:b0:3ff:233f:2cfb with SMTP id
 m23-20020a7bcb97000000b003ff233f2cfbmr4275240wmi.23.1694687061109; 
 Thu, 14 Sep 2023 03:24:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcAXSjLqT/2AypFaYEHCnobYEG9sTWcdyr04qSbjgEameO5wJK+EsPMsD/358/pyy1y31+Ng==
X-Received: by 2002:a7b:cb97:0:b0:3ff:233f:2cfb with SMTP id
 m23-20020a7bcb97000000b003ff233f2cfbmr4275215wmi.23.1694687060804; 
 Thu, 14 Sep 2023 03:24:20 -0700 (PDT)
Received: from sgarzare-redhat ([46.222.148.29])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a7bcc86000000b003fbdbd0a7desm4377973wma.27.2023.09.14.03.24.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 03:24:20 -0700 (PDT)
Date: Thu, 14 Sep 2023 12:24:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>, 
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?=  <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Volker =?utf-8?B?UsO8?= melin <vr_qemu@t-online.de>, 
 =?utf-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6E=?= n <DirtY.iCE.hu@gmail.com>,
 Alex =?utf-8?B?QmVubsOp?= e <alex.bennee@linaro.org>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Subject: Re: [PATCH v9 00/12] Add VIRTIO sound card
Message-ID: <udfmt4up4fjf5optfrl3242zakngwfwrti7dok6h4ejenvesaq@korfb3dd4nts>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
 <2gm4wkfnjopd7l5zvzepzknl4hfomkxvtgvw72daazne2n34wy@fgqmh3mi3r5l>
 <0yzxl.gd0zk711fja@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0yzxl.gd0zk711fja@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 14, 2023 at 01:02:05PM +0300, Manos Pitsidianakis wrote:
>On Thu, 14 Sep 2023 12:54, Stefano Garzarella <sgarzare@redhat.com> wrote:
>>We are seeing something strange with the virtio-sound Linux driver.
>>It seems that the driver modifies the buffers after exposing them to
>>the device via the avail ring.
>
>I need more information about this bug. What is the unexpected 
>behavior that made you find that the buffer was modified in the first 
>place?

CCing Matias for more details, but initially can you just run the test
Matias suggested to check if you experience the same behaviour or not?

Stefano


