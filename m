Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8E7BAF04
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 01:02:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoXKu-0001np-4r; Thu, 05 Oct 2023 19:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoXKc-0001Zw-1M
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 19:00:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoXKa-0000WU-9H
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 19:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696546828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EZsYxMoUYLYYpvqfpR02nm5RlV/gDaujQHR+y94vQDY=;
 b=V3Qhg+VJHo2nfGlNkncll6DPogSefG8+afWubbrLFGgjBM5RuWesx7gH3rfdumPZmX0Bhz
 eD/wN7aVcvEJGyUujEz5BWI58GddjghzplWKuYlHtZ1MpAhWqNJslS+41JsrM6GO2T8NT3
 yYqPMa5WADS2ogL5G2Cc7XviIzl0xoo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-ngbJvLm-PSSpP_egm0Pikg-1; Thu, 05 Oct 2023 19:00:27 -0400
X-MC-Unique: ngbJvLm-PSSpP_egm0Pikg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso126028566b.1
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 16:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696546826; x=1697151626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EZsYxMoUYLYYpvqfpR02nm5RlV/gDaujQHR+y94vQDY=;
 b=KWM/9n39F3R17Hi5/VA4XqGs8YAivypU8ZBUJ7/5qfsg7juwfNfzapjZgLt0lDIn9d
 pD0oEDgvpZ3L+ZSjyzSPWOanKyYudAhNKj8oSdTKS01qExLvG9UvsGCrMzjB6sLDKP/X
 M88GqNJrK6Cq2qlAh6yROlIlb4gDHrFfIL7mOauC7+mIUWClyTPkBOYxlW+z12VQfU11
 YpbFGW5hAOIxgqE0CAQixJs6aFX2ORTS2Pdhlnza8R9rAwt+Ecjd0bdbi0FI+QGgYE5n
 4GBSKoBMalRQlMoTlqyHa2HLo3ysfB14jXzOCRj5WNXM8DZTqBQTmK4JExUqmLEIfWN/
 eqgg==
X-Gm-Message-State: AOJu0Yz3MkaUrSNuhJ5nTf076N27jJ7oYSFT1+6lTWjRBlP5Gli9aBkK
 h4jG/Wthvd1Qmc/E+hdevZRnYrqUkerG/uxOz/mjjEEFbzyJcvzGSVdkFqP28b2opKn2rdhcPkl
 7BqNsqyWVYtDhQGg=
X-Received: by 2002:a17:906:7383:b0:9ae:6196:a4d1 with SMTP id
 f3-20020a170906738300b009ae6196a4d1mr6206983ejl.68.1696546826066; 
 Thu, 05 Oct 2023 16:00:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt3EF6xQDgjsHY9v9hvf4SR5WNm1mzSATpvVx6eisoZCQsWvr9Bcp7nfBmC6e94XSAstE4FA==
X-Received: by 2002:a17:906:7383:b0:9ae:6196:a4d1 with SMTP id
 f3-20020a170906738300b009ae6196a4d1mr6206977ejl.68.1696546825773; 
 Thu, 05 Oct 2023 16:00:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 u2-20020a17090617c200b009ad8084e08asm1857173eje.0.2023.10.05.16.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 16:00:24 -0700 (PDT)
Message-ID: <52763bb3-77e8-3f1e-5826-ddc23173eae2@redhat.com>
Date: Fri, 6 Oct 2023 01:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 4/5] hw/intc/apic: Rename x86_cpu_apic_create() ->
 x86_cpu_apic_new()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-5-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231003082728.83496-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 10/3/23 10:27, Philippe Mathieu-Daudé wrote:
> -        x86_cpu_apic_create(cpu, &local_err);
> -        if (local_err != NULL) {
> -            goto out;
> -        }
> +        x86_cpu_apic_new(cpu);

I don't like this, "*_new" is generally for functions that return what 
they create.

Patch 2 is scary with the newly-introduced possible failure, but I 
suppose it's safer if you reason that any problem will occur at startup, 
not at hotplug time for example.

Paolo


