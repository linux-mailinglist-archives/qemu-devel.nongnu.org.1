Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9E578EE4D
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:15:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhHs-0006Kh-QJ; Thu, 31 Aug 2023 09:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbhFB-0002xj-On; Thu, 31 Aug 2023 08:57:54 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbhF0-0005KD-Cm; Thu, 31 Aug 2023 08:57:50 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9a2185bd83cso92109266b.0; 
 Thu, 31 Aug 2023 05:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693486659; x=1694091459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSAoiEDqsEgwaEI0QYDYYQxHuwjjUN7v4Aw6JIXOYZk=;
 b=EtPeNYNkxd8ZvKQt0hf7a14GljpGu2ZjZBP91SaJR231p/EkHdye1L+rOYMSSlFoyy
 TSjsGXcOcJVkI76zTUOesc4VG44syDBSTp8k4XOQpbO0+yrLCOVOpIRMXLtYsaSAlfpu
 apnCY5ZkA3loLPhcYDHApERCUB18CkVookjsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486659; x=1694091459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSAoiEDqsEgwaEI0QYDYYQxHuwjjUN7v4Aw6JIXOYZk=;
 b=FDewL5k6qaGSJKxDkLe4sNQAojMMrVpZdQ9lb1c6ft9oTiV33+jQpXVZbZsxpOX2q7
 mYiqm0tJDJ7223wv16ZAOLQ5K0UsvWZbUCvf+u96GdhzuOgfYrn+WYWvoTCPpSx1jNYL
 FdF43rqur+w1xreO/bzU2l2GwHBRhu5/1C6fi0y/oTCI/r/0jPRtdjNKZ8+HeuEJDVWU
 QD+4P7I9Uepx9olK22aB0EQvT0LYLefZAFkNLYFPRtiTD9Nq2RW3phriLajqqrZc6L8i
 FQyc8dPOIzti909nsUdJcgwvhkgzzbc71VHNP5Xb+EskNX6K1dWWn39sDKdtg/QO4dT9
 Wsag==
X-Gm-Message-State: AOJu0YzJvE6erBmN8s8TshIUv2M8GLgSNnPj0zqVeX7sk4NwfRrYgl55
 Whly/gYrkRKIQbxHlMZ4+Pffzb4HedwgcPq9qFFb9v24
X-Google-Smtp-Source: AGHT+IHaINliQ83lAnEM0uuMsSBbtCNhc9Pxq16bginTNCdkwPtCZq3DZeI1wzjz9giHhtlAmFNKhIBEUbO3fQKkymg=
X-Received: by 2002:a17:906:3058:b0:9a5:7759:19c0 with SMTP id
 d24-20020a170906305800b009a5775919c0mr3619395ejd.64.1693486658612; Thu, 31
 Aug 2023 05:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230808083445.4613-1-joel@jms.id.au>
 <20230808083445.4613-3-joel@jms.id.au>
 <61cf0069-e845-3a07-2a55-659594e886be@linux.ibm.com>
 <bc069058-28d0-3cba-2fb5-c5701049a5d9@kaod.org>
In-Reply-To: <bc069058-28d0-3cba-2fb5-c5701049a5d9@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Aug 2023 12:57:22 +0000
Message-ID: <CACPK8XfX0uEsc6PifsWj8=Vp0sfwVotEanMum7ydmpvnP3zy-A@mail.gmail.com>
Subject: Re: [PATCH for-8.2 2/3] pnv/lpc: Hook up xscom region for P9/P10
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Frederic Barrat <fbarrat@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 29 Aug 2023 at 14:45, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 8/9/23 16:56, Frederic Barrat wrote:
> > Hello Joel,
> >
> > So we're re-using the same xscom ops as on P8. A quick look at the defi=
nition of those 4 registers on P8 (0xb0020) and on P9/P10 (0x00090040) seem=
 to show they are not the same though. Am i missing something?
>
> Joel, are we ok ? Should we grab this patch ? or not.

Sorry, I chatted to Fred about this one but forgot to reply on the
list. I made a bad assumption about the xscom registers matching
between p8 and p9/10. This patch will need to be reworked, so please
ignore it.

Cheers,

Joel

