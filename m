Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 819027883FF
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 11:42:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZTJM-0005sK-BX; Fri, 25 Aug 2023 05:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZTJK-0005rq-5N; Fri, 25 Aug 2023 05:40:58 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZTJH-0004x4-J3; Fri, 25 Aug 2023 05:40:57 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bf3a2f44ffso6475065ad.1; 
 Fri, 25 Aug 2023 02:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692956453; x=1693561253;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SCICTAZSMLN1BS39581CPUGKyF8dDYrFvWRO3MgW7JQ=;
 b=ZXxHrJ/etTAXZpxLRfSknkPsXp46d5EQYe0AS8mc4lkuiorTj+0VaQIBJc93m4hSbr
 DmI4rrdrk9Bf2VE7OynqJvShM16eQ3rWP8ZQ9CGwt2N9IGQRR+v0S0OKzMu1uJRrrO95
 AO3TPf4hjdB/pcaWf/HFUT6ovry3qe8ge0poVpCMfhKZ1wAbiNy0cHBOdSWGfEzyrb32
 daiJGW/B1cMwSBhdbOSOWItU2Ok7GYAlEGV1Vsub+08kSQBd/0UZrFW6rmoYsV/bV5uX
 Dn8eWWvmzkK+oUlNwKxc8S7dMu+3v3TVtqgskC2cvxtFWsUK8Mo2lG1r7ohmheFt9Fuz
 FDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692956453; x=1693561253;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SCICTAZSMLN1BS39581CPUGKyF8dDYrFvWRO3MgW7JQ=;
 b=DouI/I68HlJQT0Hs3S92cbQS6WZfa4njvmfctu0oZAXllpgwH8+YcYeiMKIVJfja/N
 YTxw3KQ3tvxbZ6eHGI94CvYOF4zlSgx6Kc0Nngk9jCA/iIHqjE7fkETMOnflSApeGb31
 hrNPgt2nnzL+m0mhZ7A0lgiHa4WZwdvhAv+rkZezVifUi1aRAPYezdSeaDCrCowufB/H
 eguXN2d1bj5ydKisf8TgeAzRCV6uv+LiZ3XAjSh9QCkf+iLklPYgqvIx1ADNmoROhtNG
 Q0LTXXXn3w37Z4UhdKHZUIn13NQz4KAqyVYM9melHw0KaXvwVyIuinEeLNjC+QBNK/R9
 6ThA==
X-Gm-Message-State: AOJu0YxpqqzHYbbwIJ8OQMNGSeFs/1PCX9/ZJRFzmH7ZinJ0S6w5VZQS
 qCaxAU1AkpHw/UJZ6u2ujLo=
X-Google-Smtp-Source: AGHT+IHWR1ypD7QmCc9fkyQDQeFa+VGDgz4YPfG9sX7wUK8XRxF2vfBjzF2DqepdLpkIg40BhwdysA==
X-Received: by 2002:a17:902:f7d3:b0:1c0:a536:8927 with SMTP id
 h19-20020a170902f7d300b001c0a5368927mr7846777plw.10.1692956453241; 
 Fri, 25 Aug 2023 02:40:53 -0700 (PDT)
Received: from localhost (193-116-106-203.tpgi.com.au. [193.116.106.203])
 by smtp.gmail.com with ESMTPSA id
 iw1-20020a170903044100b001bbd8cf6b57sm1212204plb.230.2023.08.25.02.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 02:40:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Aug 2023 19:40:46 +1000
Message-Id: <CV1IZ2YFXLYY.2YMYA0HD3PT70@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Akihiko Odaki" <akihiko.odaki@daynix.com>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Mikhail Tyutin"
 <m.tyutin@yadro.com>, "Aleksandr Anenkov" <a.anenkov@yadro.com>,
 <qemu-devel@nongnu.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "David Gibson"
 <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>, "open
 list:PowerPC TCG CPUs" <qemu-ppc@nongnu.org>
Subject: Re: [PATCH RESEND v5 19/26] target/ppc: Remove references to
 gdb_has_xml
X-Mailer: aerc 0.15.2
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-20-akihiko.odaki@daynix.com>
In-Reply-To: <20230818033648.8326-20-akihiko.odaki@daynix.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Aug 18, 2023 at 1:36 PM AEST, Akihiko Odaki wrote:
> GDB has XML support since 6.7 which was released in 2007.
> It's time to remove support for old GDB versions without XML support.

These 3 patches might be better to go ahead in a preparation series
with "remove support for gdb 6.7" in the subject so people don't
miss it. You could put a minimum version in docs/system/gdb.rst
too.

For the ppc part,

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  target/ppc/gdbstub.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index c86b7055ca..7e3b67a234 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -54,12 +54,6 @@ static int ppc_gdb_register_len(int n)
>      case 0 ... 31:
>          /* gprs */
>          return sizeof(target_ulong);
> -    case 32 ... 63:
> -        /* fprs */
> -        if (gdb_has_xml) {
> -            return 0;
> -        }
> -        return 8;
>      case 66:
>          /* cr */
>      case 69:
> @@ -74,12 +68,6 @@ static int ppc_gdb_register_len(int n)
>      case 68:
>          /* ctr */
>          return sizeof(target_ulong);
> -    case 70:
> -        /* fpscr */
> -        if (gdb_has_xml) {
> -            return 0;
> -        }
> -        return sizeof(target_ulong);
>      default:
>          return 0;
>      }


