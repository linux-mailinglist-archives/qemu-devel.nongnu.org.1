Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DF5736803
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXqd-0003u6-Gs; Tue, 20 Jun 2023 05:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBXqW-00033F-FW; Tue, 20 Jun 2023 05:40:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBXqT-0006q9-27; Tue, 20 Jun 2023 05:40:20 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1b5251e5774so20183765ad.1; 
 Tue, 20 Jun 2023 02:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687254013; x=1689846013;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48gT1MrKLybpZPeA/w3PDKAgaxKbpQsQGAATvmogWPY=;
 b=BHNry5VDEr6LHug6tsDu5sg3VQj8+bxsQjfHGGJsHbooG5gLBVgxCmjnCRRoqrHmR8
 1sjtVkEnevt9rqUqMLBTHOW6RLOBJlZcQBuOE1f+Z7bEgdghVMQ37a7tOT3NPMd7B2w/
 xlE+C4ZJ5fiMfrxp3DqyWm9cc59FijFqOlApMXVwwhs5HBjUiuPjCkXKI/ECxdOIt1eg
 Sq8J4iT4hb/jJcanItfGReHlYop4GX+ItL2Io2XXo5kz7HU9saWs2tqQu1i9CxyW9qGe
 7Ixjqwygv3mAL7pp2+CBhpg5Ml6ObcunZeuOY3tqflkcu/z63WBIR2frd3/bAuOG4dSk
 yTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687254013; x=1689846013;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=48gT1MrKLybpZPeA/w3PDKAgaxKbpQsQGAATvmogWPY=;
 b=ZP9QzH3FAp6nEFBjV8gVzt8aGQoHQ2ZPAX+VqsRRqjMQQN3pI3dkdTqGdnLygB0KQp
 lNNoNRRg85/sHUZH7Ryx9Jhps1UlT/M5jG2xNSx0uECLrUxnuKsDdlS80nYRLay4ERfK
 HLQbeo9VZN0hvzv4QTqovOgGy5mEV71weQxRktl8AAZqvF7e85kH7Qb0WoxiyBL2mMxO
 vI8nXehfAcE2uwzVX2zHlnNivMuuju0hNNQRXsqtKn4wTzck1MksBLhPS7wYETVATkBy
 aFA1Ftid/YlEdl9/JkpVsmkRA3xfq/tAWQjp8xlyIfPvjMJ+oGBRp53Y22lcLzOgIpcz
 XbrA==
X-Gm-Message-State: AC+VfDxUy8X87pICx10+Cyqwh7RlyIaDzfrfg25CiY8U4nTuGKXu8OJt
 bW/AtJ6FI7VNoaP2nEf5IUuhGe8PTxU=
X-Google-Smtp-Source: ACHHUZ65Zy7PFRKidMzFm5t5J9VuO0gFvvzTEcjY9IxtmbrnBljqkv0WhsedqEWws74lo278/z/HDA==
X-Received: by 2002:a17:902:7c92:b0:1b3:91f7:4883 with SMTP id
 y18-20020a1709027c9200b001b391f74883mr2172454pll.46.1687254013526; 
 Tue, 20 Jun 2023 02:40:13 -0700 (PDT)
Received: from localhost ([124.170.190.103]) by smtp.gmail.com with ESMTPSA id
 u2-20020a170902e5c200b001b05e96d859sm1201501plf.135.2023.06.20.02.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:40:13 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 19:40:08 +1000
Message-Id: <CTHDMMUCBTAM.Z7LPA87SQCVK@wheely>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Subject: Re: [PATCH 1/9] MAINTAINERS: Add reviewers for PowerNV baremetal
 emulation
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-2-clg@kaod.org>
In-Reply-To: <20230620055911.187065-2-clg@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Jun 20, 2023 at 3:59 PM AEST, C=C3=A9dric Le Goater wrote:
> Fred and Nick have been hacking baremetal POWER systems (OPAL) for
> many years. They use and modify the QEMU models regularly. Add them as
> PowerNV reviewers.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Cc: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 88b5a7ee0a79..e6f3dade2230 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1448,6 +1448,8 @@ F: tests/avocado/ppc_pseries.py
> =20
>  PowerNV (Non-Virtualized)
>  M: C=C3=A9dric Le Goater <clg@kaod.org>
> +R: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> +R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: docs/system/ppc/powernv.rst
> --=20
> 2.41.0


