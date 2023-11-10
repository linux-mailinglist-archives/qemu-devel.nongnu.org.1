Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 421147E7BF3
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:46:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PxG-000209-22; Fri, 10 Nov 2023 06:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1r1PxD-0001zb-40
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:45:39 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1r1Px9-0001j5-T0
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:45:38 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2c50305c5c4so26725561fa.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 03:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699616732; x=1700221532; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3Gbd3Y4beKSsxt8KVdiM2nj2u3zU0sDZ5nWjVa/Eb8w=;
 b=jnbOdoPI33+GGfmz9ITVIHfwCErh36LoljjMD2gHHij7wCSd9vrHXv/hqe1jbLjDoF
 UZlIL2YJxXV3vZiAB4KnFtZKWVrhAd4+kD42ALUa2yv8PbMtBaFJWC5HcKjVngiV+DLm
 bn1aOY9FnheoelSt1tCKotHU/nm++lOfcpDOj2adqKShZ7j0Q05V125O/OQzge9swIxM
 Qo7D25JEvqZ2jKUazEds0aVURZPIKAQeEIFvzMTIfGEg+QoOithXsOJKROVYWFk1TQFO
 Ds1XSfp7rs0bhhZln+PCUQoGvNNhkScumRPz9tIY9q3h1zNTEPuBXIzURFzeGan3NOyO
 E6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699616732; x=1700221532;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Gbd3Y4beKSsxt8KVdiM2nj2u3zU0sDZ5nWjVa/Eb8w=;
 b=VCwA7OSPO4oUGOdy3Pww5Tl9+/9Kjc3RphCvl0BFgIjfU/5wUjaYT7vrP6bbEgHADh
 QfkScR+MvsNGua1tt/6E0Z4G71GtiWUMDPJ5fgWWEBTcNvYTQ2aGrJWbHuqDwbg4Gjgy
 JqMhgcKmFtbR2T3rwmEA5dEkkx4wpAVyjhnKztgRF7h4HVaj9ngRWnsp7/hMpi0v+/nx
 ux/YaGQmuNL/76B/n5hGLuTHT7NprEZA6yNZ6SOUZYMkMCQglDF5ZQD7SnoXdKoAFZSt
 GDJXTfbN1NPiijNLAxWz4aBBbzqp+REnnNOeHuJ1XuD4hlR4G07SlLERt2ArgXriaHDN
 RgbA==
X-Gm-Message-State: AOJu0Yy/YBrhT9Yig8aC5qAfajADcnjThdid3dTDa9QukjdhGrs2J7zh
 UE+Td1lopOGJIWerrq+82LqMjA==
X-Google-Smtp-Source: AGHT+IFPybkpyqemqKj7+L3RBOocDHowMkV1fxTmXqcasf3nGJH8vs6sHAUWkWhkJAam+rwb/wQUEA==
X-Received: by 2002:a2e:8e99:0:b0:2c5:2423:e225 with SMTP id
 z25-20020a2e8e99000000b002c52423e225mr6292637ljk.6.1699616731908; 
 Fri, 10 Nov 2023 03:45:31 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 gy15-20020a05600c880f00b004064741f855sm4830439wmb.47.2023.11.10.03.45.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Nov 2023 03:45:31 -0800 (PST)
Date: Fri, 10 Nov 2023 11:45:37 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/virt: fix GIC maintenance IRQ registration
Message-ID: <20231110114537.GA3358536@myrica>
References: <20231110090557.3219206-2-jean-philippe@linaro.org>
 <CAFEAcA_Jja7MT_cSiEJ2it+wG7LnUXfnuoo1vmoUf1-+KSgtAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_Jja7MT_cSiEJ2it+wG7LnUXfnuoo1vmoUf1-+KSgtAA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x229.google.com
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

On Fri, Nov 10, 2023 at 10:19:30AM +0000, Peter Maydell wrote:
> On Fri, 10 Nov 2023 at 09:07, Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> >
> > Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic"),
> > GIC maintenance IRQ registration fails on arm64:
> >
> > [    0.979743] kvm [1]: Cannot register interrupt 9
> >
> > That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
> > where the maintenance IRQ is actually referred by its PPI index. Just
> > like commit fa68ecb330db ("hw/arm/virt: fix PMU IRQ registration"), use
> > INITID_TO_PPI(). A search of "GIC_FDT_IRQ_TYPE_PPI" indicates that there
> > shouldn't be more similar issues.
> >
> > Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Isn't this already fixed by commit fa68ecb330dbd ?

No, that commit fixed the PMU interrupt (I copied most of its commit
message and referenced it), but the GIC maintenance interrupt still needed
to be fixed.

Thanks,
Jean

