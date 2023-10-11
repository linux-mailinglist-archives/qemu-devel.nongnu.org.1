Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB17C481F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 05:06:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqPXq-0004ea-Dj; Tue, 10 Oct 2023 23:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qqPXn-0004eS-Fb
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 23:05:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tfanelli@redhat.com>)
 id 1qqPXl-0001sN-QP
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 23:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696993547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h2v4UnxDXQO66iJHW43eQFuDKL30rZI1OIRlWIl9vUU=;
 b=Krs4CewajnM0i/Y6rgxUeLn72JBnpaX72CQy7EjC20lfAcxclJTSMmbiJ7mztPZfgCfg7n
 zHqmSfMmcP69kCFtM2O+z07uH1u0utrBQrxeIqHUIESkFDmiDO2IDBZ1xMShGnQEpL3Mvx
 thIW0YXI39OuAcihH0jZ/0H1JN3WBO8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-KXDmR-DxNPyTt7iw9W6j0Q-1; Tue, 10 Oct 2023 23:05:46 -0400
X-MC-Unique: KXDmR-DxNPyTt7iw9W6j0Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4180b3a5119so75131591cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 20:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696993546; x=1697598346;
 h=content-transfer-encoding:in-reply-to:to:from:content-language
 :references:cc:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2v4UnxDXQO66iJHW43eQFuDKL30rZI1OIRlWIl9vUU=;
 b=SlenXGAGAUzn8eF4SbIi/yxEDGyvmqf6L4uYwERWcaBxb/nDGA0wP+MPjHgg3Qt0wE
 JzMe3FFn9b0MHePH/vSNzl2fvA7U3ippMKzcW1NU3YazScZUdljXynqCGqjpDnc3je8m
 +x+IOWZ3TOozuYCPl+ZMnJuN7gYoFc2ezaRaf2rV27h0tHAlucbxS5cgkiT10o9wOjJ3
 0uiGewVMhrg3+Tl9OcshSu0W2HWLSBWEKvmb8KRfcveALuYrYZA3azchEzhNliXO6fbG
 6SkCbJeqYj3zmhb81ssnC//bZ5G3ZQU2Hnf4TRg4FBPVNAHDyCWVKOSILIi/iKNk8tF4
 brdw==
X-Gm-Message-State: AOJu0Yz2e19yC0fLpeZyFPRT7Dx4e7VwvKbGipqG7sSebuVCOzjP6tTg
 WotUTPbI7dSBQDQLzp87EnP1eBPUQHtEee4S3SxCpQiCu7IRGqm/daipw1jzonpeU47vJiquPMI
 V3C1+H/doN7SHfjo=
X-Received: by 2002:a05:622a:30c:b0:417:f9e1:664f with SMTP id
 q12-20020a05622a030c00b00417f9e1664fmr24580892qtw.36.1696993546177; 
 Tue, 10 Oct 2023 20:05:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEf7kr3NgG6VBThWN66g/Iq7EM4CH4TleeRaQarwyCRD+FHFR/Ps+Cct3HqSMdPcM56YR1XCQ==
X-Received: by 2002:a05:622a:30c:b0:417:f9e1:664f with SMTP id
 q12-20020a05622a030c00b00417f9e1664fmr24580874qtw.36.1696993545874; 
 Tue, 10 Oct 2023 20:05:45 -0700 (PDT)
Received: from ?IPV6:2600:4040:7c46:e800:32a2:d966:1af4:8863?
 ([2600:4040:7c46:e800:32a2:d966:1af4:8863])
 by smtp.gmail.com with ESMTPSA id
 x25-20020ac84a19000000b004108ce94882sm5003235qtq.83.2023.10.10.20.05.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 20:05:44 -0700 (PDT)
Message-ID: <8acd90e8-8f83-452d-bdd3-7dd173813ffe@redhat.com>
Date: Tue, 10 Oct 2023 23:05:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/9] Add Rust SEV library as subproject
Cc: pbonzini@redhat.com, mtosatti@redhat.com, stefanha@redhat.com,
 berrange@redhat.com, marcandre.lureau@gmail.com
References: <20231004203418.56508-1-tfanelli@redhat.com>
 <20231004203418.56508-2-tfanelli@redhat.com>
 <11900163-bca6-daf0-8b70-b0109a7f6957@linaro.org>
Content-Language: en-US
From: Tyler Fanelli <tfanelli@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
In-Reply-To: <11900163-bca6-daf0-8b70-b0109a7f6957@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tfanelli@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Hi Philippe,

Why must the subproject be mirrored on qemu's GitLab namespace? With the 
changes being accepted in the upstream sev repository, meson will be 
able to fetch it from there. I see that libblkio (another Rust project) 
is not mirrored in the GitLab namespace [0] (assuming I'm looking in the 
right place) and that meson also fetches it from its upstream repo [1].

[0] https://gitlab.com/qemu-project

[1] 
https://gitlab.com/qemu-project/qemu/-/blob/master/subprojects/libblkio.wrap?ref_type=heads#L2


Tyler


