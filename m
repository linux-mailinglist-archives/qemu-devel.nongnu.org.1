Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD917D668E
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 11:18:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qva1Q-0007K0-AJ; Wed, 25 Oct 2023 05:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qva1L-0007Fo-Ba
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:17:48 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qva1F-00082z-IZ
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 05:17:46 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so72703711fa.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 02:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698225451; x=1698830251; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zT/r30Ujd+ELUU/7Pv792UL3pTWDRgtNZUNpUq2d2eU=;
 b=Cg0Z6HqTet2fk2o1ECIsObEFcM/9Yr8AX8hHiWFL7vG9OWkM1SrTMF5sJery0MB/Fr
 flkM1lcQaKJuw3kzWksHudNhmE+gf+DoSR/ROnmgsNUSpq2JKASZyPiNI8xq/S9s11ha
 u6MFdjfjDDMnwMAIQTZi6x6nQh57H8Q6v9vcqqTCyQcr2bDPgOn/DmqbFFjOdOvQZcT5
 HIZWLx1xA9d597yzUolrLipjE1UpzMDkQpbQ/loRlEfvu4JdgjiGsV5n+3tkrr2VCTry
 9+6R0RkkfemCEP83lYdfTgkJNZlxbg47GUHEoaJ7TazCs+NbJWrlTzBUdGwv4W2gpNxt
 LZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698225451; x=1698830251;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zT/r30Ujd+ELUU/7Pv792UL3pTWDRgtNZUNpUq2d2eU=;
 b=ortMMtXRggbQ7DGWv+UysYMu74qwFegp8j2LH6niUVuZ7K5/OrbCEN63QIxo4tigrZ
 ceI+XsS1dsFcRg1zTcNtZTkEpKRvqm04RMPH9E5QvrR1n0i9LmHvDPePO3PS50iLmLJN
 vNC4fDBMluCG2z4euoPhK2YpNEVkAyVaQmifJDLyh9WoAtIIXUbSzpLBksGRsywm7arK
 SrImNaHZ9X0leBO2PGoqoefBfqP+Z2Zu3WWkg5RM48ukm8uU9JvGNIWnmQnCgI9bv0rK
 JpjumNZVPUupYrhKSP2V5dULJ+MBBXIVgMG4O3sX+GVBuEHzAlZf/EZD8mIAbR6/9A6m
 a+dg==
X-Gm-Message-State: AOJu0YweusLfZKoMi9rPYyWVLhezjxXapcjkS0FiaqfU4Mu8ZOLypxQ6
 Ti2U5SdUXYIe1DERuMOJasRnvyi15fhXdNaTva4=
X-Google-Smtp-Source: AGHT+IHmcrJudfTqlFcNpOS3NR61cAh/+K78fSCeUf+dvBCZcULQX1AuDWNl+PnpMAeGkv3BpycrAQ==
X-Received: by 2002:a2e:9f45:0:b0:2c5:f8e:35cf with SMTP id
 v5-20020a2e9f45000000b002c50f8e35cfmr10656674ljk.20.1698225451032; 
 Wed, 25 Oct 2023 02:17:31 -0700 (PDT)
Received: from [192.168.69.115] (ghy59-h01-176-171-219-76.dsl.sta.abo.bbox.fr.
 [176.171.219.76]) by smtp.gmail.com with ESMTPSA id
 dl11-20020a0560000b8b00b0032da4f70756sm11649942wrb.5.2023.10.25.02.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 02:17:30 -0700 (PDT)
Message-ID: <608d8f04-5458-125c-3fa0-9296dfecc9fc@linaro.org>
Date: Wed, 25 Oct 2023 11:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 00/11] hw/arm/aspeed: Split AspeedSoCState per
 2400/2600/10x0
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20231024162423.40206-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231024162423.40206-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x233.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 18:24, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This series is extracted for a bigger work.
> 
> Cortex-A MP clusters (TYPE_A15MPCORE_PRIV) should create
> the ARM cores in its own state. Unfortunately we don't do
> it that way, and this model calls qemu_get_cpu().
> 
> In order to remove the qemu_get_cpu() call there, we first
> need to rework some SoC users.
> 
> This series rework the Aspeed SoC state, so it is clear
> what fields are really used by a SoC type (2400 / 2600 /
> 10x0). It will then be easier to have the MP cluster create
> the core instances.

Being a bit more verbose, as I was trying to explain to Cédric
on IRC.

The fby35 machine creates 2 SoCs:

static void fby35_init(MachineState *machine)
{
     Fby35State *s = FBY35(machine);

     fby35_bmc_init(s);
     fby35_bic_init(s);
}

- bmc is Aspeed2600 (A7 MPCORE)
- bic is Aspeed10x0 (M7)

If we were to create the bic before the bmc, as:

static void fby35_init(MachineState *machine)
{
     Fby35State *s = FBY35(machine);

     fby35_bic_init(s);
     fby35_bmc_init(s);
}

then the MPCORE misbehave as it calls qemu_get_cpu(0) which
returns the M7 from the bic.

