Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DA1784814
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 18:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYUfv-0004ey-3z; Tue, 22 Aug 2023 12:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qYUfs-0004dr-Ij
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:56:12 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qYUfm-0000yq-JF
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 12:56:12 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so972883066b.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692723364; x=1693328164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k7GodlGnyRisY1j1aahqN6pnIg9QC94I6fttP9jTfNM=;
 b=dnxAcjQPRIyvrSecY9u9dnlTim6DKu1hgvwW0FOj+ff7KuSWRZQC61m+aioNLlwVXv
 3X6Fkvts0pTWihqvRQw97lKmU1lhi1K89NcniD4j5HnsoUc4S5YJ0vmLmDohlFFQMosA
 5+cnYCK829ul1C7RNdJzs+lFt2A1oNUaIvNmNqC4f7zZsBCwfkDaFNvkt0UvRsfi2DiR
 0Opy+4lc8vxQc0vsaf7fQi5avboBw5NljS9RERGymI04rJfP4FAb39J3MixQexXHuxuA
 ZZ8r0K7Z7HeZV1K8+O7FjQALclSqjJoOXGOEc5QxP+PIKRiGt0+8bM6zdSTnNVquF21G
 TeNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692723364; x=1693328164;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k7GodlGnyRisY1j1aahqN6pnIg9QC94I6fttP9jTfNM=;
 b=TfIPf8QW0L6qoiJtUnUKacBj4dl87o2jg76rKVQK/sgKMNQ09v2s1m7ttJyAw8VwZ+
 egiXVdwE+hW61jmqj6V3X58P5ny2eOQ4vyslvoTwRg1x6jnzc070W0wQ3VHBXhlIccIV
 WTR3HrkZnIltRM00ygaaTTGUA0j+JNT3RzxV0Ug5MD9KASRsKxXSA5RxXeEYKBKJqFCZ
 Go/iOqAlJ3CQLx0upj1aDbjWNRQlFGT0rmwYA+u2bkKRJSxOZmyGlnwD8l7Ep0Rl72eP
 WFD0YZZwptjOGqGo/ETmudP2jY6Kl0lux+6f6FiY0qZBDdTQQRWusfm1BSeGsL3w+oFS
 Bp3w==
X-Gm-Message-State: AOJu0YzKuAjVCIlzef81cLVDQsO+yyAMnHjWCd28SdyVALY3QfEZXn3H
 Ec0+QjnQO/T80C8jxRy05nhTlNUAftXk441NR9T+Jw==
X-Google-Smtp-Source: AGHT+IHQKbNnw4z1Jx4PKNdR6ga0dq9C37nOALj/HPiS/l2nEAdOIiuJXgaa4ggdA4uHEAi+Ym0edW977K5kKP0tHQw=
X-Received: by 2002:a17:906:c116:b0:993:f664:ce25 with SMTP id
 do22-20020a170906c11600b00993f664ce25mr10649596ejc.19.1692723364505; Tue, 22
 Aug 2023 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230820204408.327348-1-richard.henderson@linaro.org>
 <20230820204408.327348-2-richard.henderson@linaro.org>
In-Reply-To: <20230820204408.327348-2-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 22 Aug 2023 10:55:52 -0600
Message-ID: <CANCZdfov9N7UQLKd9bq3ZpCOdFV+ruO8-T6rggtuMH-pfZO5PQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux-user: Move shmat and shmdt implementations to
 mmap.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, kariem.taha2.7@gmail.com
Content-Type: multipart/alternative; boundary="000000000000d83c4a060385ded0"
Received-SPF: none client-ip=2a00:1450:4864:20::632;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d83c4a060385ded0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 2:44=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Rename from do_* to target_*.  Fix some minor checkpatch errors.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/user-mmap.h |   4 ++
>  linux-user/mmap.c      | 138 +++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c   | 143 ++---------------------------------------
>  3 files changed, 146 insertions(+), 139 deletions(-)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000d83c4a060385ded0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Aug 20, 2023 at 2:44=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Rename from do_* to target_*.=C2=A0 Fix some mino=
r checkpatch errors.<br>
<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0linux-user/user-mmap.h |=C2=A0 =C2=A04 ++<br>
=C2=A0linux-user/mmap.c=C2=A0 =C2=A0 =C2=A0 | 138 +++++++++++++++++++++++++=
++++++++++++++<br>
=C2=A0linux-user/syscall.c=C2=A0 =C2=A0| 143 ++----------------------------=
-----------<br>
=C2=A03 files changed, 146 insertions(+), 139 deletions(-)<br></blockquote>=
<div><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdi=
mp.com">imp@bsdimp.com</a>&gt;<br></div></div></div>

--000000000000d83c4a060385ded0--

