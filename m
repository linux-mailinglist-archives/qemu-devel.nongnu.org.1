Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A76EC787F1F
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 06:57:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZOsP-0008IY-Sr; Fri, 25 Aug 2023 00:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZOsF-0008I4-RK
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:56:43 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZOsD-0002dz-GT
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 00:56:43 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so1259755a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 21:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692939399; x=1693544199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1PCcSXXWR5sctXDyOsSpVgHYUTsXh4kJwPeF4J0W3wk=;
 b=L+6dx2bQBthoxIv2p4k8vcfCafrbU2mYkDyqR/95/ySztV9A2dKudAceh4MsFa4zp4
 SzcWFYGkOfTToYUr3udEmc3NhtFr1xM9dRa9dstPowfN690qWnbE5Xu1uRyEHB64G9UN
 p4B5S/gVScRYeEGJU1rlv0x2XnvKOmszdnngTd7ihHS9vnf9VGZhC4R3FnaigcZV0+BP
 XIgnlh7p1aKEjYty1MDBansCYxAAEZI909bb3HVr4MpBTFXjg3dtP2F2qBCnGuIyHF7V
 J7RGkmJtlouVSXGTzs/HF22kBwlqVK4ioQ0DLkEid8KGHwJApTIb2bX6zQrIeNlEkI5X
 JMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692939399; x=1693544199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1PCcSXXWR5sctXDyOsSpVgHYUTsXh4kJwPeF4J0W3wk=;
 b=VLQmab/lwbcAIPwJSpxt/+wJzulVY5xPOxoqBvjZpml7wsrj25XgaggSy8hiDd0FHK
 738QygBw5/D0X2H0oFNhymj7/kU+5Z8K7W66kGlNtQXUWv3YpsJZZhP2tinyKNoY220x
 OAyVgaEbeuqm8Mzb0UTl2oF3m7sH2fzA6PPxS5VBBUJpXO1cLyogsb9y586XOHV2bz95
 Hp0RyrQnc400H9MVAsRGLiypP4NBAhDET4EYU5SQixAV8lHS3zdKAkhalLyloBMsEDte
 VWMMoEFw6BZwPQ01ivCuMI9VRyfqFH7PvTenxxu3Zu6sz9l2TWYYP/5elh04sQEVZJoC
 3qFQ==
X-Gm-Message-State: AOJu0YyslXX5zJoq05WAHrRhu3UIf4jR9jvxxAa8C0opLN69OjOLLcOT
 5y26v+VjOhKVqlrErOnbV8Z+PiHmZr0hNH68oWI=
X-Google-Smtp-Source: AGHT+IGBgNJ3diw14/9xmSPSbQWLKxgLa9zpFOrtYPBTgXCLh/wIChtf1+8NlvcdLhlu7FSQLCcyFA==
X-Received: by 2002:aa7:de8e:0:b0:522:582c:f427 with SMTP id
 j14-20020aa7de8e000000b00522582cf427mr20704391edv.14.1692939399312; 
 Thu, 24 Aug 2023 21:56:39 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.69.26])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a056402120600b005232c051605sm563253edw.19.2023.08.24.21.56.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 21:56:38 -0700 (PDT)
Message-ID: <53477102-19ad-70d3-18ff-28e4815d7e41@linaro.org>
Date: Fri, 25 Aug 2023 06:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] hw/usb/hcd-xhci: Avoid variable-length array in
 xhci_get_port_bandwidth()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230824164818.2652452-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824164818.2652452-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
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

On 24/8/23 18:48, Peter Maydell wrote:
> In xhci_get_port_bandwidth(), we use a variable-length array to
> construct the buffer to send back to the guest. Avoid the VLA
> by using dma_memory_set() to directly request the memory system
> to fill the guest memory with a string of '80's.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Use of dma_memory_set() is a suggestion from RTH from Philippe's
> original attempt.  If we ever do anything about the "use real
> values" TODO we'll need to do something else (eg heap-allocated
> array), but since we haven't done so since the code was written
> in 2012 it doesn't seem very likely we'll ever do so.
> ---
>   hw/usb/hcd-xhci.c | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

