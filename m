Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8A703193
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 17:31:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pya9m-0008U9-NU; Mon, 15 May 2023 11:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pya9d-0008RM-IW
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:30:30 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pya9X-0002CM-Hm
 for qemu-devel@nongnu.org; Mon, 15 May 2023 11:30:29 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-50bc37e1525so24029739a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 08:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684164618; x=1686756618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k6WHLFZ5fR8+TGTJrOacBSkcyB3koTblBrGWoH2pfwg=;
 b=kuYCBZ+2JOxlJIDf8m+v5gLyXeDPUVzwb0ABi5nKi5dYgt7cFIfQNogkbyziD0x7tc
 onA+k6F49cMO23/KTo0BXo70JzQYY1HJP+41T2poxoQ2Om7ztWHkZsmZJncKwHqlwGHb
 3q9AmqLseES9qWf819UBiwKjyAcI2DMXAkySInTvY/bsquRyowrQytzg4J6ohaWnkU4J
 dAtP2tuBqYx8DyfFsPonWWqEF+hcpU0Ks0XkxnpIsllYvkL9XGhjATG3ypvhO+97Y5DV
 1WELcYinzjE6xEDLvErDMY5ko29D7wJUUilW0SbCbmLYFY8dE36Q2h7RcSnv62WuKI5A
 yzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684164618; x=1686756618;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k6WHLFZ5fR8+TGTJrOacBSkcyB3koTblBrGWoH2pfwg=;
 b=DY98H7TIa6R9lh6usrOxJD3UjuzZvHuWBSlwaLkWvCT0gAGTNgxyksw0Xyvb9ia7GH
 GPnU5enPI/l5PTmDfr4WxblrmdN9d00Yy+PorAptlcULLHwUyIOX9VkQHh1UG9OeaFBm
 h7X/ww7JDhtHFToKhdsoYjvXuCOR4LB87zjJENt/CEe+5T0xODAM8SBFYG7ZJd2qDiIz
 yROP4JlNbNCOudiu1ttNw7cgfUs4BvZ76qpPNjJSwKRF6gbdh5pW36NdWpPh+P7KqDBI
 +UNg7v7mb+XXQjk+fzI0ITY7LsEJwM4tFAUCP6x0WP6a1ySQi7gRZWDk7eAekopYXjJL
 dn6Q==
X-Gm-Message-State: AC+VfDx2r0O4Bm4ihY+vGMmmJ3hMC28Mwu0pfdkAzDwu1b+3wRLxaWQk
 ZOd6eGNTdTvnLN2Y609LFDSS412fF13DLSz5vUYuXw==
X-Google-Smtp-Source: ACHHUZ7BBNtqiPKnZz93AiFH6ny3UhW5QdNpAuJwideExce4iGya0w5J8Pxg93Mfm7Ko+Pvzb4mPs29c7DLi7Mos95w=
X-Received: by 2002:a05:6402:322:b0:50b:c689:8610 with SMTP id
 q2-20020a056402032200b0050bc6898610mr29763801edw.18.1684164618575; Mon, 15
 May 2023 08:30:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230504104232.1877774-1-richard.henderson@linaro.org>
In-Reply-To: <20230504104232.1877774-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 May 2023 16:30:07 +0100
Message-ID: <CAFEAcA-MdYoQiTvp_c+m3342aNAQ50FtpeaVijhwmv0HcvzeTw@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Fix vd == vm overlap in sve_ldff1_z
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 4 May 2023 at 11:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> If vd == vm, copy vm to scratch, so that we can pre-zero
> the output and still access the gather indicies.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1612
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---



Applied to target-arm.next, thanks.

-- PMM

