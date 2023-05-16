Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A842970499A
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrEF-0002d8-Ol; Tue, 16 May 2023 05:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrED-0002cI-MI; Tue, 16 May 2023 05:44:21 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrEC-0007N4-7J; Tue, 16 May 2023 05:44:21 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so4134482b3a.1; 
 Tue, 16 May 2023 02:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684230258; x=1686822258;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Un0PstfYaZEkYAsL0ULzBnnhij2cp0uXkS4DsxBJdc=;
 b=V+CE81f5OxUSRcIyhwyq7G0Kq0kIsRVTkTh/bCdJd5CJgZtHp03qvGBlslCO6pWunK
 WcOSleNcDq3A1b/ziTL20AQVd+J10+9Yi05Vx8pvQomHcytbIt7RwAW6HEd3h3nyerQW
 vgKFWuF3Zb3Timrqw8IpatOhqi0ziPqf9fMAkI07aQsE4Z06CXUSkQV6dKTHfLKogyOa
 ni8hz6ymsKvhlllOTgg8U5Wyv5sPUafFIkWn+sjHqs3uwc2OT3l/Vnqd2ykfhEV1kURo
 Vw8WG/tCbK3ZHc3ZiOOk87jq1e7i0ZMpMgqUX1OoQgMKNJs+zCrpTAVJpom2Wf/hKVZP
 61Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684230258; x=1686822258;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Un0PstfYaZEkYAsL0ULzBnnhij2cp0uXkS4DsxBJdc=;
 b=h4xmK/bhnU66B0cxp8bZenzVMS3wYrGlMyaifKSRuDHogAWtqx/Hdd/fyv5K93w+UG
 WZCYzYB5YtWu6oblLm9Ck1p+5Cv1sP6WAfnyL0lSzxygpIHfX/e+M9MaCoc1imY/0VfC
 4Y29JRiZsNpXdONxmgr5vxO/T9Flzqn0xJOXtVdqZeuyZ3RqUYyBpzlzXZ9bg0PzJ7Uo
 Jgub/MwoEdjCtpcgLZMs8gARFdEUeqOi6W32Ywk9srZPZh9cLDfQysllWUUWGUptCLvF
 612lhpinaZjKvzhRJ49TCV/VWaIbU+iZR5NZXz4TiibTbZVknzH3YIjtTThAYxNYvBOF
 8DCg==
X-Gm-Message-State: AC+VfDx4IDbmRtfiiMQOGz37WmJOREETmkA3y9PoCnbSQzufqj7IqKAA
 igab0+XsqUw6b4WMiqEViXA=
X-Google-Smtp-Source: ACHHUZ71J2h1oWZ8fQoTtTRIobHE4pv671YR44cZnK8CJ3GwPl1kx+9xQsPQxJ+twkcRGr1aoAPD3A==
X-Received: by 2002:a05:6a00:4c18:b0:649:76a8:df27 with SMTP id
 ea24-20020a056a004c1800b0064976a8df27mr20821844pfb.14.1684230258479; 
 Tue, 16 May 2023 02:44:18 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 f3-20020aa78b03000000b0064385a057dfsm13114806pfd.181.2023.05.16.02.44.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 02:44:17 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 19:44:13 +1000
Message-Id: <CSNLSP464PKJ.3NNMBKX65EUWI@wheely>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harsh@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Frederic Barrat" <fbarrat@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.14.0
References: <20230515160201.394587-1-npiggin@gmail.com>
 <efda933a-7a14-7157-887d-28137c872895@linux.ibm.com>
In-Reply-To: <efda933a-7a14-7157-887d-28137c872895@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

On Tue May 16, 2023 at 5:56 PM AEST, Frederic Barrat wrote:
>
>
> On 15/05/2023 18:02, Nicholas Piggin wrote:
> > POWER9 DD2.1 and earlier had significant limitations when running KVM,
> > including lack of "mixed mode" MMU support (ability to run HPT and RPT
> > mode on threads of the same core), and a translation prefetch issue
> > which is worked around by disabling "AIL" mode for the guest.
> >=20
> > These processors are not widely available, and it's difficult to deal
> > with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> > and make it the default POWER9 CPU.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
>
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
>
> Which makes me wonder if the P9 DD1 and P10 DD1 cpu definitions are=20
> worth keeping, since we don't really try emulating the differences and=20
> we don't support them in firmware/skiboot. The only place where we seem=
=20
> to bother is in target/ppc/kvm.c and that's precisely what this patch is=
=20
> trying to avoid.

+1. We could do a follow up as Cedric suggested.

Thanks,
Nick

