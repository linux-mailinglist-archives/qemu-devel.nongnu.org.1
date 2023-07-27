Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B04765B27
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 20:06:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP5E7-0000FH-4K; Thu, 27 Jul 2023 13:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP5E5-0000EB-6O
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:56:37 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP5E3-0000EP-Cy
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 13:56:36 -0400
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55c85b4b06bso694295a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690480594; x=1691085394;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q55Yk4bcrQlGRW7j3t485OcQBSm3401IpPIDfZgOgW4=;
 b=WpOhJroJkG8NuPqf/tI7AZZvS0caGHxbDMiQrfmoKBIouGzp2Ku9k6iFQxDYuF2yAg
 pVrmumYqznGZSW688zD+te+EivNVHXWt5grhM+JFfBPANaWccADBJMCrs3w6aODF7vNZ
 mW85XsnruAp7kdntZ4A5mU7wrAPBHRca8XEmr28hqhM3D6zWFP4Op6rNcyhg5yqrrOLo
 7ztnaKh5rQ//t5AtvzRXq+tm5dzNvSvVCHplbpD3PSBb0RW7XNbPM26HDCCUiHhP9nC8
 k4MLAzDDjS7Gx9Ntl9QTzXEw7HvIaMo3L1YxfkxOWjVVkt/1A3O8mQqQY+e/v+LOZNXR
 paUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690480594; x=1691085394;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q55Yk4bcrQlGRW7j3t485OcQBSm3401IpPIDfZgOgW4=;
 b=JVW1YDBmzIqM+IXYdPMmVLKOJyXmGnjUono5G4azdIo1dsJTwN2uS0EKPR+3Bpal06
 kYkoLP9AvMNbAOmzVGPpH78/XH1hGZjBkgdyfRO5kxIy/axo2g/yd16egySKmTsappv1
 p7NvYozxBJwlPvtN1MOgXdH+XLaFdjm+LIE+D6z6UhNHEri8S3kT35T36SxoH2NWC63M
 Af9g4FUA/dZuuiyKDu9/8/2OqL891Wl5wtYF7vW1EYWA6osH+PNhugaunvhb9CISOfOd
 wYWyAiAXIch5Zl9ZFfX8Z9hk4TJVsf663BQ/2Qh+MuHWCl98nT2uWLA1Q2peXoZZ+gXd
 13Wg==
X-Gm-Message-State: ABy/qLYgn+brCZOAeakU/DQG/P8QjwQ14Ai3wFY+ntxJ/97nWXuT0O10
 cDxyWxxcHt0bpP4KXL0uvd2ZbQ==
X-Google-Smtp-Source: APBJJlFBP/34KZSY2+f+d/PmTArDsMxYxm5m754Cqc7fki9LJzjXEXEcN6L57hXPKNIAc5e12NGVdQ==
X-Received: by 2002:a17:90a:64cf:b0:268:10a3:cea8 with SMTP id
 i15-20020a17090a64cf00b0026810a3cea8mr53874pjm.9.1690480593870; 
 Thu, 27 Jul 2023 10:56:33 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 r6-20020a17090b050600b00263f8915aa3sm3048131pjz.31.2023.07.27.10.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 10:56:33 -0700 (PDT)
Message-ID: <173fb35e-a4c3-4112-afd9-b313c6d95b2e@linaro.org>
Date: Thu, 27 Jul 2023 10:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20230726081710.1051126-1-ardb@kernel.org>
 <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
In-Reply-To: <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/26/23 08:01, Richard Henderson wrote:
> On 7/26/23 01:17, Ard Biesheuvel wrote:
>> Hints welcome on where the architectural behavior is specified, and in particular,
>> whether or not other 64-bit GPRs can be relied upon to preserve their full 64-bit
>> length values.
> 
> No idea about chapter and verse, but it has the feel of being part and parcel with the
> truncation of eip.  While esp is always special, I suspect that none of the GPRs can be 
> relied on carrying all bits.

Coincidentally, I was having a gander at the newly announced APX extension [1],
and happened across

3.1.4.1.2 Extended GPR Access (Direct and Indirect)

     ... Entering/leaving 64-bit mode via traditional (explicit)
     control flow does not directly alter the content of the EGPRs
     (EGPRs behave similar to R8-R15 in this regard).

which suggests to me that the 8 low registers are squashed to 32-bit
on transition to 32-bit IA-32e mode.

I still have not found similar language in the main architecture manual.


r~


[1] 
https://www.intel.com/content/www/us/en/content-details/784266/intel-advanced-performance-extensions-intel-apx-architecture-specification.html


