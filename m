Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9BC7F5E22
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:45:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r688R-0003Ey-DJ; Thu, 23 Nov 2023 06:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r688P-0003AW-DS
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:44:41 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r688O-0006o5-12
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:44:41 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-332d5c852a0so485292f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739878; x=1701344678; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DyBumdY4oK4xGOLba13k7G2SW2DI2Gypm/xiew+OYA4=;
 b=ZDLvVyyidBks6GSrgQGRaQP3r2HzeORfEigo2qq6+FKrAALaUTX/hrwF8eSJah14lP
 g3F/2nZ5j15BHvaA3ZkqyAfOSEsxQqzCu3gZ2M3XSDzvOyCucDGg13AVcB1hqdb70VcF
 V2Thulo3lB2N6hKBO5S2jv5vHSfCLsYUN8Xia+4NzUsluAGbfThKAyWCl1YacJdmCN4N
 xSHDEZ1h8ro7pP/7jT5atfIk3eVNbZHL18B91NoeENb8Z2oeCa6hs0JRRF2OERsoGPWT
 Wq6DZLAuqAUTXQUEsb1ojv0JZmNDjNkxjQUVJyouqtfiam1h0LUO4yx+c/8iOznL98m1
 xmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739878; x=1701344678;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DyBumdY4oK4xGOLba13k7G2SW2DI2Gypm/xiew+OYA4=;
 b=hdFTGRs/o3wBqRcewKEqYdCt485Vru5iCiTheaXT+RzTj8ZRtukCkjK4XLPS4ItCkq
 fn0zBOgGXQ8uFC7FN2haRSr870L4XazjqRdfzYI5WWgZw89AN1wy44CV+QPjz+6kM65Y
 8Hv4S3NRTWIk3kY55B3j/yvIWN7myY4vHGEypp3DzRkI2RVj00wi+9GiOgIR5Kq3gQ1/
 0gIUhdcpOmKmkyqxaRBC/LjZbfBv3zc33SzNn9/q4K+CwYILF3DoATuYf+gK0Jp/z6ce
 2ddK3Y+BKqcAqev+yIwSRbleYS1FGMmHysB4OC87xvZHFhhSMOu3Q+nJZxnc406gnxeX
 8+IQ==
X-Gm-Message-State: AOJu0YyUkwCPbh+dCHwXTqqvXQdXa6TVqLk9u+pSWZ7wA2/u6/dgHf39
 EMkJY9DsyOBY6rmKIcvCv8hrEAuEl3ZYBHZKQGA=
X-Google-Smtp-Source: AGHT+IFKyUYN/83RMzRBVh8/IE1Fr/2PCiOcXm0UWH+B/s+yVkad8uL86zLZivU4/+krQZERj1IUiw==
X-Received: by 2002:adf:e285:0:b0:332:d11d:5288 with SMTP id
 v5-20020adfe285000000b00332d11d5288mr3381752wri.46.1700739878093; 
 Thu, 23 Nov 2023 03:44:38 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 h4-20020adfa4c4000000b0032d8eecf901sm1455905wrb.3.2023.11.23.03.44.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:44:37 -0800 (PST)
Message-ID: <868b09e3-a191-49d8-9acd-a18453aad4d8@linaro.org>
Date: Thu, 23 Nov 2023 12:44:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] target/arm/kvm: Unexport kvm_arm_vcpu_finalize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 14 --------------
>   target/arm/kvm.c     | 14 +++++++++++++-
>   2 files changed, 13 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


