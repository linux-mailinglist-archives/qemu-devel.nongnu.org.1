Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D499782893
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:08:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3h7-0001ea-Tx; Mon, 21 Aug 2023 08:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY3h2-0001Yd-I0
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:07:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qY3gz-0006Qe-So
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:07:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fed963273cso14304795e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692619652; x=1693224452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6FKiwaRtHa8kMxfBUIhaIKIbuZZfKv6OBfY5FFAVkvA=;
 b=xGiRiPsQVrgn36Q8Mi+EpncP5Y1c9hn/PYPb4/1h9VDEEMHLze3pdxdkBGZvacIv2Q
 VO5nX7sVY1kgkqLqNz/OnJVh2SxtpZb5byggvqGsO8fANZPh4xl8ueX4Xp9cJyMoT6Mm
 OKQDrxWK2h3UCj+WZ+pJnj+6N1uRC04he7/2N0Zn211Nog6DWVsABBGwvnE2hQ4awepH
 kB8WmJ9ibdOeosDjHd4XDaODGgbjoOKrg/6D+kWPyDtbbcuvOk8NZ/zRM6wK4tuKh9Yt
 cDfp2PTOdzQRMaYP9EeZWGOmruTk966Q1SKZCZivMv0Cnd2stdh9Ea9t+J9f1kVEFrh7
 7uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692619652; x=1693224452;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6FKiwaRtHa8kMxfBUIhaIKIbuZZfKv6OBfY5FFAVkvA=;
 b=RPVRcGbKgxlu/EXLKXY2WkRtsERSu8lqNKebqufBJVtf2OEBDhIV57WPHSAfjODawV
 +6h8KNT89JT4WGAwRblSyY2vb5irxNYCwfJGTt/hwOt91j9CJwUMlU0I6qzHNC7ymX6M
 OGAHXEKVuASDSzDtUZMDk7U1m5pLBLB2R7N27UQMiLc4+ByhlQfcYxS6fAxaeDpDHZd2
 IMpgaz8hvUph4NdTqyZmlgkSrNdm+yNIVMgdtKtorsuulsWHC2thM0dDUiTXq8lqIJ1z
 RgewNB3dXYaV19B+ZNkvJNYehxaYU94+/fTY64ieYhrH04odgdCHrcipRPmhBBQHxwv5
 8nJA==
X-Gm-Message-State: AOJu0Yx5l7UjujNwOSGbBQvIlmBGrX3b/ET3QmNxjIb5UOE2Pes3amnB
 wEy17CRt2sdV8FiQb6rucOYfXg==
X-Google-Smtp-Source: AGHT+IG1ldGUMC8wN+gzj5jQEj266WyPHWj769joub+SqIb2QsGsisXAmNStxHg6sHa7ojtapjpxrw==
X-Received: by 2002:a05:600c:1c03:b0:3fb:b18a:f32d with SMTP id
 j3-20020a05600c1c0300b003fbb18af32dmr4861550wms.17.1692619652666; 
 Mon, 21 Aug 2023 05:07:32 -0700 (PDT)
Received: from [192.168.69.115] (static-176-182-122-208.ncc.abo.bbox.fr.
 [176.182.122.208]) by smtp.gmail.com with ESMTPSA id
 x20-20020a05600c2a5400b003fef60005b5sm131736wme.9.2023.08.21.05.07.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Aug 2023 05:07:32 -0700 (PDT)
Message-ID: <40ed15f0-40f7-52f7-ad8d-3b074793c319@linaro.org>
Date: Mon, 21 Aug 2023 14:07:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 6/6] linux-user: Show vdso address in /proc/pid/maps
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: iii@linux.ibm.com, deller@gmx.de
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816181437.572997-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -54
X-Spam_score: -5.5
X-Spam_bar: -----
X-Spam_report: (-5.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.374,
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

On 16/8/23 20:14, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/qemu.h    | 1 +
>   linux-user/elfload.c | 1 +
>   linux-user/syscall.c | 2 ++
>   3 files changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



