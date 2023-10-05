Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 156C07BA01F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 16:33:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoPOj-0005rW-Hj; Thu, 05 Oct 2023 10:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoPOb-0005qq-Vs
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qoPOW-0005Up-G9
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 10:32:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696516319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=By4HQqu0HduQ7XjjwLx5typ/4r8lacldykqjQcqGRTc=;
 b=fmIAGjKghtkHOJ/JJ6H9OfTCazo89inRJ8+XoySNyziU8T0YB1UNoJvTElIOncI3gSi2Vl
 n071lyzSw8bPjf/gxjbBto+mtYBOYYg74Ok/4sRG/n31edsYMFjRFE8OeHwLROgH/GsGXe
 k0aohMt8XSckJUk2SjQYu0ATUybrh2Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ETh2WCMoOAyXPQXIdnP5Pg-1; Thu, 05 Oct 2023 10:31:55 -0400
X-MC-Unique: ETh2WCMoOAyXPQXIdnP5Pg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b2e030e4caso245815066b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 07:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696516312; x=1697121112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=By4HQqu0HduQ7XjjwLx5typ/4r8lacldykqjQcqGRTc=;
 b=Anp/uQ2zPRx7Qa8hzUA9a5ItdaFxNEZGWfh2V75IJAUKPEd1hXPAa8leGUUucI6Ox7
 5+YpFy6TVfSzH+fX10pzpsqQ7c5q9viCBn4go95dKzwx6Mik8khjuPbXjpLMH9pdXYbI
 0bXKAA/U3v196SCQ6HdRkIiqPXTBktcXz8g7SqnXQXo2nCHyl3b5vmh+FvhPRYZW4gae
 wbbd3G3MG3wxUnXyjvQYAjCoblPxAq32Rn3Vawye5oTVlxlhRQP1g1l7NHgKCrmrxyie
 yoPPTYIS8FcWn/LnE2BvS3yTocj7aBj1AhjUjFXYOH/iGWp9gukbQlOe+x5fNV8YEinq
 xtyA==
X-Gm-Message-State: AOJu0YxWM5obqBkmrk9onUFz/noFWbfXzx6yct9gYoR8k/TmOOtj05T/
 2u+6lKGAqiW3E7GCAp9Bc28JNLFhHvR+oO7z9FbPmdr4mt+7QakA4Jh5JOS8C/X3qfXVTeVsKI6
 CWCKU0bfeO5Bkaj0=
X-Received: by 2002:a17:906:fd84:b0:9ad:e3fd:d46c with SMTP id
 xa4-20020a170906fd8400b009ade3fdd46cmr1345928ejb.10.1696516312431; 
 Thu, 05 Oct 2023 07:31:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzJxESbg25EcO47evB/Wk6Y/mZjG+/kz15xGe0N33SUr3R/XB5rZQJ8J8IsBrd9KJ00snGlg==
X-Received: by 2002:a17:906:fd84:b0:9ad:e3fd:d46c with SMTP id
 xa4-20020a170906fd8400b009ade3fdd46cmr1345900ejb.10.1696516311987; 
 Thu, 05 Oct 2023 07:31:51 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 t8-20020a17090616c800b009a1be9c29d7sm1291106ejd.179.2023.10.05.07.31.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 07:31:51 -0700 (PDT)
Message-ID: <454b4732-d9ce-3cc5-e018-8fe2f88cc406@redhat.com>
Date: Thu, 5 Oct 2023 16:31:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add some unowned files to the SBSA-REF
 section
Content-Language: en-US
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230929141918.397096-1-thuth@redhat.com>
 <ZRb3aTLxBSnVGGr2@qc-i7.hemma.eciton.net>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <ZRb3aTLxBSnVGGr2@qc-i7.hemma.eciton.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-4.219, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 29/09/2023 18.12, Leif Lindholm wrote:
> On Fri, Sep 29, 2023 at 16:19:18 +0200, Thomas Huth wrote:
>> These files belong to the sbsa-ref machine and thus should
>> be listed here.
> 
> First of all, thanks for this.
> 
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 874234cb7b..fc415d3cea 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -954,6 +954,9 @@ R: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>   L: qemu-arm@nongnu.org
>>   S: Maintained
>>   F: hw/arm/sbsa-ref.c
>> +F: hw/misc/sbsa_ec.c
> 
> Yes, pure oversight, sorry about that.
> 
>> +F: hw/watchdog/sbsa_gwdt.c
>> +F: include/hw/watchdog/sbsa_gwdt.h
> 
> I just want to clarify that this is not "the watchdog for the SBSA
> platform", but "the watchdog defined by Arm's SBSA specification"
> (and belatedly the BSA specification)" - the specification that
> sbsa-ref (intends to) provide a compliant platform implementation for.

Thanks for the clarification!

> Another such component is the "generic UART", but since that is a
> subset of pl011 there is no real value in providing a dedicated model
> of it.
> 
> Which I guess is a long-winded way of saying: this component does not
> necessarily want/need the same maintainers as the sbsa-ref platform.
> I'm still happy to maintain it, and it may make sense to keep it under
> this header for now.

I think as long as the sbsa-ref machine is the only one in our git tree that 
uses this device, it's fine if we add the sbsa watchdog to this section 
here. If there will ever be another machine that uses this device, we can 
still reconsider and create a dedicated section for it in the MAINTAINERS 
file if necessary.

> (In which case
> Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
> )

  Thanks!
   Thomas



