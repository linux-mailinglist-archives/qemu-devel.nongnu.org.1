Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF947D00CE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 19:42:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtX1M-0007t0-IA; Thu, 19 Oct 2023 13:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtX1E-0007sK-Ee
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:41:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qtX1C-0001J7-JG
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 13:41:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697737269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sb8PmOdPdBX7z9VVSpMrzs4JoG7i6FSASwltQ6OtKok=;
 b=DlD0HtrRSlzkJnkEZM1mLYVOZ4YHn7OmrOgZzIOlMdKxljL02CtZM27pPNRYLSlodNHtPn
 mdQTdOWBYUvA4idymTKYqfRnu+q/b7yIB29aFPvihaRYUam06D7xQO0Zod6S7not4+GzKG
 oV9SE/n99TtfO5ePVeIf0CrPsPmQo+Y=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-oxM75agYNMCTdzAEKP7pRQ-1; Thu, 19 Oct 2023 13:41:02 -0400
X-MC-Unique: oxM75agYNMCTdzAEKP7pRQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3b2ef9a0756so2293546b6e.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 10:41:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697737261; x=1698342061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sb8PmOdPdBX7z9VVSpMrzs4JoG7i6FSASwltQ6OtKok=;
 b=UePURt97+Qqi1EBYKnPVBIBJe5FSm8p6DJcI907Fdfn05Dlqcg51aY+b0X5xSI3Tlm
 zeGCQ2c+GbYkIT9IvNRh66+cyp0w1oUqUcg225H9NApayuK0AXbIP5IQy2Q8EsfDoNjd
 uosjnhDSBlW6onlJbDYH3zFH3Pvgb7oPzL8jxbZdM57HKgnlg8HPW6Vy0wZV92EyUkkR
 MKXD8hQaNyue5YXbiMeJorV7cgkJtAa2sncALQMjeX1L5w2Qf1oz4xhC368s0VBIWWsC
 gEmNxC/CKoAygAhAaXs/QqRpSeFMmQnIhhbILi/TWFJLIOA1004mKYCwVP34yWHyQ5uc
 YACA==
X-Gm-Message-State: AOJu0Yy/iRYWJY/CTBiBpk7xnpdLFeGAcUPLNAcEIYiIZS2WHOoZkQJD
 Aa+2jcT5kho3a9Ltdydbxs4BS6DU4EI2BE9OF/qoEDVEWye0TjrwUalapWnYKUS3BZNgBn0gMrP
 nTBbiOoJoS0x2I6w=
X-Received: by 2002:a05:6808:210e:b0:3b2:e519:192c with SMTP id
 r14-20020a056808210e00b003b2e519192cmr3565586oiw.9.1697737261272; 
 Thu, 19 Oct 2023 10:41:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpErE0Y9EJpc1sU31mKgH2TpfzHHon41efKe7n02+sZjMd90fXBQYEhtCduR86YU1QkNt19g==
X-Received: by 2002:a05:6808:210e:b0:3b2:e519:192c with SMTP id
 r14-20020a056808210e00b003b2e519192cmr3565525oiw.9.1697737260112; 
 Thu, 19 Oct 2023 10:41:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d27-20020a0cb2db000000b0066cf09f5ba9sm15658qvf.131.2023.10.19.10.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 10:40:59 -0700 (PDT)
Message-ID: <8f943dbf-5a75-4b82-9521-af8999105d62@redhat.com>
Date: Thu, 19 Oct 2023 19:40:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Content-Language: en-US
To: eric.auger@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, jean-philippe@linaro.org, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, david@redhat.com,
 philmd@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 YangHang Liu <yanghliu@redhat.com>
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231018093723-mutt-send-email-mst@kernel.org>
 <9ddc3f2e-8be7-4e03-bf9f-3ac930650a52@redhat.com>
 <9a8912df-23d1-64c0-134d-cc42838b34d8@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9a8912df-23d1-64c0-134d-cc42838b34d8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hello Eric,

On 10/19/23 15:51, Eric Auger wrote:
> Hi Cédric,
> 
> On 10/19/23 13:07, Cédric Le Goater wrote:
>> On 10/18/23 15:37, Michael S. Tsirkin wrote:
>>> On Wed, Oct 11, 2023 at 07:52:16PM +0200, Eric Auger wrote:
>>>> This applies on top of vfio-next:
>>>> https://github.com/legoater/qemu/, vfio-next branch
>>>
>>> virtio things make sense
>>>
>>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>>
>>> let me know how you want to merge all this.
>>
>> Michael,
>>
>> I will grab the series if that's OK.
> 
> I have just sent a v4 taking into account Alex' suggestions, collecting
> Michael's and Alex' R-b, and YangHang's T-b.
> This should be ready to go if you don't have any other comments and if
> this survives your non regression tests ;-)

Sure.

I did a simple fix in patch 2 for a documentation breakage. No need
to resend. I should apply in the morning.

Cheers,

C.


