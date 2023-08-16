Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEB777ED68
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 00:49:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWPJG-0000wV-II; Wed, 16 Aug 2023 18:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWPJD-0000w0-VK
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:48:12 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qWPJB-0005jn-Lv
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 18:48:11 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe0d5f719dso11746359e87.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 15:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692226087; x=1692830887;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2oXlQHwCHirU6bEDhFGEnYoZDKxLVEIs4IFSyEORKOw=;
 b=dsBWShIt046zjSxapfs3lorVvNsOcH9nEI2fGLvgCgLuRKbzqcj3A94/Lwz+sexEwJ
 XCDZdG1eOK7e+WycxFCGhvfN65dYorvnpTx2NjfywccJXy/mVXEm5bB2Ii7dq3wf6aOY
 ppZ/5xA0cAyMp1U6xcIlo8gedHzr2dzI4dks/Pyw+SU7660kRNiKPWu0u44RQvgcWArc
 wFmFyzTGo81u6dX7ELDi1PRd0hTcX+0EJ6kMddmvpgjCJcAXrE0QL7wt5gFiT7KjDCFa
 2NdlbIVDI+UjWepQ8Uq509DVL3+a8nAmnkc08AKmyiPfLlcjjz9dIupsvbNmneH2e+ZK
 KQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692226087; x=1692830887;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2oXlQHwCHirU6bEDhFGEnYoZDKxLVEIs4IFSyEORKOw=;
 b=W0GIyZWCFv7a0Ifx6bYI1OZwQ601gcMqKFdICrlvxX4hRYzYSaQu9PFiMlYnUgBdGu
 HNmXRp4aF4nCBcLgXdZVKmSO4Brl7cFWMh4/AT/NAkSPI7AjDqyH4IQNUN/qQJoLwjmu
 CZdmWxlKYlarbIGQ/dCQa/rMS7qCOEqBEDQp+oZm3EWrs/AXaLVE0U3WWKV6XmNkt4Gn
 dipabIILleLJnGwhNT6Q+eJTawB8mptrh3liI39/cJwobKvV+7rTyBPEL/03vJgys+ZS
 5IyVs7tMSxxFX0GB+/Y/RmwYMzBlDhWhqzbq6wI5oDLfxBlFfAaHloVaAuMTdFTuU5TF
 KJGw==
X-Gm-Message-State: AOJu0YyStsavUexhFuPK6ce3zXzHUX11yoJ42z2jG0igSOqpFby957Lv
 mI99/tlASRIADdcjWno8qBFVjA==
X-Google-Smtp-Source: AGHT+IEw+kj3jz/iDIrutHk4/S8lUfdquoxZ7qHVURdnh8W0zarqlrSfYYgXPTcaIeFv60QJmdqMZg==
X-Received: by 2002:a05:6512:2149:b0:4fc:3756:754e with SMTP id
 s9-20020a056512214900b004fc3756754emr2439179lfr.56.1692226087579; 
 Wed, 16 Aug 2023 15:48:07 -0700 (PDT)
Received: from [192.168.69.115] (mna75-h02-176-184-40-35.dsl.sta.abo.bbox.fr.
 [176.184.40.35]) by smtp.gmail.com with ESMTPSA id
 d15-20020a17090648cf00b0099ddc81903asm2383398ejt.221.2023.08.16.15.48.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 15:48:07 -0700 (PDT)
Message-ID: <5916581f-c0c5-4659-cfbc-1f02cfbd2392@linaro.org>
Date: Thu, 17 Aug 2023 00:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v4 01/18] linux-user: Introduce imgsrc_read,
 imgsrc_read_alloc
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230816180338.572576-1-richard.henderson@linaro.org>
 <20230816180338.572576-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230816180338.572576-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 16/8/23 20:03, Richard Henderson wrote:
> Introduced and initialized, but not yet really used.
> These will tidy the current tests vs BPRM_BUF_SIZE.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/loader.h    | 61 +++++++++++++++++++++++-----
>   linux-user/linuxload.c | 90 ++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 142 insertions(+), 9 deletions(-)


> +/**
> + * imgsrc_read: Read from ImageSource
> + * @dst: destination for read
> + * @offset: offset within file for read
> + * @len: size of the read
> + * @img: ImageSource to read from
> + * @errp: Error details.
> + *
> + * Read into @dst, using the cache when possible.
> + */
> +bool imgsrc_read(void *dst, off_t offset, size_t len,
> +                 const ImageSource *img, Error **errp);
> +
> +/**
> + * imgsrc_read_alloc: Read from ImageSource
> + * @offset: offset within file for read
> + * @size: size of the read
> + * @img: ImageSource to read from
> + * @errp: Error details.
> + *
> + * Read into newly allocated memory, using the cache when possible.
> + */
> +void *imgsrc_read_alloc(off_t offset, size_t len,
> +                        const ImageSource *img, Error **errp);
> +
> +/**
> + * imgsrc_mmap: Map from ImageSource
> + *
> + * If @src has a file descriptor, pass on to target_mmap.  Otherwise,
> + * this is "mapping" from a host buffer, which resolves to memcpy.
> + * Therefore, flags must be MAP_PRIVATE | MAP_FIXED; the argument is
> + * retained for clarity.
> + */
> +abi_long imgsrc_mmap(abi_ulong start, abi_ulong len, int prot,
> +                     int flags, const ImageSource *src, abi_ulong offset);

Nitpicking, having imgsrc_mmap() in another patch would ease review
(in case you ever respin). Otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


