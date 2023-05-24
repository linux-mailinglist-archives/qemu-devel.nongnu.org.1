Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B213270F9B9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q2d-0002CR-Gn; Wed, 24 May 2023 11:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q2U-0001zU-Py
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:04:34 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q2S-00083V-3C
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:04:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f605d8a8a9so12733045e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940670; x=1687532670;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qT3c0MJ6QF5+ny9CS1PmhFnR1vHndv/Mg+n7itDxbQ=;
 b=HzNQzvRI0cp4HwIPWUUnn5n6DIekkGS05vCZVd1KA9DixPnprZf3mt63IsjDHppQDq
 07AxHnTbxipK5eo1ilodlmn7Qm0Id9rJWqr8EUniTQwlRySo3P+G7cdWjcBUucNHB7Lw
 H1hloaxitLo87Zsde3osCNGfavzhaTO/GyjDqrxl17bhUPrg/B5y+/Eto/e1rtNv/qKX
 QrMF60j8QSgX9obe0/Pkw60ALt3Zg5jfVR1HWZl0KS35H6FUGSWKUMqPhZzmB71sHXpx
 So9CVRLcVd8rt5+d/FMmxvRd0WgOX0NkwKncQEiaDxjC80BF9Szy97Qg/w2nrmDBHi9c
 TVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940670; x=1687532670;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3qT3c0MJ6QF5+ny9CS1PmhFnR1vHndv/Mg+n7itDxbQ=;
 b=CNZhfb6ZmmuYa+KQlyf9WExcmLRbvs2RMCMUue5geeGVWpQVU6Qt3EdCrn8AbQvvoi
 vcVurfGVV5F8Zx7D3ljqDH0EI6hYBFcmXH8rXVoY20zWNMI+/jFTIFe/0JkhRY+nNRy9
 uVwj2basewzWElkqQAJrw4z8lIXMh8kN/5evbU/FhZik7j/HlEfDtbf5TiU3ZgW+4GG5
 zID9HanEEA4UFbs1XIfI+QcZSinsHCgGDkXxPAQ2nGEEny/D97HCWQ/Zp9py9uhfRXkF
 QQtBE4J3Qqd+gsxQxWRn4ttuaGjeH/Lw9b29zVLmyBfovtGlU99j4Qr2WLOMal7UZkj2
 lVwA==
X-Gm-Message-State: AC+VfDz40mNcPz+XTE0dOggXgBV4aaIm+xFk6cB13VQH8TIEv/kfn7rz
 nVaAIxKNBTfEPWWzGIySGiOgyw==
X-Google-Smtp-Source: ACHHUZ6/KUOtlj56oV+pgZy2dDYS4pij3aUnNAn4iwfcBWZ5ZreROnaYJQ+7RVhvo0u4JrexzdWZFA==
X-Received: by 2002:a7b:ce0f:0:b0:3f4:e4fa:90f1 with SMTP id
 m15-20020a7bce0f000000b003f4e4fa90f1mr28812wmc.33.1684940669843; 
 Wed, 24 May 2023 08:04:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003f1978bbcd6sm7319221wmc.3.2023.05.24.08.04.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:04:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 30A2F1FFBB;
 Wed, 24 May 2023 16:04:29 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-9-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>, Peter
 Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, David Hildenbrand
 <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/10] hw/virtio/virtio-iommu: Use target-agnostic
 qemu_target_page_mask()
Date: Wed, 24 May 2023 16:04:24 +0100
In-reply-to: <20230524093744.88442-9-philmd@linaro.org>
Message-ID: <87pm6pvkhu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> In order to have virtio-iommu.c become target-agnostic,
> we need to avoid using TARGET_PAGE_MASK. Get it with the
> qemu_target_page_mask() helper.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

