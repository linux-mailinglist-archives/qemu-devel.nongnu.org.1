Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE976F729
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 03:47:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRjur-0000BF-3b; Thu, 03 Aug 2023 21:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjuo-00086W-7b
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:47:42 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qRjul-0005rk-PO
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 21:47:41 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6873a30d02eso1143971b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691113658; x=1691718458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+Um/oeg585mI4S5/+in6uYCkFJfRIXsPy1YVX1IJbY=;
 b=xCWUWjYbfb7updAzKDWqZX6+diRQApo81zWaGUUpcR8fcXjqxDafRkrI/mHFAfIniz
 e+hBjwWbr1W7h+HDtWOr1cSczodxXTINLm0UkBtUTzfSj+spKfeX3Dc3QIiIadkH/dEV
 uB1Q72NH5t0upWKEiWyVOcoDH14gQg/RqWqkR1DdzfSuU8QamDsoagz02DdyoFcQA92/
 SWONrCJANVeFl1PTSTGTn3dhbwyodvRfBb1/I+i6IXnoqUohWVw0B+EpDVs+IdsZds9x
 FwkCY+8U4HwPaLeT00mk2dNJBY/nnbOkrePMqoaCRmFILypVG8zx659HehQTDw6we3kS
 5cHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691113658; x=1691718458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+Um/oeg585mI4S5/+in6uYCkFJfRIXsPy1YVX1IJbY=;
 b=elnkQgmZXB1VPisJq6wHkbrhPYtyLgWZF6tpUHwmPyN4OS9eDn6s1vA+eV1aZIb/QF
 Jx5B+cuMVJh0rFNwU1KZD+Ns7cGfY4RNHSjyT/WbAvFzRIDvXS3aK7zgWpLRWh1an1SI
 7HBzdmhvP8E6+mZ/AUK4F0+fxR+frJ7GRI9FyQr9UdFsShn9XM/2hLEoGUg0P7cktr5g
 EAD5o4121d7g7wJrJ61FCx/0BMUDF860aJxKLqzpuvBLyqbn0FWZJYZmt8l6eoHWTbq6
 juV643S0LtmBFdTJtUj9HQEeOcah7AFfmSJjLrvTVB/76ga4ZOdhBm9QNKEZxi5TUQZL
 x5mw==
X-Gm-Message-State: AOJu0YzCF22OkaBW5hro9PPWl/tG4XEkdFGyOYGG8CarjoC2ec8yi+hT
 LSFfy+HrBIqCozsUMC6rxfbgEw==
X-Google-Smtp-Source: AGHT+IGdgLabtn2Mer2wPhPArggvIRdQ13LB0jXTb1bK2kGY2o898UYil+siq13H+8Jatd7ckh7rKA==
X-Received: by 2002:a05:6a20:3259:b0:13d:c70d:de62 with SMTP id
 hm25-20020a056a20325900b0013dc70dde62mr279415pzc.22.1691113658322; 
 Thu, 03 Aug 2023 18:47:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9d52:4fe8:10ce:5c3?
 ([2602:47:d490:6901:9d52:4fe8:10ce:5c3])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a62ed06000000b006833bcc95b0sm451988pfh.115.2023.08.03.18.47.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 18:47:37 -0700 (PDT)
Message-ID: <cbe28c2b-47f9-9bb0-32b3-03645d746062@linaro.org>
Date: Thu, 3 Aug 2023 18:47:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL for-8.1 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Richard Henderson <rth@twiddle.net>
References: <20230803155545.2349984-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230803155545.2349984-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/3/23 08:55, Stefan Hajnoczi wrote:
> The following changes since commit 9ba37026fcf6b7f3f096c0cca3e1e7307802486b:
> 
>    Update version for v8.1.0-rc2 release (2023-08-02 08:22:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/block-pull-request
> 
> for you to fetch changes up to 9b06d0d076271d76e5384d767ef94a676f0a9efd:
> 
>    block/blkio: add more comments on the fd passing handling (2023-08-03 11:28:43 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> Fix for an fd leak in the blkio block driver.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


