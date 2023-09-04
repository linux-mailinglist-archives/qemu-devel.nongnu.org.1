Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4679195D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 16:05:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdACu-0003hP-6u; Mon, 04 Sep 2023 10:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdACg-0003dv-Ai
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdACc-0000ps-PV
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 10:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693836318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8yXzW5tsa1Z7AA7w1SpCuR5NnaYK/F5DG+726b4Q5rE=;
 b=H5TS0ThlbyI0v/RGU7jqHsoiO782bnPhLXO1jvFQ0mCi7zXQtTLW7IXhE0dWvtN1TbQTKR
 +8EGNLsbTTNKi5gWr6XOa4DDCJ+r3+n3lMWkM0ZfhGAE0/U5PWtDaNlZ/0jE1xbtddSePd
 vxtGc97TGgd9M65VRzneM5/lDY8Xh/Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-1OfkhRuyOjixT8F2VccpRw-1; Mon, 04 Sep 2023 10:05:16 -0400
X-MC-Unique: 1OfkhRuyOjixT8F2VccpRw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31aca0c0d63so771094f8f.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 07:05:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693836316; x=1694441116;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8yXzW5tsa1Z7AA7w1SpCuR5NnaYK/F5DG+726b4Q5rE=;
 b=hNw0MZLAKFgaeF84DSw7ri/XwdvUh5qBGxGu1E+QQHmJIauUrUkqfFjJCVCuEViCQz
 QUOkJnt30V8P6KqiPM9AFJccvCk38HW6F2uvmVxSmXgz6bgZ15YzE1qAkbhvBHUIFMah
 xLzd/X2Kj/oOe6n0bpg9Xy12UmvNRRD6ApPMk8u244mUNjfKXj5+Rw7Mb7dVO0Jv8jK6
 e5msBo3q0LKABN0JsrjOaChK9WL22acCpd6EAhT+cg6hllESNfsgwAtEZaeraBI5WCLo
 aYg0fT94tJD/WPcHZUpBucPq0H8bsGRM5rTpcY2cVAdW1KpjtVu6MYcihAycmKDKoZxA
 hAdA==
X-Gm-Message-State: AOJu0YyeykPM4Qeg/gOftBaYaCef8ZTlDBfF181vmZQMPkywlzj//V/d
 ZsWWGa0CmYZePz52qxfSjf6tLPCXyiJPD9BQW6FABWzXr1glUk6tuTlqqSYDfS2SvmIWPNLRRKN
 iDTb54bq3FmicO5A=
X-Received: by 2002:a5d:5227:0:b0:319:8c35:37b with SMTP id
 i7-20020a5d5227000000b003198c35037bmr7331996wra.7.1693836315861; 
 Mon, 04 Sep 2023 07:05:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQhROvQSXScCrAFch8B41xU455eh4h/JpD2nb5bx9tNFY0hzquFjhYyOyThihquIv+yEhZqQ==
X-Received: by 2002:a5d:5227:0:b0:319:8c35:37b with SMTP id
 i7-20020a5d5227000000b003198c35037bmr7331983wra.7.1693836315547; 
 Mon, 04 Sep 2023 07:05:15 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 c17-20020adfe711000000b0031773a8e5c4sm14521712wrm.37.2023.09.04.07.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 07:05:14 -0700 (PDT)
Message-ID: <a3e93076-7aa9-db12-e564-37f66ba31f98@redhat.com>
Date: Mon, 4 Sep 2023 16:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 65/67] ppc/kconfig: make SAM460EX depend on PPC & PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-66-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230830093843.3531473-66-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/30/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau<marcandre.lureau@redhat.com>
> 
> SM501 is going to depend on PIXMAN next.
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   configs/devices/ppc-softmmu/default.mak | 2 +-
>   hw/ppc/Kconfig                          | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/devices/ppc-softmmu/default.mak b/configs/devices/ppc-softmmu/default.mak
> index a887f5438b..603ed701ed 100644
> --- a/configs/devices/ppc-softmmu/default.mak
> +++ b/configs/devices/ppc-softmmu/default.mak
> @@ -8,7 +8,7 @@ CONFIG_PPC440=y
>   CONFIG_VIRTEX=y
>   
>   # For Sam460ex
> -CONFIG_SAM460EX=y
> +#CONFIG_SAM460EX=n

This reminds me that we were planning to move all boards from "default 
n" to "default y", similar to ARM boards.  But for now this is okay.

Paolo


