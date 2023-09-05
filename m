Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF36D7921B8
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 11:57:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdSnX-0000QY-MY; Tue, 05 Sep 2023 05:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdSnV-0000N9-7R
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdSnS-0004Jy-GY
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 05:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693907793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bml7IUDxn/YAQeTCVdXyHjhAYUj3HUP9WvNxUGl4p5s=;
 b=HprLS7/hYGYUd95acsvSlB5KA3OQopQwXUJUNBcHLT1s2KpUwWjbg1w4EhE3LUYv3RjdpA
 AHLOyeSvnPGfjN5bIBaUSeZKqKeFHLHs/yNQNh5T3PiSdFju382/5jUhr//ymwlaR/34DY
 sM4cIRkEuv2UzaaCriJjACJnxK+G/HM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-67_OPD8pNzG8NW3h-NtYLA-1; Tue, 05 Sep 2023 05:56:31 -0400
X-MC-Unique: 67_OPD8pNzG8NW3h-NtYLA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402c46c4a04so14403635e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 02:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693907789; x=1694512589;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bml7IUDxn/YAQeTCVdXyHjhAYUj3HUP9WvNxUGl4p5s=;
 b=ehUvjEdpMjmmP1WH+H4xKV8vn7gBYDqptH4CpwjDb7/zxQkFeU4WpZzZGRPm67Keuk
 xv1C8OEqGz+L8mhOwIawfZGLhHSgaP1l49D0c2zoxk3mwh0eN/VB2WbofHpYuN0C5xGk
 SG0MBdpHlN0DVlmJ2wpmfWIrFmgX5NIErn/lQpkJ67clgOCDipnqQpFQiWzTH8m3Pp3N
 HqGi8Pg4sWCtditqci9c/NMihIvD2uANYdGRN/L3/mbT+zGvn9kdZalgtvlkPY2PNtJ8
 RpxZJOazzE2WstMogUtF/Drt+jp2Xk0rps6c0fG9JPXxgYxJG4XTNgm/7ttndsitQtjC
 p6rw==
X-Gm-Message-State: AOJu0Yx8Kt6dxzJkXdujMOBQa0UAsjFijrgaIitTWcAGlsmmWNmnjXps
 NCtoGaHah5BYGCZVxpzBaTJgKVqO0OrWwt8hOeV8CZ0Yihf/oZFvezPKvK6dWfI2gkHxDKam4d/
 yzPN1DYJLzf9wBto=
X-Received: by 2002:a05:600c:2114:b0:3fe:d630:f568 with SMTP id
 u20-20020a05600c211400b003fed630f568mr8412170wml.39.1693907789696; 
 Tue, 05 Sep 2023 02:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8MDdO9bfkXT4W/MDeM1Q+VRDiivhYmbuBJA5vFlQ5SCQsgGGAqa4bis/YMwovvZzxcwNy8Q==
X-Received: by 2002:a05:600c:2114:b0:3fe:d630:f568 with SMTP id
 u20-20020a05600c211400b003fed630f568mr8412163wml.39.1693907789412; 
 Tue, 05 Sep 2023 02:56:29 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a7bcc85000000b003fe1a96845bsm19644283wma.2.2023.09.05.02.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 02:56:28 -0700 (PDT)
Message-ID: <e6a845f3-4308-370b-e062-f34106daaad2@redhat.com>
Date: Tue, 5 Sep 2023 11:56:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [risu PATCH 2/4] s390x: Add simple s390x.risu file
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
References: <20230904140040.33153-1-thuth@redhat.com>
 <20230904140040.33153-3-thuth@redhat.com>
 <b25fa578d588f29a7dc3f7817f0e6ea253647b11.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <b25fa578d588f29a7dc3f7817f0e6ea253647b11.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/09/2023 16.20, Ilya Leoshkevich wrote:
> On Mon, 2023-09-04 at 16:00 +0200, Thomas Huth wrote:
>> This only adds a limited set of s390x instructions for initial
>> testing.
>> More instructions will be added later.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   s390x.risu | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>   create mode 100644 s390x.risu
> 
> Can this be somehow automatically derived from
> target/s390x/tcg/insn-data.h.inc?

Hmm, maybe ... OTOH, if something is wrong in that file, you won't find the 
bug with RISU is you used the same source, I guess...

> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks!

  Thomas



