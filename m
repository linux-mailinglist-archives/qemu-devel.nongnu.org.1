Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49787780755
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 10:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWv1L-0007tw-W5; Fri, 18 Aug 2023 04:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qWv1J-0007tk-Rq; Fri, 18 Aug 2023 04:39:49 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qWv1H-0007Sl-Ho; Fri, 18 Aug 2023 04:39:49 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4ff8cf11b90so955335e87.1; 
 Fri, 18 Aug 2023 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692347985; x=1692952785;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qQzDmZTwKCR0XStGgpiSBJ5DY3muBzKn3aAo29NKn+c=;
 b=Cbo6on1u3h5+oqZRSNlWn0LmugD0rhyR98FRGBS5ZQ9thaqzjr0cjolT8JDc4cGKuK
 bLEPiJYwLtg/sf2P60hsKJVZQZbJGBvWaXaNDXzdecNPs5yHaIhWYcCCaLQ6JFO/j2zp
 rNXqKM7mnOdFU+eHExnW5Xoqzi9rVGVfPmhv8XXva/36mHIU1UrCdYIKVLzPto/d05gl
 QQv9vFg5XiRsE+JI8WvelGJo6SudPTLJhX4iuIsntuAh886e07mGX5LCWiDbVkN35zX9
 xFlWzrsf0uxygNFJW69ByZB2PypMAoeMyZP8T32+f/9sQa6S157LoELhWnAOu59oXNTn
 T+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692347985; x=1692952785;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qQzDmZTwKCR0XStGgpiSBJ5DY3muBzKn3aAo29NKn+c=;
 b=ESIqyCjSdKbltZH+snAgSXqksGJe61k3wmL4+G7FbtZd0h1pmbWeFSiuwZ53iLHnmF
 B4nR28Qsvcm101hnWEMvMbhCaOod2g63fNFxXZ8b0VIJZzjo43fb1T1ND+C2sbiExvTF
 UVJN3galb21TcMSJahNGdBWQEYXxX+p+3QKZW+UhNRqWPm0GQlc2x1xM6pwfxu0KXoc2
 4N7E57/wIsn1NbtN7pDqyCQhRV/QQIL3se9QSihw0ANTUl2TxsBolVDIvVOVtT4P5aiV
 9D//RqZSdnbm98FEFEUWF0HZWEFAEjN9jzgakuBIrEpm0s4Cjkjf3gaVm6mMewzJnm0t
 pH9g==
X-Gm-Message-State: AOJu0YyfVZSRgyYezRpbGljA2ucPn9eJdEGb4/ZavabfgsDitpxVZDko
 35GaecWE0swS5zFpkhun8uw=
X-Google-Smtp-Source: AGHT+IHnnY1WBt6bWQmiJyPXHGLS8rYzXJpBU0E4UH97cThqCTCBNQpkFuX3xmC9iMUNQqEW8Lu7Kw==
X-Received: by 2002:a05:6512:3123:b0:4fd:d7ac:2654 with SMTP id
 p3-20020a056512312300b004fdd7ac2654mr1203734lfd.13.1692347984543; 
 Fri, 18 Aug 2023 01:39:44 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 q24-20020ac25298000000b004ff98f99f90sm245652lfm.190.2023.08.18.01.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 01:39:44 -0700 (PDT)
Date: Fri, 18 Aug 2023 10:39:42 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH] block/vpc: Avoid dynamic stack allocation
Message-ID: <20230818083941.GK6984@fralle-msi>
References: <20230811175229.808139-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230811175229.808139-1-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Aug 11] Fri 18:52:29, Peter Maydell wrote:
> From: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Use autofree heap allocation instead of variable-length array on the
> stack. Here we don't expect the bitmap size to be enormous, and
> since we're about to read/write it to disk the overhead of the
> allocation should be fine.
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> [PMM: expanded commit message]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  block/vpc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/block/vpc.c b/block/vpc.c
> index 3810a601a38..ceb87dd3d8e 100644
> --- a/block/vpc.c
> +++ b/block/vpc.c
> @@ -510,7 +510,7 @@ get_image_offset(BlockDriverState *bs, uint64_t offset, bool write, int *err)
>         miss sparse read optimization, but it's not a problem in terms of
>         correctness. */
>      if (write && (s->last_bitmap_offset != bitmap_offset)) {
> -        uint8_t bitmap[s->bitmap_size];
> +        g_autofree uint8_t *bitmap = g_malloc(s->bitmap_size);
>          int r;
>  
>          s->last_bitmap_offset = bitmap_offset;
> @@ -558,7 +558,7 @@ alloc_block(BlockDriverState *bs, int64_t offset)
>      int64_t bat_offset;
>      uint32_t index, bat_value;
>      int ret;
> -    uint8_t bitmap[s->bitmap_size];
> +    g_autofree uint8_t *bitmap = g_malloc(s->bitmap_size);
>  
>      /* Check if sector_num is valid */
>      if ((offset < 0) || (offset > bs->total_sectors * BDRV_SECTOR_SIZE)) {
> -- 
> 2.34.1
> 
> 

