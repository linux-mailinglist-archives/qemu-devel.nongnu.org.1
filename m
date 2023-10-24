Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26B47D592A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:51:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKcK-0002jW-Jo; Tue, 24 Oct 2023 12:50:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKbw-0002JP-80
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:50:32 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKbt-0000jC-HE
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:50:31 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso37150765e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166224; x=1698771024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmuUGoHCORY6b3xYBYNaxyA/xFjVN7W/5LtaDw8rdjg=;
 b=Z4XbLYhD/jaHMIRK/fcyql0Zr0/OFPuawG/2f9+G19vzFWqnatnHNBBxoNP2qifOmR
 r0x3rguOolUdqPfeguqIHUtLTuojbelbtin69PYEUfH8yC/1kdtkn+0fKjegtfibKh+D
 HpGluAvBuyzrheLlEhFEccozT0o+fnTN0YQvP5Xtm/CjOmnAESxaGZCG2V2fEZ/aEJPf
 bnGnbe2eTLZknRsm5CfuPs1K3hLvb6sNWXFDwyaZmWVYAHjfFYR0nxsRoFaEhsbW0qNo
 aIXG3Xl0cMSxR4YWxdXFMBLLk3j96K6TawDNni13+V7yfk7XlA5V91NTd9SlqxBPBZrY
 VZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166224; x=1698771024;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MmuUGoHCORY6b3xYBYNaxyA/xFjVN7W/5LtaDw8rdjg=;
 b=EpeXd7sfjPmmjh/k7yehbiuV8ywSEeic9ltTNP7NIJ3QsbOgXANzlZK9Do6vflg77R
 jtWVMc1CrbEJD3BsuBF6qzxlTbiC097DgwSWgKN2xyRqs7yiT9RqkBbfvKFIeo2H82FM
 ZET92RMa5ZR7+UIHVPGB9FGfbWeHkICwRPAz3cwpU0/F/qNYkLLx0vGRYpnVfV0I49M+
 uD+vmGUnDkTZq4BVS100trkJKFR1scD9zlzbvCPz5+xIt8PKT04IuMO3ygx7VvUb7o17
 WRkzXn0Bh+i9SL800rQ5LCgGX1bgHeqDlYGQtBVxggJvTcZLyb1H0qpx3Cz35UpNBNzo
 Xduw==
X-Gm-Message-State: AOJu0Yy4JKR5LaC7bcYRCHyGmEPEIF6U4Nh9hjaA0OSdeTQAPo1Gubs4
 vsvODcgY83iPbPgc/c0wsdYIag==
X-Google-Smtp-Source: AGHT+IHX7yWvCB5MMMR+miq5m0KKOfZXgT9bCyRES8y64cADJIXvRryPAJ6EhOn0/nX+GMUjXAeetw==
X-Received: by 2002:a05:600c:3147:b0:406:3fda:962c with SMTP id
 h7-20020a05600c314700b004063fda962cmr10336284wmo.31.1698166224295; 
 Tue, 24 Oct 2023 09:50:24 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 y34-20020a05600c342200b004063977eccesm17177906wmp.42.2023.10.24.09.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 09:50:23 -0700 (PDT)
Message-ID: <dcba89fa-fb3c-711d-acbe-9dfce9b89c0f@linaro.org>
Date: Tue, 24 Oct 2023 18:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/6] target/arm: Move feature tests to their own header
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231024163510.2972081-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 24/10/23 18:35, Peter Maydell wrote:

> Peter Maydell (6):
>    target/arm: Move feature test functions to their own header
>    target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests together
>    target/arm: Move ID_AA64MMFR0 tests up to before MMFR1 and MMFR2
>    target/arm: Move ID_AA64ISAR* test functions together
>    target/arm: Move ID_AA64PFR* tests together
>    target/arm: Move ID_AA64DFR* feature tests together

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


