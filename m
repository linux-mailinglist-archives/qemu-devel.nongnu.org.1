Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 180F570F996
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:02:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q0U-0005TP-7C; Wed, 24 May 2023 11:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q0M-00059U-CO
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:02:25 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q0J-0007PY-4P
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:02:22 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f607766059so11727505e9.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940537; x=1687532537;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+d0/3/edTxnWdpkva6kGosm89VVlGTnLooegwt2jwt4=;
 b=jtbVrO9xC8tev8eXQ4ZWii+GZszSMa6LV36Jn2k6NmWi5hv8xZtMqihukxu8VmGlx1
 vznlvcL8yGvWEIvKr9AE/5QUDoYd8R5FXrTn2yJG3seAmu5mgkTab2nn6llO7k/Bq/88
 bmi6mJf/DulFmyvUK157VuifZQpa1for0eL8D0W80DTU8/he9JjRJPMUC/SUnJ4mXIzh
 AGY89hmX7UX0X4oIFGyPx4gbWV9uxPBmTJk4c8G8pCCywxp0IlMvTWz8eKrrSSIaP9Ip
 4qHYK0/L58zcN4mV8rWgtCWeWkV/t2w2998EZm098PfEP6GtZrk7maubOh8hzqZhJxmq
 TqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940537; x=1687532537;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+d0/3/edTxnWdpkva6kGosm89VVlGTnLooegwt2jwt4=;
 b=IkqPKHbEwzUP6/Qwompynm06hssMeRBekUOpNyZa1s1aX9n2mTJ+8VUxm52q1xr5Q7
 aW5Lj8KOqvZYCcBDimROQYLQVCyMwId8foIdSIQ7bEKPu9Ofnu1B+CL07CPtyys6gwCL
 YLzjHaKG47z72oCtHUPR2HKlY+LwK12hzG8jqlW0cdxuvsQzND1+XK3u4jCN0fs+EjEp
 Yp1sE39XvDR7ESHiLNMp0jv1zoN5oGL2qzdTpwYNIwC/bt+BLfmbQuA/I7muxnMWUHcW
 Cjz4KiemFbbAaGV4Q5NybvSzrKRDf9DXH5sZw4X9iYcNmeJ0IZfLlSdGFf3fT+X9mPZF
 K49A==
X-Gm-Message-State: AC+VfDy4SwmJWs1oDnbkTNowoVuukXjwAPfFu9joBAK5qRfJICQVU/RB
 ii2KNYVBf85SYa5644fwcm1EtA==
X-Google-Smtp-Source: ACHHUZ6bMea/XvG4BcQdGwyllEkG2kh9ULfkiLbJNqAOqFy+bk6dUe5x46XnNrFkSVZntAuvcD6hUQ==
X-Received: by 2002:a7b:cd93:0:b0:3f4:20ec:7601 with SMTP id
 y19-20020a7bcd93000000b003f420ec7601mr28242wmj.34.1684940536934; 
 Wed, 24 May 2023 08:02:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a1c750a000000b003f423dfc686sm2578186wmc.45.2023.05.24.08.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:02:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id ED82F1FFBB;
 Wed, 24 May 2023 16:02:15 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-2-philmd@linaro.org>
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
Subject: Re: [PATCH v2 01/10] softmmu: Introduce qemu_target_page_mask() helper
Date: Wed, 24 May 2023 16:02:09 +0100
In-reply-to: <20230524093744.88442-2-philmd@linaro.org>
Message-ID: <87bki9wz60.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

> Since TARGET_PAGE_MASK is poisoned in target-agnostic code,
> introduce the qemu_target_page_mask() helper to get this
> value from target-agnostic code at runtime.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

