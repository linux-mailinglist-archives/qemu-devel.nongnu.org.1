Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F8A7E2C6B
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 19:54:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r04jk-0006pd-1I; Mon, 06 Nov 2023 13:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r04jh-0006Rw-Bb
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:54:09 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r04jf-0001gB-Gi
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 13:54:08 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5406c099cebso7993282a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699296845; x=1699901645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWyNCT41O/cD+GcfrlVN7Nm3WeuSnMVYzvPDZMqtGO0=;
 b=bQI04tvYkCn+79uGHoYjDS8/qdl19kXQ0bITOQrr5lzh1c1tUedpQlwYxxj0KM1YYe
 oQg9m22bpjjcXoOSt7G81SeYYeD5OdtRZIoVdCedHH5MF/hLtyOyioyKA/Q1evi4CSvg
 hlMv1XwXKp8J2kO60LnXXmHWP5F9Q0QSecwXwwqTOk2jmTjFD5OFiK/baEKX1FlZ1p2H
 WmkhMLKhFrLcJRkBSbGOqKTng5p6mgdrLQtT+efbD/LBl7fEXRvq7pOgmY0z14DttDSo
 2nkrel3IQe1SWfbsqOs6RLJ3CjlU44bn+A2UoTsz8MbJ8SbtJSSYphtvSUIFUIEMtUb4
 ohww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699296845; x=1699901645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWyNCT41O/cD+GcfrlVN7Nm3WeuSnMVYzvPDZMqtGO0=;
 b=Zj1/dD9NqY4waEQAH/sn4TRo0cdDENgRqey9ZwACZccoblEF8CVX5PwaEyMTIHBrgW
 rKzjVSEInyahYBmgeLteB34/HkSFVxZKqmodAE8ESkrB9nPhAZFoz0Z1OURAcrIvF9kN
 F3N6RfkLwrA9n8hgmLKTzB3SZND7ghUYOy11hQb2LsRkXvsxIYQ0tT3s+H5mZX+1bvQ2
 egn6GONKw1ZcCYmfoixYCm9KSK3jCLbnDljdFC5cGY0LIGzsvktlcjqgnGu2NAuAG9HW
 aEel8Jneey7GVl/x0l6M+q+YtKqoESTWgYkrZFaW6fI4yDKAqs7Y1PfolICY190vur70
 X63Q==
X-Gm-Message-State: AOJu0YxQYWxBgtC+b2TgD4WxDAR7p4R4DifT+8f7yZhovn+yhn4o12eV
 yMt2JD6vv2ZeBE+L4Kfhokq7NQ==
X-Google-Smtp-Source: AGHT+IGfxBF0JQROFXZVJvr+6lwnJSM+FfX8Z9WRIE5M1FGyXvI2yTBjeQlKaSwTJB7AFHHzQZ0ipg==
X-Received: by 2002:a17:907:94d3:b0:9d4:2080:61d2 with SMTP id
 dn19-20020a17090794d300b009d4208061d2mr15141015ejc.2.1699296845428; 
 Mon, 06 Nov 2023 10:54:05 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a1709064c9700b0099bcdfff7cbsm134356eju.160.2023.11.06.10.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 10:54:05 -0800 (PST)
Message-ID: <1b1ea848-e3f9-501a-e01b-ba438baad60d@linaro.org>
Date: Mon, 6 Nov 2023 19:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 23/35] tcg/ppc: Sink tcg_to_bc usage into tcg_out_bc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-24-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 28/10/23 21:45, Richard Henderson wrote:
> Rename the current tcg_out_bc function to tcg_out_bc_lab, and
> create a new function that takes an integer displacement + link.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/ppc/tcg-target.c.inc | 28 +++++++++++++++++-----------
>   1 file changed, 17 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


