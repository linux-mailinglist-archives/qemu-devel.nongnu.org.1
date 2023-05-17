Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4791706397
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 11:07:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzD6n-0007BE-CA; Wed, 17 May 2023 05:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1pzD6l-0007B2-Ob
 for qemu-devel@nongnu.org; Wed, 17 May 2023 05:06:07 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1pzD6k-0005Dh-0c
 for qemu-devel@nongnu.org; Wed, 17 May 2023 05:06:07 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3090408e09bso291315f8f.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 02:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684314364; x=1686906364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hzzhUu6NqXhYwAMhgp72/3S4BHobstJjZ3S9dtyR02U=;
 b=Gefh7voe1sJKpFJinwFGm2QGHuj0q13Vm0WdTR7d0xpk8EBshVh8rbkdkQD43nKcvG
 qaQBkmZ6kOqOSH0xnGGq4opMoTWnPPKAEqf1g8Vo4yi8FqinRH0A/sSaI2hIT5H4HnX/
 QDGG9Ye74zcDvuH5ydC0it8O5bDco8WvidOYhy8jJ3vEgRqQ8LG8SZ+tNQSy6P8Ol4Dv
 cgWED9g12CK7Eb4g/LtQcSpTjhUNqgL4AlTNa2vBrSOa/tMYlceUMc/FyXfxAIjYH6eg
 Euv1+f65zFnPb00yr6hGpTxNq0JFsWyh73Tg151OFfRWL9G82XiSYYmCq9ZK//n0nk+Y
 3+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684314364; x=1686906364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzzhUu6NqXhYwAMhgp72/3S4BHobstJjZ3S9dtyR02U=;
 b=Q93LEx5hAjwHVjJJuBDbK2BDssxg/TmjJx9mrsZZgdyk15heerW5EgyqvouuSdFNvu
 gbk2g592R2OpRRN5VFL5h4tDWVk5rzi9ZwviwXgaqGmRfk3GDN7avWoxYpfNzXh1Natg
 fWkJ2IVWuNazxzDdLJzLgV/5QvoXVCn+Rd1YAI/R6iyM1fjAwuV/jrSoPJW+9a9tPOWM
 E+MQLJKzHnw3S3YKh7A6qs4FyJZLN4nFVFMWtMp7ycMrnLG6lfWRt6ojSx0Fn4Grrldq
 /zK/mb7giWA4dBA/n9EWxKwdDrBXA+KrWz1VC6l2Csp2TxbuG4RXtEy2VsRHqsOsRq4H
 RFyg==
X-Gm-Message-State: AC+VfDyLAD7ick1fPpYV2r6cijpyuiIdcZXiUSfAfjASZWkyg2iepGJh
 3wpGM5Ie3423DMVFSA7tgkAeRg==
X-Google-Smtp-Source: ACHHUZ5f88JjignN9+QV7ZHWQeoXVFtKkuEMSG79v637LDvuq3uRu2wHcvR350MYDe//A7cMD3GZOQ==
X-Received: by 2002:a5d:6ac4:0:b0:309:42f3:4c3a with SMTP id
 u4-20020a5d6ac4000000b0030942f34c3amr93181wrw.32.1684314363783; 
 Wed, 17 May 2023 02:06:03 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
 by smtp.gmail.com with ESMTPSA id
 u16-20020adff890000000b00307bbbecd29sm2126674wrp.62.2023.05.17.02.06.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 02:06:03 -0700 (PDT)
Date: Wed, 17 May 2023 10:06:06 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-devel@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, richard.henderson@linaro.org
Subject: Re: [PATCH v4 00/10] Add stage-2 translation for SMMUv3
Message-ID: <20230517090606.GB1415802@myrica>
References: <20230516203327.2051088-1-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x42e.google.com
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

On Tue, May 16, 2023 at 08:33:07PM +0000, Mostafa Saleh wrote:
> This patch series can be used to run Linux pKVM SMMUv3 patches (currently on the list)
> which controls stage-2 (from EL2) while providing a paravirtualized
> interface the host(EL1)
> https://lore.kernel.org/kvmarm/20230201125328.2186498-1-jean-philippe@linaro.org/

I've been using these patches for pKVM, and also tested the normal stage-2
flow with Linux and VFIO

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>


