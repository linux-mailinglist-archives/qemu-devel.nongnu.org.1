Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E297BAF64
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 01:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoXyS-0001h1-3o; Thu, 05 Oct 2023 19:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qoXyP-0001gZ-0W
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 19:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qoXyL-0001uJ-TG
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 19:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696549294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wBdmR1TWK2OvlMb8+ioQNuzBS2AY0xYEtzQBiDKYRoA=;
 b=JJWWGKnhGWoB6ZEiW9hPJZlG/uzSZaj4fLfBx4WxmbDTQaahNH8pYnwL5WL4perAAepWJ9
 kWQ79LyiSfqP0xT1txyzC+wbatJilPaks/db7iH5ULlX3NLDuwXIyLDVtO/QNeIRZjdEr4
 SmXWGKh58dcUMITvEOJgnVbIW2WP5j4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-h2SxvnrXP1itPLwbOUZdqg-1; Thu, 05 Oct 2023 19:41:33 -0400
X-MC-Unique: h2SxvnrXP1itPLwbOUZdqg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-65b23c40cefso13961286d6.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 16:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696549293; x=1697154093;
 h=content-transfer-encoding:in-reply-to:to:from:references
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wBdmR1TWK2OvlMb8+ioQNuzBS2AY0xYEtzQBiDKYRoA=;
 b=jkh87y+OU1Y2U+oYY/4ONrg86BRyy2DL6tNw/I25rUy7f30kmMTFjiC7QgGmSQXSVN
 1+8NR+eXfzWVVcS2/k/joJ9+kwvcaFTBRzwooXnF8wNoU5ly+rW7Vj66zjJJCugXxcF4
 Sb5/WhMTLAz5pDp2J90q8wM03I7rgTo8AA5gFPvVl6r+uy9QiwmhNnbmII6WfeutsK36
 Pb3V7UymtiK/nRIItRVf0qh6R8mCyhvmAs+Oj77EJN9fTOZQ3RUJt+lFS9YcPB0Ntm8A
 oiO3ehwt7NokVcOGqI0h0xdUGfZ0FHnxtvBtlpn1pQwtA+tmC1/N4bNlWIPskPDZsDsq
 tMXQ==
X-Gm-Message-State: AOJu0Yw8JjEj983TXs+MCDQYTKjWp63ffXBlHSiKe4sqQep7NNwPLZXY
 07oU7H4wLdBzDpgLdqN8IWUKvtglk89bjvtSDOut9BJ9DTiXlQOtRDr4boA7KR+rHKNPRf9v6jK
 bqdBX5gz44vZLIzA=
X-Received: by 2002:a05:6214:398a:b0:659:abd1:8d37 with SMTP id
 ny10-20020a056214398a00b00659abd18d37mr6830500qvb.4.1696549292900; 
 Thu, 05 Oct 2023 16:41:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHffRzHYTuz3/f6IChyXx/LTgxC8LKLOHm1XMLZmnyLPTdanlKaaof50puDHH8Y4SrozKsnnQ==
X-Received: by 2002:a05:6214:398a:b0:659:abd1:8d37 with SMTP id
 ny10-20020a056214398a00b00659abd18d37mr6830490qvb.4.1696549292546; 
 Thu, 05 Oct 2023 16:41:32 -0700 (PDT)
Received: from ?IPV6:2600:4040:7c46:e800:32a2:d966:1af4:8863?
 ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 u21-20020a0cb415000000b0065b0771f2edsm904048qve.136.2023.10.05.16.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 16:41:31 -0700 (PDT)
Message-ID: <a34e5041-e71f-9689-ed58-000b54704c89@redhat.com>
Date: Thu, 5 Oct 2023 19:41:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Content-Language: en-US
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
 <11900163-bca6-daf0-8b70-b0109a7f6957@linaro.org>
From: Tyler Fanelli <tfanelli@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
In-Reply-To: <11900163-bca6-daf0-8b70-b0109a7f6957@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/5/23 2:03 AM, Philippe Mathieu-Daudé wrote:
> Hi Tyler,
>
> On 4/10/23 22:34, Tyler Fanelli wrote:
>> The Rust sev library provides a C API for the AMD SEV launch ioctls, as
>> well as the ability to build with meson. Add the Rust sev library as a
>> QEMU subproject with the goal of outsourcing all SEV launch ioctls to C
>> APIs provided by it.
>>
>> Signed-off-by: Tyler Fanelli <tfanelli@redhat.com>
>> ---
>>   meson.build                   | 8 ++++++++
>>   meson_options.txt             | 2 ++
>>   scripts/meson-buildoptions.sh | 3 +++
>>   subprojects/sev.wrap          | 6 ++++++
>>   target/i386/meson.build       | 2 +-
>>   5 files changed, 20 insertions(+), 1 deletion(-)
>>   create mode 100644 subprojects/sev.wrap
>
>
>> diff --git a/subprojects/sev.wrap b/subprojects/sev.wrap
>> new file mode 100644
>> index 0000000000..5be1faccf6
>> --- /dev/null
>> +++ b/subprojects/sev.wrap
>> @@ -0,0 +1,6 @@
>> +[wrap-git]
>> +url = https://github.com/tylerfanelli/sev
>> +revision = b81b1da5df50055600a5b0349b0c4afda677cccb
>
> Why use your tree instead of the mainstream one?
>
> Before this gets merged we need to mirror the subproject
> on our GitLab namespace, then use the mirror URL here.
>
The required meson changes for the sev library are still in review, so 
I'm still working on a personal branch. Those patches are a blocker for 
this series right now.

This is moreso another RFC to get feedback on building Rust libraries as 
QEMU subprojects (and if this is the proper way to do so).


Tyler


