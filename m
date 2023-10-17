Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3F07CC217
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 13:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsid0-00043u-OC; Tue, 17 Oct 2023 07:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsicv-00043V-Oh
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:52:45 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qsicu-0004rT-5v
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 07:52:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so8071302a12.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 04:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697543562; x=1698148362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lM5B5XR9gM6+adHyTNebOwRjArl0u2qQcUgBG1MiLKo=;
 b=wawewQeeY9aZ1jwN+8Zv9/iQKrqYNW61FRSM6WD97H/ajXBYxTaBlwQ88+uJJJERSj
 cEpDOCkY/4koN63mTIDSqj8s22w6hHWvBOhLhHrhAIk/M3jIbvwJMndVvEawcZKSJFvo
 PWbOqCCyMtBJETRnUTIjGVNszaPwHJkTzTTKSg1ObGWnvs/10gReGDU4/Atjy1t9PFAJ
 w61+KFBOUTxt0BHkLxeMYmyZz/qVWyhgx6mlzGxTZrh7/7ZJBUII5xrgBDthZZdtXrb3
 +vAHOvENvCTlo+7ra7HN18pVlwYocnUqMXQcNxBLNxa7uJFD6e3A8GWrPQRO/mPI+Xxs
 zuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697543562; x=1698148362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lM5B5XR9gM6+adHyTNebOwRjArl0u2qQcUgBG1MiLKo=;
 b=jryXTdynACVny08UQo4Y1affG/XHmX3HVRnJ1/tN8G5Zn+W8aKz102Bm7KdVKA0q47
 nM6W/zIyB/eRUCWRMkYg1MrtALc1dopc/0rEivO/PB07Ff1GGxp95zXEoqIotc6kqZJA
 zgtmJtt6wTvmlmWmF85NkRzGHmbBdqDZuQ2raaGENWfBYXb63vOiszV+MZB2JlnfzeY/
 Cu9eJWl7CkcsPPF2xWZKiTlgZwY6UyNok7rqnA6onrENYN+GAU5mQOtdej26O+16H0i6
 WiQ7jG0NXzq5Z1Up6ePfHEVHe1bEBJfOv8szHntdO7RrH68V+YfrRp+2tR4GKF8j+S3v
 cvXw==
X-Gm-Message-State: AOJu0YxbzulK/nMAmBk6Wvq8BbUyZM4Vuke/Be1RQ8N8UtE0n/MZfPoi
 8m5rwSK8L2iTVBuSL9+7OWsLiQ==
X-Google-Smtp-Source: AGHT+IFS1eGyPhuBjBm53DEb+6xsvCE8DPSaUix48LBGNJyodYCDrjcTDzka+A6r4YAR2G7CNy11tA==
X-Received: by 2002:a17:907:1c28:b0:9b2:b71f:83be with SMTP id
 nc40-20020a1709071c2800b009b2b71f83bemr1576365ejc.1.1697543562518; 
 Tue, 17 Oct 2023 04:52:42 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.33])
 by smtp.gmail.com with ESMTPSA id
 hx27-20020a170906847b00b0099e12a49c8fsm1127143ejc.173.2023.10.17.04.52.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Oct 2023 04:52:42 -0700 (PDT)
Message-ID: <2ccd41e7-bc4a-9223-7f56-04493e0357d4@linaro.org>
Date: Tue, 17 Oct 2023 13:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] tcg: Streamline vector load/store
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Brian Cain <bcain@quicinc.com>
References: <20231013175109.124308-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231013175109.124308-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 19:51, Richard Henderson wrote:
> We have tcg_gen_qemu_{ld,st}_i128, which can be used to implement
> load/store of vectors to guest memory.  But at present we have to
> split into, or concatenated from, two i64 to reference the guest
> vector register backing store within env.
> 
> Provide tcg_gen_{ld,st}_i128, which can avoid the trip through i64.
> 
> This does require that the target store i128 in host byte ordering,
> which is true of i386 (and some other backends) but not arm or s390x.
> There is definitely further cleanup possible.

Is hexagon gen_vreg_load() candidate?

