Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6C79222D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 13:34:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdUK9-0001gi-Rx; Tue, 05 Sep 2023 07:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUK8-0001gU-8C
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:34:24 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdUK5-0007TG-Tr
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 07:34:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-401bbfc05fcso25276825e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 04:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693913660; x=1694518460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uWzDT0xz5Hyqzdf2DafqgSHjqZD67O1iyc/mwXN+YZM=;
 b=my8Pn6lkEgoTNaTz+sP4Rkv8MjlH3GAMYTVRlvRg+9ixr8B2GmlmoAwdAthISxuuaU
 yY/yQIZ2O0ncXTK8evIGZ8oCFeWQviimh9QrF66BiDodRhFOoy5Y7ghBcnYV81Rbhv5b
 B3rkR0fcCB/CQJtx9y+oe8d9Au2BvfUbUNSZXRMBgke+6AW9PLomD+VmJkLT0kpFwTSv
 unt4bT3ILDYYTopyN4NkZvmPLfRYWB7nm99hS+8el49v8NJvI059zAWgNm1m6CHc1/Xg
 GQImu+kf27k2zjLzlHY/vvUTZIJGv9HgmyFvPROX7VF9U7WZt0zP0O/n7iTLWAdac8F9
 oAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693913660; x=1694518460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uWzDT0xz5Hyqzdf2DafqgSHjqZD67O1iyc/mwXN+YZM=;
 b=JTq2tTm4Am2GRLlj1j5CN5QW1lbGncK4ETS8c/GFb+Js/dwJvfkFEO5dETPqCf9r4L
 /en5HnYgsvyPtsliK4SctLBZS7ap62rEFjtV2ho706Z079WgC9FpqQdxzv74HB2ADia7
 K/xellG+QX0HoM5PSUwXpOqQNIoudYRWp+p2i32dXQIUUjwRcMC0Phh6YB49zGbm5mvc
 LWQ1nuTS6MApAdz1lgjsD2/VL706zqe2NzhguJ5qtqMnGMLWmAJF/isC+S7DHAYR2VvX
 yBlCwbELvz9xeGgBxDvZZNs4E+yU8cLg0u6kabnp0vocLC/kEGVchoWL/DO8kpjFiLQZ
 60bQ==
X-Gm-Message-State: AOJu0Yxo4onTJeORYOZokXF+aYK+iMnWWNpFakHwzWFXwfzfeD0mdFvh
 DwMEQidEpewxUXjL2OA1SsOxXg==
X-Google-Smtp-Source: AGHT+IF84xYseUBqCwQ6Q8BmZOkQrw7ymgj5JBr2reKx4dcZgGwx2Pg/iULJxwX204TxtMnG9xZzcA==
X-Received: by 2002:a05:600c:a388:b0:401:eb0:a974 with SMTP id
 hn8-20020a05600ca38800b004010eb0a974mr9137048wmb.3.1693913660391; 
 Tue, 05 Sep 2023 04:34:20 -0700 (PDT)
Received: from [192.168.1.34] ([37.69.27.38]) by smtp.gmail.com with ESMTPSA id
 l7-20020a1c7907000000b003fed8e12d62sm16697019wme.27.2023.09.05.04.34.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 04:34:19 -0700 (PDT)
Message-ID: <fc52bf2d-ac51-5137-9add-c529b3c39043@linaro.org>
Date: Tue, 5 Sep 2023 13:34:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v4 06/14] simpletrace: improved error handling on struct
 unpack
Content-Language: en-US
To: Mads Ynddal <mads@ynddal.dk>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Mads Ynddal <m.ynddal@samsung.com>
References: <20230823085429.20519-1-mads@ynddal.dk>
 <20230823085429.20519-7-mads@ynddal.dk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823085429.20519-7-mads@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 23/8/23 10:54, Mads Ynddal wrote:
> From: Mads Ynddal <m.ynddal@samsung.com>
> 
> A failed call to `read_header` wouldn't be handled the same for the two
> different code paths (one path would try to use `None` as a list).
> Changed to raise exception to be handled centrally. This also allows for
> easier unpacking, as errors has been filtered out.
> 
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>   scripts/simpletrace.py | 41 ++++++++++++++++-------------------------
>   1 file changed, 16 insertions(+), 25 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


