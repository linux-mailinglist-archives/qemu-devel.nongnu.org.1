Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3D9FCEEB
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Dec 2024 23:59:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQwoa-0008LT-On; Thu, 26 Dec 2024 17:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwoY-0008Kx-Fm
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:58:46 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQwoW-0005wf-NK
 for qemu-devel@nongnu.org; Thu, 26 Dec 2024 17:58:46 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-216281bc30fso93615595ad.0
 for <qemu-devel@nongnu.org>; Thu, 26 Dec 2024 14:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735253923; x=1735858723; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cIwE37iPsAJ+XHGsmT+5/VtB+UGmfDP2BekpC7UvyY=;
 b=vs489DoDQxysc7T8sowpcncM3FNBgdnunjw4cQkxU7wNv7MCfh+1hGVOx+vzlkdpF4
 z0s6mKvI5541UgHfPRLS3jeSK2BK7iJdCUHNxj1L66H3u84xa0Hu3iZQcCkgvv87TYgX
 GFDClq7V63L3WAb+kFpg1IuGHJyW6G/Lg5CejHDh6rdAicpnIpUhtGVY0rOw4FZ4yujd
 AhbVUBzhkxdWnaW5JC8TRmCPNVd4nAZLxEsLHDd5yMefUXVIBai1qgjip/GGf6f/4Wya
 2rerbN7q51NubxlGIs4daYCZYXTghXpnXoGOazmImQkWbQafIfQ2SpM+mgz6IDNfBwde
 M6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735253923; x=1735858723;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0cIwE37iPsAJ+XHGsmT+5/VtB+UGmfDP2BekpC7UvyY=;
 b=SVsIrJ5SWv6MpF7OiS0MWUfYoVr6rvdkWsTlQWvz08kPebWsWrxTCEL0i0i8YVq3ve
 MpJ7yOyQK7lqTCuhxihlOdasSCKmNoKGvS/hEgNdPs3F8JQDEwemtW5dAc1/V68sSaSd
 d/TSTwh2xkvWgOzkBx4ZrPGyOoZ/ioEX1FNoVsmnsI0oqVjDe6MVCVMukhgXMKz97DZP
 nk1jpZfCnWQDui6XmNzVS7mP8lNi1OKqspE/zajtPYzlXdO3BA5A1rHF2po1cpZjyCr2
 6d2LB7nA6qhZJpU+j5qRd7V3M5yV/opcUVPYmCSEMCtaIm2A5nKJyv44QIa5aySvWj0/
 zWrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw5g0V+cREyVDPIeDhJK5bIQHigpGOXky1NjF/wMTfesDSpnYTF16cK4QMU6BsM5y0tktpOHvYAoGV@nongnu.org
X-Gm-Message-State: AOJu0Yx6qz3tHr3W8E/ov42OMGKM5bHcEQf1lJ/UyBEsrWxkbwTvYecZ
 oE0oOMtAxkhiGGszjuGGHf3wCCtyNy4y3lefhYdMnXqlarfkwCEMVDZLSzulZKQ=
X-Gm-Gg: ASbGncuRaRRnzkGXBgo3G4L0aswV649n/HAX6QuZkcWyerTamXp59hPqB4y4WXUVUT4
 It2lv0YFloqvMhDrdUf/YbiJZmdawKM9su2opVjThlfAtcf83bQA6TxFH24lWMRzFK9CHIaZNOj
 NdiLqaO/EkqUMV3PD1DPexRmUkC9eRew/+SchkyLTA72lg7YsFgWu3jfsdJDqjGjfFUSXzZzuAq
 ZOCZ+Lq2w67KyNI37abmgkepGFlBcvt7KKpfyzMpi6ulVRXrnSRavKNzllrdhLRWDUmUtiu6cwm
 SbCae3QnxSErDpTX8r4UycnnBCYIAg==
X-Google-Smtp-Source: AGHT+IHXRYJ4jI4nm45gh1Gu5faJPGJIzlGimzQ78Bcr7hggOMG6XctKOb9wvZIz+kN6A0oBiJAJtA==
X-Received: by 2002:a05:6a00:b87:b0:726:54f1:d133 with SMTP id
 d2e1a72fcca58-72abddb19ccmr35405457b3a.12.1735253923541; 
 Thu, 26 Dec 2024 14:58:43 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad90b949sm13404529b3a.176.2024.12.26.14.58.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Dec 2024 14:58:43 -0800 (PST)
Message-ID: <f332d6b4-66c0-481c-8936-12892664d24f@linaro.org>
Date: Thu, 26 Dec 2024 23:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/23] config: Add loongarch32-softmmu target
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241226-la32-fixes1-v2-0-0414594f8cb5@flygoat.com>
 <20241226-la32-fixes1-v2-23-0414594f8cb5@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241226-la32-fixes1-v2-23-0414594f8cb5@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x635.google.com
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

On 26/12/24 22:19, Jiaxun Yang wrote:
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   MAINTAINERS                                     | 4 ++--
>   configs/devices/loongarch32-softmmu/default.mak | 7 +++++++
>   configs/targets/loongarch32-softmmu.mak         | 7 +++++++
>   3 files changed, 16 insertions(+), 2 deletions(-)


> diff --git a/configs/targets/loongarch32-softmmu.mak b/configs/targets/loongarch32-softmmu.mak
> new file mode 100644
> index 0000000000000000000000000000000000000000..50e0075a24ac6bf3717db967b03b816b52a25964
> --- /dev/null
> +++ b/configs/targets/loongarch32-softmmu.mak
> @@ -0,0 +1,7 @@
> +TARGET_ARCH=loongarch32
> +TARGET_BASE_ARCH=loongarch
> +TARGET_KVM_HAVE_GUEST_DEBUG=y
> +TARGET_SUPPORTS_MTTCG=y
> +TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-fpu.xml gdb-xml/loongarch-lsx.xml gdb-xml/loongarch-lasx.xml
> +# all boards require libfdt
> +TARGET_NEED_FDT=y
> 

I'd really like, if possible, to not add a new target, but make the
current loongarch64-softmmu.mak evolve to support both 32/64 modes.

