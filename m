Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1179F6447
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Dec 2024 12:05:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrrM-0004E3-6Y; Wed, 18 Dec 2024 06:04:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNrrC-0004DM-Eu
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:04:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNrr4-0001gx-Rh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:04:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=93mmvX8sqP0sgzc4wkkyRirLRSuC3P731vVx8fTgmH0=;
 b=ePRAed9i2iAx7NutvlNMoS1xEPAuzTXmJqBtLcyaoAejfzbXX/Nga6qjQ/LCHSlyrytA8p
 brldJ/dlVBp3+BP6BlxiPaR1dYOP3bB1oolhuaKgFGFHqJlsoJ9Dp94RRNkH2DematJl0V
 /K4wtxlgAMZV0M31DWOnJmSVM5uqX+k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-xHYUzYLJOV27rPRY8OfFDg-1; Wed, 18 Dec 2024 06:04:35 -0500
X-MC-Unique: xHYUzYLJOV27rPRY8OfFDg-1
X-Mimecast-MFC-AGG-ID: xHYUzYLJOV27rPRY8OfFDg
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4359206e1e4so56528545e9.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 03:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519874; x=1735124674;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=93mmvX8sqP0sgzc4wkkyRirLRSuC3P731vVx8fTgmH0=;
 b=Xq4yeIGQjGCKfsB0h9RBE6ZH760/0MQjEGVtGFE+KzIL3eQhUk59+KJXAaVKOkupFl
 HuiV4CMnv03n0W5w0olmjpaZQNehNgJvkqUApzi8FT4aGcZWCqQcXk6Xdi07NgEy1u2A
 lg84F3k16dtlO4xOYkB04zVhhEVtGNwjj7Ht1+U+qsac6OyoylplKuo3H+4ZYPANubP4
 dlJ/uN5LQ+oqTt9nXgJw6rXYl0+i5A8EFVvnOoLdKqKiu/Nt8QQZUUddQEoTwelvPvtk
 a9ba2sjKfIELLsyxmm/jgCJbQyF1XFMe2UZe1+EugVpQdSKTWnw/UFuoG2PCSXKoR90E
 Q5xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIH0EAsK1MYXl1wwSuaQGAmTW8RAsEkXm3fyplsCrWElctLSKykYBvJY3GW63bqkOIEbtPErCHbi13@nongnu.org
X-Gm-Message-State: AOJu0YwE18qD4kYCaKX5R1IerQVVh8uqu+Db1VS5EbW44KnGrffd7b4+
 joZGQS8Z9zZu92WHA8TB4p9/ldQ44v4w2lfg50vGGnWaHPocdrDlvlHbmFCvqxAuRwnNNTw8v0I
 N68ZC0N67fw/+877BJAP8xhuvBwsjyPiW9yBwQ+tLWoe3dSuksx4h
X-Gm-Gg: ASbGncsfKYmwtLTqVPDdYlLCGqbXCC2CrXgFbryof5rqZck5IMrrBjPqqv9d3NxYu4l
 49hc+oykGO0zJrfGS6I1AQbiDMuFKS1B4DYGrjq3CPaaavbYFRoij1S7XYbZCpKgX3YcvqBZdy+
 Fqsy5sjO36U97Thq2fYjTPrKgR+lvw5M6V8yrTE2/+gPwHCFVPf8hOikHWa3PHSwmARIK3ho26t
 Q8xzp1UsWSWpeIuDvTpb033SwMyK6BOEehs5GO+xL81JL/eQXYQ5++MnhW3
X-Received: by 2002:a05:600c:3ca1:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-436553ed060mr16189955e9.23.1734519874501; 
 Wed, 18 Dec 2024 03:04:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoacjbMxUvL/lG3cjism/UBNHVMtg2n0Q/HW28E0wae1NbjKOOHHwk9U48rZibjJUMcdt0Dg==
X-Received: by 2002:a05:600c:3ca1:b0:434:fbe2:4f with SMTP id
 5b1f17b1804b1-436553ed060mr16189695e9.23.1734519874132; 
 Wed, 18 Dec 2024 03:04:34 -0800 (PST)
Received: from [192.168.10.47] ([151.81.118.45])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43656b12399sm16955015e9.20.2024.12.18.03.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 03:04:33 -0800 (PST)
Message-ID: <b8b87cd9-7cf8-4b6b-961a-c34bfa8a01f6@redhat.com>
Date: Wed, 18 Dec 2024 12:04:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] More Property cleanups
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241216035109.3486070-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241216035109.3486070-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 12/16/24 04:50, Richard Henderson wrote:
> Based-on: 20241215190533.3222854-1-richard.henderson@linaro.org
> [PULL 00/67] Constify almost all Property
> 
> - Missed constifying two arrays.
> - Eliminate all empty Property lists.
> - Detect both of these cases during the build.
> - Count the elements in the property list and eliminate
>    DEFINE_PROP_END_OF_LIST.
> - Constify Property callback pointers.
> 
> I expect that the rust api stuff can be simplified now that we don't
> need to add the terminator.  But I only did enough to keep correctness.

It's good.  Most remaining macros will go away sooner or later; for now 
the loop is what we have...

I queued this series myself since it conflicts with what I have ready 
for Rust.  Thanks!

Paolo


