Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DD7A4999
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDM1-0006UJ-9U; Mon, 18 Sep 2023 08:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiDLt-0006RV-GV
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:27:48 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiDLn-00064Y-TE
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:27:44 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a9d6b98845so1214001766b.0
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695040058; x=1695644858; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Cr+Ko7QspAhTvPFgBPMU4WOmRLT7hHyAdpJ94mdw28=;
 b=F8UBnPel/c+NoAzAiAUVYVIay8hfc6oOXA9dQi/WR2sJOodEzbxZ4iJohNa5rg8uJg
 QXJU9km8z9TJhQxYBHIf6bSblEARHtLqHrqyvW1HZWvYIG69Y05agq/oB88a7J+qkDJJ
 D64XcRrlWo4bBw3ylucFeXXNERxDMiPHpFgfsKlTkr//z/y0FGD5/l5l+Fw0xJGOegVY
 qOVyxMVj+2z07wpF+C0Ro5mXIBmiC3NMTY5FQgf0unjgf2ZcWwPtDrd3rkCq7lIFLkXl
 hKzDrhwxxl8zC/m34WIHp6sxES4p7QNf4h87cnTMzq0DrMuXSe1n6lsU1oAvl2Uk5N1A
 TKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695040058; x=1695644858;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Cr+Ko7QspAhTvPFgBPMU4WOmRLT7hHyAdpJ94mdw28=;
 b=EELycK279rePcdf6lJrj/ABjF4enTOek2F625sUaJgx1wTn835q4Vqnx2OiYmAAqeI
 9pt2JN6BmToXAQ8HocLs7j1hBtX6yUl1ajc3GR5KNI78ieXzgHqGUmeZiuuGqB+Pv2pq
 BGlJ/u4xwGoVBjCC9jPVN6vv7TvndIr1wnrBWDOljq/hYHwEraU+VKmGhrnOl5DQFvrG
 8Imzd8xskqr6CbOmi4YMPxd0+SL/yqi/Ke/Z7jWnOKLiHTlhDVJWExW+uDKFYtA+Hf25
 U88VZzSjNSZm1cnkW/m5pPkDbPN0gqeO0wxqK6QWwmqVLXxx/qBepUCm6mrBdG8Py0IT
 81OQ==
X-Gm-Message-State: AOJu0YwQUEKhnFEoatcidSD0bbp6XsvNj8ecLycD+y+dSjegEH/WbkOP
 ujJc1oPqdNzVBbJzaDHFScTxoOk0X29xQVYw9vtWNw==
X-Google-Smtp-Source: AGHT+IHZFh+VD0PAN69qXUNT43OOPSpW/leNuyBcV0fX76t91a0ZviUeyyFEgTWVshaChJy/u4ODa0/YGpDxCUrezM0=
X-Received: by 2002:a17:907:7b88:b0:9ad:8a96:ad55 with SMTP id
 ne8-20020a1709077b8800b009ad8a96ad55mr18402055ejc.14.1695040058250; Mon, 18
 Sep 2023 05:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230914113311.379537-1-thuth@redhat.com>
In-Reply-To: <20230914113311.379537-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 13:27:18 +0100
Message-ID: <CAFEAcA-dret2XW4hd=PV1zvTnd5sFeH4VERkxZBWi1UPji4otw@mail.gmail.com>
Subject: Re: [risu PATCH v3 0/7] Add support for s390x to RISU
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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

On Thu, 14 Sept 2023 at 12:33, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> Here are some patches that add basic support for s390x to RISU.
> It's still quite limited, e.g. no support for load/store memory
> operations yet, but the basics with simple 16-bit or 32-bit
> instructions work *now* already fine.
>
> (I'm also already experimenting in extending RISU to support
> instructions with opcodes lengths > 32-bit, but the patches
> are not quite ready yet)

Hi; I've applied these patches to risu master, except for
the last Travis one -- I'm not sure that makes sense for
the upstream repo given it doesn't use Travis.

thanks
-- PMM

