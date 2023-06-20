Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A67E9736807
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:42:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXql-0004pP-Bw; Tue, 20 Jun 2023 05:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBXqi-0004cc-6h; Tue, 20 Jun 2023 05:40:32 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBXqg-0006xx-06; Tue, 20 Jun 2023 05:40:31 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-53fbf2c42bfso3679729a12.3; 
 Tue, 20 Jun 2023 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687254028; x=1689846028;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gqXYeh6xJrw67BdKU4KInuTz93iOW33J1ks271D8C/0=;
 b=pcogaFymxeXe9+rqkZ4t+6BkzFkEptKcgDkETgkRGzI/elV6zBq+VAnwUhcT38R4Pc
 KRTTddQ9fGLKgwmlEt3WVKpHlocY3FWROpi/ObqSMnnyxPFKUEnog1k0EXm7AAQFtk4f
 MnM3/1UlsNrjvvlU+Ax09Gf8Yd6q9N/YQ29mciz0YWfSjcnpdez44V5HqBDOBmXF83TX
 LE1IccOZtu4biBlXuBXiaINB2yS6rQPcGJYxsyCW5NEz+vXTmXi63XEcptPDvs9r4xMB
 +X8D3EdOMXAA+7khPg3u0Kz/9e6RHLJgKs6K0vjWk7eSngCNoLWI5z5k3YSqS1LgZM/c
 1UWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687254028; x=1689846028;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gqXYeh6xJrw67BdKU4KInuTz93iOW33J1ks271D8C/0=;
 b=CsO48JMDYE1n2vIiDf/XcET4lt79I6SZfe/tytU1HqTvHcnv4vmUJLGm7J7/Cg9qgl
 ayXYXq0S89tQHWTRvy7hYGH0DfVY1ByGrZTSpwefYz2QiBAKNLgbwQVQWtWNQcSnZbxu
 fXMDf3OAunPm7FKnFfSvPoAZHnzKjySDZFATHQJvffUIgurpvqnsYNENDPmU7u1llFAC
 ws7K6t4XJuwZc+zDL6ckXZ83EXGt0/CTJJU3Iwi+x8qiuh/HQ4jSmARtuNg9+JCAG9EI
 NDlCypBOzMbnJV3A+SCa/LHd5u6OFoa4ztgi21Mi/F2fF2BY4qqVr7cSTR3ZWMHJT+Un
 3KRg==
X-Gm-Message-State: AC+VfDyhYjrIQc+1ZPZh+xul4eNNXAprOveSeT1QviBgsIndI96HGGRS
 VO862MJDg06pNfm34b/HJyQ=
X-Google-Smtp-Source: ACHHUZ6W2Y3L2jCYRi7Y4hkpRps3N+Rt32UCQOyvrxoOjQDRpurJGlhsQc1/JO8wB2AtkA2ehe+erQ==
X-Received: by 2002:a05:6a20:54a2:b0:10f:d1d4:40d4 with SMTP id
 i34-20020a056a2054a200b0010fd1d440d4mr15443793pzk.14.1687254027832; 
 Tue, 20 Jun 2023 02:40:27 -0700 (PDT)
Received: from localhost ([124.170.190.103]) by smtp.gmail.com with ESMTPSA id
 u21-20020a62ed15000000b00660d80087a0sm968719pfh.199.2023.06.20.02.40.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:40:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 19:40:23 +1000
Message-Id: <CTHDMTMTG72L.17YSIOWBD8RMD@wheely>
Cc: <qemu-devel@nongnu.org>
Subject: Re: [PATCH 2/9] MAINTAINERS: Add reviewer for PowerPC TCG CPUs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230620055911.187065-1-clg@kaod.org>
 <20230620055911.187065-3-clg@kaod.org>
In-Reply-To: <20230620055911.187065-3-clg@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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
> Nick has great knowledge of the PowerPC CPUs, software and hardware.
> Add him as a reviewer on CPU TCG modeling.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e6f3dade2230..90fb83c4cb58 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -302,6 +302,7 @@ M: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
>  R: David Gibson <david@gibson.dropbear.id.au>
>  R: Greg Kurz <groug@kaod.org>
> +R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: target/ppc/
> --=20
> 2.41.0


