Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 576877EB404
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:45:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vZ8-0003KU-Ua; Tue, 14 Nov 2023 10:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2vZ6-0003J2-EL
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:43:00 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2vZ4-00049b-7r
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:43:00 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9e5dd91b0acso684600166b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699976576; x=1700581376; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gCFoXhGCZFhwzHOt1ECCBxHdb8kGrjYPklFidAhJw58=;
 b=ACv+NtnMJk4j6bY/hA4rIxvzmtji5PBfMwtFyyik/+QgDmjfPEtqVQEdYfJYD9UIwj
 g8/hZyKZnL4b4r4oN1uyoJNfDTo2ehSZYEJqOCmcPoPe0E6G0V57yMCgP5LqOXFI3Icg
 /+yQYnZvyb4IFMe3mJNJpXaKy7cDs9GxyiUMfERhJVG7IMyPkIDZVXyGC0sK7hAEaIUq
 xZgWryY+1SgNc+QFJhhzQcO5IXwwLqAXUweZw4uXQvoy/oImOJPOJa6TJ5RTh2Uioj6E
 KvOiAe5KerCHGzEDCLkc0rdW/bTMq/AfMNDDG5qv+Axvb6YN6SqGec5UQ1h6Uuq3ojPW
 V73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699976576; x=1700581376;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gCFoXhGCZFhwzHOt1ECCBxHdb8kGrjYPklFidAhJw58=;
 b=vNtEv6vrOijuPZg22eWtGCyJ8h+42KAqOqAQfHNnBQAQk6yqPPRRr4ZrIqjfYI9LeI
 Y+wNhtu4VYqI72QlBOsxsXpI8MiirY+uHKJo1GGCR96wDQia8MAvoumQGmtYSfrS/UJ1
 3GpLNrWymVEmFYWGcr8OENpNzyUk6JQjdZvGiv51pchP69pNWtkiKXg04z5w2akuyF3N
 eUQT/tZsW41Flo/IIGs1Ck1zrcCN2K4Dg64SrnnIdVCrs0B/huzVlIgfliuK81gaN5h+
 1DuGS+7OA3dRpxCOT2lGA82o+0n0H2PklvAzkGixHpaEJ/XuOIjp2c1KCHVwd0RdSR5U
 Yr5g==
X-Gm-Message-State: AOJu0YwdZI0yoUuXgNjO3XjAvZZ/UKkOIdl9SHoV8QLJmbxEi2UYaBXB
 /T/cEu2bxUneBr3I3x2dBUce/A==
X-Google-Smtp-Source: AGHT+IHp79TSN3T1f0iR/8hTGuWsFNTOnvRmliGhAL1mNCFX7w4yOvOUPmAnOLIhILS3nzzmhv8aFA==
X-Received: by 2002:a17:906:1919:b0:9e4:121c:b9fd with SMTP id
 a25-20020a170906191900b009e4121cb9fdmr7690326eje.12.1699976576191; 
 Tue, 14 Nov 2023 07:42:56 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 dx5-20020a170906a84500b0099bd1a78ef5sm5691278ejb.74.2023.11.14.07.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 07:42:55 -0800 (PST)
Message-ID: <e298292d-fc40-44ca-9de2-1b159519836b@linaro.org>
Date: Tue, 14 Nov 2023 16:42:52 +0100
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
 <04917b57-d778-41a2-b320-c8c0afbe9ffb@linaro.org>
 <37D11113-662D-49FD-B1F1-757217EAFEEA@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <37D11113-662D-49FD-B1F1-757217EAFEEA@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 14/11/23 16:19, David Woodhouse wrote:
> On 14 November 2023 10:13:14 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>> On 14/11/23 16:08, David Woodhouse wrote:
>>> On 14 November 2023 10:00:09 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>>>> On 14/11/23 15:50, David Woodhouse wrote:
>>>>> On 14 November 2023 09:37:57 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>>>>>> Add a tag to run all Xen-specific tests using:
>>>>>>
>>>>>>     $ make check-avocado AVOCADO_TAGS='guest:xen'
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> ---
>>>>>> tests/avocado/boot_xen.py      | 3 +++
>>>>>> tests/avocado/kvm_xen_guest.py | 1 +
>>>>>> 2 files changed, 4 insertions(+)
>>>>>
>>>>> Those two are very different. One runs on Xen, the other on KVM. Do we want to use the same tag for both?
>>>>
>>>> My understanding is,
>>>> - boot_xen.py runs Xen on TCG
>>>> - kvm_xen_guest.py runs Xen on KVM
>>>> so both runs Xen guests.
>>>
>>> Does boot_xen.py actually boot *Xen*? And presumably at least one Xen guest *within* Xen?
>>
>> I'll let Alex confirm, but yes, I expect Xen guest within Xen guest within TCG. So the tags "accel:tcg" (already present) and "guest:xen".
>>
>>> kvm_xen_guest.py boots a "Xen guest" under KVM directly without any real Xen being present. It's *emulating* Xen.
>>
>> Yes, so the tag "guest:xen" is correct.
>>
>>> They do both run Xen guests (or at least guests which use Xen hypercalls and *think* they're running under Xen). But is that the important classification for lumping them together?
>>
>> The idea of AVOCADO_TAGS is to restrict testing to what you want to cover. So here this allow running 'anything that can run Xen guest'
>> in a single command, for example it is handy on my macOS aarch64 host.
> 
> Ok, that makes sense then. Thanks for your patience.

No problem, I'll add a better description in v3.

> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Thanks!


