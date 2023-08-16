Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7CB77E1F0
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:51:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWFy5-0003UF-Qc; Wed, 16 Aug 2023 08:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFxc-0003Rp-Qo
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:49:17 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWFxa-0004MU-Ls
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 08:49:16 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-99df431d4bfso58136366b.1
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692190152; x=1692794952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpA0RkboYzH+61megmtz4fv8FkUXXJiDR9EdSN+fNek=;
 b=DNBFKiqzmd81Pzsj/I5AriSgyQkJpmry5ZspXYlUjB2yUrITBMDyW0IhOrUQkJrUeU
 BAWgZN4Xqo4gf7lZkfNK5wcPClqNiIBU8QV6jX0WyIMeP0b1tqGgtZjsTT0qDqHPMApK
 5+t7iPidJvOHzPu0qEEoBepC9h+kNSf8h3BVtRXHBAP9SHWjZbxyg++4DtTlYQVTNpeU
 hK73wD+5/fKK+SOsF7rHzcTTC8AMRkvF+BLNngsyuJkAMzNJCOFjRmqNgC+CZjq/Fay8
 rkJ5lQhdwFj+z8/PHXBjaV6clzSd15epg9oBfaU0ly6A4pxKVgOoDIOFTlPvjYoQGBCy
 NBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692190152; x=1692794952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EpA0RkboYzH+61megmtz4fv8FkUXXJiDR9EdSN+fNek=;
 b=LJqtYE8ePf+KvRZ26vqfoCr/L+vLDPJ7Lg9JLqr6ypFx+zFzfIDPE1EBuLc4vZpSYk
 efYa8LUJoABKy28W0z+3cBkf7qvNnKBFskfksqvLffgAJohZ3VuQRSQUvHdOAQ2q4Ix7
 tZpUzPZ8LWsasLfrQDZjXcTDnAZ7oJA7xaPVn+a24jRx13ADYmejo81WmLQ7f1C8JFhf
 5U3GX51Qm2vDyhCxoBAh1oB1NeNMCVS7TQtAWtJunhNO024vr+mTaw8ErLHT8I+BWMU0
 nKYU+qS0GKNDKmYtfPfvh3mFc74p+x9WmVmflAJTj9sh00wGEK+0Uv8zhjXqIROk/T18
 UHEg==
X-Gm-Message-State: AOJu0YwqqDeT5aPXynM89J1P8d6dKuu/HUjQ1dbiXfqNmTkfBc4dbtoi
 /MVEjgdcVbl3LVIb4JaKUFVAlA==
X-Google-Smtp-Source: AGHT+IF4QuIKiND4NUbHbXFYcqZseoCiS83+4AD+sOk8qBXdd2fETHQ0HRQUP1bnQn0a73bpO6+89w==
X-Received: by 2002:a17:906:d7:b0:99b:eecb:275b with SMTP id
 23-20020a17090600d700b0099beecb275bmr1471725eji.19.1692190151926; 
 Wed, 16 Aug 2023 05:49:11 -0700 (PDT)
Received: from [192.168.1.102] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 gl5-20020a170906e0c500b0099cb349d570sm8465793ejb.185.2023.08.16.05.49.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 05:49:11 -0700 (PDT)
Message-ID: <1a33ef6c-a3ff-ca92-5288-de66bc2818aa@linaro.org>
Date: Wed, 16 Aug 2023 14:49:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] subprojects/berkeley-testfloat-3: Update to fix a problem
 with compiler warnings
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Olaf Hering <olaf@aepfle.de>
References: <20230816091522.1292029-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816091522.1292029-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 11:15, Thomas Huth wrote:
> Update the berkeley-testfloat-3 wrap to include a patch provided by
> Olaf Hering. This fixes a problem with "control reaches end of non-void
> function [-Werror=return-type]" compiler warning/errors that are now
> enabled by default in certain versions of GCC.

e7af9751d9 has:

--- a/source/genCases_f32.c
+++ b/source/genCases_f32.c
@@ -411,6 +411,7 @@ static float32_t f32Random( void )
       case 6:
          return f32RandomQInfP3();
       case 7:
+     default:
          return f32RandomQInfPInf();
      }

Why the default is with 7 and not 3 or 5?
Shouldn't we abort() or mark with __builtin_unreachable()?

> 
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   subprojects/berkeley-testfloat-3.wrap | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


