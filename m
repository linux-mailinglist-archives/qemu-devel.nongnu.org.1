Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A938A7C65B6
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:38:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpKA-00044U-UC; Thu, 12 Oct 2023 02:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqpK7-00043o-17
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1qqpK5-0000wA-HF
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 02:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697092648;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wpU6OFmUcAVGCMlO9l6/9Sg/VeRvKLNwQ1sR+erClM=;
 b=fNdmAP18Fu1SJFsBxNkr9wl8stehJED3juHBtx1p+ULVOl/vTaY1g3jyy3S10Qr4crA0EJ
 E55Rw3LSAEfKcMYWKyRQdTl7QNNf9kbvOpnFgsOXCVuByM9S6LDgUbv+5vkXN9GXMaxENE
 KV9EW1jTAOHaa5xO+FqJufk/PnCiGVc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Bz5KaR4AOX211YFJHt9LFg-1; Thu, 12 Oct 2023 02:37:25 -0400
X-MC-Unique: Bz5KaR4AOX211YFJHt9LFg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41b19dc9ee4so6011471cf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 23:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697092645; x=1697697445;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6wpU6OFmUcAVGCMlO9l6/9Sg/VeRvKLNwQ1sR+erClM=;
 b=pKTHaskvMvR21t0z1F+QQ1PkNDB0wfVVasJxF4iDUMcZOVpe9vHLovd3Y9ysgHLeUu
 UOVJYTUVBFOTpRUJs/xFIRUXIpxLZdRdxR/Vzc2bYj18JdjUeJ+81Cy6lGlosQp1i4fi
 HfymA7OZvFi1chxdxLqS/hCYNscrQr2TK3NXqb2UDDM9PrDNFuWzmbcoc3c0FziXul0p
 +Y/OPGxss1/ZFouEm/njBCg5+GZV6jTsE8AssMwgx2P6b2yBp0EjV5ycMU5njHLheNvb
 WHT+WSL3EjquedjUkfiThUshW0smcvptIAONB7NMEC/vJYbi+lGj5fTkRutYADWhVAYI
 UCAw==
X-Gm-Message-State: AOJu0YwtIzXxpehj5lUsOzsU4c/kYJpbdIIJ4EbB91UfrSUiTe7yLJy+
 8S2Ei0qWt7f6jZpAocTY2VgAw/0BJ5PcAHjZheBwse20RH269f8rDcjX0t51IrS4tDYj0qqPSOh
 silHe4kdCHmMRmvw=
X-Received: by 2002:a05:622a:1747:b0:418:1088:7d69 with SMTP id
 l7-20020a05622a174700b0041810887d69mr28298467qtk.18.1697092644811; 
 Wed, 11 Oct 2023 23:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiUQH/LhRfEPZfIFnjGxLPqNEnpFdhdL1lyc8pcP7/fJ4vW2x6fm3bvZRSevNATlS/XXt8dw==
X-Received: by 2002:a05:622a:1747:b0:418:1088:7d69 with SMTP id
 l7-20020a05622a174700b0041810887d69mr28298451qtk.18.1697092644519; 
 Wed, 11 Oct 2023 23:37:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 j1-20020ac84c81000000b0041812703b7esm5962167qtv.52.2023.10.11.23.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Oct 2023 23:37:23 -0700 (PDT)
Message-ID: <8323dbfa-98ed-1db3-d901-a1f859c46685@redhat.com>
Date: Thu, 12 Oct 2023 08:37:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize
 error path
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
References: <20231011200934.549735-1-eric.auger@redhat.com>
 <PH7PR11MB6722D7A0E5D47F6E9A5B191C92D3A@PH7PR11MB6722.namprd11.prod.outlook.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <PH7PR11MB6722D7A0E5D47F6E9A5B191C92D3A@PH7PR11MB6722.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Zhenzhong,

On 10/12/23 04:34, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: Thursday, October 12, 2023 4:10 AM
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; alex.williamson@redhat.com; clg@redhat.com; Duan,
>> Zhenzhong <zhenzhong.duan@intel.com>; Liu, Yi L <yi.l.liu@intel.com>;
>> yanghliu@redhat.com
>> Subject: [PATCH] vfio/pci: Remove vfio_detach_device from vfio_realize error
>> path
>>
>> In vfio_realize, on the error path, we currently call
>> vfio_detach_device() after a successful vfio_attach_device.
>> While this looks natural, vfio_instance_finalize also induces
>> a vfio_detach_device(), and it seems to be the right place
>> instead as other resources are released there which happen
>> to be a prerequisite to a successful UNSET_CONTAINER.
>>
>> So let's rely on the finalize vfio_detach_device call to free
>> all the relevant resources.
>>
>> Fixes: a28e06621170 ("vfio/pci: Introduce vfio_[attach/detach]_device")
>> Reported-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Thanks!

Eric
>
> Thanks
> Zhenzhong
>


