Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DA7751DFE
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 11:58:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJt4N-0007oN-FX; Thu, 13 Jul 2023 05:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJt4I-0007mx-24
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 05:57:03 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJt4F-0005LY-GF
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 05:57:01 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-307d20548adso620486f8f.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 02:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689242217; x=1691834217;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g0kj4w1l90GLexgBhVG7rNFTgi4g5XSWrOleiU+1odI=;
 b=pJJQJT8zbUP/y1vZRSbfCzDoA6xoRlFv3Qi/ul8OFyI5k2BMKp4eG2yzu+1u0WgrB7
 6lN+8t1DDs73HCrhEt4cy8lIIDN0WowF/9LR4Qi4HVqzC9XXz1ZIrLfnl6D3h8E5iFz9
 aBHNfS4KPzknFvuKHTl/y+35oRwA7k2dV7sDbF3T/VC9mYeD1bZdK58fh1UeFqlVQfeU
 +XoHz3bN8iSQu0f609OX9CMqD8QSkaFMtPHoRrLsirCAroXv2KMJwn0mKTC8TwaD9GsT
 FpU0fctPrwK9b+IrbxJ+EjZm0y0DELsgkBVVtrYOzwbx4YAihomvwMjYbjmJAE62AidE
 CZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689242217; x=1691834217;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g0kj4w1l90GLexgBhVG7rNFTgi4g5XSWrOleiU+1odI=;
 b=aE6xlICgKGVKkHrbFRnBSeT+VbT4+TOAUkB5Ax9yuL49IJIuWzqz1l67bYdXTtGg1/
 USyAcXChaBsJhw22k8qHyK1H/cexmHn8iDcmVmFf/GeXz+MxH/Twvdu4kr0yvXE6H7Pz
 wYyoYG7Vb3UlLGGt20onrh4XGgWPzntjQJ2p55ET37r/vE/EH12kLUdTMfV5ALv087QC
 ycbuTovkB7+JENd7K6prr4NvBSsA3lh2xbOg+baKXhiBDOb4KQw/69G75DMt0r0pycgB
 jeoduLufIyf5Ujgomo7xyKnavUQzaSltWQFTD510AeJerJxGh2Wief6ND76cPCYED5Ao
 /Dmw==
X-Gm-Message-State: ABy/qLY2967rt9h/zoaderphtmnpkFjKPm+q3/rNH9Uh7sxwp1s+MiD4
 YvOl4F2ZaV4Smc4qh2kgYEtqlQ==
X-Google-Smtp-Source: APBJJlGrmKj6chCU3AynpObR2pkq232nAnZSa2GsZG+xt3KIqtV2971FPI7+cUsY6esOw/x4IUGtKQ==
X-Received: by 2002:a5d:66c5:0:b0:315:a34f:b520 with SMTP id
 k5-20020a5d66c5000000b00315a34fb520mr890610wrw.71.1689242216784; 
 Thu, 13 Jul 2023 02:56:56 -0700 (PDT)
Received: from [192.168.7.115] (m-109-111-99-24.andorpac.ad. [109.111.99.24])
 by smtp.gmail.com with ESMTPSA id
 l6-20020adffe86000000b0031435731dfasm7423320wrr.35.2023.07.13.02.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 02:56:56 -0700 (PDT)
Message-ID: <7b37cc65-1314-29f4-006f-70836bdfb4b4@linaro.org>
Date: Thu, 13 Jul 2023 11:56:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: qemu-img convert gets 403 from s3 presigned urls
Content-Language: en-US
To: Ross Vandegrift <ross@kallisti.us>, qemu-block <qemu-block@nongnu.org>
References: <20230713020302.c5sxc5ad4s5e3s3f@vanvanmojo.kallisti.us>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-discuss@nongnu.org
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230713020302.c5sxc5ad4s5e3s3f@vanvanmojo.kallisti.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.11,
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

Cc'ing the qemu-block@ list.

On 13/7/23 04:03, Ross Vandegrift wrote:
> Hi folks,
> 
> I'm trying to qemu-img convert a source that's hoted on s3, via a
> presigned url.  When qemu-img hits it, s3 returns a 403.  But curl works
> fine with the same url.
> 
> I didn't see any debugging or verbose output options in the man page.
> Is there a way to get more info on the requests as they're made?
> 
> Assuming that awscli is installed and setup with credentials, the issue
> looks like:
> 
> $ disk_url=$(aws s3 presign s3://bucket/path/to/image.qcow2)
> $ qemu-img convert -f qcow2 -O raw "$disk_url" image.raw
> qemu-img: Could not open 'https://bucket.s3.us-east-2.amazonaws.com/path/to/image.qcow2?X-Amz-Algorithm=AWS4-HMAC-SHA256...[redacted]': CURL: Error opening file: The requested URL returned error: 403
> $ curl -o image.qcow2 "$disk_url"
>    % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
>                                   Dload  Upload   Total   Spent    Left  Speed
>    4 3322M    4  160M    0     0  13.5M      0  0:04:04  0:00:11  0:03:53 15.2M
> 
> Thanks for any pointers,
> Ross
> 
> PS - please CC me, as I'm not subscribed.  Thanks!
> 


