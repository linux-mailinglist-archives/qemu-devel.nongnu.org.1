Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F071E797170
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 12:09:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeBwG-00018X-OT; Thu, 07 Sep 2023 06:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeBwE-00013s-Dm
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeBwB-00048n-I3
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 06:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694081314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xs0kHa3IlvmTfseI5FYwVEi3ovJgkSCUBkT8WrYHdV0=;
 b=huv2xQlTL46Fy7MFrO+bG8aQMpcLjZ/psQB6xCypzvcxG55ZA+7sCRrv/4uJ1bTeMdaAtG
 3bB9/AYrKJqDNUykuwazkXgZR6L0TWp0HdVu1cIHZFPTiXu6Sryj5iRqfT9PwPUYx9y7hN
 rLUC9gY/Y90CYmHUTySRhESc1XEAyfU=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-EKagug8qMJOt20sxY3hvuA-1; Thu, 07 Sep 2023 06:08:33 -0400
X-MC-Unique: EKagug8qMJOt20sxY3hvuA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2bce36a1628so8727941fa.1
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 03:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694081311; x=1694686111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xs0kHa3IlvmTfseI5FYwVEi3ovJgkSCUBkT8WrYHdV0=;
 b=A2WvdFnqA0cWgEr7Qi9MBkCOTaSD5QyT56dre4rBMU3vOsPJP0rWsgUm+mUKpEA0ab
 //Hm10QdKMCVJdmagJtzk5UnMAQfcz33a/pyWV52hBl2ZGWW2RXByy7JyDR8MdXoeVUV
 dvLaZo/3AMWzcTnldKZXLkLoLFvQScTFSxtXHiPy4goas158GYqwVBdCmH1mXsMSLfFI
 OPWnTh6NgY1vZHcTkVwWgcm+cDwp29ITxpgVQ/ybyAHAh3ExlOtuHlNZpbLJCyufy4po
 8zgGG4993VPp6mxeTV5jLW1i62uLgJtroe99i2NhK9UACxrkxDn5Ra4CrFid/JrmFyQF
 ALKQ==
X-Gm-Message-State: AOJu0YxUHh+0hvLmTTIrYObMH+4kCnetj7Rsm3u9lyd4Zl1qP6NfiIG6
 /0XAzVDs0uZ/eTZ9rPEoNnmu88AgW12QY7ZWOo/dZX5qizsul2cJVfnT3XzSEvSKuOSnHCJysaR
 wyF2p69LaWHPWA2s=
X-Received: by 2002:a2e:8e97:0:b0:2bc:fd50:573a with SMTP id
 z23-20020a2e8e97000000b002bcfd50573amr4323433ljk.6.1694081311684; 
 Thu, 07 Sep 2023 03:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtp5/LJxm/0HtEmyXvSRSM0mtsAR//w1Mk8+GCwI+mwAdd/2CvlkrJi6A+ApTgVfD8NX+mNQ==
X-Received: by 2002:a2e:8e97:0:b0:2bc:fd50:573a with SMTP id
 z23-20020a2e8e97000000b002bcfd50573amr4323395ljk.6.1694081311379; 
 Thu, 07 Sep 2023 03:08:31 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 ay30-20020a5d6f1e000000b0031f65cdd271sm3863364wrb.100.2023.09.07.03.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 03:08:30 -0700 (PDT)
Message-ID: <e5e33d77-15d7-bb93-4a3a-e161c47d11b4@redhat.com>
Date: Thu, 7 Sep 2023 12:08:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 17/20] tests/avocado: s390x cpu topology test
 dedicated CPU
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-18-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-18-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> A dedicated CPU in vertical polarization can only have
> a high entitlement.
> Let's check this from both host and guest point of view.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>


