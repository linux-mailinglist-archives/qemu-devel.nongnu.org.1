Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F50A21B7E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 11:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td5n0-0003h9-5q; Wed, 29 Jan 2025 05:59:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5mx-0003Zi-IF
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:59:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td5mw-0001Td-5J
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738148357;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=F1Z2b5SplCCulCnrThb1IgfVC3F5Flk3ECgk19GSKfY=;
 b=DrT0dAV6dt6TqVqmc2i3djn/ZA4pv3c77igo0+vnxmK1ZAc4sO2gGSX9ZgvoxyqkI66unr
 xNTKsO9nr52vVIuIymdqCNVl3NpE/3ax93PY7aXra/0BndbjkcHHTUU2k33clpL/Fi5jR5
 ar/XySgMkNzBMTiR61UY4Hkbnm9z+gQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-JXddY8OhPIGhc-S5D47nAw-1; Wed, 29 Jan 2025 05:59:08 -0500
X-MC-Unique: JXddY8OhPIGhc-S5D47nAw-1
X-Mimecast-MFC-AGG-ID: JXddY8OhPIGhc-S5D47nAw
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43624b08181so3102325e9.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738148346; x=1738753146;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1Z2b5SplCCulCnrThb1IgfVC3F5Flk3ECgk19GSKfY=;
 b=M/isI34/lASx1zJYc9qutTd3vYr1Za3qjzMRwoJiBJoRD+emgWoMWTQeC6urhitiq4
 zn2vUdx4avF8+57mUtBU1pVmgZwZwalHrrx/7McmR0uAM70oISx7vHXis6dB4mRSfkSl
 ebbQR0rEQ66hKXSVdibJ8KEh0rTwA2GcM5eCx5llJstmnKOfKy+PtCJAl8xnuc593eeC
 OX6c/HlSSMC8Rs5qa5+xq0NlpT3qScycGV318kf5lA9XVZ+TiMbR2Gil6Gg98io0VD6d
 c6uK72Y+PT3HPHz0nBGYcNfXWAXMveaRoNoMMkaOG76Ujej999z6x7sHrUR91YLBNobh
 LBHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXxUIO2Kbam/cP+4V6fcdIKQiSxrflYH5vWV+0Ms5TuEVENyJEs0bBjTF6jkelhy0XJaBze2UZUmrW@nongnu.org
X-Gm-Message-State: AOJu0YyOz5oF0LH6suub3jJqFVkDbTd9GXBc/5Yc8tyOQ/s2dFTm0NPQ
 1Aw9+Od3PtDmrrLGnPAURitnki3p+5pdVXVEeyUSVhbPDCOM/O8wdbjv9xukpXhF/ZvlGvz7Ch0
 ohAdu7l0u564x0VhRMSqqHB8aglVZubaNVl3MvPoVVyvSnALi0789
X-Gm-Gg: ASbGncssD+jyvCYuLV/pSmYCYvc4rc9lh0Pirq8TtFvBAvqlQpYM6A2l6FurLtnUMEe
 XCUUdVzjRlTbCvZ5JsU96/26rAiIdrVxyYw/l0mKOJtc0p3SR7O9Nj6zmEXAm1ykCa1tQIntg24
 BP+GWtxmH66fesOSLLbcr4VQyAZrjTmYjPgqXlBcisD5AaU/bt00ZB+oWGz0s/vbG0R9213wzZO
 bWFZWpOepykQkVX3rLCYkihaxJDNaGL3UV1V7sscG2xSpc5KihzcBOQ/OoEEa0Gytxy3TvEb6um
 lYEjzw==
X-Received: by 2002:a05:600c:3d87:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-438dbe9a124mr25259245e9.9.1738148345906; 
 Wed, 29 Jan 2025 02:59:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpji0f2qhnG/LJPTman0u74BgwolbJa2Etkiau+0YR3gHpY/jMPjMYZ9BXiYs1iP84SpO+Mg==
X-Received: by 2002:a05:600c:3d87:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-438dbe9a124mr25259065e9.9.1738148345587; 
 Wed, 29 Jan 2025 02:59:05 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18867esm16401996f8f.43.2025.01.29.02.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 02:59:05 -0800 (PST)
Message-ID: <5a19e7d2-9d69-45fe-812f-84145229876f@redhat.com>
Date: Wed, 29 Jan 2025 11:59:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/10] rust: add bindings for gpio_{in|out} initialization
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-5-zhao1.liu@intel.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250125125137.1223277-5-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On Sat, Jan 25, 2025 at 1:32 PM Zhao Liu <zhao1.liu@intel.com> wrote:
> +    fn init_gpio_in<F: for<'a> FnCall<(&'a Self::Target, u32, u32)>>(&self, num_lines: u32, _f: F) {
> +        unsafe extern "C" fn rust_irq_handler<T, F: for<'a> FnCall<(&'a T, u32, u32)>>(
> +            opaque: *mut c_void,
> +            line: c_int,
> +            level: c_int,
> +        ) {
> +            // SAFETY: the opaque was passed as a reference to `T`
> +            F::call((unsafe { &*(opaque.cast::<T>()) }, line as u32, level as u32))
> +        }
> +
> +        let gpio_in_cb: unsafe extern "C" fn(*mut c_void, c_int, c_int) =
> +            rust_irq_handler::<Self::Target, F>;

Please add "let _: () = F::ASSERT_IS_SOME;", which is added by the 
qdev_init_clock_in() patch.

Paolo


