Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDE0766BF0
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 13:42:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPLd6-0004J9-PL; Fri, 28 Jul 2023 07:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPLd0-0004Ik-91
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:27:26 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPLcv-0008F6-S2
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 07:27:23 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5221ee899a0so2596577a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690543640; x=1691148440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lKXmC5nhmDQxwhxljGdqfLxFE5xppY49GUUXr7M0Reg=;
 b=ePnWGtHs8xxkrW1qHdP0DioAURcpHuEvznmoYVXTVyf11GBR30ZZfAvZJQUQ2tEiL2
 c/ABQVTLJ189c4peKe2U8SRZPy1zjJpqqsBsZubVSTkU+gje3NIamb7rir4Q8bXUzQTi
 hns9+MnkJ82YavzofN5EpKJtXKDQf3JuAenUw2S17PMLGIY962a9dDe8LJbtQvmUI/dt
 23jK4NLQGIHxWXBuftqf8EHUYmf/x2/ocBZBSS2C3K0KbcuwrGyt8vIHFumF2ue5g/wv
 hfHu8Ez7ZakbyZW1cDOfm2gxnZtBWoHXB++WeNJPVdrJr9yGKq7sVJhKV/uZnL7fjH+t
 EKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690543640; x=1691148440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKXmC5nhmDQxwhxljGdqfLxFE5xppY49GUUXr7M0Reg=;
 b=Uf3eOLY4lqdUaer/QBkYlBPnYUAmd5vwXAlvTvoaw2SDIPH0GLHs+X/QAZP1t4bzwz
 SM6xEGs0Ufalu1KEmTKscv4YAEOqm7nLCoZ91QfeZ3QdMZMjWVfwdn4PWNGJcDjHCpD3
 OVbunCRbTm63OD8cbAckCuZzab1Y+/wQC5zL9oOk9LrcRAm7wh0s1p7wYLG9/8f7GE6w
 d0iTjMoAMVfngtIRc969Lbd6qqlMpOjFH90f5gJOjS0SfyEJjGBTPnf9e139PEtx19NH
 81TSd+DCZNex09B53MHtf4c5Cv+AbfR7F+fACHTMsGoq/kXviaSpGz2pNG2toWmjcMQk
 lhIg==
X-Gm-Message-State: ABy/qLbAluI/ABsjGLdRuI4+75m2Tfsvxfaed+nZFIUuY7eK8dq8RAFB
 yfz2zqhESdIfkGD0MuuLukmyIzJbuufvirRJqmM/hw==
X-Google-Smtp-Source: APBJJlGSY9sMV0fSieQV5mXfKlsSOEPQzKUgr+KHe1ZShjoSgPLEXt1CtBSz4T25b27Rgz2Ka/CJHIh0tGcmhKQbjYQ=
X-Received: by 2002:aa7:c393:0:b0:51e:1a51:d414 with SMTP id
 k19-20020aa7c393000000b0051e1a51d414mr1333562edq.32.1690543639949; Fri, 28
 Jul 2023 04:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA97SK=iGVfTbujC1iH32AYt8zVOkX+YzS7JtcxM-=jXsg@mail.gmail.com>
 <20230728105031.1130-1-dinglimin@cmss.chinamobile.com>
In-Reply-To: <20230728105031.1130-1-dinglimin@cmss.chinamobile.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 12:27:08 +0100
Message-ID: <CAFEAcA-nP-yaJLyDJs-VgKbHHL+Q=d6E9baKnBZxMA4HHmv_fA@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
To: dinglimin <dinglimin@cmss.chinamobile.com>
Cc: mjt@tls.msk.ru, richard.henderson@linaro.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 28 Jul 2023 at 11:50, dinglimin <dinglimin@cmss.chinamobile.com> wrote:
>
> Replaced a call to malloc() and its respective call to free() with g_malloc() and g_free().
>
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
>
> v4 -> V5:Use g_try_malloc() instead of malloc()
> V3 -> V4:Delete null checks after g malloc().
> V2 -> V3:softmmu_unlock_user changes free to g free.
> V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=NULL
>
> Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> ---

Thanks for this patch, and for working through the code
review process with us on this!

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

