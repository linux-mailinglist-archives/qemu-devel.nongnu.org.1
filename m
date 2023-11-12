Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 011CE7E91A1
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 17:24:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DEB-00069P-Bg; Sun, 12 Nov 2023 11:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2DEA-00069A-Cn
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 11:22:26 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2DE8-0002h8-Te
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 11:22:26 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6cd1918afb2so2380614a34.0
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 08:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699806143; x=1700410943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ocmIQd+SVY2U71IwwT0Nh9IIR0HnuTvPwuQ/4K+4PK0=;
 b=YTzkZIGsmUMf8KUp+V24y79E+6iuhEtIBFMZ9me5Zty8XjI1lmww0AhQWQQxvooIHy
 sOuMOrG5g+MI/PlAA/9+XzrXwgSPCdiL8282aMABJMwvUJjJsb8GbvsYLGEOnpmYD4l0
 0hUbgDqUk8D/87Ku3/mX/Fjwo5Q9n6OSNs+H09c5WmPcLYAz/IbSKU5ZAW4pz/NXVagx
 HSbEB8R0SaXv7fw/iQmzlBc6sZrfTZ+z+HwYHZ1xHD8tA6hvIBOpyno93HlhiUNAFu7T
 Wt7RV9FdgjA7bfIJ244rxAthQumBhqHrpPQFqW6g20vTTmYQsIXsQT0bRrJPcBoph7IN
 Lpvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699806143; x=1700410943;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ocmIQd+SVY2U71IwwT0Nh9IIR0HnuTvPwuQ/4K+4PK0=;
 b=BY46I425OjVau+sXrN1Y60HfrhW5w9dsgmJvLwdO8SE8nlsgnse0ukiUAG+p5FhkNS
 lKfuNxyaDU3KoopbTvY9jLX0v5s2K3UuDECnJw/RW87bPk9cpDbcinD2OD1qoegWdWyz
 MnF3r78lnYbu9qB5ySvvYVelElvxB7Xbypgokw1u9iAatNczmB4bvAA12PqjcmOBPIqK
 uu0irYug5bAYwrdk1lSXpMRkiSYtnzncB0GMbrtBmex72hNSWC4ow7HB8DvtXdzH+H+v
 cBR4AtVdwlqpBid5IH4UHpxq19YwcAMjC9gDpLw1sYN08Cdx6q+y7/mZYoOtJSvS7sG0
 sAEQ==
X-Gm-Message-State: AOJu0YytPi8c2rSYP0N8WpeuaHacT5w4H7O/7B8YtLZJ9JCq/RADSVpn
 f9w/QN53N8Uxk1N8DlDBYx02hg==
X-Google-Smtp-Source: AGHT+IEo1qbvHadS4siFtABMcZdebrPBI/SeDlx/CW9wZH5kbPpjDF8UyztF/nAV0ahvWnLWBoGC/w==
X-Received: by 2002:a05:6830:71a7:b0:6d6:45f1:d7b4 with SMTP id
 el39-20020a05683071a700b006d645f1d7b4mr6140058otb.35.1699806143067; 
 Sun, 12 Nov 2023 08:22:23 -0800 (PST)
Received: from [192.168.114.227] (c-24-20-177-206.hsd1.or.comcast.net.
 [24.20.177.206]) by smtp.gmail.com with ESMTPSA id
 w123-20020a636281000000b005891f3af36asm2828571pgb.87.2023.11.12.08.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 08:22:22 -0800 (PST)
Message-ID: <80d7bc69-1277-496c-94fe-e1fd974f6ea1@linaro.org>
Date: Sun, 12 Nov 2023 08:22:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Correct MTE tag checking for reverse-copy MOPS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231110162546.2192512-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231110162546.2192512-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 11/10/23 08:25, Peter Maydell wrote:
> When we are doing a FEAT_MOPS copy that must be performed backwards,
> we call mte_mops_probe_rev(), passing it the address of the last byte
> in the region we are probing.  However, allocation_tag_mem_probe()
> wants the address of the first byte to get the tag memory for.
> Because we passed it (ptr, size) we could incorrectly trip the
> allocation_tag_mem_probe() check for "does this access run across to
> the following page", and if that following page happened not to be
> valid then we would assert.
> 
> We know we will always be only dealing with a single page because the
> code that calls mte_mops_probe_rev() ensures that.  We could make
> mte_mops_probe_rev() pass 'ptr - (size - 1)' to
> allocation_tag_mem_probe(), but then we would have to adjust the
> returned 'mem' pointer to get back to the tag RAM for the last byte
> of the region.  It's simpler to just pass in a size of 1 byte,
> because we know that allocation_tag_mem_probe() in pure-probe
> single-page mode doesn't care about the size.
> 
> Fixes: 69c51dc3723b ("target/arm: Implement MTE tag-checking functions for FEAT_MOPS copies")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)

Acked-by: Richard Henderson <richard.henderson@linaro.org>


r~

