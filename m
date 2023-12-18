Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 748D7817485
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 16:00:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFF5I-00089i-7f; Mon, 18 Dec 2023 09:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFF5A-00089J-H1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:59:00 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFF58-00069M-Nw
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 09:59:00 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55114c073b8so3924813a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 06:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702911537; x=1703516337; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QzLnCTVfaMX3GmaeHQ5NuJy/QO3103fDAV+f6peyJ54=;
 b=CMIZ14nPlswpTUhAebWkl9FD571QFaKpV8Rq9On1nvlTIOTwknfFFKhYNIqu4pfxJ5
 9jBCfrsDgF9POAN/Xq2QKEyKpLBMfE6fLfo3hTh54H7TqYmLW/O2XMRSBKzt9WpgT/Z4
 Tn8ajkWuYCLNwibMorP2T0b2uB9ds1/CUt3b8cksnESll/f06FQwL51JC/DuCFnEquav
 xRNSp6mHllgmhBgHKS/4GVO4ckIjZDVb42FChM8dKDjJH4hfLFqfBFtJDnZ2CrDR5Ht+
 27stZ6rdRTlRqomegaQqnXqYe7I97oc41crv2zMMlPDOtTK08TUENCIQ/moFVRyZEjCa
 9rJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911537; x=1703516337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzLnCTVfaMX3GmaeHQ5NuJy/QO3103fDAV+f6peyJ54=;
 b=MKPDx9SeCd6RLMYxR8VPK642VPK4xrxyaH7OrUfLjI7s2LCJpy5kKas2OWYwQY3kmU
 btAwOnF1+XILXLnuW7hnMUPThouDwpx/t21kQvyGlxV0kCWdK78hKZVEL4a4mk02hLZy
 e8qBi39UI8b8nsf/iltN6GO5nHolQQg5vekfkYheJfa0NJ4hmLIlh3AKSpbvIoJLO4/p
 VV9Nu7zuzlOJrZJzmlgX54NGngHIzoY11bU3gYnl70IbTBFdZSHR8q1bVfHKW2FJb3tG
 opB1vcIVEYjvKvE5NhynO0B6K7IS1LcQdbiHD084eJrp/o0bEcHxNbREP8TELsotLE4u
 sbUg==
X-Gm-Message-State: AOJu0YzYlHE2uaeIZJa1X2tJz17AP5MprLRlw7oaEFCxNWBvNbI7bl3x
 +tmSMkEn2mY888xKTe2qSseqiTD5sCCF46vD37dM3w==
X-Google-Smtp-Source: AGHT+IFPrRVwUTSFl1mqwbh2O6In61HzCykLHddoO/koIgIIaug3jE/nXUKgXr5Z/Wzw9Yew2zzzkaEKgDZ+pV3b4/8=
X-Received: by 2002:a05:6402:2152:b0:54c:4837:7d0a with SMTP id
 bq18-20020a056402215200b0054c48377d0amr5751385edb.73.1702911537068; Mon, 18
 Dec 2023 06:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20231215120307.545381-1-jcmvbkbc@gmail.com>
In-Reply-To: <20231215120307.545381-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2023 14:58:45 +0000
Message-ID: <CAFEAcA_ONSsjp8oRHyq1T53tmcc=kW5axAFh25JX1fM6R6prog@mail.gmail.com>
Subject: Re: [PATCH] target/xtensa: fix OOB TLB entry access
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Fri, 15 Dec 2023 at 12:05, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> r[id]tlb[01], [iw][id]tlb opcodes use TLB way index passed in a register
> by the guest. The host uses 3 bits of the index for ITLB indexing and 4
> bits for DTLB, but there's only 7 entries in the ITLB array and 10 in
> the DTLB array, so a malicious guest may trigger out-of-bound access to
> these arrays.
>
> Change split_tlb_entry_spec return type to bool to indicate whether TLB
> way passed to it is valid. Change get_tlb_entry to return NULL in case
> invalid TLB way is requested. Add assertion to xtensa_tlb_get_entry that
> requested TLB way and entry indices are valid. Add checks to the
> [rwi]tlb helpers that requested TLB way is valid and return 0 or do
> nothing when it's not.
>
> Cc: qemu-stable@nongnu.org
> Fixes: b67ea0cd7441 ("target-xtensa: implement memory protection options")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

