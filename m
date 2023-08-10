Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1199D77743A
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 11:18:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU1nh-00036t-Ao; Thu, 10 Aug 2023 05:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1nf-00031O-J5
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:17:47 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU1nd-0000F6-2P
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 05:17:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-31765aee31bso609354f8f.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 02:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691659063; x=1692263863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QQf4LquBd65ySTnhKk68cIBvF8eXymDszmhfrBPoOXM=;
 b=EzT9qs7EF0FCAf8FT9mNBnTxzVfbxzvYti8Z4cfty3I7+xW+D+IxjrdVbLbmLVNzzc
 r3LCTYuY+aSbieOgqUrFI5aBI4QRMDjeoq565fhZT4vokXEbzR5D5lF/tmq+PQec8M5A
 5gsNG4TNfKPdK1fTBQn3LU9/QpYX64r5KdRKsKtfuw96ncNoaKf7a66sAK7g4+S4sidQ
 72ORPnxU8jcYlVIH6OAey+eI5JYo+auC3oJ27H5vHeR38bv/L4Z3XivRPhZFWy47Oep3
 VAWEf2yNPO8Y5J+mKQ1pSpWYXjrCsroclNC9IzUx+Qnl7uT2HKLNeic+Sd2XIPCwi4dK
 2oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691659063; x=1692263863;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QQf4LquBd65ySTnhKk68cIBvF8eXymDszmhfrBPoOXM=;
 b=gHYAHzaN2262hJmpo0be8jfRgBPUI2VHZwRhlQIp5nlHgtHIy0SkDp+b+IkXAHD1Np
 KEJh2wqAWrvTDEOOoogymL+QYuvIwgvAWEBj8g727xruv2D9W94i3vlo7vNbGhUsfPqA
 JyCwaQTVUq+6/tiQV5fmh4uFlb0Q5bMgT+6kwIFG0pXtKfjk8RYAbSz8MHmgq/MvQX85
 Mkd8qtXMK+qF9esu5dYhINTsg0kRqE/fJXH+saKcXekG+edAP2iuv9nkgzTvqm89Jwv2
 kiNDeXuEIp6GOI/m1j8jxpNuCP73DHXFMQEe/B8RAdgP/JdGjVFi0QAESjJsECSqXo4k
 WF5g==
X-Gm-Message-State: AOJu0Yw4dRIIWy0/1JUPpOPp3tgv7RjFqMas+vqsatN7Wg2HeegCZCPh
 9t9rkTKcncRTZbec7ikx0MMxRw==
X-Google-Smtp-Source: AGHT+IHVUZC2xblty8/WDMMkeM/XMBFZhxw55Mv09xof8YsHMJLyDXUAOmZP4Zn7njVT6X3A3C4Gzw==
X-Received: by 2002:adf:e689:0:b0:317:690e:7b39 with SMTP id
 r9-20020adfe689000000b00317690e7b39mr1643959wrm.12.1691659062935; 
 Thu, 10 Aug 2023 02:17:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 a2-20020a5d4d42000000b00317ca89f6c5sm1499244wru.107.2023.08.10.02.17.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 02:17:42 -0700 (PDT)
Message-ID: <183b3243-e61a-12fa-0460-73e417bf029d@linaro.org>
Date: Thu, 10 Aug 2023 11:17:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v5 3/6] mips: Report an error when KVM_VM_MIPS_VZ is
 unavailable
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-4-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230727073134.134102-4-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 27/7/23 09:31, Akihiko Odaki wrote:
> On MIPS, QEMU requires KVM_VM_MIPS_VZ type for KVM. Report an error in
> such a case as other architectures do when an error occurred during KVM
> type decision.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   target/mips/kvm.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


