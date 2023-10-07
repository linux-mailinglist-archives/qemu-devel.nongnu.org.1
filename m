Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7B57BC6AC
	for <lists+qemu-devel@lfdr.de>; Sat,  7 Oct 2023 12:16:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qp4Kr-0001jO-75; Sat, 07 Oct 2023 06:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qp4Kp-0001jB-S5
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 06:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qp4Ko-00074g-9m
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 06:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696673697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PRTTrmBABeIP73I++vuQJeCXAu83X781ivE5Urxjq+4=;
 b=N2FbuxttHc/Xz8WEw6pGAzeX4Q0EmxtS3V54fNHLGqE+QyBN5v0NPSuaXRxliWj4AgEfAL
 HDuode4c66UTrR9Fh6R5lfAOIH/VuJjoSgnSltr3JXopvsyoPvUdRbTMYBqiLoiIGGAyay
 QXyob/taQIV6DdbxXdV2yB9kNgz4Nl4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-K6Xz8IKcPFWRwVpVdymWAA-1; Sat, 07 Oct 2023 06:14:45 -0400
X-MC-Unique: K6Xz8IKcPFWRwVpVdymWAA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3231fceb811so2116793f8f.2
 for <qemu-devel@nongnu.org>; Sat, 07 Oct 2023 03:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696673684; x=1697278484;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PRTTrmBABeIP73I++vuQJeCXAu83X781ivE5Urxjq+4=;
 b=nVIsPo8+O95k/ZQ8+OfFZ7yzHT0qkZZqyL4QiTdlZtbJwbNTgTEOa3JFvKMBTvdH1C
 5XCU6Pxqv15fg4oxizuSHAlmxN9wq+OvgtBQ///xcHSWCwJ+0TfuajqZ5NLz7gawzzmk
 pcugOhmDEj2/sZy7J5ldKv2teyR1WSSkenZZWC92eR0pJbQjMoDD+QGkv1n+G9waOaEm
 q+XlQDYHaiMLO7BIfniYpPZfgRhCHFJVxEN0w/l1RiG5YQ1kXhpCxaUcLyPFGDjrgcCZ
 FobdrCGIlH29tNdEB3SvnQkcqMv0HY5FgiTikU5z0EBIALa/Otnz41Ih74Tr17i1T7x/
 fRXQ==
X-Gm-Message-State: AOJu0Yxgj1C6fu17leEwEICmNbY/ZZJwPip43cysH9rFKafQ7YBSixKr
 mWhPaOiDt+GeTpTuzpif2XO0L19/AQGu1ePGPUqJmKVNue4bYOlNLo6vW17ef9ox7Tr5jxoyZNq
 8FFYxT5DLHng8yvk=
X-Received: by 2002:a5d:60d2:0:b0:317:6fff:c32b with SMTP id
 x18-20020a5d60d2000000b003176fffc32bmr9267626wrt.53.1696673684563; 
 Sat, 07 Oct 2023 03:14:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcmmcK+IK9Aeb95ATnM4dWUgXOQeYXF26Iselq1SDAFbuspkigafsBJ58mBOhQJpQIPHDhIg==
X-Received: by 2002:a5d:60d2:0:b0:317:6fff:c32b with SMTP id
 x18-20020a5d60d2000000b003176fffc32bmr9267615wrt.53.1696673684245; 
 Sat, 07 Oct 2023 03:14:44 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:853d:fa00:f59e:918a:6675:6332?
 ([2a01:cb19:853d:fa00:f59e:918a:6675:6332])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a05600c204400b00403b63e87f2sm5760046wmg.32.2023.10.07.03.14.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Oct 2023 03:14:43 -0700 (PDT)
Message-ID: <27807aad-57c1-ca10-f697-a2848d32c826@redhat.com>
Date: Sat, 7 Oct 2023 12:14:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PULL 00/21] vfio queue
Content-Language: en-US
To: Eric Auger <eauger@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20231006062005.1040296-1-clg@redhat.com>
 <1e2652d6-c10b-9b65-6e2c-7903574d501a@redhat.com>
 <3ea30f06-aeea-8e66-a8ed-75a9292a415f@redhat.com>
 <1c19badf-0c65-4ee0-61a0-e653b7be89bf@redhat.com>
 <58d75d69-cfd8-903e-c0a1-f95acc64bfd0@redhat.com>
 <1d87070c-2561-c6da-1380-9e3e13bcd844@redhat.com>
 <a0feb302-2490-8e3c-a54a-47bc8671f11e@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <a0feb302-2490-8e3c-a54a-47bc8671f11e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hello Eric,

>> If you are ok with the above, I will squash the change in the
>> related patch and send a v2.
>
> Unfortunately this is not sufficient. There is another regression
> (crash) on a double free of vbasedev->name as I reported before. I was
> able to hit it on a failing hotplug.  How do you want me to send the
> fix? I can resend the whole series of just fixes on the related patches.

Please send a v5 for "Prerequisite changes for IOMMUFD support" with the
fixes we talked about. I will rebuild a PR next week.

Thanks,

C.


