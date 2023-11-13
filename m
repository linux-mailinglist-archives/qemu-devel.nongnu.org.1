Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1729D7E9724
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 08:58:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Ro3-00073G-L8; Mon, 13 Nov 2023 02:56:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2Rnu-00072l-3q
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:56:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1r2Rno-0001vM-6o
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 02:56:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699862168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AP9CEFm9pP0lKE6ugBT+KeW8yFRdGUz9Kpgkb9IZGb4=;
 b=Z7pY3urf3fY1zXPAsPwwS58Tksed0PAX+q8HYJa2ZgefIEjWpNhQLbAt7bZZzcwGZRBW3T
 q4KUjqAKmE4cE1aJSJl+9gn48xSY/tq/VrYgcBYrmwmbr2u7HO1nEY+bDnZuGvp8SnH2eB
 mLeAR6pmYLks3ILD3g6wO9tOw1ng284=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-uK7_XnxJNDyo1rGaY49FFg-1; Mon, 13 Nov 2023 02:56:06 -0500
X-MC-Unique: uK7_XnxJNDyo1rGaY49FFg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-779ffb552eeso503053785a.3
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 23:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699862166; x=1700466966;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AP9CEFm9pP0lKE6ugBT+KeW8yFRdGUz9Kpgkb9IZGb4=;
 b=SFM1OjN2KdScfNenCkFe1TeraHAQ6QEjLSZe+ucBgagdvUE3d8rUAl1jw5gEqozaBf
 jdm4SHQQ4H2Qq8DwKsddh6CU/RpMx4dmrY9wP0t2ggrJkb+CTlqnR92K+mp9Db4DYNyT
 BRxvtZG5tCyohaE0xTd9zGvJCXhxivnLA4tMb7/HwGp+0xBpvHIBAk6tEiF8wrQQTmXC
 YP7jk6pAI9IsTlAcmAvbHTCvY3HDf2Y8Ovn0vLWnsxYkERDGFthhyugGSyuYsxXK5sit
 W7KLHjTyQo3Ylru0BmEGwgSIC/o+Qy4sBNbrxNUd4tZnEpksgBCH2hM6mpwNhWa0TjAP
 BZwg==
X-Gm-Message-State: AOJu0YwU7qLJ5nsEIb8MqPyJOazxcmQLTzEVTCq4PoMs54nUs4tnFBof
 SGyIbc+sMbAioCYn+47rsftWtsd9sfquaUie6yWAcFganAZcTLe+aCZyCNeee4miOIrALUblb2O
 v2QYiaPmqY9ztHjQ=
X-Received: by 2002:a05:620a:3d1:b0:778:92d6:db0f with SMTP id
 r17-20020a05620a03d100b0077892d6db0fmr6654183qkm.20.1699862166375; 
 Sun, 12 Nov 2023 23:56:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTKSrScdrBzEs8FaYKSqShClHwk+JxJaHnLNWx8ehU8QSrVt5KK5eKhezpIfpsGl5J8Fmzqg==
X-Received: by 2002:a05:620a:3d1:b0:778:92d6:db0f with SMTP id
 r17-20020a05620a03d100b0077892d6db0fmr6654176qkm.20.1699862166106; 
 Sun, 12 Nov 2023 23:56:06 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a05620a0b5400b0077bda014d8esm1341552qkg.87.2023.11.12.23.56.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 23:56:05 -0800 (PST)
Message-ID: <69f9d31c-893c-492c-aea3-1f0af4f52962@redhat.com>
Date: Mon, 13 Nov 2023 08:56:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2] test-resv-mem: Fix CID 1523911
To: Thomas Huth <thuth@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>
References: <20231110083654.277345-1-eric.auger@redhat.com>
 <b92285b4-156b-4a39-baba-ffc2e80e21bf@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <b92285b4-156b-4a39-baba-ffc2e80e21bf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/13/23 08:21, Thomas Huth wrote:
> On 10/11/2023 09.36, Eric Auger wrote:
>> Coverity complains about passing "&expected" to "run_range_inverse_array",
>> which dereferences null "expected". I guess the problem is that the
>> compare_ranges() loop dereferences 'e' without testing it. However the
>> loop condition is based on 'ranges' which is garanteed to have
>> the same length as 'expected' given the g_assert_cmpint() just
>> before the loop. So the code looks safe to me.
>>
>> Nevertheless adding a test on expected before the loop to get rid of the
>> warning.
>>
>> Fixes: CID 1523901
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> Reported-by: Coverity (CID 1523901)
>>
>> ---
>>
>> Hope this fixes the Coverity warning as I cannot test.
>> ---
>>   tests/unit/test-resv-mem.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/unit/test-resv-mem.c b/tests/unit/test-resv-mem.c
>> index 5963274e2c..cd8f7318cc 100644
>> --- a/tests/unit/test-resv-mem.c
>> +++ b/tests/unit/test-resv-mem.c
>> @@ -44,6 +44,10 @@ static void compare_ranges(const char *prefix, GList *ranges,
>>       print_ranges("out", ranges);
>>       print_ranges("expected", expected);
>>   #endif
>> +    if (!expected) {
>> +        g_assert_true(!ranges);
>> +        return;
>> +    }
>>       g_assert_cmpint(g_list_length(ranges), ==, g_list_length(expected));
>>       for (l = ranges, e = expected; l ; l = l->next, e = e->next) {
>>           Range *r = (Range *)l->data;
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> I'll queue it (unless somebody else wants to take this?).

There is also another fix for the same series :

   https://lore.kernel.org/qemu-devel/20231109170715.259520-1-eric.auger@redhat.com/

I was waiting to have a little more for VFIO to queue both but
they could go through your queue also.

Thanks,

C.



