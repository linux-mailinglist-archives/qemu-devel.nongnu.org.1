Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B15C973A159
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 15:01:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCJvn-0007gz-Ki; Thu, 22 Jun 2023 09:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qCJuu-0007KE-W5
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1qCJut-0000c2-DF
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 09:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687438799;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmuiP/xKtU/P8i6nH/v0PfmDT8vIAMmQlHbp7H1EWsY=;
 b=ilbN7JYRLx7Vbdc9D/ejmGk1GT58qHvlpWBnMCdcHDsuwCImeZypx07vI1jmk89KLT1ygD
 zkWpcIZjt0//rfuhNJuBZsbox9tiqbLyNz/afGTDJt/NYHvvu0XPjeBY1Z43Ynj9gVxqKa
 u6AlX+LHwxwuOSrY75leb3J/+VQObZw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-KQi04VPiOQ2l_A-EWfTSMw-1; Thu, 22 Jun 2023 08:59:56 -0400
X-MC-Unique: KQi04VPiOQ2l_A-EWfTSMw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f9e616e25dso105295741cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 05:59:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687438796; x=1690030796;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UmuiP/xKtU/P8i6nH/v0PfmDT8vIAMmQlHbp7H1EWsY=;
 b=K78obVrfHXF+ac1175vuFpOcDtOS0UL47m6AW/kxAynOqM9BauUdCqzuXn9/lipm0V
 MCOVS4JLhfWhhGKjDRlzagRR6dvrwHLTygF2uiDrU2ry78PRUWlzTPp/W84ZMmVVgh3o
 5ZSpZeeIUleGP787kuInbV3iGg/Uis2/vJVu+e+fkMuFApryDVo6zatsflwqW84NrPsi
 JDycb9PG93w257BH1coYhA+1zAMIZwX8LAVe0XWxgQWDsrtbuBA3KaDr8AtQrpxrXwEk
 dGY16eZZzUIvXX3pVAKorub+a0eMCWDOGPw18u+522JeN45cF70l0ikDAE43ozZ15Cov
 STCA==
X-Gm-Message-State: AC+VfDxcEAU5ZCB1zXmnS/dVMvz88Sa2kmZz76mwvIoAGrpi62Ul1YJ+
 /pPbhnNfpSbpoZ8ZiGz/TuVcpA2/ixW6bYesEOmcFmcWxWAh6QRUSo9jYgBn8ya0QKLHixGWK2o
 JD2CmtMKx5fSC4Js=
X-Received: by 2002:a05:622a:8b:b0:3fe:3074:64bc with SMTP id
 o11-20020a05622a008b00b003fe307464bcmr13019801qtw.10.1687438796480; 
 Thu, 22 Jun 2023 05:59:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6nLGd/nIQpzJJfUGdkPKwARGNwpBtovXjpCzQussJXUTFKaYh7d+Ytn4C2vk/MVE4Ykn2keQ==
X-Received: by 2002:a05:622a:8b:b0:3fe:3074:64bc with SMTP id
 o11-20020a05622a008b00b003fe307464bcmr13019791qtw.10.1687438796284; 
 Thu, 22 Jun 2023 05:59:56 -0700 (PDT)
Received: from [192.168.100.28] ([82.142.8.70])
 by smtp.gmail.com with ESMTPSA id
 r5-20020ac85205000000b003fdec95e9c8sm3543098qtn.83.2023.06.22.05.59.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jun 2023 05:59:55 -0700 (PDT)
Message-ID: <06d07da8-68a7-c7da-1a78-f45750971ede@redhat.com>
Date: Thu, 22 Jun 2023 14:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] tpm_crb: mark memory as protected
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 jasowang@redhat.com, mst@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 marcandre.lureau@redhat.com, eric.auger@redhat.com,
 Peter Xu <peterx@redhat.com>
References: <20230620195054.23929-1-lvivier@redhat.com>
 <20230620195054.23929-3-lvivier@redhat.com>
 <13593b65-7df3-7ebc-0759-82c6731eb04b@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
In-Reply-To: <13593b65-7df3-7ebc-0759-82c6731eb04b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
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

On 6/21/23 11:13, David Hildenbrand wrote:
> On 20.06.23 21:50, Laurent Vivier wrote:
>> This memory is not correctly aligned and cannot be registered
>> by vDPA and VFIO.
>>
>> An error is reported for vhost-vdpa case:
>> qemu-kvm: vhost_vdpa_listener_region_add received unaligned region
>>
>> To make it ignored by VFIO and vDPA devices, mark it as RAM_PROTECTED.
> 
> So, VFIO will simply skip these sections via vfio_listener_valid_section() I guess.
> 
> Yes, it will report an error but it will happily continue.
> 
> So regarding vDPA, we're also only concerned about removing the reported error, everything 
> else works as expected?
> 

Yes, it has been tested and vDPA works as expected.

Thanks,
Laurent


