Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB1B9DB522
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Nov 2024 10:56:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbEd-0007Cq-9o; Thu, 28 Nov 2024 04:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGbEb-0007Cc-NR
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:54:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tGbEa-0008K6-2s
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 04:54:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732787689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DERNOl6ZZ8SFXDjtyb5Vo42owRn2GZeCBJ026jClSiM=;
 b=MTI5KBmxWDoo0fIzGL1f2/y6lo9d1b/FRgBN/dT1+vsgfEAymB8o+sRMyEaLxzH3PHBsxg
 /sG2wgoqeg2OQGLI5+YYojycpVLhMVtwieFLJRBpp/rX8rgvJ21dyhWS2mJMyQB+no/HWx
 JaBcbCXDqRyvjBfBpFTiXs/ASSIAmOs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-nTYo-3pCMMeLA9QAHU8cUA-1; Thu, 28 Nov 2024 04:54:46 -0500
X-MC-Unique: nTYo-3pCMMeLA9QAHU8cUA-1
X-Mimecast-MFC-AGG-ID: nTYo-3pCMMeLA9QAHU8cUA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a37a57dfso4923795e9.0
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 01:54:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732787685; x=1733392485;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DERNOl6ZZ8SFXDjtyb5Vo42owRn2GZeCBJ026jClSiM=;
 b=s+6aGwIu0y2fewtDOLccCWvz6j6jtiBj/pStYmOwQC80P4tT2lymf9bQ13OFCnSCOT
 D8smmU1rcvNwC9potdKYCW3DZu/LPa2eXzfs6JaJTqExCkxwn3dD3tSZb1NpirLlY42B
 Hl4ooAZDZrzZQrmtwhb1zW67bHHLLo7m8xFqu2hTiiLKj0Fhua8qYGUO82lpmdvl+AaD
 ottFVPNNU31zsRT0Q9oJJPJM0Ko1+gYJ2wY4IjTw7ITRPdIOhlYfEUx24S+k2IpwSZsY
 D6okmdOstzpeSRVcDXbQ11yHfYh2MJUnJK0kf38dezdZ0Siyaeee4tch7I5o2snxXzxL
 4q/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbIydd3MDeaFTmwryg1lZ2Feky1mE+p+MicVWoXafkh+TsXGIpDDNHP8Qrp6fp5TQY883SuQnjEVky@nongnu.org
X-Gm-Message-State: AOJu0YzyUw/oOOjiP0hErmrnwRpnSN/zP2fQfLYlNjcPz4FMl7BxaIo/
 jcj2Glj4egVHUSYjXLN89JfOS0z9rbgaK83ADOcGp5X/5sVALzioGYGCdyfJX6//WsNTPiSOx1G
 KJD/GXLm3UCFmUUcZ0UrK3Q6+6JpaKr8yyIClIgMboQ4eAeLDap0B
X-Gm-Gg: ASbGncsKDs0HgAKJsp4pdfvgzMYMo7bmr1OJefpysYDw56MB1pWPkPq1EhFgmegXOp0
 K1xM+zK6O5wFnnc0epJ51/UXwylVl5qR20HK8blR3nQWZOZTu3lYgNyvaAV35O3ChA1SjuzitA+
 mySmpZ1QThJCDIpDkBRdLS47mBAsv+yqykMTUWT/0mURhowHZweykSjF7dQ4I6yJNIhlj+YenTV
 Qpcm3mMSFIAltB5pY/4e7oWWXhMrtUDkF9fKbM3OmI1JfdJID/kGVwO7B79Tlg9yYOY9m3iUIf7
 uzdSmQ==
X-Received: by 2002:a05:6000:402a:b0:385:bee7:5c63 with SMTP id
 ffacd0b85a97d-385c6eb916cmr4223306f8f.14.1732787685271; 
 Thu, 28 Nov 2024 01:54:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEU0tvxxVSciRDLQ6GT3pPymaCWku4wE/1fcoebBi2b+YoaRabwxNccHb9AMrPCpKbmaLVQlQ==
X-Received: by 2002:a05:6000:402a:b0:385:bee7:5c63 with SMTP id
 ffacd0b85a97d-385c6eb916cmr4223289f8f.14.1732787684912; 
 Thu, 28 Nov 2024 01:54:44 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd370ebsm1223863f8f.43.2024.11.28.01.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 01:54:44 -0800 (PST)
Message-ID: <340ed154-86d8-45da-bc81-5e1ebb8af8f4@redhat.com>
Date: Thu, 28 Nov 2024 10:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
 <ce5825ff-53f5-4cf9-aa6d-e0d28639e664@redhat.com>
 <90b56207-a602-454f-9d3a-82de83a8f2a8@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <90b56207-a602-454f-9d3a-82de83a8f2a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 27/11/2024 19.02, Richard Henderson wrote:
> On 11/27/24 00:29, Thomas Huth wrote:
>> On 26/11/2024 23.54, Richard Henderson wrote:
>>> On 11/26/24 11:52, Thomas Huth wrote:
>>>> I think we want to continue to maek failing downloads as test failures, 
>>>> otherwise we'll never notice when an asset is not available from the 
>>>> internet anymore (since SKIPs just get ignored).
>>>
>>> I disagree.  Download failures are not rare.
>>
>> That's not what I said / meant. Sure, servers can have hiccups and 
>> downloads can fail, but that's what we have the cache for. So having a 
>> working cache is essential.
>>
>> OTOH, if you simply mark tests as SKIP if the download fail, we'll likely 
>> miss if an asset vanishes completely, since some people already have it in 
>> their cache and the remaining people will likely just ignore skipped tests.
> If the cache is populated, we will *not* miss if an asset vanishes, because 
> we won't ever try the URL.

Well, we'll notice it as soon as people run the tests that don't have the 
asset in their cache yet.

> If the cache is unpopulated, and the download fails, then we cannot run the 
> test. Indicating FAIL is *useless* because there's nothing that we can do 
> about it, and we also skip additional tests that CI could be running.

Thinking about it for a little bit longer, I think we might rather want to 
distinguish the different failures that can occur during download. If we get 
a 404 error, it means that the asset has completely vanished and thus the 
test is broken, i.e. that's the case when we want to have a real error, I think.

But if the server is just not responding or gives a 5xx (like 503 or 504) 
server error, the failure is likely just a temporary one and we should skip 
the test instead. Does that sound acceptable to you? If so, I can look into 
creating a patch for this.

  Thomas


