Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C16358252F3
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 12:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLiSG-0004AO-86; Fri, 05 Jan 2024 06:33:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLiSB-00045f-Cs
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:33:31 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLiS9-0004GX-Pe
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 06:33:31 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a2967a6a86bso33624666b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 03:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704454408; x=1705059208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EpsazrxZAmb7NOeKh+MKglWQMMWul4SSyn044YrkZF4=;
 b=SCQLLjRmBHiND6xQe7yoen4Lg+3LLTconPbUckK5dhQghq6ne3q5L+4phLL5ilmfoW
 s5Wxgau9/BAPZ/Xa2jC0fyR5ZnnkCE6O2nfe/lJRseJlqKU1AOAUsy9fpGfVFmeLIlGc
 PtmC+blUNGmsJI/HKsf+cwClByWQatK0DcUfLay2Zpq3UomSLYCpYIz6HRuXU1R+uECL
 1IATrqgJMyWn/52BrbxcM+Pps2ShwNfUAlBEMPTRAMm/I0/XZb1oMH5HBzPmlPM1g+xC
 MT7mRkIJg3Ez5G2dv6nNP67C6keGnb/QZ9mEJkpA6HfuD+5sCNwp9auy361NXq49VB7Q
 00sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704454408; x=1705059208;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EpsazrxZAmb7NOeKh+MKglWQMMWul4SSyn044YrkZF4=;
 b=DWtnZwfccHijI6zu4Vil686hi1MGgA7sDF/K0vM2nuQUMmBZ8Ch1n6cyU97+x9MfA8
 wLZ9FG6hZ+Chzu4p+5uZlsfQy+abvrC+O+9Vd+5uCppphXfPpj5QAzzuNBtgaDAByC3x
 3i4mIE4Gq/tP1f8ewBUPohZ5DmOiHUzHNTmSjY3Evj6ZpNCwrPAk5Tf70ySFUXk2kIK0
 aSROaz9ol9PDh/AqIZgQqeD1b3Zg7yPWP0SIuf/WGZkYqJNnNn//oPFGQlZ/4S5RlQ93
 7BiOpEPEx2qU0FUBeMPyLS1+IGyoh7e0zfySU15gB8/T6y45s/xGdIp/iIPlqzB/SOmn
 RUhg==
X-Gm-Message-State: AOJu0YzFINEYeCPdEiey5TunVIBnTf16S2vhNDtMtsZtaCc8l0jSI/dG
 yQ3yGlRhll110LU7QxeQ/FZ8APRVzzzRrE52E9mk6663wi8=
X-Google-Smtp-Source: AGHT+IFkSfNGzQtIaBJBEpR3jlnOenyrPgBSqKSRO4QB+bgSphgIiTrHob2a7BLuaMLys5Tpb5zGQg==
X-Received: by 2002:a17:906:4e8e:b0:a26:8dd9:7bf5 with SMTP id
 v14-20020a1709064e8e00b00a268dd97bf5mr1019703eju.44.1704454407903; 
 Fri, 05 Jan 2024 03:33:27 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 oz39-20020a170906cd2700b00a1f7ab65d3fsm781262ejb.131.2024.01.05.03.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 03:33:27 -0800 (PST)
Message-ID: <2d94c6fb-5096-484e-897a-2f7c946b1879@linaro.org>
Date: Fri, 5 Jan 2024 12:33:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] target/sparc: simplify qemu_irq_ack
Content-Language: en-US
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>, qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-7-chigot@adacore.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240105102421.163554-7-chigot@adacore.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 5/1/24 11:24, Clément Chigot wrote:
> This is a simple cleanup, since env is passed to qemu_irq_ack it can be
> accessed from inside qemu_irq_ack.  Just drop this parameter.
> 
> Co-developed-by: Frederic Konrad <konrad.frederic@yahoo.fr>
> Signed-off-by: Clément Chigot <chigot@adacore.com>
> ---
>   hw/sparc/leon3.c            | 8 ++++----
>   target/sparc/cpu.h          | 2 +-
>   target/sparc/int32_helper.c | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


