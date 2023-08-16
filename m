Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 628F277DD1A
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 11:16:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWCdQ-0002Gc-Ti; Wed, 16 Aug 2023 05:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWCdL-0002Fv-Nl
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:16:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWCdJ-0005zw-4O
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 05:16:07 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3178dd771ceso5565969f8f.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692177363; x=1692782163;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fsCiGagy3ihpNpZfP6B62EnqGGIAm7mlOmqhVD9wtfw=;
 b=WXMPbBK6ZUbtHSJfNCE3BoFIvoszJQ4Qkaqf6ysdF1PAhYy1A6dKeBksV4OjK1vZxN
 eW8qawsQuJcdCSaebIUVjA7n+2u36LJVzjtN0AUDnB7fY8d01IaNI8JUBCEA+GK7LNJA
 vVk8UKqVbgS1+rof5dOGo4eV9hns1cybqeF/WbmK438m00jJmLdzJhqSYh6r4cLsaG3u
 T2q/JgcDfy6IhyUVa+2n6Uk5XweJqSaJ8oFNoYE7QDcMWMZgEx/+aeAn9XIqzaALtMQE
 IDRqzmcMipcFWvA6nZVRHo2Ei7MAyKEoYyh1fIqUwjePvclg5EX6pWAaxfg4/UUd9oGj
 uKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692177363; x=1692782163;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fsCiGagy3ihpNpZfP6B62EnqGGIAm7mlOmqhVD9wtfw=;
 b=ZIeBtTWbdyqSh9r0aoU0tIT65CaTnUcI+mh+KhD/xCIDd1ezaLVSB8POdo0+s/T5BZ
 EnFv0QLB7EJ4f+Ptb74Ei9DzotCENhxLrBh1ANF0gfi7ZvT8tSwQ8wQ1psjUZb/EB8F6
 HhHoVYnK+241G4ElJJo1CQxc1Bp4ASCNXkSQ17942GU3elXEFerl35ULUgE/DXNlwNwx
 xMbacDZ6/1Ok/mczsCTq9Ziha8tiYGewala+GkY+n+KOjD6gD0l62k+yIgEFey8ndXdf
 j3hL2NhYM0o3xtchVZkIJ5gRY1rHbyaYuoD1oJNyYqwzena8dINbe5cGya3V4rHlhyTy
 +QMw==
X-Gm-Message-State: AOJu0YxyOQ+WmuSiyuM4zXdT5ysq+gI7LrA4K4OhwVeNO7K7lLM78GGP
 sc8ad5Mcc5wLEHocluAY3HusLKUzx7LaO6yF0Q8=
X-Google-Smtp-Source: AGHT+IHbvZIgoKZoxECvu2lkjJfMICW76NnVjN9dM9AZu/S9DBdbKXhdmBrzMxqlEtRvtx25qhBEEA==
X-Received: by 2002:adf:ee4b:0:b0:314:1b4d:bb27 with SMTP id
 w11-20020adfee4b000000b003141b4dbb27mr955900wro.64.1692177362955; 
 Wed, 16 Aug 2023 02:16:02 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 h5-20020adffa85000000b003197efd1e7bsm7358101wrr.114.2023.08.16.02.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 02:16:02 -0700 (PDT)
Message-ID: <389cfe6d-aade-f79a-b618-fb0e029fff5d@linaro.org>
Date: Wed, 16 Aug 2023 11:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data:
 Assertion `r->req.aiocb == NULL' failed.
Content-Language: en-US
To: Waldemar Brodkorb <wbx@openadk.org>, qemu-devel@nongnu.org
References: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
Cc: qemu-block <qemu-block@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <ZNiKYwbkk5zwlLB5@waldemar-brodkorb.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.045,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Waldemar

On 13/8/23 09:46, Waldemar Brodkorb wrote:
> Hi,
> 
> I am using Qemu 8.0.3 and getting this error:
> qemu-system-m68k: ../hw/scsi/scsi-disk.c:557: scsi_write_data: Assertion `r->req.aiocb == NULL' failed.
> 
> It happens f.e. when I extract the glibc source code inside Linux.
> Linux 6.1.44, glibc 2.38 is used for the Linux system.
> I am starting qemu this way:
> qemu-system-m68k -nographic -M q800 -kernel /home/wbx/openadk/firmware/qemu-m68k-q800_glibc_68040/qemu-m68k-q800-archive-kernel qemu-m68k.img
> 
> What can I do about it? Why this is happening on "heavy" I/O usage?

Cc'ing the qemu-block list.

Do you mind filling a bug report at
https://gitlab.com/qemu-project/qemu/-/issues ?

Regards,

Phil.

> 
> Thanks for any help
>   Waldemar
> 
> 


