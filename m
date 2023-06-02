Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B16720A22
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 22:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5B13-00071n-QK; Fri, 02 Jun 2023 16:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5B10-00071c-TF
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:04:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5B0w-00022f-V2
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 16:04:49 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso23264305e9.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 13:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685736285; x=1688328285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WpFMACP0RIdoZPUBC1MBjKf1NU1INCbQ/iB58Gf0QME=;
 b=S6QpCZx5L1eTA3yLUBmKd5ygM+PnyanU5Q7peI5nTwHdR77GywYyrrJ4HlFfeICNo0
 QHDkm7D+YXKQNSH4KqAzdr7FFQBMuPMwwvCaaGDE2V1zXzzn/+Yp7VtBlgXkJmdUXazk
 wFI4Dz/M8zFGis39cKfj1ktyfiEA7B+1hr9xJKcoZP77ixqPkPqGTjaiji0B6EAcSdXU
 OMO/8yVRh0bBsgsWSI2S7Q7cxoSJ3py7A1iTSiEExUgURhtcNveuS0y1mGBB+9pkQDpS
 nrBuqPkA4y/uIReJX1wwxbj+v3xdilqvvN4h6nhepKPWh6BT8x0nwIzreEcdqvqTz2JY
 xb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685736285; x=1688328285;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WpFMACP0RIdoZPUBC1MBjKf1NU1INCbQ/iB58Gf0QME=;
 b=YhUwgpdkCrjJBGx9K3vP3hq5qinf8P6ByLTZTArMv9XHrlfby3+LKU2N5O8t19Dc2+
 0poJHQBQ2rBBxaLV9Ujxd/mdiV031lcxrn5UOLrdpgaQwqvewp3F/y2JehN4cstxEC3b
 WggiD9MEMeFT2l6bk6L6HNiONLB2YsbPspefV+dYCwDIRTMUU/Y6fKMZr7qgOIiUvfik
 WIwHzEMRQr7UpUMskjORANGyXfdmSLAk4idjvchmBnJj66zjmoPNKfccTGe8zsZ7HN5D
 USmuenGYJGNvSrrsoAtIo+yi1+3/yKVqZ/5sOdafT+RO0tlTdv9R2pjMgKmGIToxDjC0
 dg0w==
X-Gm-Message-State: AC+VfDxa/aDyNx34Bxi9xcu3N5/xNDnY1b7QlTFfvNbcjkv4cP5bLK/K
 bH5j0nhP1y0XxG5iArsDq1FyMw==
X-Google-Smtp-Source: ACHHUZ7m/Cyd7ixWhdPTrVOb/oVua7IJBCYjTufDrkOObTkgCslyOPycXe0aHvvs2OzMaQ2Swt8OrQ==
X-Received: by 2002:a7b:c3d0:0:b0:3f6:1a3:4cee with SMTP id
 t16-20020a7bc3d0000000b003f601a34ceemr2578753wmj.14.1685736285523; 
 Fri, 02 Jun 2023 13:04:45 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a7bcbcb000000b003f60d0eef36sm6438207wmi.48.2023.06.02.13.04.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 13:04:45 -0700 (PDT)
Message-ID: <50dd74e9-94db-a516-c455-58f8f8a64405@linaro.org>
Date: Fri, 2 Jun 2023 22:04:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] linux-user: Return EINVAL for getgroups() with negative
 gidsetsize
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230602174806.2060683-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230602174806.2060683-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 2/6/23 19:48, Peter Maydell wrote:
> Coverity doesn't like the way we might end up calling getgroups()
> with a NULL grouplist pointer. This is fine for the special case
> of gidsetsize == 0, but we will also do it if the guest passes
> us a negative gidsetsize. (CID 1512465)
> 
> Explicitly fail the negative gidsetsize with EINVAL, as the kernel
> does. This means we definitely only call the libc getgroups()
> with valid parameters.
> 
> Possibly Coverity may still complain about getgroups(0, NULL), but
> that would be a false positive.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   linux-user/syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


