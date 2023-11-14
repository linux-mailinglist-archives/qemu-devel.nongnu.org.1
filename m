Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF87EB33E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:14:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2v6Z-00016d-Oh; Tue, 14 Nov 2023 10:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2v6P-0000xr-4U
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:13:21 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2v6N-0006m4-I2
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:13:20 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-9d216597f64so873701166b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699974798; x=1700579598; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HIHi0yKkQuExrrqaReTTaHyYp9veWL43i8XQ+amSwZ4=;
 b=UOMLgSBY2D1oL0ctLDoVzk1xhfdVzKNWsc0YTuRXo+mgC/DF+8CJiWhpWY0ZAg0Wo4
 Q9DPxhVLoW6p3JH0us/MpIMgKb7HPVeDC20zt90hDR2OpxibwAENgBcafwYq9NbIb/5L
 dU0oEUYoIkQVXBFlGrNtVIIYyPbovJeHkXZMQMSpDkze0yIDs6ucamMuZhFkuKSVHg1H
 0qy5Wu3mh8vuWrUcmcrE5+DnUZA72zPoGQO2K9DJYVCng1q/JsggLmlPcFuOdBnJjMrZ
 ehTQ7YZsjJ5+doJFigvpnqdhkvxQzjqSYj3m8bYzvtvVsfGD7HWElAbIwm4jmx02Woqv
 8DRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699974798; x=1700579598;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HIHi0yKkQuExrrqaReTTaHyYp9veWL43i8XQ+amSwZ4=;
 b=wK8wnENRhTAFEyvwixIR9gPZRp03kz4iCbNjVt94KfaE9BOE/MFnxrW4diAqU+z1xJ
 vpHxGHFHZ9t4M5sYYh3zE9/0y2hxTz3VouzP6A2WMKaRyx2J/UIXMnGL/hwux3EWAXFo
 4Cpszq2px2NtrpePUggFIzN3o4311M3s5ICGYiPlBPSH19TTWLfMCM1gq5QivrdYLqO3
 lamXctJIldo5XDmLNCoFeduoQAZfKoF2Xuz7Usl2X8Ty3Xhf7VLBxCYkKnLBae1rssUQ
 xYiTXts/x26q4T7LtCzqs+EGtdxqgOYkyCPE4hoQSZfS+kcQ50Zb7ehgxGsOEOsmhAn5
 1kKQ==
X-Gm-Message-State: AOJu0YwX6YlS19VYpTxVnsCdO4Du8U0aGlbsrHOmTj21bhvDnleuo6D6
 9kY4wMn0D2P1ipAhfusQwcbOSw==
X-Google-Smtp-Source: AGHT+IHGFXgwRm95QaGDvzmEn8xmzfuJoAXM9MDWtXppVWdC9PPQJI2AOwqlfdbCPZx6yH7hHs/ywQ==
X-Received: by 2002:a17:906:c01:b0:9e5:d618:d6c1 with SMTP id
 s1-20020a1709060c0100b009e5d618d6c1mr8703674ejf.19.1699974797997; 
 Tue, 14 Nov 2023 07:13:17 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 fi6-20020a170906da0600b009e6a990a55esm5644531ejb.158.2023.11.14.07.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 07:13:17 -0800 (PST)
Message-ID: <04917b57-d778-41a2-b320-c8c0afbe9ffb@linaro.org>
Date: Tue, 14 Nov 2023 16:13:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 01/19] tests/avocado: Add 'guest:xen' tag to
 tests running Xen guest
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, David Woodhouse
 <dwmw@amazon.co.uk>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Anthony Perard <anthony.perard@citrix.com>, kvm@vger.kernel.org,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-2-philmd@linaro.org>
 <94D9484A-917D-4970-98DE-35B84BEDA1DC@infradead.org>
 <407f32ee-e489-4c05-9c3d-fa6c29bb1d99@linaro.org>
 <074BCACF-C8D0-440A-A805-CDB0DB21C416@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <074BCACF-C8D0-440A-A805-CDB0DB21C416@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 14/11/23 16:08, David Woodhouse wrote:
> On 14 November 2023 10:00:09 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>> On 14/11/23 15:50, David Woodhouse wrote:
>>> On 14 November 2023 09:37:57 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>>>> Add a tag to run all Xen-specific tests using:
>>>>
>>>>    $ make check-avocado AVOCADO_TAGS='guest:xen'
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>> tests/avocado/boot_xen.py      | 3 +++
>>>> tests/avocado/kvm_xen_guest.py | 1 +
>>>> 2 files changed, 4 insertions(+)
>>>
>>> Those two are very different. One runs on Xen, the other on KVM. Do we want to use the same tag for both?
>>
>> My understanding is,
>> - boot_xen.py runs Xen on TCG
>> - kvm_xen_guest.py runs Xen on KVM
>> so both runs Xen guests.
> 
> Does boot_xen.py actually boot *Xen*? And presumably at least one Xen guest *within* Xen?

I'll let Alex confirm, but yes, I expect Xen guest within Xen guest 
within TCG. So the tags "accel:tcg" (already present) and "guest:xen".

> kvm_xen_guest.py boots a "Xen guest" under KVM directly without any real Xen being present. It's *emulating* Xen.

Yes, so the tag "guest:xen" is correct.

> They do both run Xen guests (or at least guests which use Xen hypercalls and *think* they're running under Xen). But is that the important classification for lumping them together?

The idea of AVOCADO_TAGS is to restrict testing to what you want to 
cover. So here this allow running 'anything that can run Xen guest'
in a single command, for example it is handy on my macOS aarch64 host.

