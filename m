Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED27987C3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:25:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebSs-00074j-CP; Fri, 08 Sep 2023 09:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebSq-00074Q-HW
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:24:00 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebSo-00017l-BH
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:24:00 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so2633199a12.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694179436; x=1694784236; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1G9jEN0L2RqvID71WCf+WwTVwnk2Gp91F9cYIMBJEjI=;
 b=ByICHVKLFgVgqNpcR8ZCyjc3sa06ZRZkOF1iYdq8CZAC03aa6qieikQBq/DHIdBhEZ
 g1ie5e2pnQgJ0PRnXtQzP74gs1STJGn7sOiBcIi1IcD6rFYjdsMU7WN/ofsmHzP3z8wc
 gNWtX3s0CXCL7KDgwj+xAavhV1XbuoRkdkGWdw7l7vg+rxL3fsQZh/Mh/03h78yALb3+
 4Hz2HGJqZGJKZELNazXE1IYYnDEXZC6cH841dgKcC20X5UN2RtsGDDGvFhTqGtDFZCKO
 EYIbv11Uj1rdHxoonPZZdtq3vdSHAcALB87WumaM9KQxSb4xztdV+mpMaLPOLHm4a9Ow
 lkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694179436; x=1694784236;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1G9jEN0L2RqvID71WCf+WwTVwnk2Gp91F9cYIMBJEjI=;
 b=WwrISCkasCccjcKqbIT98C09zqwFRScfN6bVLvvBRNB3um88qD03I7zlSZww8P2f8K
 gRoc9/HB8u/CD1Au44v6d1FdJyi/YSoFSamydZhr1Wr6UXL5F3ZTbg4IPYCLusiJsiyu
 2cP6fH5oEYIUJukmWqaRlasht8eLlhNeJCpf9VHB/NXdopXfiHK8LT0x7wqvjDgi2KEP
 KwGGOAfbHbOgkKBRarUbuy0pKJcNz6IirJul1c6LBqn+U0vv9rbBht1eewfqhNIun1qb
 iHnFmXPt/qZDSU03HSHeBhG82C0UVY8bvVd7UM+1NzAZATawk6Dk6EkeI3905mMlqvnY
 SQbA==
X-Gm-Message-State: AOJu0YzKhRJQba1B67Yf1MvbFWu8rthw/nKYVt2iQsFbCSkYIWb+ggAs
 m3KjwI0jWQ66lzfjzL1DF5XAUKF+Eg6fJntGoPF2jQ==
X-Google-Smtp-Source: AGHT+IGu3PZwzDSQKXMdAizwLjKH3VAKZit38yRTczy9MTNGa3h5zSn+aMSNO6yE59Jtqekh6aqvqyZnU/KBjahHlH8=
X-Received: by 2002:aa7:c641:0:b0:523:7192:6803 with SMTP id
 z1-20020aa7c641000000b0052371926803mr1868667edr.8.1694179436434; Fri, 08 Sep
 2023 06:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230831232441.66020-1-richard.henderson@linaro.org>
 <20230831232441.66020-3-richard.henderson@linaro.org>
In-Reply-To: <20230831232441.66020-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:23:44 +0100
Message-ID: <CAFEAcA_rkA5MtRDCRK3ZZYxK4OQ7ToYy3eZh1NQRVehM-OwcPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] target/arm: Implement cortex-a710
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 1 Sept 2023 at 00:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The cortex-a710 is a first generation ARMv9.0-A processor.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/system/arm/virt.rst |   1 +
>  hw/arm/virt.c            |   1 +
>  target/arm/tcg/cpu64.c   | 212 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 214 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

