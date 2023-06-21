Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26EF73854B
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 15:34:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBxy1-0002xn-Ao; Wed, 21 Jun 2023 09:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1qBxxy-0002xV-Mr
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:33:46 -0400
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lucienmp.qemu@gmail.com>)
 id 1qBxxw-0003Jj-Lv
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 09:33:46 -0400
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-440c368b4e2so841497137.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687354421; x=1689946421;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=43KjpQ8M6gmogf6qTmqIFXQBfIX9LXEH/7om6X0yi7s=;
 b=Y+AaxJ6AHPUZrx4WzClRDAbdCaeQpPoojIoG8egr68cjJNUJKM0at59yVT90fXc05R
 Vksbplj7u9DuvbqdbSF3sQZsQoLYjxCpx+b6E+3BnQiRGXC6OaiwElwTPYmw+lBaaf7l
 UIMeOCTt2AVFg9abL4LdL98RCMKryR7+Ezmx0KXRjwuSWamir5aKmfqU1aUSkL+H4H8l
 FQ+ONzpAy1ch4lcD/PxgwSbA9xnrmJRwSwQb85Hht/K6vJLHrKxX4F3E6wLOrihFGx3F
 BZorr2jWma7GiqgDIrFXT9QtC/C9Br2wWLpjgy5vA8vmDqQD/93uExgrbJwCITfzZUKm
 1dxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687354421; x=1689946421;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=43KjpQ8M6gmogf6qTmqIFXQBfIX9LXEH/7om6X0yi7s=;
 b=DB4Fvdulu1LY9PXIRcCqFEvVDSokwCjA+uBVe446OxVSEQDYTSZPrwcAK7gDX1lZsk
 TkEWQcQwDWrNkwqYBQgkEGTOIShMPZTmBZTC7xwhU5JfAuuXR+CASNfQUyOnBi9FdeRf
 MeX7Bg7IBv8cxwmS/pBWQz8TvUjFaWxU0OrIedwM6tZgwi3zaFhmE9auk83ZK1tzQeb1
 2AMmuQg2PFprhexpQqdAAUV+cLqlyhe4yGxRDfWPOrKLk3wGeD6Z3//DU0Vo2TCLWWuy
 28g8GHaYnljqTE6qlHdSBGeXV60egELmjJjdtZOJYvAGfgzYTV0s/MdfZABeZ9vGBdxD
 R2nQ==
X-Gm-Message-State: AC+VfDzDDT+hLuFxajDI6bm5cY1JaDQQRsjJUu/pcMRH/9AEoTVUMXHf
 tUauOUSTmWUEyNShWP9DrXsCKQhbg5mem6lZbDCSQzOCDBg=
X-Google-Smtp-Source: ACHHUZ6PRox9Q5iVCfCj9HfbWeo/+vxUn6yGA7ft3k9BWGY5eY/sROdSPGJZipJ2KECT5Wy2yRCdYAjEOa6lE/0bSH4=
X-Received: by 2002:a05:6102:41b:b0:440:9f9a:4bbb with SMTP id
 d27-20020a056102041b00b004409f9a4bbbmr5639295vsq.20.1687354421638; Wed, 21
 Jun 2023 06:33:41 -0700 (PDT)
MIME-Version: 1.0
From: Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
Date: Wed, 21 Jun 2023 22:33:29 +0900
Message-ID: <CALvKS=HrptQNXs0a+pERGmScXAcWyqKBds-OwxWFu9RNOHiY5g@mail.gmail.com>
Subject: QUESTION: sd: emmc: what happened to the progress on the patches?
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e29;
 envelope-from=lucienmp.qemu@gmail.com; helo=mail-vs1-xe29.google.com
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

Hi C=C3=A9dric/Philippe and others,

I would also like to see eMMC support as its very useful for certain
embedded emulation.

I found a several discussions for SPI/eMMC in Qemu but couldn't find
anything that ever made a release, and the conversation seems to have
gone dead a couple years ago.  The mail-list search is down so I had
to use google, it was not as easy to follow.

What I could find is as referenced below, did I miss something?

"[PATCH v3 06/21] sd: emmc: Update CMD8 to send EXT_CSD register"
https://mail.gnu.org/archive/html/qemu-devel/2021-03/msg00118.html

"[RFC PATCH 00/17] hw/sd: Rework models for eMMC support"
https://lore.kernel.org/qemu-devel/8aa56da0-a54a-102a-fc85-2fa9f02c18d1@kao=
d.org/

2011 eMMC original support
https://lists.nongnu.org/archive/html/qemu-devel/2011-07/msg02835.html

Cheers,
Luc

