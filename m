Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D37A4F42
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 18:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiHEY-0002cq-NV; Mon, 18 Sep 2023 12:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiHET-0002ZZ-NE
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:36:21 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiHER-0002du-PV
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 12:36:21 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50079d148aeso7789246e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 09:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695054978; x=1695659778; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3fm8UOvf0dn97kAxKjVd0ClnGGmlGmrv5xri/Lnmcqk=;
 b=MkQ+rEyPCNppsff+Tsb5QoEn53u8Nj/9TW6NOfyV12b3zNAcdx8pBsQYSMegdyxrjk
 aPf3A70iamyUwDVSaPWky0WFeNHnPbnBbHhP8W5vlSAxwKrTGuqSGxTZcRzA0Bd9iBaq
 QyE4tLmrzBXgZCb57YrvSgWgVVnOJgW8b9UgD30mN1FuzWI7Z3LNV3ScoRPGyqIZ2Cij
 MjV+tzJECPEjZv0lNJkm4LzpP1J0z1ArJChOs3PkhRFlKqEnvPsqwxH6kXxwSE0MZhzl
 Ht8YZyF+odRtZAObiyk+GpG4M+HTyyfcZFa17nFGVxp93VSL+ctIiQOieSeWRuwbTOES
 dtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695054978; x=1695659778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3fm8UOvf0dn97kAxKjVd0ClnGGmlGmrv5xri/Lnmcqk=;
 b=q7uzV+e7dnrocECHKGwM7k/eMm0EeEj0vp1JL42l7ZK06Iyb4rp9Br4rZj44EaqqCc
 IY0lKITZFHBWfBf1BctSr9C8GXPYuRKNCknkjxUkDj+IUPdz4Mj6VHTZuRZUpKd/igDn
 20qK5kuP9R+3vSPaVZ4XiwD9pYY/aemz20EPyPRHEey3mHeABxRKqMnx1jy3/yzypiNb
 cZF/MxKLqz10wGOHXCB5D7+cetx3C0SYsuWwcvGeuDmhbmYmdrWeydWTqMMAY5qNuGom
 gPJqzOvpoe/KZSLGvU/xnlvCcqYvc6/uh21wulP1hd+k5ZFcDvXIj0odZbg7BtIF9B8C
 zS9g==
X-Gm-Message-State: AOJu0YxxOFT/4aDfibGvF0fUB6K9+ama/NqAkT+1mvzKqcZzuO2WT/aC
 3tGwufLSghgq66FoaJ1/r2HADonkAYPnbREGG9Cd5g==
X-Google-Smtp-Source: AGHT+IGQFfp0Bv66NVw90mXfI4sNw2hjUmxSDUVR08K0ioTEJKl55aD8EpW9Ck63EMEkN0dWl1M+ZRLoxTlYUnXWvTM=
X-Received: by 2002:ac2:5e2e:0:b0:502:f2a8:d380 with SMTP id
 o14-20020ac25e2e000000b00502f2a8d380mr7662279lfg.19.1695054978012; Mon, 18
 Sep 2023 09:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230918150259.11165-1-Jonathan.Cameron@huawei.com>
 <20230918150259.11165-4-Jonathan.Cameron@huawei.com>
In-Reply-To: <20230918150259.11165-4-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 17:35:59 +0100
Message-ID: <CAFEAcA_fGbJDoGRAG4OV3-tr5HnSOOZ5cG_xkCdbx8Wq2M2fkA@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs/cxl: Cleanout some more aarch64 examples.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linuxarm@huawei.com, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Mon, 18 Sept 2023 at 16:04, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> These crossed with the previous fix to get rid of examples
> using aarch64 for which support is not yet upstream.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1892

thanks
-- PMM

