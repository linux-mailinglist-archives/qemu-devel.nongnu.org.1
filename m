Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B679D2EF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 15:55:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg3rT-0001ZD-3z; Tue, 12 Sep 2023 09:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg3rH-0001Yu-Bb
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qg3rF-0007HC-52
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 09:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694526908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HWSywQOyXhs+lRTIP8jscfp8x9Qky+DgnTbreZ66TAw=;
 b=ETqq468hH/mbucS76nTmLQg6b9GzzRizLW0YS/MDWE+xx09vJ/WQUy+XhkdRxULPjimu/f
 75CDliM5zGswjP+7WmZN6QqHJ95E1kJxk2noh0YaN7viBVoLHy0DdNewDqZz2/aodSk6Gf
 43sK7bHLR7e2OkmwxX3LSrUZP3evMeQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-RxumfD5wPI-rXXzgLa_eKg-1; Tue, 12 Sep 2023 09:55:06 -0400
X-MC-Unique: RxumfD5wPI-rXXzgLa_eKg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401b8089339so42048285e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 06:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694526905; x=1695131705;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWSywQOyXhs+lRTIP8jscfp8x9Qky+DgnTbreZ66TAw=;
 b=xI7SC3RylXj1Jz8zw4NxrBTxOH92A29eo+sN2hMubQO3w85P6P7kbm3MDxwXSEo4UU
 5NPltv//D7zjHnCHHAPfDkcGYq/iixp70+WKqygq4zhe2e4g86zWSh1kOKLhElMhHw0C
 YjaHI7wpcGJm/DuH1QD/YIvSVlylZ1m60OeA6YIj4ITz9ndsO2siUbFkUfve1bRZzIDa
 +KC3AoI0venU7MDvun0Bes2xwdsJdDNuPQppdCmeddbvPmKre5e3vr6I4jdQ4OQaxgqJ
 NpeLfcO6hFY+L31M96/NzEj/BYl2b9YXHfWZ3bkHwlOYT/f8Jao7aaQOfN1q93L1LP5B
 hJAw==
X-Gm-Message-State: AOJu0YyMsxyZFWAWi20mOz2YhhflZbWQhlw3jBo8uQW0PEk3SV2fCpy8
 wNPJccD7kJEauAW/bpSoQw5kHgM749Aode1pfQJ+T09PpYGh+bCTGaFZqACOOnlwF0cfWHEBokF
 vSxqH0X3bza+mI60=
X-Received: by 2002:a1c:4c0d:0:b0:402:ee9e:ed98 with SMTP id
 z13-20020a1c4c0d000000b00402ee9eed98mr10637163wmf.34.1694526904924; 
 Tue, 12 Sep 2023 06:55:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZBORV/yxg6auhE2uvAkwdsxqjiY9D+NBX8pgKHSwdE+T8DcfIwMBJ89MXEs1TSzTUfsyRng==
X-Received: by 2002:a1c:4c0d:0:b0:402:ee9e:ed98 with SMTP id
 z13-20020a1c4c0d000000b00402ee9eed98mr10637147wmf.34.1694526904565; 
 Tue, 12 Sep 2023 06:55:04 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 2-20020a05600c22c200b003fefca26c72sm13133043wmg.23.2023.09.12.06.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 06:55:03 -0700 (PDT)
Message-ID: <5c35d3f5-91ab-4340-0363-04494bb6881b@redhat.com>
Date: Tue, 12 Sep 2023 15:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 2/3] seabios: turn off CONFIG_APMBIOS for 128k build
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20230912105359.563101-1-kraxel@redhat.com>
 <20230912105359.563101-3-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230912105359.563101-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 9/12/23 12:53, Gerd Hoffmann wrote:
> Needed to make the build fit into 128k.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   roms/config.seabios-128k | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/roms/config.seabios-128k b/roms/config.seabios-128k
> index d18c802c46e9..bc3ba7f65bcd 100644
> --- a/roms/config.seabios-128k
> +++ b/roms/config.seabios-128k
> @@ -19,3 +19,4 @@ CONFIG_USE_SMM=n
>   CONFIG_VGAHOOKS=n
>   CONFIG_HOST_BIOS_GEOMETRY=n
>   CONFIG_ACPI_PARSE=n
> +CONFIG_APMBIOS=n

Why don't we instead drop ``pc-i440fx-1.4`` up to ``pc-i440fx-1.7``, 
which have been deprecated since 7.0?  We cannot get rid of the 128k ROM 
because isapc uses it, but we can remove PCI and ACPI from it, and solve 
the size problem once and for all.

Paolo


