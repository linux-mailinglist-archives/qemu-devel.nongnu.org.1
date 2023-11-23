Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E1B7F5DDE
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:32:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67vf-0007dz-JX; Thu, 23 Nov 2023 06:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67va-0007aV-1P
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:31:27 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67vY-0001nL-Ip
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:31:25 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-332e58d4219so154377f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739082; x=1701343882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rNT4uJPZ2Dmm1Ek6e2mDzvr1mgbyyVH2ct5Ei6V57t0=;
 b=pNMSCTk+c/CLJfTGdvUytZ9r9UmplxL9/naiqLKxa1gGfUVT32yX7TZWmIDyz69b30
 RGoxSzjydfaBqR9Kgm78CKqNlOvFHoHlTQT8j5agsVCVhQYSOXYhzeRirX4bpN/GMiJz
 M+eRB/3ymT6GE4yiQcpVWPn/EX/L7H8S893ioccdwSJdCtn7JYEJiFRHwqgEklv1mCmR
 U/h0zjSjZwiertbxJFZqM7Fj0oyUW4hTapqBHun0brx93gWasvTXx9p4+70UdXoHdvTr
 JGgzi1qFmRwluA/EZ8EVMxG6/9HZF8tcAyV9ooqGtcKf1asAW8Q+EV+zIMb+3fVxATGv
 tFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739082; x=1701343882;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rNT4uJPZ2Dmm1Ek6e2mDzvr1mgbyyVH2ct5Ei6V57t0=;
 b=eOJKk/zmIpb+oO49ei0fXoBpivb46XefNbK1/QLmtAWOO5knrH7+Rah+VTbUYZO9Py
 9fj6PDkGqAQtI/XuKKkW3SOBK57bopZH1wiNboDH+5EocP9evgwv+do/8cl+yvOnwruw
 Lb4YG/6MMMchudavf7e3faUpjX08VQg+xrrYMgCh5D/trNiCvSqxeylseLYX1w67mBUj
 OOuf0fbHOUaxqCIMh0oZcSoup90zeuxieXcxGJColWrCvPzh+tga0HePmuDLlgbI0C+j
 V8jeiSZHl+ZXl+fE4uc/LCAC+1BqIejFrQlQLc9L+jCb4tomBwUfLdT6fje1YSVgwWN4
 lnRg==
X-Gm-Message-State: AOJu0YwTQjPsxS15VSt/VuPugJfo8Lv83eHv7j6o2hrYg2OwWtjSVaZy
 isEbiBCiu5IVRQGTV8BTVsX9Jw==
X-Google-Smtp-Source: AGHT+IFkkHK9JeXJNOx5SSPRvNz5SufxyK1OP+raWhJPpn5N37a58lQwcZGZ07NVDHM52SehBS8eJQ==
X-Received: by 2002:adf:d1e3:0:b0:32d:90f7:ce4f with SMTP id
 g3-20020adfd1e3000000b0032d90f7ce4fmr3331006wrd.38.1700739082053; 
 Thu, 23 Nov 2023 03:31:22 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a5d4d0b000000b00332cb23ccbdsm1381619wrt.81.2023.11.23.03.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:31:21 -0800 (PST)
Message-ID: <3f8e7301-c6a1-4b38-b0dd-62d8b8bcf8d3@linaro.org>
Date: Thu, 23 Nov 2023 12:31:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] target/arm/kvm: Merge kvm_arm_init_debug into
 kvm_arch_init
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     |  8 +++++++-
>   target/arm/kvm64.c   | 12 ------------
>   3 files changed, 7 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


