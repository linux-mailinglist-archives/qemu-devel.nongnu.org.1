Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AFF776D6E
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 03:16:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTuHY-00010z-D5; Wed, 09 Aug 2023 21:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTuHS-0000yY-VJ
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 21:16:03 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTuHQ-0006r0-Eo
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 21:16:02 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686efb9ee3cso355262b3a.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 18:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691630157; x=1692234957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=29vtLLq5dpR2ATfPUQltcfCnhc6fz9PpQtt22AmCV0o=;
 b=ouSwuft0WU77eDqhdnVfMTdgeD6LhwogiIv5246U89jj/q8H3wEXYWMOTAsd/iLg3G
 AfPOr3iqenI9UD2Q/Fvszz8gBbtmYkKL5Cg1WxyNsPyGNLLZ0UbG+2YX2qQtlO9sfdec
 rQa54d30USBC5FAvDyi839TqESNnoIlimcTKN+Ky/6+I+XWknaBXyxI2we8KMgURpaxL
 0NZQ2RKqIcVcFCduyX0wwdokY5PltxmoYoouU/omdnEDVVYEHmOGz2vBIeom/J8s5bky
 VG1K4B7xyFC7gnp9LqLXKakC8iVaB4slhQWHiCgElWuHbixW4T7EX7P7THPoiKJybhov
 zxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691630157; x=1692234957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=29vtLLq5dpR2ATfPUQltcfCnhc6fz9PpQtt22AmCV0o=;
 b=KoZxMjdg2Oq3qliQ74WJWnu9FvnnG0u2ud1Mp4zSCcNTi6vqaYhckttOe7vrG4BEX9
 E4pH28WVYq5OzUqObAbcW7iy26s23GEJoZTt4r0cfImFybeZONXCljVHMoFMDHN+4RNo
 /lllOqsAVezrCGBsneWjpmicQmdXAf3758/8IUzNm/3OgQVKhP6ju0IE2vVXYveDtn7T
 yWbabbT6t+I01PxndAVrvZewXQdC/NHC7lMxI+xaI0V0aXzeYJJVJuAnOZp3bjiX5I1b
 Q+m3SM195T1YMJFSH1IMRJOPd1EaMeRUdywvPL2rwcLDc/zdquoY7jY6jbjxy/uzVmcl
 EUqA==
X-Gm-Message-State: AOJu0Yz8N5m9C/UAS0D85670muEM2aVfoOQbPwn6vD6RVnpqlmWd96hK
 5gH6kdXJdGMp9ukdbXVWw/C63+T4WlZNRbg6fMc=
X-Google-Smtp-Source: AGHT+IEMgwA8eduGycxlyZAlegWnWzylhZw1BOK4tHOFOG42F8XE1DK6z9JsQpmtjPaonS6G2pndyw==
X-Received: by 2002:a05:6a00:b8d:b0:67f:3dcd:bc00 with SMTP id
 g13-20020a056a000b8d00b0067f3dcdbc00mr1271923pfj.2.1691630157466; 
 Wed, 09 Aug 2023 18:15:57 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a62ae17000000b0068780736f11sm219972pff.176.2023.08.09.18.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 18:15:57 -0700 (PDT)
Message-ID: <0293df98-3129-d04d-8db8-479607b81a55@linaro.org>
Date: Wed, 9 Aug 2023 18:15:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/1] OpenRISC FPU Fix for 8.1
To: Stafford Horne <shorne@gmail.com>, QEMU Development <qemu-devel@nongnu.org>
References: <20230809203432.424071-1-shorne@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230809203432.424071-1-shorne@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 13:34, Stafford Horne wrote:
> The following changes since commit ccdd31267678db9d80578b5f80bbe94141609ef4:
> 
>    Merge tag 'pull-qapi-2023-07-26-v2' ofhttps://repo.or.cz/qemu/armbru  into staging (2023-07-26 07:16:19 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/stffrdhrn/qemu.git  tags/or1k-pull-request-20230809
> 
> for you to fetch changes up to 765fdc1e8355d4bae563b3b185c5f9d079384164:
> 
>    target/openrisc: Set EPCR to next PC on FPE exceptions (2023-07-31 22:01:03 +0100)
> 
> ----------------------------------------------------------------
> OpenRISC FPU Fix for 8.1
> 
> A patch to pass the correct exception address when handling floating
> point exceptions.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


