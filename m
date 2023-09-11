Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A8179A9F7
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 17:50:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfjAc-0002k3-VC; Mon, 11 Sep 2023 11:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfjAb-0002jR-8C
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:49:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qfjAV-0005Z8-6l
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 11:49:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-522dd6b6438so5577033a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694447381; x=1695052181; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jznnk+tVY05ug114C2B8KIDSOcgDo78R1CMCwVNTR2Y=;
 b=FU2mujv74HTxsfsPq7aYWv7GIa+ML56uTo+EmCpBr0kAWEQ+qWUD9sMI46OmJO5B66
 obwm+Q/Pjp0gm/piGIA20tIfBGZGndKzgyNphCZDVcJgELQK9nAh82ahKRWQKnS84nNy
 FZ+fsF/7pKf4Diwvy/wZ87HrULOQauoME6FiC8tyuKaLMmWh3mKvz0qc7gjA6MS2LYTB
 lqfD3XQz0KTRQOKBrewVgJUqUKHm6spMusOXbIVeL75QQqSkcUrls1amWUDtEMWEf0WE
 ACK1fhELjDEYn9DkC4I9MCQd1p1MpihkRyCftuxgK9lPrXp7ODPV5GKJtOj4kW37rWHz
 qBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694447381; x=1695052181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jznnk+tVY05ug114C2B8KIDSOcgDo78R1CMCwVNTR2Y=;
 b=mBDKDCIFyeaa4pYdzOKNCLkHF8rMr9Wa4AwpTljQdg3mHuFwBF9Hj4T0oTqbSOC2A2
 ngW4VgpOK8WzQdYum/j+GAVZkxr20gpgm6ocY9LL4+X80pmsDEqUGxF5qzPuSNOoI1Dn
 Tq9wEzgMzsgzzfOxwzihsbkAZ0eC7y7j6hF+DzAt2KB8KNWjPQo5SV16XnlcflzkQ0DZ
 UdmyFsxhdtJp7UbEd00Hdb33OZsUzc7gfgEHHbZqzJqinhlUZxNZpYSwhiT5mn/Y64Js
 X4M4M5jIM+TVKjoI31tx+BkX7OfK91gNYgjKEgVCsvibjog9ntHKnNAX1llJL0lm7bRa
 fyKg==
X-Gm-Message-State: AOJu0YyAivdM5K0xI4qwP1mUHw24PJm598RdWBm2VQGD7cVcCvakQxyN
 Ig9LFN/K1ini6BJ5e0Jbmdxv0svFdb94hiBRQdnwcbTKDsmPvkD/
X-Google-Smtp-Source: AGHT+IGdtjctnCJzJsUHaVb01Fk1SxwVzvUVEoyrbcmhPmHPh7oxiklNGKiFuLK3aDHODL7ryLBXeGbCJ5J7eAamNDA=
X-Received: by 2002:aa7:c392:0:b0:52e:1a29:98b with SMTP id
 k18-20020aa7c392000000b0052e1a29098bmr9084110edq.23.1694447381007; Mon, 11
 Sep 2023 08:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230908143703.172758-1-kwolf@redhat.com>
 <20230908143703.172758-9-kwolf@redhat.com>
In-Reply-To: <20230908143703.172758-9-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Sep 2023 16:49:30 +0100
Message-ID: <CAFEAcA_7-_tScSuvhWbpMFArb=M1NiRu6VvDtaoSL23ac1s0Zg@mail.gmail.com>
Subject: Re: [PATCH 08/11] hw/arm/xlnx-versal: Use qdev_prop_set_array()
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com, 
 pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 8 Sept 2023 at 15:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Instead of manually setting "foo-len" and "foo[i]" properties, build a
> QList and use the new qdev_prop_set_array() helper to set the whole
> array property with a single call.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

