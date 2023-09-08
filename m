Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CD27986DF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:11:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaK1-0001aM-Vn; Fri, 08 Sep 2023 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaJi-0001PY-H3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:10:33 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaJf-00034C-92
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:10:29 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so3369854e87.2
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694175023; x=1694779823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=39oDq1SHkVWT6dfZk/dMADTgX3KEW+aeBSn7Fn7ylqs=;
 b=AfgaTSwTDb+7oegrJ4uRlR/dRWWz6jutaG38ozIyGvcx0WrmxpxomAhRqq7IiJQ2Z6
 ScXJg0oiyc1vQHE1sjeiAqmC9IpgzC5u0/CMHDwsmrAKtiFMYQy5r8dVBItQ15/tZMiU
 OqIbIyH9FcOcxocDlLYwvLXWSMXOJ5+AbGVDey6BqpADD6PyjJ3Obdg50TmYhgsEoG42
 eWOTmS26sSSRShgurIr6W7WiBLRhYSRJvvkEdpGF8mscWVEdsoKHtDwX/eXbyzaax020
 sXCTXGefHjgVY/RTdA3ukMyE/3aSLX5xrUIYmM+C2TFP32nWLL3T8yTKJenSlV7yXhfI
 J82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694175023; x=1694779823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=39oDq1SHkVWT6dfZk/dMADTgX3KEW+aeBSn7Fn7ylqs=;
 b=fVvEFZ++EaPfmAWcvzVuLgmB2ZzJYvTWIcrJUW9UCsERiPzUD1rvXqnWflskCDxo0H
 uCgXJAQEnu8EBrQI6AOlRnekYm27KqsukOD0sFlH+J/M/zDbpGsZQ3pUoLq21IbE6ueO
 GmEfEsD54HjUZHBqPARqgxxBcpZYSs8pbvmqgQsHX3d1p4dLACVhTcd0crBiYIN66uwO
 n4FZi76mxx1YBX6dUrKPV6GzCRLAhAyvjiP45UIGoHWp12TvXrfdheVxpmi03uu8KeQ9
 NzDXedB/ASZe5nswlT0mJgL5sIc2a5kT2JzByySoOEd3MmmL3eoxeHXerCky3Orcvqwx
 6svw==
X-Gm-Message-State: AOJu0YzRvkLV6WUD7edInUH+KxKuEaLWxCA3X96Sdc1bXHqwaq6LPSTX
 YQVKdHZPmjp3A321Kjdnp8TNMLeqkT1zOYz0Ga21eg==
X-Google-Smtp-Source: AGHT+IEYM9XFTqXFbQ2EslmGag2YWGK8tWWjGJzcaUFuWVvrDOpxtpVR7pjbTkBJ8/diouVpGe07RZWwX7hNU5VDz7Y=
X-Received: by 2002:a19:e057:0:b0:4f8:6d53:a68f with SMTP id
 g23-20020a19e057000000b004f86d53a68fmr1589444lfj.64.1694175023429; Fri, 08
 Sep 2023 05:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230901203103.136408-1-richard.henderson@linaro.org>
In-Reply-To: <20230901203103.136408-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:10:12 +0100
Message-ID: <CAFEAcA8bjNKqd00cUs6mc+WDfizABRE75YGCFri7wTfQrPdCXQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Do not use gen_mte_checkN in trans_STGP
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Fri, 1 Sept 2023 at 21:31, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> STGP writes to tag memory, it does not check it.
> This happened to work because we wrote tag memory first
> so that the check always succeeded.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

