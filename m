Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8887CD1C6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 03:23:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsvHD-0005gu-Mr; Tue, 17 Oct 2023 21:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvHB-0005gd-6G
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:23:09 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsvH9-00011e-Le
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 21:23:08 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6bb4abb8100so2898187b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 18:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697592186; x=1698196986; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53FWt/I4TMg+o6dv6RYCr7S9W9TM5CB6z01xcoAY83g=;
 b=pxO6ebvETGssSmCa5/V4WQGcn3y/iRHf8HwspjUaOhDjX3uvul4yccYXHyIaVJRymD
 pXkoAq3fsmgoUoemHEoyCIIUwdEu0aBf6BjnrvYqSZsmJzhCyfSOVc0AsMm3LIN0je1D
 PME37BXu3dNDkYBT+NI8LY2A4p2T5UVRVnw0c9caPFCgjLqSqfD2rDwlrZrzK7BFla6c
 Eww883sTm0YSCWHRH4ysa2kZJt/rC9zqsc8BRn+JH0iAA7cOiGbEod9hULJfwEAHkYdG
 DktQ2Xmg1+gneF1Mc0p/tGAGvLKcJPyEvD8fmuptMO1crxW/EoXFeBDgcPuaVOC8lCDF
 YaCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697592186; x=1698196986;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53FWt/I4TMg+o6dv6RYCr7S9W9TM5CB6z01xcoAY83g=;
 b=VCnVnNejj8SQhiVcqeffNhWu51fDNF70w28/6C1v34uotqW++Fc80UagRMnx2ksAH+
 kOp/9/VDPmmmJzZsQG9y4xJTf0vwiFWREnu22JdhzsHbvYIOhhtd87WxqFFCr9SMICCe
 GmtdpVfoyit6wcP/liWKqNIck2YBL9rWE2HKcRrRzlzSAEpfMT/cf5Zy0FngziP8GnQa
 IJZZkwBFExKx4enI97GeCwwVdO5nm+g9PNqGVkVaMnGMBJB3n6Himqvdr0jb4NfK1UV7
 XJbSslYiqhnjs5gAgGGyzOGQcsNMi+3yogsz6EhJUAueZaSRA3WyAl9npi/xm3Hh1E5l
 /26A==
X-Gm-Message-State: AOJu0YzqX0kmn4Vid3WZBLDt/Z2sU0oSiUlXpB0v5ofmvnHtPUItrK1F
 L3QcLps16TpOCUVjFnYZWE+e0g==
X-Google-Smtp-Source: AGHT+IF27ehtrf3KMA7LaDHZE+QNQ9CJwhUXa+JQ0uay/Ag4OiGh87KNqAFuxXRQ2kmrpA7QpWO/hw==
X-Received: by 2002:a05:6a21:7187:b0:159:fe1d:2f32 with SMTP id
 wq7-20020a056a21718700b00159fe1d2f32mr3413573pzb.42.1697592185747; 
 Tue, 17 Oct 2023 18:23:05 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 iw9-20020a170903044900b001c73f3a9b7fsm2232418plb.185.2023.10.17.18.23.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 18:23:05 -0700 (PDT)
Message-ID: <321c65a7-e698-485e-a262-02a11715223a@linaro.org>
Date: Tue, 17 Oct 2023 18:23:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/i386: group common checks in the decoding
 phase
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20231014100121.109817-1-pbonzini@redhat.com>
 <20231014100121.109817-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231014100121.109817-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 10/14/23 03:01, Paolo Bonzini wrote:
> @@ -224,6 +233,8 @@ struct X86OpEntry {
>       unsigned     vex_class:8;
>       X86VEXSpecial vex_special:8;
>       uint16_t     valid_prefix:16;
> +    uint8_t      check:8;
> +    uint8_t      intercept:8;
>       bool         is_decode:1;
>   };

Unless you have a good reason otherwise, use "unsigned" with bit fields. In this case, 
'uint8_t' is really 'unsigned char', and so gdb will print the ascii by defailt.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

