Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D77C70EF2F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 09:16:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ij5-0005Vy-4C; Wed, 24 May 2023 03:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1iiz-0005Um-S2
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:15:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1iix-0004yg-8Z
 for qemu-devel@nongnu.org; Wed, 24 May 2023 03:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684912554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O0Jl4I42wTiEXaQvx1QlXI5DvYmqiRqhscvnsxY1ShE=;
 b=X8rxKr+y+ilG+/OxmY15+P7ye9vn66eGq2zi0ZU/h7SCquOI7lKdTMctJDZOTVpaGBcrdk
 G07iRaHb5Qhxek+eGBGtp8RS4OFmFsEHUQugNZJKO7K4QVUcL28wr/JRHZWEFxpfCc7kJk
 IMDBTxCXugWylmDA/EJxCqL7SL6lNFY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-u0_zVsLWP7Owm-HClwfsJg-1; Wed, 24 May 2023 03:15:53 -0400
X-MC-Unique: u0_zVsLWP7Owm-HClwfsJg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-513e916ed47so700484a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 00:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684912552; x=1687504552;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O0Jl4I42wTiEXaQvx1QlXI5DvYmqiRqhscvnsxY1ShE=;
 b=RvxIrpfD2x4TLsP+RjbbdiTk2muSheWZYNWQz+J8YAqv879Uqjd8p7DFVF/8ga496x
 qWEx0CbJT6rOJ4Tpcy2bXJSA/PZ8rrC3Mx/29Gmc9zTXEm0lwIPcShQcVT8wwvFF5bk2
 LWuuXme/hrtoCOH0IcgamkpfpEQoIqCHGYzFs2dA64fe3G8G1dmDu7hhoLt1FFvIsVuQ
 Xe5ifbo7nMTutVigKgIlhuw9CXHpwaf5StOrFC79KCVDU488aq6l1KY7nha3ul3ZfNsc
 fBK7K6/1heJOuR23b3PUx5Aj7hRRGS8nRxmJEAzEgEIcrQf031U+C8LTZFZ96nd0v5EU
 vuCQ==
X-Gm-Message-State: AC+VfDxjhV9spcrOFgwEa0I3DFgSLT8mgXfuWWXph56n3CNrFEwPmavp
 NaimSwKZGx/XqCqWkiAxI0hxTul8aO/L5lMdmx3vi3f2EKNx0EYm89jriftY7Yu7WnOoH3OMRSh
 FID2oCK+l+oQ/JiA=
X-Received: by 2002:a17:907:6e92:b0:96a:3811:f589 with SMTP id
 sh18-20020a1709076e9200b0096a3811f589mr19786044ejc.10.1684912551971; 
 Wed, 24 May 2023 00:15:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4vnMNmvmKyNSZJmfwJ2zCwsKqFMdDEVZjdMfDupX2lmVq3GdzXwBgAfL+lNBFj3LRYkeOulg==
X-Received: by 2002:a17:907:6e92:b0:96a:3811:f589 with SMTP id
 sh18-20020a1709076e9200b0096a3811f589mr19786006ejc.10.1684912551731; 
 Wed, 24 May 2023 00:15:51 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 16-20020a170906101000b00965ffb8407asm5285025ejm.87.2023.05.24.00.15.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 00:15:51 -0700 (PDT)
Message-ID: <bdc94162-f9bc-89bf-0b33-7b286de02b49@redhat.com>
Date: Wed, 24 May 2023 09:15:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 05/11] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol in
 Kconfig
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-6-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230523163600.83391-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/05/2023 18.35, Philippe Mathieu-Daudé wrote:
> Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
> and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
> selected by both symbols.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/virtio/Kconfig     | 6 ++++++
>   hw/virtio/meson.build | 5 +++--
>   2 files changed, 9 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


