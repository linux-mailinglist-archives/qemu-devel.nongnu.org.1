Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB28792265
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 14:02:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUjy-0006ie-6T; Tue, 05 Sep 2023 08:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUju-0006fx-G6
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:01:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qdUjq-0003hx-Gb
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 08:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693915257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HCCXf2F3PhaAB0+YdKTrrumdl+P7W3CudQBNBNw0eiw=;
 b=FdfZPPlwJrFmJajuAXNtsFsTToUtP2/udufw9IfZ1nurDzxLZA2wLAd7Soyp3eLgs8Qg4y
 K3TH7RSk54NRzNiinfmAKq4wJx9OHObiBbAGwbLEDUwteW5axngtnARTcLzqvG5Q5OmbHQ
 flNHEn3BrrB01pkmoJzgu780oy0IJ7c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-5Bko-WvRMniyuFp2yaECKQ-1; Tue, 05 Sep 2023 08:00:55 -0400
X-MC-Unique: 5Bko-WvRMniyuFp2yaECKQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fefea09bd0so15094905e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 05:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693915254; x=1694520054;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HCCXf2F3PhaAB0+YdKTrrumdl+P7W3CudQBNBNw0eiw=;
 b=IZIPkYH2RVfP1yfVl+NgeToOyQbbaUsoz52Nj3jDN4s7K2PXD2XOhWJYBNxerts5zY
 z5kY8q20VwA5Yq5H54tOXPx1kFl2ZxLbpeHhednggAmaP22UxD9lC3U7fBPL4UTF8uHV
 gqSF522T2YdqHpe5sA3atVe1zFqHVKxspU4JgFFD68Q2q/ZggjE2rFgsZKJQ5nCXA0C8
 LZNPMQh7hmzeycwK8N8ODWiHHqL5vajoNLVcYFdixcQcFzSIPKsuOTuzWMdWh5MfS+i7
 eLFPNY3bGIt+pGb6Ny0GVYs50lmCC4mRoE7LECNVyXVsekEuTUa5Il11bpPKQfQyx7vm
 9f9Q==
X-Gm-Message-State: AOJu0YzNvB1QZgK5oERZ6egsH/o9Hs2U1zZxJEKSgNIzXmCuF2KkRruT
 Vi1D/TfrUQ0JI066YUyVv7xOjKcOFHLowh/vrd6mTj2II5TnYDHbzEnBldXYSoSEBMN72ZXUCZS
 Vx/RNCqKLWK1QcZo=
X-Received: by 2002:a05:600c:225a:b0:401:b204:3b97 with SMTP id
 a26-20020a05600c225a00b00401b2043b97mr10059553wmm.4.1693915254574; 
 Tue, 05 Sep 2023 05:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUo6e4zF0/IVyH5gGlRSmqni6JmI9/2RS16un7W9k3FS4DGWvgwKJy49ceuDvw5Zoqojtu9w==
X-Received: by 2002:a05:600c:225a:b0:401:b204:3b97 with SMTP id
 a26-20020a05600c225a00b00401b2043b97mr10059531wmm.4.1693915254206; 
 Tue, 05 Sep 2023 05:00:54 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a7bc40f000000b003feee8d8011sm19882131wmi.41.2023.09.05.05.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 05:00:53 -0700 (PDT)
Message-ID: <39d2a035-f51a-31a6-b294-919d4a27933d@redhat.com>
Date: Tue, 5 Sep 2023 14:00:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230904140040.33153-1-thuth@redhat.com>
 <d5e28e46b9fab10c0a505fd49f86c12481b9e185.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [risu PATCH 0/4] Add support for s390x to RISU
In-Reply-To: <d5e28e46b9fab10c0a505fd49f86c12481b9e185.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 04/09/2023 16.30, Ilya Leoshkevich wrote:
> On Mon, 2023-09-04 at 16:00 +0200, Thomas Huth wrote:
>>   Hi Peter!
>>
>> Here are some patches that add basic support for s390x to RISU.
>> It's still quite limited, e.g. no support for load/store memory
>> operations yet, but the basics with simple 16-bit or 32-bit
>> instructions work already fine.
>>
>> (In the long run, we'd need to support instructions with 48-bit
>> length on s390x, too, since most newer "interesting" instructions
>> like e.g. vector SIMD instructions are encoded with 48 bit. This
>> will require modifications to the generic code, too, so I limited
>> my initial implementation to 16-bit and 32-bit instruction length
>> support to keep the code self-contained in the s390x architecture
>> specific files)
> 
> What's also interesting about SIMD, is that floating-point instructions
> clobber the upper parts of vector registers. I wonder if there is a way
> to systematically solve this?#

No clue yet, so far the code does not support the extended vector registers 
yet (since the weren't part of the information that is provided by the 
ucontext.h header file).

I guess it should be OK to check only the floating point part for the 
registers where it overlaps, and only check the full vector register if the 
register does not overlap ... I don't expect much difference for a vector 
instruction when it executes with register 0 - 15 compared to when it 
executes with register 16 - 31, so skipping half of the check for register 0 
- 15 shouldn't be too bad.

> One other thing - for not-so-near future - is it possible to integrate
> this with coverage-based fuzzers? I.e., somehow generate the
> instructions based on the coverage signal. Maybe even make sure that
> the signal comes from JITed code too. I wanted to try AFLplusplus in
> QEMU mode for this purpose (which would ultimately run QEMU in QEMU),
> but never found the time.

I don't think this is possible yet, but maybe it's be possible to write a 
TCG plugin for QEMU to dump the executed instructions into an input file for 
risu?

  Thomas


