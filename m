Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7433779711B
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 11:06:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAxg-0003wh-0Y; Thu, 07 Sep 2023 05:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAxd-0003qf-Ey
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:06:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAxZ-0001lC-5h
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 05:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694077554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSRw5+22dP6lzRpJu5j9zBESFV2A3c5OurJOdwX2Qac=;
 b=X1vNDbNEsftjJQxxkQJHZ00jO5qFNQFxaL++wHSHYNpz+1RSYFgdAswwf/WZOXL5NOMAqI
 n1N3T3OHZ6tnAt7G/1TVddk5UEo+TDVF/D1WTDnMQYR2+pHYN4mUkDG69rVIVYJxdeEPhe
 CptM/3DEgnh6QMw9ejEDg7HetpSdIWA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-mvxxGHB9PeO6JO4TI_sL8w-1; Thu, 07 Sep 2023 05:05:52 -0400
X-MC-Unique: mvxxGHB9PeO6JO4TI_sL8w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31aed15ce6fso465399f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 02:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694077551; x=1694682351;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CSRw5+22dP6lzRpJu5j9zBESFV2A3c5OurJOdwX2Qac=;
 b=UMsa/Q1VjmS4GxjmncH1h9tobsbYhtM+efmcOE8tgNc3kNh9/LaSTgBZ7CCjlQIk8g
 GOC/FWKMsLH3cBWKTnQ+s8iHvGGdjP1YOMCNYM2yOO2E9lhFZAeOf8Sk3HQRY41d3uoo
 0Gm9Nr64iMg2ZsC81lG5RAegCydQ4JowQTw8kWQyNuAIq+RplmhD4UYXKQs/RgJzUhPa
 RsZ2CWaW65rLIcfvIe1hYTmKC/TbXDRVqXzyQ01hPcK/oOaiX2wK6YiNAQfJ72aYOYyj
 x/p8XFQzPCWPtNDsdMrcUSD7TzkOsls6JGSPAJLCrEi+Fk16lkw1SiNl6UR0yfl4x993
 xWbw==
X-Gm-Message-State: AOJu0YxZVIPakLiHqgfNzpBhv4fCnOtIDxaO+RCD1rKo933ym+pTH72x
 uqXzzGAG1jhTDs56Asx0ZsByl6PttMcYpvwS7PEuiYHw3ddAO5Ue0546ob4MEmCasPuoBbmI+wh
 V5NMQTIB1XRz7PCU=
X-Received: by 2002:a1c:7206:0:b0:401:2ee0:754a with SMTP id
 n6-20020a1c7206000000b004012ee0754amr4602756wmc.13.1694077551112; 
 Thu, 07 Sep 2023 02:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXxRVIe9SQDIU06sef/Tg6egG2+8pqGbdjoVGVlKMxDi3Sj9Nnz41karYwwzP8XGB2hfUrPw==
X-Received: by 2002:a1c:7206:0:b0:401:2ee0:754a with SMTP id
 n6-20020a1c7206000000b004012ee0754amr4602727wmc.13.1694077550834; 
 Thu, 07 Sep 2023 02:05:50 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 c25-20020a05600c0ad900b003fee567235bsm1894884wmr.1.2023.09.07.02.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 02:05:50 -0700 (PDT)
Message-ID: <ea0464ed-fd1d-001b-09f2-e71220d862be@redhat.com>
Date: Thu, 7 Sep 2023 11:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 16/20] tests/avocado: s390x cpu topology entitlement
 tests
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-17-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-17-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Test changes in the entitlement from both a guest and a host point of
> view, depending on the polarization.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   tests/avocado/s390_topology.py | 55 ++++++++++++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> index d7ee36cb89..733093723a 100644
> --- a/tests/avocado/s390_topology.py
> +++ b/tests/avocado/s390_topology.py
> @@ -243,3 +243,58 @@ def test_polarization(self):
>           res = self.vm.qmp('query-s390x-cpu-polarization')
>           self.assertEqual(res['return']['polarization'], 'horizontal')
>           self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +
> +    def check_polarization(self, polarization):
> +        """
> +        We need the polarization change to get stabilized in kernel
> +        before we check it through the sysfs.
> +        """
> +        exec_command_and_wait_for_pattern(self,
> +                """ sleep 1 ;
> +                    /bin/cat /sys/devices/system/cpu/cpu0/polarization """,
> +                polarization)

Using "sleep" in a function that is called multiple times will blow up the 
testing time quite a bit ... could this be done in a different way instead, 
e.g. by polling the sysfs file for the right value, or maybe there is 
something in the "dmesg" output that could be used as a reference?

  Thomas



