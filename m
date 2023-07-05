Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA08747AE0
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 03:16:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGr7q-0001po-Sq; Tue, 04 Jul 2023 21:16:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGr7o-0001pa-2D; Tue, 04 Jul 2023 21:16:08 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qGr7m-0001fN-AO; Tue, 04 Jul 2023 21:16:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-55adfa61199so4509217a12.2; 
 Tue, 04 Jul 2023 18:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688519764; x=1691111764;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcE6/LoPmw/j92rzJtNg4XhS/HvzyNVEwT2Sn/Z430U=;
 b=F7+IspckwNo2SQ7/97gLRrLfO6E/P7oIeUiWga7Et8WBIX1cjzmw4qmmBHkWdAYVH4
 pnF4MzWPZRbpRIAQ7XOV3vG6i99ywaEvZzbzf1yKQabgWVoh1C0hGiJRqoreHIeC1jSC
 OO6i9TEdhR/xSPVXylF4Mp31FUGcmAQQLk6EpoxDwzt6lL04d8wtSAeoKskv9iwGBnIJ
 ZoG5Pf+BWoIFDIfY4zRaNA0dxZ/rPCO0+9i6/gYJSaW20V4wVlLtfRF1Fiavsu3m+Xue
 EFiWyn+W6kduzRkS/h9XCqLW37pODC0yeC7Qf7mI0LTODGWnZavDfac/4tRVut7Ckt0l
 j9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688519764; x=1691111764;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bcE6/LoPmw/j92rzJtNg4XhS/HvzyNVEwT2Sn/Z430U=;
 b=iM1kPnlhllL0cnN0SJBZsGjy5m7fGHY58an5l3UKU3YtDgmA94bT5sW2d8vIwxqEUu
 S1p7Ce8TJf0vFB8xT8eRpkJFmZx+HgxVOlI485dQrpfJg3uR0JhweZkdgH890PCSmUfD
 APm7kukhFnLOYPYhg/wpzQ1p8Z2qmtsseDcYtZ1fvBhRwWFOsV7G/G242YF4xJ/nq2Ya
 Je//UNXpVLReJWg8kQvFWFuq5w89mzNE9TgdhWAmIC8cN5XH6Lpq6WzqmJWgh+PHUE/v
 iNWVEFnVNPw0n9cg88MrR4YBnUaOljRdo+OZ6TJVtan11dSK0nl75tt+26OuPkp58VE9
 dp3g==
X-Gm-Message-State: ABy/qLYiwSw/eLNPuikwTM0Mo0VBNsJH4nC4lnNZMILCtCCGNPFI4Ylp
 SBUeX+L5CBoo89Ot6Hd5o2E=
X-Google-Smtp-Source: APBJJlFLCel5nO0oC7DKEyV0EyAjecNq9RtUvijwXKJvBocRAwHMlE2X24qcbnzyMYyKyweGUKMgow==
X-Received: by 2002:a05:6a21:6d9c:b0:12f:1f1f:b8b5 with SMTP id
 wl28-20020a056a216d9c00b0012f1f1fb8b5mr4638285pzb.51.1688519763548; 
 Tue, 04 Jul 2023 18:16:03 -0700 (PDT)
Received: from localhost ([61.68.2.145]) by smtp.gmail.com with ESMTPSA id
 q18-20020a62e112000000b0067aea93af40sm12667487pfh.2.2023.07.04.18.16.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 18:16:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Jul 2023 11:15:58 +1000
Message-Id: <CTTUASA1LO97.3N0QY20HXPNVG@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Joel Stanley" <joel@jms.id.au>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 0/5] ppc/pnv: Extend "quad" model for p10
X-Mailer: aerc 0.15.2
References: <20230704054204.168547-1-joel@jms.id.au>
In-Reply-To: <20230704054204.168547-1-joel@jms.id.au>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52d.google.com
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

On Tue Jul 4, 2023 at 3:41 PM AEST, Joel Stanley wrote:
> The quad model implements the EC xscoms for the p9 machine, reusing the
> same model for p10 which isn't quite correct. This series adds a PnvQuad
> class and subclasses it for P9 and P10.
>
> I mistakenly thought we needed the quad model to implement the core
> thread state scom on p10, because the read was coming in to the address
> belonging to the quad. In fact the quad region was too large,
> overlapping with the core. This is fixed in v2, and the core thread is
> back where it should be in the core model. This should address Nick's
> feedback on the v1 cover letter.

Already queued, but FWIW these all look good to me. Thanks, this is a
good base to add some more functions on too.

One thing is the core xscom regions seem to still overlap...

Thanks,
Nick

>
> v2 also adds Cedric's r-b, fixes the s/write/read/ mistakes, and is
> checkpatch clean.
>
> v1: https://lore.kernel.org/qemu-devel/20230630035547.80329-1-joel@jms.id=
.au/
>
> Joel Stanley (5):
>   ppc/pnv: quad xscom callbacks are P9 specific
>   ppc/pnv: Subclass quad xscom callbacks
>   ppc/pnv: Add P10 quad xscom model
>   ppc/pnv: Add P10 core xscom model
>   ppc/pnv: Return zero for core thread state xscom
>
>  include/hw/ppc/pnv_core.h  |  13 ++-
>  include/hw/ppc/pnv_xscom.h |   2 +-
>  hw/ppc/pnv.c               |  11 ++-
>  hw/ppc/pnv_core.c          | 165 +++++++++++++++++++++++++++++++------
>  4 files changed, 162 insertions(+), 29 deletions(-)


