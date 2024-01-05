Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A86825636
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 15:58:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLlcW-0005L5-83; Fri, 05 Jan 2024 09:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1rLhek-00010M-24
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:42:26 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chouteau@adacore.com>)
 id 1rLheh-0002Md-WA
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:42:25 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-5f3a5b9e09cso3587177b3.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704451342; x=1705056142; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HUAY7/inRynsZl++1+YW3S5TEhHdtizNHrzpGXfQOpw=;
 b=N47YEUz58ikYzvQBV7soO2H+J8YZZaSe9nRWixlj52JzWdyL3pTURDojfkb49DN5NK
 YqdLqetOSgZo4to0HxZUGugz/X1RS8ZEH5gZdD8RaH5K8p5c8i7u3v/XfddhbH7Vm+pt
 aHf6KLcbVWuTnqfp1TFbYeP4OQdK4Ejd5Dj7E+kEq3QiQ22FYvEmTUKbwSTNBXHERXrw
 QVQmQ0gydCfhKqmoMQsweqK1U9A6faSrDDGS8U2MOry4KU/ClJnbF2p55DDIoV5v6Z7g
 beCukDLNtCmbN/lZn6juA1d/57DLoATwy72uolxezW6StC8yqH6XqCWYntta1igXBjkc
 mfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704451342; x=1705056142;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUAY7/inRynsZl++1+YW3S5TEhHdtizNHrzpGXfQOpw=;
 b=R168acQ5RudomFlmB8imslShapfOu6tkW7LAJ6eCpD9QywSpHQgE13JxUsz5KgchiZ
 fM5Zu8Zylxj2danj9QSrIdv9LzrLpcF4qxD5a6OcafUSSvER6+BGVRwSuwuYuWD5AcpN
 MaGRVk/nIg559TNPmIMAFrYrK3g2uEg31WBbSErtrHNlq7ktIB1FOfgonlGMrV17jcPv
 dpSfOXNFvy3g+sdRVdLbfZuqsw1q76pMa3atfoT45+8lX9Uaw0OmgEhiSI96ntUH31la
 wzalaOyEI1zEbGq60rLfRs7OfuHteaYFOOmp9tJPuASv7akXtJWn+XFjnVUXQcZP70VI
 PThQ==
X-Gm-Message-State: AOJu0YyoGU2+9zbjmYEfT3crwzaQcdmN1wOdWDSRj4WWiN+n7sCcIZzu
 5h3SBBB248mGvidYiC3k+9VGdesxvFC3V6pDkKcBquYmBPQ5Z4ZzUCWXx9AUOQ==
X-Google-Smtp-Source: AGHT+IHHrrnS+NBoPU/kTBM6zMtGF2ilLpZlBt17A9ckU71hcRire8UrNRsya/22OfTlCN6L9HZ5M0V+KE7dbGT/lco=
X-Received: by 2002:a0d:ed03:0:b0:5e8:62c:659e with SMTP id
 w3-20020a0ded03000000b005e8062c659emr2921880ywe.2.1704451342690; Fri, 05 Jan
 2024 02:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-10-chigot@adacore.com>
 <CAJ307EjcP7_-qaC9CkmsU_tbWg9c+nV1JuocdYR4J-yJfLPhNw@mail.gmail.com>
In-Reply-To: <CAJ307EjcP7_-qaC9CkmsU_tbWg9c+nV1JuocdYR4J-yJfLPhNw@mail.gmail.com>
From: Fabien Chouteau <chouteau@adacore.com>
Date: Fri, 5 Jan 2024 11:42:06 +0100
Message-ID: <CALQG_WjYNc8sEAHWyfu51gBfni+UEzjhG8ZskzQJYh6W6eVyVg@mail.gmail.com>
Subject: Re: [PATCH 9/9] MAINTAINERS: replace Fabien by myself as Leon3
 maintainer
To: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d17d97060e3080b4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=chouteau@adacore.com; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 05 Jan 2024 09:56:22 -0500
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

--000000000000d17d97060e3080b4
Content-Type: text/plain; charset="UTF-8"

Looks good Clement.

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>


-- 
Fabien Chouteau

--000000000000d17d97060e3080b4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Looks good Clement.<br></div><div><br></d=
iv><div>Reviewed-by: Fabien Chouteau &lt;<a href=3D"mailto:chouteau@adacore=
.com">chouteau@adacore.com</a>&gt;<br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr"><br></div></div><div><br></div><span clas=
s=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_=
signature"><div dir=3D"ltr">Fabien Chouteau<br></div></div></div>

--000000000000d17d97060e3080b4--

