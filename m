Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D25A29FBD79
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Dec 2024 13:41:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ4DQ-0000Re-GM; Tue, 24 Dec 2024 07:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tQ4DB-0000MY-Ok
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 07:40:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tQ4D9-0008MN-Hg
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 07:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735044029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OMLGC0ehhQ/emrIQngWF2KEEUJbZVdJsU/Lgx/Vc6Es=;
 b=VdC1ZteoDpA4nX00gNU1BBlnFma6iVOfyjHwedueGlm658MPuhWnoqcyvBOGH4281yO/Ha
 nThDJjy3iF3x0cMhWtJNxeYpKfBpFnDlrkooshguu4SpE9uz3FeckMi46cTrmp7Ps3Lg3a
 xGF7y8R740CMlOEFe8AV2PuqBwOO1Aw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-0oXdG2gbM8SkNtl5-QY4Kw-1; Tue, 24 Dec 2024 07:40:24 -0500
X-MC-Unique: 0oXdG2gbM8SkNtl5-QY4Kw-1
X-Mimecast-MFC-AGG-ID: 0oXdG2gbM8SkNtl5-QY4Kw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361f371908so37939165e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 04:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735044024; x=1735648824;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OMLGC0ehhQ/emrIQngWF2KEEUJbZVdJsU/Lgx/Vc6Es=;
 b=mJWpHJgSaIlNJMCUQswlCtaVRWwaeNm8WW5uigUfB044Yg1X2ZIcahvQVcPan5wnD7
 EYIPPbY7Df0oRfp831LrXX2q54eTXXWdWxD3edgX1wGT1f8fjiLvUntpBOaFfA26+n7U
 2itRiRDvExCdv9U8HRgq8g1zOpQ/JDwKlujPVynacLJYyjnHLknKxykXTkLv2TooNrVM
 PO1/HfrAQkIE+tE+2mzFa6SxDSnM7WIYSENCKi8OgLgz59QOYYoe0Y528QwdlVwBwvsH
 Mv/xh7CCtxHAKDXH/VS5XH817hJ312gTcJiov2mbHEexGIBDGCoKrv0SK6dS10IVT4/m
 Da1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz3axsPUoUgBqtsQSqAHhVJGNjNnxK7dlHQcbCU+cqRh5eEEOFgd1xZTDN/tpV0AwHuybylhCV00vV@nongnu.org
X-Gm-Message-State: AOJu0Yw+6pOPlx0ab4XF7Ain1aKo2BemVvxygVDEDUz3M1FJf1AuPnFo
 LVoigt6vUXRrYr21BHHCHM4VxEtnEm5QjjpbSyXy53Vkokg6Nrhz/o7ZLKvHrgkJGqNaVapHGJq
 7iqGSEaEscB/SCY39C/5/dmeLKimA4+0XItSrFU1ZQ3cRHaRqwUmQ
X-Gm-Gg: ASbGncuXVWJVYOFJAZhCtfCwWiw5LtoKOHGrGfsu68FCuUBaLTsFAXQFA2gv8BwnaXy
 YedVleAA6e4tMBU70Bk+HXZAvsl//l7npST8xAZdKira7J260kXS/P2jZDwKEuczdM8WI7DBTfO
 6UF0u/tov6GYkMgghOiMoxkgcyHIfelGd58aCh9prZscDnLZ+9nD9l50p0K2p8vGktbCxYHDf9d
 LZJu1pxZ8vS1zFXh1cP8ziVIRhVVso+bRLRX7e2KKoidbbwzJmLnXWxl9R5wln/N6xrLmwfkobb
 sZN162z351FBPFBLIDnkJOko7DTIGDve+0Bx2blh+X5fwDx3XBcBe4q6yNuV63yFfjTsWz9NbBP
 /62x8yJK5
X-Received: by 2002:a05:600c:154a:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-43668b786bamr125084565e9.25.1735044023756; 
 Tue, 24 Dec 2024 04:40:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpKy5xIKUJLN+IGyrQDC9xfn03amRyMHxeHO+Lza26t0qvgWEmf7Z/rXCItLoukeeOkSlzug==
X-Received: by 2002:a05:600c:154a:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-43668b786bamr125084365e9.25.1735044023382; 
 Tue, 24 Dec 2024 04:40:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c72a:da00:e63f:f575:6b1a:df4e?
 (p200300cbc72ada00e63ff5756b1adf4e.dip0.t-ipconnect.de.
 [2003:cb:c72a:da00:e63f:f575:6b1a:df4e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366121955fsm169538695e9.21.2024.12.24.04.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Dec 2024 04:40:21 -0800 (PST)
Message-ID: <5727aaac-d042-48fe-b2a6-2211081124b6@redhat.com>
Date: Tue, 24 Dec 2024 13:40:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/14] s390x/s390-virtio-ccw: don't crash on weird RAM
 sizes
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20241219144115.2820241-1-david@redhat.com>
 <20241219144115.2820241-2-david@redhat.com>
 <85ad5cfb-f6c0-4a37-bbe4-46861778e8c9@tls.msk.ru>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <85ad5cfb-f6c0-4a37-bbe4-46861778e8c9@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 24.12.24 13:32, Michael Tokarev wrote:
> 19.12.2024 17:41, David Hildenbrand wrote:
>> KVM is not happy when starting a VM with weird RAM sizes:
>>
>>     # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>     qemu-system-s390x: kvm_set_user_memory_region: KVM_SET_USER_MEMORY_REGION
>>       failed, slot=0, start=0x0, size=0x244000: Invalid argument
>>     kvm_set_phys_mem: error registering slot: Invalid argument
>>     Aborted (core dumped)
>>
>> Let's handle that in a better way by rejecting such weird RAM sizes
>> right from the start:
>>
>>     # qemu-system-s390x --enable-kvm --nographic -m 1234K
>>     qemu-system-s390x: ram size must be multiples of 1 MiB
> 
> Shouldn't this one be picked for qemu-stable?  Seems like a good
> bugfix to me.  Picked up for current stable releases for now, please
> let me know if I shouldn't.

Yes, better to have it in qemu-stable, so it would be greta if you could 
pick that as well (already upstream).

Thanks!

-- 
Cheers,

David / dhildenb


