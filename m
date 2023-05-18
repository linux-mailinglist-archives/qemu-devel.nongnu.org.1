Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41870855E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfve-0001y2-8h; Thu, 18 May 2023 11:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzfvc-0001xu-OK
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:52:32 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzfvb-0000TA-96
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:52:32 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-510e90d785fso1083144a12.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684425149; x=1687017149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ykp/NMO2d73c0SnK4LV8R0oIFsbb8dCN1sBdkCj+DNE=;
 b=w1R1Ba511l7quQlbqS7f5NIFGd4MrOnFjocgAl601Ccy7iU4NjHIkZY1C5IsO2LTq0
 kQKD+P5Pcd3NCCLMbi0k47T8QUYBHZgDWhNdsYAOMy1JzKGFS0mTe229q74khKInHUrf
 5UTh3B7bZxqFlPqIwaCQ+VDxcd9KO80W7tnZugFvaQrdvKpTH05h89Y5uXR7mqpCK+Lh
 ruLnkAmNCRDv+rF9891Eu8yv7anI4clo1uMiaVsIQCzgbmoAJhwlbyEMaZ0zYOVEpgek
 wjNRMLUWtH80gzE+IQMtDyx/BOnQq5kB+O5lcqpN5AbBwBSCQRPEDBUwtefvZKucO79n
 91YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684425149; x=1687017149;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ykp/NMO2d73c0SnK4LV8R0oIFsbb8dCN1sBdkCj+DNE=;
 b=A8N+jMIVys/MwwRFje0TPHN9tvukw041VbXLt5kZ5A5o1ODl9krLJwA7q9C3SnC0oj
 NBzJ98obqySnHtD9G43baqk9nOMol/toJUB+hJTm+TuMYLYCRVzbiEg++3g/X2VQF4US
 jvfGOnaxtpnyJdCeEuanxSiblQ4++vRlCz56mg+56yaPRbV4wJKOQnAOpJnIUm6h5FJ3
 kRk5T3jP3XHjTcQ215WCme1CN06LsfaObbvz//AGOVKKUbG/ul2zyYIUsgt/zb/nR8fe
 y8Lug3TSD2Mqqhin7oHBJDPAVkvJ4ylUaN7FlwKVbhlpN+WpxQnwX0576y/1+qpgkboi
 Rz4A==
X-Gm-Message-State: AC+VfDyg18PLnZVk3YLcRZv56rHrL255BoZLs8RFfItM2q8mbR1Kd+di
 m0xd91UnJ8vJNySk/gnA+t4hiKAXTsLAroqIlZPhtw==
X-Google-Smtp-Source: ACHHUZ6gpj3VB7j6jonpGXnzz9kIrL6g4DXPVOm5JipSqIVkhD7OAuiHcfTc2SbxQ51SLp2fh87So9m41aSrqGrk+tE=
X-Received: by 2002:a50:eb48:0:b0:510:d9b3:11fb with SMTP id
 z8-20020a50eb48000000b00510d9b311fbmr3554838edp.40.1684425149412; Thu, 18 May
 2023 08:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-4-richard.henderson@linaro.org>
In-Reply-To: <20230518044058.2777467-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 16:52:18 +0100
Message-ID: <CAFEAcA8PndFpVuitJd1CR3BG7mhtkMxp98jdNQo+F_YwK5640Q@mail.gmail.com>
Subject: Re: [PATCH 3/9] util: Add i386 CPUINFO_ATOMIC_VMOVDQU
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 18 May 2023 at 05:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add a bit to indicate when VMOVDQU is also atomic if aligned.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/host/i386/cpuinfo.h | 1 +
>  util/cpuinfo-i386.c         | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

