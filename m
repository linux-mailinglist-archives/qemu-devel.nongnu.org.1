Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEAC73B7DB
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:44:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCg4P-0007iA-LL; Fri, 23 Jun 2023 08:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCg4D-0007X4-BJ
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qCg4A-0004JO-FS
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 08:39:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687523945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jk/OmSaFwCmsSL3VxRhAYdY/OdlSBMxFCQf/52QIHCE=;
 b=HoYA2Dy1tERujoVCgsJmL0ZRFzJE4ehjU7Heb+oRWoa2ucgD2wWA8+Mx5H47pQFl+sG93d
 2FhnsGdAPxeYCgkTvS6A2KWTmj7jyoCGBBwaFMhDmQR6VoeWtiMcF66gnITsLss2XhxfVS
 ZERQsUybnqag+kbm8Xay+HFpJhO2SqU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-LJiYqXCxOMi3GerzZd3EHw-1; Fri, 23 Jun 2023 08:39:03 -0400
X-MC-Unique: LJiYqXCxOMi3GerzZd3EHw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b59e209572so3541151fa.3
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 05:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687523942; x=1690115942;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jk/OmSaFwCmsSL3VxRhAYdY/OdlSBMxFCQf/52QIHCE=;
 b=lCVtiyYgcbWXbfadITipc1g7id+HSdcSsSTFA53lvTJQzSbT4J4RrGMcyWXfMJDifj
 EsLrjbERBchskCa1lBRtORusGasCobwQ941E15RLuzNW8Z5HUsw0YgHpjU63OWZDEti4
 H3VxOIDtuTO9ntvuqCjEi5o42deBJYrSuqTRRcPEKP7H/n5f9qHTFjy1dihtU83hxsMc
 SmhT9KpMNUUBdCa9Okk1NwSgpNFl6kgGnRZ1WWnzQaeBi9idxoBBH01I/pmbFxmYdwJx
 bBR/rQ8/9AoBzb+7OxT4XFe0nEijEmtvV00FdgTwFJB8bRr93429NgLYC8kHcDyx/tL8
 Jzzw==
X-Gm-Message-State: AC+VfDw8gz7sLFHKYBCDulZIBZChxUC6AcvSSzWNc6JJRwrGs9BXk3FC
 Ounzu7QgKoZ7bXGB3YeiRVD+OLKaRy2WFXd5+kvB+gRwFa6ultHOUI8nJGB2p2Fi2pwZ/xEyEun
 MYrfZ7FNt2Oh0y5M=
X-Received: by 2002:a05:6512:32ab:b0:4f8:7796:623b with SMTP id
 q11-20020a05651232ab00b004f87796623bmr8360491lfe.39.1687523942377; 
 Fri, 23 Jun 2023 05:39:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5UXfUeb2bvjC3g50JAXnh+D2xLdDYy1PiMyMM80Qcrka7dwDFId4+HnqR/+dytF6Msr9yRNQ==
X-Received: by 2002:a05:6512:32ab:b0:4f8:7796:623b with SMTP id
 q11-20020a05651232ab00b004f87796623bmr8360475lfe.39.1687523942020; 
 Fri, 23 Jun 2023 05:39:02 -0700 (PDT)
Received: from ?IPV6:2003:cb:c729:1700:9783:58ba:9db:1221?
 (p200300cbc7291700978358ba09db1221.dip0.t-ipconnect.de.
 [2003:cb:c729:1700:9783:58ba:9db:1221])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c029900b003f42158288dsm2266289wmk.20.2023.06.23.05.39.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Jun 2023 05:39:01 -0700 (PDT)
Message-ID: <852fe9b9-cee3-63cf-91e1-2a0065e837fe@redhat.com>
Date: Fri, 23 Jun 2023 14:39:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 00/10] memory-device: Some cleanups
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230530113838.257755-1-david@redhat.com>
 <20230622161320-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230622161320-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 22.06.23 22:13, Michael S. Tsirkin wrote:
> On Tue, May 30, 2023 at 01:38:28PM +0200, David Hildenbrand wrote:
>> Working on adding multi-memslot support for virtio-mem (teaching memory
>> device code about memory devices that can consume multiple memslots), I
>> have some preparatory cleanups in my queue that make sense independent of
>> the actual memory-device/virtio-mem extensions.
> 
> pc/acpi things:
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thanks, I added that to patch 6/7/8.

-- 
Cheers,

David / dhildenb


