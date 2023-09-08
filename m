Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB987987E1
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 15:30:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qebY3-0001pV-Bp; Fri, 08 Sep 2023 09:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebY1-0001oa-G4
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:29:21 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qebXz-0002Jy-1V
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 09:29:21 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so2755516a12.1
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694179757; x=1694784557; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmsKpQrDbZTcm6DbrI2zVy7d9sIh1qYxIKXlQT8nL20=;
 b=DR+V2vlcRiD+Vj59ykDse/RMLqXQ+YCCtn6/RVJ4vQrEl3QkVcd9SjLwPHtjC4vUex
 gCRlpduAc0yevsxLj9daP1XEGohtTuUAZPJPF0KtZo8LKmT/WIUaaKm0qsApNzrHeXAj
 kzFsqsfsESPATcYo5jlyrW/xieAKyuM8gx1/SNMPW7hFHl1zGgpha0TiU4sxQP7lrykX
 YbeCiCeHAcYIuGnsMQU/Rh++at15XaE5fuAOaAadFPQ3sy5n87XIIYYcdAPM2tmuw8ZM
 tbglnss8SrHRqzhzHbbOuSMk0AQx5ER01o5XKRpbN+QVoPWghoFnACOjMi/TMQ36j9Qb
 zEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694179757; x=1694784557;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmsKpQrDbZTcm6DbrI2zVy7d9sIh1qYxIKXlQT8nL20=;
 b=qhMGbXRYM5z4EN3NKFadXnPXPBetvbekWOYhONa3eFMNvXXCBdrEkcnz8RGjnLs9zQ
 hfhoo1uIvR/vV8Dad91l7iP4J21GpFV9jHuU6lM+VwUlzSg8TiojRDTPn1TP87J1FD+0
 tJURwBBe6X1QAGh4L/YJ1qFU2xWVKZTjplceWQPg+XRW/kDHHR0lJzplk3RHXe3hYVLF
 rdhtEV2ecDqjT43Li574j+9IiQuG9AqxCsoB4uvj21Hj9iJtAo6Uz7XWzU+szwaMn7q1
 MgmfnT1yBUn/2yxUrKth1Pl60fjRINhI8lGb22xzK0fUcInhlFLq10QmFlEenwL/ZzQP
 mlFA==
X-Gm-Message-State: AOJu0YyW5SN/XSoYNaErNMbMYhv8gDgzxnMgl0x2MT9xxPFumT206Dfh
 DI+qiTspVSSO1dJf90qJUrfQ8SF+Vsj08i3GLPnpog==
X-Google-Smtp-Source: AGHT+IGYoZ9aJ82Ig8YmuI/VO1TiuhD6rWlHANUaNHyr31sXQYnx2cOe+fEArdZEIYmVCimwxz+pJBO0GooT6ZbDNU4=
X-Received: by 2002:aa7:da46:0:b0:52b:d169:b372 with SMTP id
 w6-20020aa7da46000000b0052bd169b372mr1983109eds.4.1694179757639; Fri, 08 Sep
 2023 06:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230831232441.66020-1-richard.henderson@linaro.org>
 <20230831232441.66020-2-richard.henderson@linaro.org>
In-Reply-To: <20230831232441.66020-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 14:29:06 +0100
Message-ID: <CAFEAcA-GiGGm0m5g2RjidRgpt+tGVHFqScsk6u87oQF4wERzuA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] target/arm: Implement RMR_ELx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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
> Provide a stub implementation, as a write is a "request".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I suppose in theory we should have a feature bit given that
the register is not necessarily present if the CPU only
supports AArch64. But we can add that if/when we need it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

