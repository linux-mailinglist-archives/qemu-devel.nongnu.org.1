Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4A8B17115
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Jul 2025 14:24:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhSJn-0006ud-5H; Thu, 31 Jul 2025 08:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhS0Z-0000kY-Hn
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 08:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uhS0V-0005I1-T8
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 08:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753963411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IschEN4hjITKhDc+MuvNtR4g6lV5Ht+cmwI9zm1RT2c=;
 b=UpG6+B0liREk6TDPwpYcuN5UjLK9HXZRspDLTaCMD3w61EPtGY1qdrOX34fMavdUqg3zSs
 GyBfMEE837fL6Z/M3aZoHBYtznkvqVyBygN3P9/qsAFpvyJP1aTzaULBc8pRRBnA1rrF02
 us/IPGNyjbffGLYKyyK64uIhmYG5faA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-eRjKM278MlO1vXHxU3IXSA-1; Thu, 31 Jul 2025 08:03:30 -0400
X-MC-Unique: eRjKM278MlO1vXHxU3IXSA-1
X-Mimecast-MFC-AGG-ID: eRjKM278MlO1vXHxU3IXSA_1753963409
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f3796779so517278f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 05:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753963408; x=1754568208;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IschEN4hjITKhDc+MuvNtR4g6lV5Ht+cmwI9zm1RT2c=;
 b=usZbtrQTHSVUX1cipEd3ymPQYxti9sgkNwrG12B+pJZ7qqGR2ugr5BK3sj8R62SSc0
 09ND5rnM9DTmhu53gS2ArPdrG3tJagrzyVYjvpMyXog1oBU6tlg/tc6tsT6/zgEXHyEE
 jCJz6emaIHTVC6AdhIU0344sWcw1gtgjN1PwggAxPEHgtMscl8H3IEW5irTcOb7GUNou
 tvqMhFs+xY+uaQhtazNyTjS3rxTQpVrsFRKtWqDXKiZzCyEvocL4su9Jx4WyfSe1FoKa
 NqITBIlRLSj8MgWgi3qSPtfbIcaRj613nIfCWlt5uHTwIMDFAwVUVDQALh2fBNC92OeS
 dnuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCFYAl3GI4XqZj+Urm+iHJDhj+wvn+d2YhgFyNKWyjVwoccBY6F5A4Yz9rMZKBTs9LNdBWlIZ7DkJX@nongnu.org
X-Gm-Message-State: AOJu0Yx250unx9kW4YKt64Ndrwdqk4xCgVu8gCfLxSHE6be0NvUFlZe5
 Vk0uRS6iZxPRfLH1W7Y9hbqNpJGNzBNGTvI5NgP2JNHir8FFMTqXZROWwASe+EMabTCJivFL/bo
 Y3thABGsLveko5G27SRKr/4MQm3ML1VO/bGcGqEUTeD9hOSi66c1bVrQv
X-Gm-Gg: ASbGncvi+Y29OpYXk/EL67KTBIdp0imNqrCZZ7MSxb59OrhIhQoQuDrG7Tq1BgyfUWy
 3n77BSEwi9QtvyFhE1alG/WbQds95XFOhkq5GjiXqOX2KNllINi6J0Fhe1nrmAETi8FA5ZdUWC9
 VKjk4+KepFB6RnjLn/2RhYevU1Dovbs8GGs8Nfp3JJYsG27fbmDYTvwKB1yYsALLpl+JJ4v99JK
 ZJ4eYF3CO3s2SwDBBcA9Au1Cdtd8wyYuc9yY/5j4z3f4fDDl3Lxu3gUG4DAR1gkBNifGVowlxx+
 Ezmng5GvnDw5LK6KnDxo3w1j1BKOTc7x2+jkBuaCMXt83auIhjpQxmqHZ5aoZHhakUkSRURqj8d
 +JhccUWA=
X-Received: by 2002:a05:6000:2484:b0:3b7:908e:e46e with SMTP id
 ffacd0b85a97d-3b794ff77eamr5816349f8f.25.1753963407882; 
 Thu, 31 Jul 2025 05:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWrXFRpUA/1Glafi1YykH0bnbacNXdddsUhkKaPYI9ACVeFEhKmNrZU8hZs5C6zWq+PQz6aQ==
X-Received: by 2002:a05:6000:2484:b0:3b7:908e:e46e with SMTP id
 ffacd0b85a97d-3b794ff77eamr5816322f8f.25.1753963407433; 
 Thu, 31 Jul 2025 05:03:27 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:9004:d500:837f:93fd:c85e:5b97?
 ([2a01:cb19:9004:d500:837f:93fd:c85e:5b97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee628fcsm24659375e9.31.2025.07.31.05.03.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 05:03:26 -0700 (PDT)
Message-ID: <b0af165f-b464-4479-b2fb-bb9e7ebdb5be@redhat.com>
Date: Thu, 31 Jul 2025 14:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250731033123.1093663-1-zhenzhong.duan@intel.com>
 <1e5263cc-23fb-44cf-a8c1-f01b6fbb6ef3@linaro.org>
 <IA3PR11MB91364FF957288A4DBC5A3F709227A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <a5b7729f-ca9b-44c8-9ec9-89fdf2636340@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <a5b7729f-ca9b-44c8-9ec9-89fdf2636340@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/31/25 13:24, Philippe Mathieu-Daudé wrote:
> On 31/7/25 10:49, Duan, Zhenzhong wrote:
>>
>>
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Subject: Re: [PATCH] vfio: Introduce helper vfio_device_to_vfio_pci()
>>>
>>> Hi,
>>>
>>> On 31/7/25 05:31, Zhenzhong Duan wrote:
>>>> Introduce helper vfio_device_to_vfio_pci() to transform from VFIODevice to
>>>> VFIOPCIDevice, also to hide low level VFIO_DEVICE_TYPE_PCI type check.
>>>>
>>>> Suggested-by: Cédric Le Goater <clg@redhat.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> ---
>>>>    include/hw/vfio/vfio-device.h |  1 +
>>>>    hw/vfio/container.c           |  4 ++--
>>>>    hw/vfio/device.c              | 10 +++++++++-
>>>>    hw/vfio/iommufd.c             |  4 ++--
>>>>    hw/vfio/listener.c            |  4 ++--
>>>>    5 files changed, 16 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>>>> index 6e4d5ccdac..00df40d997 100644
>>>> --- a/include/hw/vfio/vfio-device.h
>>>> +++ b/include/hw/vfio/vfio-device.h
>>>> @@ -157,6 +157,7 @@ bool vfio_device_attach_by_iommu_type(const
>>> char *iommu_type, char *name,
>>>>                                          Error **errp);
>>>>    void vfio_device_detach(VFIODevice *vbasedev);
>>>>    VFIODevice *vfio_get_vfio_device(Object *obj);
>>>> +struct VFIOPCIDevice *vfio_device_to_vfio_pci(VFIODevice *vbasedev);
>>>
>>> Please return the typedef (like in the implementation), not the struct.
>>
>> That will break build. VFIOPCIDevice is defined in internal header hw/vfio/pci.h,
>> while include/hw/vfio/vfio-device.h is public header, I'm not sure if it's right way to include internal header in public header.
> 
> Moving the following line:
> 
>    OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
> 
> from hw/vfio/pci.h to include/hw/vfio/vfio-device.h should be enough.

I rather not. These are 2 differents subcomponents.

vfio_device_to_vfio_pci() could be moved.

Thanks,

C.


