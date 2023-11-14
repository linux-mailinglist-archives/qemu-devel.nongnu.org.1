Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AEB7EB371
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 16:23:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2vFL-0008K2-M1; Tue, 14 Nov 2023 10:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2vFK-0008Js-72
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:22:34 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2vFF-0000NH-9c
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 10:22:33 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9d10f94f70bso843534966b.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 07:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699975347; x=1700580147; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MUHR/sFEjdzbvDET4onhF+bWIy1sGTTug2OAYdlSeSM=;
 b=Ssvo5/el/dxoSl10Gapnfjfu1BZqdq4m3P3aVdOqQy9N/4F7KmVn2G/ubV4nLou4UY
 PdY1IegQzQGoGH7upxdobDye7XT4q8xKSoSJNmZHgXbnQmvse2m9wWelCubNwZpghBR3
 HKe8qNg2axOuQ8l6tDl9e5ABDKSBxHB/5h4PMpryFXNEUWm8ALqKro9n9FRbBLpHdExG
 s+UMJyMKqB2mHupczWT3qxkRynEgGH6qf5FuQKvfgGrtfMK8WJFqUPVX/s1YOx3g/2CW
 RemIEzO9im0XQaSXZIfSB1zrSgx7LtiJpnoAdbXQW+ndCV/IYB831nvDASnXcaUX4Cwa
 PVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699975347; x=1700580147;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MUHR/sFEjdzbvDET4onhF+bWIy1sGTTug2OAYdlSeSM=;
 b=gl5poc+VGv3iN091hkFHqeLT0idxUClROv8pR64RmLtzqXcC6N2wAUq6+vPk1K9Psu
 qUKWQOBs1laX13gxqrh2hkx2jryINmb3hOIsUBqGj7RiKhGKdNjVV0d3ECkeOV8qtsUr
 hqVuGJ6fNZzByTMyTQjrT/sapDAU1STme+Qkikhd6BoEzNjerGaoWqyA5urM/tbb9RRx
 svWPbw0kg+3F2XTH6yqUH/ME8Q9L0QjRrHTSyYmTsraNUkrlZrjLCmL6IwccIfQ48KMO
 EvUmU6v9l2gwguqPwyWMXwRtkEVBl9TpZQIp3plRIZCZoDjyJMbxtOsfSsWnpqeS8JT1
 7KQA==
X-Gm-Message-State: AOJu0YxMHJSrNUosiK3WKyZLcxOK8nek/zJ+TrRZkE419qeg7fblY5PC
 PunBw7RACDiE48qYJj+GdEHmJA==
X-Google-Smtp-Source: AGHT+IF5d1ESnNl3DW6y2+imScFbz4lvkI6XZHXfhsQrAJwxX/tlICwDYWPVmK4nZgJvWNEuauG4+g==
X-Received: by 2002:a17:906:3615:b0:9be:834a:f80b with SMTP id
 q21-20020a170906361500b009be834af80bmr7614130ejb.75.1699975346999; 
 Tue, 14 Nov 2023 07:22:26 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 ov3-20020a170906fc0300b00977cad140a8sm5694156ejb.218.2023.11.14.07.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 07:22:26 -0800 (PST)
Message-ID: <7fd25b34-6fd9-4f7c-90b4-e44338b2b09e@linaro.org>
Date: Tue, 14 Nov 2023 16:22:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2 06/19] hw/pci/msi: Restrict xen_is_pirq_msi()
 call to Xen
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
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-7-philmd@linaro.org>
 <EEC18CA6-88F2-4F18-BDE5-5E9AAE5778A7@infradead.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <EEC18CA6-88F2-4F18-BDE5-5E9AAE5778A7@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 14/11/23 16:13, David Woodhouse wrote:
> On 14 November 2023 09:38:02 GMT-05:00, "Philippe Mathieu-Daudé" <philmd@linaro.org> wrote:
>> Similarly to the restriction in hw/pci/msix.c (see commit
>> e1e4bf2252 "msix: fix msix_vector_masked"), restrict the
>> xen_is_pirq_msi() call in msi_is_masked() to Xen.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Hm, we do also support the Xen abomination of snooping on MSI table writes to see if they're targeted at a Xen PIRQ, then actually unmasking the MSI from QEMU when the guest binds the corresponding event channel to that PIRQ.
> 
> I think this is going to break in CI as kvm_xen_guest.py does deliberately exercise that use case, doesn't it?

Hmmm I see what you mean.

So you mentioned these checks:

- host Xen accel
- Xen accel emulated to guest via KVM host accel

Maybe we need here:

- guest expected to run Xen

   Being (
                 Xen accel emulated to guest via KVM host accel
	OR
                 host Xen accel
         )

If so, possibly few places incorrectly check 'xen_enabled()'
instead of this 'xen_guest()'.

"Xen on KVM" is a tricky case...

> I deliberately *didn't* switch to testing the Xen PV net device, with a comment that testing MSI and irqchip permutations was far more entertaining. So I hope it should catch this?

¯\_(ツ)_/¯

