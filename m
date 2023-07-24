Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBDB75F570
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:50:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNu4Y-00071Q-Ug; Mon, 24 Jul 2023 07:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu4K-0006uH-H5
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:49:41 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu4J-0007Es-3H
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:49:40 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so11013634a12.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690199376; x=1690804176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QUOinpeZXzwBjhF5cXUkkVnKisCQfhqBCZV0hhZiwVQ=;
 b=a/N/MehIDsHaORli6PpYx8NwuKmVrRyJZybZh53JtcScJH6KCdTGmbAu0lGX11Kx+V
 DryvdPphP5oydptQavlCyQ+7mKfQV/izhCHKSGUezPns+53q4NQowRIvZKahHK5Nl/ZE
 I4ydrWV0ksCw80ImOwHurqctUpjgVSlty6K40xB6HMj5L/FAxqh0HJOYKHRp43ZmDCjq
 bXNVa+oYE/ZbVjiHpU19km99LWm3f/1tLKcrBTE0+JqqBJBTzqITpW+n50H9SIXdH2Xh
 2R7xdUbbzWHPOrokLhWkxq8eFOtW3bnuc6apNCBfER56K2bAFD/2DMM207ts1z7WbtWZ
 J2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690199376; x=1690804176;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QUOinpeZXzwBjhF5cXUkkVnKisCQfhqBCZV0hhZiwVQ=;
 b=Gh9fEm9TE7mKPxqg62x+0o+MheRP8cSZZJmX73Ivtio0m6xLC/ET7xQCDGO97KoSpr
 IPdUAy0Yscp8lp6Xtj5rXogueidXcrcdLOFhisUnDD9Qck4NFECSA1OcQXA+OU/oE2VI
 ZVCV0gId8wT/NqMrPlrHmivf+xiMOldQbFR1NZIqA41nCkWu4UdOl8TwtksLVe8ep/vh
 yM6HSolZUX0iv7BNJh2EWHpa8q9pw+4Rq4Tj89jpfS4JgJPh+VOKft77oMhLDzv2BjBM
 zYsXhxsico6QHnMRSn8i7O9a5ScNUU3VZQ9/Qy8v852UFQ9wH3W+O36DHD7AN7U8u9SU
 Q+0Q==
X-Gm-Message-State: ABy/qLZxB2oMFtVVyABMdESC8yPD4KvStIfv8KHg+jOUyEN/jfjKEkbM
 vvPDyodZvQrp0NnTyZbXpRiU0cTPQcdyrNxmA3kaOszKBnm8VwQE
X-Google-Smtp-Source: APBJJlEwX7g3to+TGkap2APC8Ck+UUkVKam1O9HeLXZxoVWHYc95l+woONabj8wSYYlTGXRMo0AqV0jcTEVwwAzPWyY=
X-Received: by 2002:a05:6402:4405:b0:51e:48e7:72ca with SMTP id
 y5-20020a056402440500b0051e48e772camr19339095eda.13.1690199376559; Mon, 24
 Jul 2023 04:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230722214422.118743-1-richard.henderson@linaro.org>
 <20230722214422.118743-3-richard.henderson@linaro.org>
In-Reply-To: <20230722214422.118743-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 12:49:25 +0100
Message-ID: <CAFEAcA_Byo23E3PLk91kH3FyKCnpu_r_gVYuES9m7O=FcJPhBQ@mail.gmail.com>
Subject: Re: [PATCH for-8.1 v2 2/4] util/interval-tree: Use qatomic_set_mb in
 rb_link_node
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sat, 22 Jul 2023 at 22:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Ensure that the stores to rb_left and rb_right are complete before
> inserting the new node into the tree.  Otherwise a concurrent reader
> could see garbage in the new leaf.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

