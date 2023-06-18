Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8759F73462E
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 14:50:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qArpq-0003z1-GV; Sun, 18 Jun 2023 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qArpo-0003yj-Gm; Sun, 18 Jun 2023 08:48:48 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qArpn-0003y1-0t; Sun, 18 Jun 2023 08:48:48 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-987341238aeso251440966b.3; 
 Sun, 18 Jun 2023 05:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687092524; x=1689684524;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TptMjLu16quoyRXU/+pBex3cATgGkDzVhR0wTQOR0C0=;
 b=jxMcw9JFckVj7VwNMzaSLA5ULpY9iLc7ZuEip3aWATl/xKuPe8AkIh8HNo5BRWO2UO
 xSe+UeiMl5pu4T7KNZnoHwD67ve8Ku9IiAR59x9wLtJP8p4dAsEUKX1S1V16i6ouUBEP
 ih8dhnkZdickgIw3Me70DjOS9BhagYqzqZzhP/jz+KPI68+dD4VcNoTj4hFdYtvP6vIm
 mS0qhwf79SMFfchX/qGCustllUaFfcZsszoivh5MHA8QnW4jIZeKz0Gx4o5wS6QyYM/O
 pTKIsvZpw0rYIuFLJoABy8o1ajxw340ytDr5xgGjiI09HYuJ+yYoyjzpebHUR6wrVb+b
 Nuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687092524; x=1689684524;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TptMjLu16quoyRXU/+pBex3cATgGkDzVhR0wTQOR0C0=;
 b=jHqkjLAWQPoUX7G2oIKRKsD5eDsqQtPB6gfNz9bFMgrT4qwfRl7cgUkkLmOd5Qlalj
 KwfrqNqfdqPifS1QJurXBlFif8vHJmGhrdQ29tITVPqqkKhI/6RmETi7OvdktjggrOOK
 opDXydd28WTQUdTVihG5wvDFUA/XqRbiiYbNl/YYqPKW813i2G0JqXfpGHjYvKxOsQAb
 QbO51kuIV66cfdZQcvCKXqBFbadF+aBulZRzEWVuFPzoWqckv68aN8iUVTFfhipHlmaj
 mrJjSdzRXLKJA7/J2M5gXv47gGN7p1xmkASY6kK0lB905teL9I7hMjjeqR173bGWEj8/
 kJ7w==
X-Gm-Message-State: AC+VfDw3HsgaeQzuz9pCaLlcu/TO/RSanloiXReGj75PP1lBxASDuxID
 eVtGaZhu7J1UyOS3X3kFfF0XDQR6RbY=
X-Google-Smtp-Source: ACHHUZ6yukkgzmNbI5y6DulbYyuYddqqkZfHGBMRpbxRKXCC7lbbRfsz0WQU7Io/v4DZdC4IMadzlw==
X-Received: by 2002:a17:907:8748:b0:974:1c91:a751 with SMTP id
 qo8-20020a170907874800b009741c91a751mr5964804ejc.29.1687092524153; 
 Sun, 18 Jun 2023 05:48:44 -0700 (PDT)
Received: from ?IPv6:::1?
 (p200300faaf258000405ede7f0de9d5cd.dip0.t-ipconnect.de.
 [2003:fa:af25:8000:405e:de7f:de9:d5cd])
 by smtp.gmail.com with ESMTPSA id
 j14-20020a170906410e00b009883a3edcfcsm1414107ejk.171.2023.06.18.05.48.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 05:48:43 -0700 (PDT)
Date: Sun, 18 Jun 2023 12:48:37 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org
CC: clg@kaod.org, Greg Kurz <groug@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 07/14] target/ppd: Remove unused define
In-Reply-To: <50adc24f9d408882128e896d8a81a1a059c41836.1686868895.git.balaton@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <50adc24f9d408882128e896d8a81a1a059c41836.1686868895.git.balaton@eik.bme.hu>
Message-ID: <34E068CE-1750-404E-8282-107429CDEDB9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62c.google.com
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

Typo: s/ppd/ppc/ in the header of the commit message=2E

Best regards,
Bernhard


Am 15=2E Juni 2023 23:03:16 UTC schrieb BALATON Zoltan <balaton@eik=2Ebme=
=2Ehu>:
>Commit 7a3fe174b12d removed usage of POWERPC_SYSCALL_VECTORED, drop
>the unused define as well=2E
>
>Signed-off-by: BALATON Zoltan <balaton@eik=2Ebme=2Ehu>
>Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>
>Reviewed-by: Nicholas Piggin <npiggin@gmail=2Ecom>
>---
> target/ppc/translate=2Ec | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/target/ppc/translate=2Ec b/target/ppc/translate=2Ec
>index b591f2e496=2E=2Ea32a9b8a5f 100644
>--- a/target/ppc/translate=2Ec
>+++ b/target/ppc/translate=2Ec
>@@ -4416,7 +4416,6 @@ static void gen_hrfid(DisasContext *ctx)
> #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL_USER
> #else
> #define POWERPC_SYSCALL POWERPC_EXCP_SYSCALL
>-#define POWERPC_SYSCALL_VECTORED POWERPC_EXCP_SYSCALL_VECTORED
> #endif
> static void gen_sc(DisasContext *ctx)
> {

