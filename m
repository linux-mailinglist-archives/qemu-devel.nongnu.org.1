Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3CF82190C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 10:46:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbLj-00063r-7N; Tue, 02 Jan 2024 04:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbLh-00063g-0g
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:46:13 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbLd-0002KN-Pp
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 04:46:12 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-336746c7b6dso8380605f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 01:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704188767; x=1704793567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BvMBtZj6qG2YAHPCp33gXWJoAoUmhT3nZupD7Y526G4=;
 b=xL9dZGrrOpgrhySoH0r5T2uOp11ojpafFt2hM37QLyGEByXhM6aFNAsoa5B3b9VAr8
 ZutfUcsJGOq4ilXSRSqBbRlM8mEpvTrVTEdoJ3fe5XXT4NitSSxFDBSQo5XmTLkHcfGc
 DFVcXGD7O4ks2q6hrpvnMezX09jTPx96Ll5gf84Slo8xuRNr36iIBSfPbePwQJH4Mh1+
 990Rx1rfG5eF8l5RBzhu06sIrFbt3MY3Vf0MB4ivl/WCWRwAT42XklhO8qi105mH2PYe
 VDaG7cP/yEV+bLsloXyxG7nsknyrY+7ZB5DLfiH0JcyJRGLZKrsgjFeLuR3pG8oeihm/
 Y+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704188767; x=1704793567;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BvMBtZj6qG2YAHPCp33gXWJoAoUmhT3nZupD7Y526G4=;
 b=lwiZUZnelrQsR8OkMwxrDXBdPR+9fPxMAhHoWgpVS1IPISFE00WWRfmzH4XZyoIPJQ
 fJ8Af5jEdRRqOSP9qSP9sx/fnL18aIbIHg+Q2lP0Gw3RSAiXOElQTLaS0AcdseRwNMrL
 SR84y+J8FtKVu3LslA2cFlNXBahkkSfU5c2Kn488FHNN/OwyVk8/fAB67hfADIrzf2iF
 Y2g1ym7zHkhcV84KfP0OMBxOY6m0p17qiERVn2PNugzlWGCau/pxgkijKqK2isx6DzX4
 ueAItWs/sMZB5hxVpxaxuRoPLxM1GuuDKrXRwX+iuvU6PU+FUyYvO8AHb5xASd2MIr+L
 B7Cg==
X-Gm-Message-State: AOJu0YyaJyTwg1Bv9qBOFIW8aIgMMquHKKcqEyYjEl08/VIZA+UTOv+R
 LEWJvGS+I0rUbR1ZUu29lsqvxW3vhZ0XZQ==
X-Google-Smtp-Source: AGHT+IHIo0rYm67SDNvbhqITqenaAyXC5moHEnvXXtNCwd/Jj8amiQ463fO2lQufC1ND2RbQI+Dgvw==
X-Received: by 2002:adf:f003:0:b0:336:43db:e73 with SMTP id
 j3-20020adff003000000b0033643db0e73mr8113891wro.84.1704188767791; 
 Tue, 02 Jan 2024 01:46:07 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 l2-20020adfe582000000b003366cf8bda4sm27938746wrm.41.2024.01.02.01.46.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 01:46:07 -0800 (PST)
Message-ID: <0c873d56-fb90-41e2-8777-8b0642479a9f@linaro.org>
Date: Tue, 2 Jan 2024 10:46:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/loongarch/meson: move gdbstub.c to
 loongarch.ss
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 alex.bennee@linaro.org, pbonzini@redhat.com, maobibo@loongson.cn
References: <20240102020200.3462097-1-gaosong@loongson.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240102020200.3462097-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 2/1/24 03:01, Song Gao wrote:
> gdbstub.c is not specific to TCG and can be used by
> other accelerators, such as KVM accelerator
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I didn't really suggested the change but the split ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)



