Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D2E7B7DCE
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:07:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnziR-0004jm-A1; Wed, 04 Oct 2023 07:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnziM-0004it-I0
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:06:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnziK-0003jY-Vq
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:06:50 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso358618766b.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696417606; x=1697022406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s0Qu3I7AXgcp66xgoLABvD9w8jZGYzONePst7dHqmgQ=;
 b=KTNeey/IzGM/rIP/2eYzHJ1U1LRN8lqlhyAwhiTqvQ5dmpOu6ux1dLr6FgW3Sy1+Sy
 NTTvB1dB85WyrX7oPl0ObIWbzeicZxN41I4sZ0qxIx/90yJ/iLiBgwgWCYatzOPnZvr2
 Gwjktx6wQ9JkggOYUjyHceXAjwJFrzVqE7DKKQpy3G3pCOOGykObiko9soYWJP0IkMZg
 JKKYV1AZPfcupnM7JU2A2vbCFqo1oJDQtogEeHf8J1fhva92nf68oUWka1W1KZDlleEW
 TS3tPd6dQlMZ7Kpe6kqdVAd+sbLFMVu0d8dspy3cs3MDfDpWx2MGGaAT4KDIJrKK80Nw
 4Qfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696417606; x=1697022406;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s0Qu3I7AXgcp66xgoLABvD9w8jZGYzONePst7dHqmgQ=;
 b=gA05cNdUe36bBlU/XcdwjF8eZSCLpquB6EBJTjLzm9i1ND5gs4Qd7jLpIexZUacvIZ
 NML5VKhsfcCJYq9R8aa/pCdCY8y2XyQSFoTU87OvQwILVO/FeDD+45TNhQttLwgn8eWR
 LFjm+ucCFDgU1dJ5nNIEeAilnQg5k86TRzwLUa+ZWcHVLeu9dykwqi1g09kKC0jTHsMl
 OumDt0OicLVjElcmoKRXAF4rRSnLLHOYn/N1uzLBG3TOkv4i1KxEgnlcWjm1gdSdpPSM
 YtPJFke11NIfBXwJHwklnNwdFr4myhwzGZh/gdg4XfWdr8izRAvh9vbI3bpu1vzZMAdt
 4HdQ==
X-Gm-Message-State: AOJu0YwJjHFkpRqWfwdq269gJiO5Cjs8IgNH8YBsPfZSXNhGbbL1N0z0
 go7Lcp7APKWEr2TQFXRnlrdfLjXXn0hOnd9nPX0=
X-Google-Smtp-Source: AGHT+IFKCOgaoO3dleLj7q2QKuwdBsr9ICLrshBoCMZX86kyD7AJN52PuSlx6bnb1/zh5viQ50QZyw==
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr1997649ejc.64.1696417606404; 
 Wed, 04 Oct 2023 04:06:46 -0700 (PDT)
Received: from [192.168.69.115] (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 x16-20020a05600c2a5000b00405c7591b09sm1244276wme.35.2023.10.04.04.06.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 04:06:46 -0700 (PDT)
Message-ID: <b9b3fbbf-c49b-6403-49d3-46b53e1f50d3@linaro.org>
Date: Wed, 4 Oct 2023 13:06:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2] hw/isa/vt82c686: Respect SCI interrupt assignment
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>
References: <20231004105709.16994-1-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231004105709.16994-1-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 4/10/23 12:57, Bernhard Beschow wrote:
> According to the datasheet, SCI interrupts of the power management function
> aren't routed through the PCI pins but rather directly to the integrated PIC.
> The routing is configurable through the ACPI interrupt select register at offset
> 0x42 in the PCI configuration space of the ISA function.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> 
> ---
> 
> v2:
> * Introduce named constants for the ACPI interrupt select register at offset
>    0x42 (Phil)
> ---
>   hw/isa/vt82c686.c | 47 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 35 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


