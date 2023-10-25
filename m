Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD477D78A0
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:35:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnOa-00016l-Hk; Wed, 25 Oct 2023 19:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnOU-000142-CB
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:34:35 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvnOR-000748-CW
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:34:33 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cace3e142eso1970315ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698276869; x=1698881669; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dg1OBB8uq30rbUjGjBKh1rlIsUrMi7z4i1E5b2xoMC8=;
 b=PU/bOO+VZEn7XYRHojh27v7nvsXEMt2RnjqwnyGwOLMDNBr0U4TEb8YxUi+F/t2jmz
 uGHFEwg4d4rlGCwZnP2wE6ndoDkEFRYHDtg/Jsh6mvAMLUKYkA5tzWgA0zAhTNhMoon4
 t251lpF+MXmOgB99K6n0w9SyFmTfmpaoK9GlHMoHsvlGv+dVGGslRbY03I1nJAkFSNvh
 k0vEa634WU6MsWopDnY4TXrJjZSdhN3Cal+uiHDH+W3FyMv4ay3UuqFmBcoFsvFqVMh2
 0szbJ3jRoI9ESK3n0emRh1XT4eMtNDQHJKZKl2Uq4+h/ZZ7w8wP/h0TSbVTw4LLT6tbj
 lSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276869; x=1698881669;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dg1OBB8uq30rbUjGjBKh1rlIsUrMi7z4i1E5b2xoMC8=;
 b=tIKpNkU2jo4+L+QD/iHl1WbebgCc7ee0fAfJmRZkFq4+uMguoQqf87Ixld0zuoYcbH
 pRRrbMxVykYcZ2BiNaj9wqtY8rp6hgt6LMWnNrVLS4n9ImCtaW2E4qCj3MiHkyiiSFUC
 rv9pUbdf6+9ygADakEQy91XZ0T3sA+JCJrftrgUTs+YIZbJLcdk+tmg5w/pIKqew3kzY
 /194ItVyVMvIHFnIXYqElRULryWaCrOr3TUjEMa7RwHu/d1ukdxc3ynI71p/WTFiRY5J
 vn15W3KL26BW/jag6bkdycB+atzJOd8H9pKx6Myu7ZyA8kWtmCzp9XwgoAwU56JwGabK
 /9eg==
X-Gm-Message-State: AOJu0Yy6+QtJU0XtK2Q1DxOkBkLglivJOzZ4HN5xbkR7U3i4DEiGRwQz
 s3BMRPCW4ILz5nxrPEAOPwZ7oLRdQpUOqVQxJ48=
X-Google-Smtp-Source: AGHT+IFWj4wF0kcM26kQ8715EO+DLr3ZC7vVQ/j+4ZZ3B/ki43yFnMmIWnkpXhHw/x/yw5N5Z4/nwQ==
X-Received: by 2002:a17:90b:2b46:b0:27d:882f:e6c5 with SMTP id
 rr6-20020a17090b2b4600b0027d882fe6c5mr14473017pjb.9.1698276869092; 
 Wed, 25 Oct 2023 16:34:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w5-20020a17090a6b8500b00277371fd346sm475304pjj.30.2023.10.25.16.34.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 16:34:28 -0700 (PDT)
Message-ID: <bf12b6fd-af13-4d9f-9359-5fb6139a6ffc@linaro.org>
Date: Wed, 25 Oct 2023 16:34:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests
 together
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231024163510.2972081-1-peter.maydell@linaro.org>
 <20231024163510.2972081-3-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231024163510.2972081-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/24/23 09:35, Peter Maydell wrote:
> Our list of isar_feature functions is not in any particular order,
> but tests on fields of the same ID register tend to be grouped
> together.  A few functions that are tests of fields in ID_AA64MMFR1
> and ID_AA64MMFR2 are not in the same place as the rest; move them
> into their groups.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I had initially tried to keep them grouped by ID reg, and then ordered by field bit 
number.  We obviously haven't kept to that.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

