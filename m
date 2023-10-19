Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8FE7CF73B
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:43:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRQe-0006Hf-TK; Thu, 19 Oct 2023 07:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtRQJ-0006Es-UD
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtRQI-0000gj-Iq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697715761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JlWu4cfsU+g+WfaTewPxPGqmzTpLHhNOBt7yEzfQKZI=;
 b=ZLe/EOCNUDDQMAJIXWDyjECAnnzFZ4MRI5zZax6aWPJ1WDOIsmVMpTpJc5gmt1IFuK3CJZ
 ktWVaJfBHoOGWQbNw6hmd1XiH8ftUi8/U7GXlgX6BEAnWRFMj17ESXHnizUxLJfQVROXsC
 SRY4NlKUk+dqjq+I/p+DCJtLEWUID+E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-hGit-EzdNoaTEAeJQXvTGw-1; Thu, 19 Oct 2023 07:42:40 -0400
X-MC-Unique: hGit-EzdNoaTEAeJQXvTGw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso580512566b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697715758; x=1698320558;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JlWu4cfsU+g+WfaTewPxPGqmzTpLHhNOBt7yEzfQKZI=;
 b=AVu/Gyu+NVhxCtanC3dqrdPSSGkAzba6GGg1wbVpuMQ0Ey4JfwMR1FlC3bN4VUjCss
 g5ld23Tlb9Wa1jBR8k6K/oc0V8jhcA/pTFWwIQNqs8+OCmYiMXXJ4qDHI5TB5vxHn1G4
 B/cVj1diI9jWdb8f+Wje9WsL/1KJm9v0VWLFBWs52LZlvAXYN/bF13tUrF7CJ8hG3LWY
 Fy/aIw0dMdTDQ3UWJEFoPqVGlsRvJEQJ495PUZdktGHTPl5ECMCYZdnbdrKOBg0C8FI3
 YD9Hzd12oKV87/UwvxZlxdgS7Tbhpk+H385zTbTtHAONfHwOn7l/nwxFrlSnnhp4ZKSW
 v4/w==
X-Gm-Message-State: AOJu0Yw/dOgjzSQ7FL7OAXorMTOXcn3grtQKTJ4SI+aRjDRN9uoAtFHd
 8i9vD2iU571yHespQjEtNmBHSAhkf/jwzJ9ZK1+C+z3ehknJW23IaJN9vrf8jYa5b7xE2vUHomc
 Q13wvS1QZs4AUltDGKspo6+E=
X-Received: by 2002:a17:907:3603:b0:9be:6ff7:1287 with SMTP id
 bk3-20020a170907360300b009be6ff71287mr1376931ejc.57.1697715758656; 
 Thu, 19 Oct 2023 04:42:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3vgrCW+AHikOa/59zllMk/qAJHmvy5gj/BOjMSP64aZtL+31VDM2UZ/KEaFqifOh1L9ycfw==
X-Received: by 2002:a17:907:3603:b0:9be:6ff7:1287 with SMTP id
 bk3-20020a170907360300b009be6ff71287mr1376917ejc.57.1697715758335; 
 Thu, 19 Oct 2023 04:42:38 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e?
 ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.googlemail.com with ESMTPSA id
 mm27-20020a170906cc5b00b00993cc1242d4sm3371556ejb.151.2023.10.19.04.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Oct 2023 04:42:37 -0700 (PDT)
Message-ID: <31f8e6fc-d3d0-4ed4-b2bc-622b8d2378d2@redhat.com>
Date: Thu, 19 Oct 2023 13:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/19] target/i386: implement SHA instructions
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ard Biesheuvel <ardb@kernel.org>
References: <20231019104648.389942-1-pbonzini@redhat.com>
 <20231019104648.389942-4-pbonzini@redhat.com>
 <1261e3b2-fc10-c37b-c19d-ac78f5912fc2@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <1261e3b2-fc10-c37b-c19d-ac78f5912fc2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 10/19/23 12:59, Philippe Mathieu-Daudé wrote:
>>
>> +    /* Even round */
>> +    t = SHA256_CH(E, F, G) + SHA256_RNDS1(E) + wk0 + H;
>> +    AA = t + SHA256_MAJ(A, B, C) + SHA256_RNDS0(A);
>> +    EE = t + D;
>> +
>> +    /* These will be B and F at the end of the odd round */
>> +    d->L(2) = AA;
>> +    d->L(0) = EE;
>> +
>> +    D = C, C = B, B = A, A = AA;
>> +    H = G, G = F, F = E, E = EE;
>> +
>> +    /* Odd round */
>> +    t = SHA256_CH(E, F, G) + SHA256_RNDS1(E) + wk1 + H;
>> +    AA = t + SHA256_MAJ(A, B, C) + SHA256_RNDS0(A);
>> +    EE = t + D;
> 
> Better would be to implement that generically, so we can reuse
> host crypto accelerators when available. Can be done later...
> (See commit range fb250c59aa..ff494c8e2a for example.)

ARM extensions are probably too different from x86.  ARM does four 
rounds per instructions, while x86 does two.  And Intel passes ABEF/CDGH 
in the arguments, while ARM passes ABCD/EFGH.

Paolo


