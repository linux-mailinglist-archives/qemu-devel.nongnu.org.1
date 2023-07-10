Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7921174D4FE
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpjc-0006Ad-Q5; Mon, 10 Jul 2023 08:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpjS-00063H-Hu
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIpjQ-0001rV-0C
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZhAlYnIhAjvuhmMm+cYmQWN65YRA3JYBO+OgLBOM78c=;
 b=JPxoUnWiPcL+aSyX7FhvVXjIucTXdZvHTyfYfKUqmZ1MYs5VISBg4M/r4UGfl/6lklnHJG
 1uaAyB77OVXChZCuETmBsrXJrJi/FazQIzgay9LPUqdyQQB7n0FJh/CA36D9K92gboksvd
 NBJYcDlqOeKZrfncRvkR4ae9vpIiUk0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-tMEIEPwUM0q8CYw277i4Mw-1; Mon, 10 Jul 2023 08:11:03 -0400
X-MC-Unique: tMEIEPwUM0q8CYw277i4Mw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7659cb9c3b3so405532885a.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688991063; x=1691583063;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZhAlYnIhAjvuhmMm+cYmQWN65YRA3JYBO+OgLBOM78c=;
 b=g2/VtZCzA9m7SxTPQEeXvy78tIsgzddh9OsFtQDVfuzXgyVP2r3zLJ6dmyWmg428hl
 xHo5xiLnvaF5r4nQe4b7Mc1O75jHZbQLbyer1qpxsI64WwXtQK9sNz/7WOocTlNVJzfP
 3Kv6GsS9g4kQ9+Yf9QqAoXh2mkiBIdgPPiVpyeiOCr8Ye0nLd17quthUo9Td5dAsAZ/T
 OVGkbVhfEeJAhDTkZvrdMJ69pZsUE9x/TFjhDqLHgnl809rtNV0fO2fQA1jQJy0BdE5T
 K+k7uFzMJuRgb3K2YWBzsw9+gtaaRNI14KZD9cqS6fPlZ0x9Abq1pvugZb7V4YyXLtC0
 8pGQ==
X-Gm-Message-State: ABy/qLZoZH+RXCbP13++IWKQa7rtyNEyu2roEuzpr2+BqQEXJHi0QOVG
 m0Mo0W8n1L/Vd5YsHQ0GGvYnuKM94h9BneGKpX6aiIAJ7PSpFSuSY3irWV91C3Uoiv+0Vwl0IcD
 CRNLigzkYCHwEI+o=
X-Received: by 2002:a37:b605:0:b0:767:4068:1e06 with SMTP id
 g5-20020a37b605000000b0076740681e06mr7404242qkf.78.1688991063460; 
 Mon, 10 Jul 2023 05:11:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlETQ6pMmlGsaAQFUimX1hDPE3fkyps3ru3aJYXCRU3vg3Ya2MA3gX2no7l4u1rvtOfKArFqRg==
X-Received: by 2002:a37:b605:0:b0:767:4068:1e06 with SMTP id
 g5-20020a37b605000000b0076740681e06mr7404220qkf.78.1688991063242; 
 Mon, 10 Jul 2023 05:11:03 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 z23-20020ae9c117000000b00765a9f53af0sm4800683qki.128.2023.07.10.05.11.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 05:11:02 -0700 (PDT)
Message-ID: <f9442f36-fe47-2dfd-2bb6-ae9c007a7511@redhat.com>
Date: Mon, 10 Jul 2023 14:10:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 03/18] tests/avocado: Add set of boot tests on SBSA-ref
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: richard.henderson@linaro.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:SBSA-REF" <qemu-arm@nongnu.org>
References: <20230427154510.1791273-1-alex.bennee@linaro.org>
 <20230427154510.1791273-4-alex.bennee@linaro.org>
 <e61e3522-2cd4-9e81-e74b-2932a53b8da0@redhat.com>
In-Reply-To: <e61e3522-2cd4-9e81-e74b-2932a53b8da0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 28/04/2023 12.33, Thomas Huth wrote:
> On 27/04/2023 17.44, Alex Bennée wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> This change adds set of boot tests on SBSA-ref machine:
>>
>> 1. boot firmware up to the EDK2 banner
>> 2. boot Alpine Linux
>>
>> Prebuilt flash volumes are included, built using upstream documentation.
>>
>> To unify tests for AArch64/virt and AArch64/sbsa-ref we boot
>> the same Alpine Linux image on both.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-Id: <20230323082813.971535-1-marcin.juszkiewicz@linaro.org>
>> Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
>> Message-Id: <20230328171426.14258-1-philmd@linaro.org>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Message-Id: <20230424092249.58552-4-alex.bennee@linaro.org>
> ...
>> +    def test_sbsaref_edk2_firmware(self):
>> +        """
>> +        :avocado: tags=cpu:cortex-a57
>> +        """
> 
> This is failing for me in the gitlab-CI:
> 
>   https://gitlab.com/thuth/qemu/-/jobs/4196177756#L489
> 
> Could you please have a look?

This test is still failing for me occasionally:

  https://gitlab.com/thuth/qemu/-/jobs/4623296271#L290

If nobody has a clue how to make it more stable, I'd suggest that we disable 
it in the gitlab-CI ?

  Thomas


