Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0024B7BF8A0
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 12:27:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9wC-0000Vh-A6; Tue, 10 Oct 2023 06:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1qq9wA-0000Uq-5R; Tue, 10 Oct 2023 06:26:02 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1qq9w8-00037S-FZ; Tue, 10 Oct 2023 06:26:01 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5045cb9c091so7321155e87.3; 
 Tue, 10 Oct 2023 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696933556; x=1697538356; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hiWE6lqt70Q969ZpEO8q/Fz3O806MYs68jZyy2fFHv4=;
 b=FoHcHvmJeAJG8S33+b+FrAfwJ1ACqSSdZLrnSt29XB/PJR3O//t64iCG69e7UZL0H7
 njgnJDMH+czlBTB3Q63fKCZf94t/oq7jTFfexEgpTHGkQgOzo0jhX2GRhihJ4gcbFp+k
 /6EOByJkn/xEe9623QzDhkKiSuzlbyNV9Ar8kAhlkfP/sBBX1VvSsLUz4WRq9iWEWkLx
 1LBTNjpUNEhQrsBZqrPDTNCLL+33OYShORNhh52tEXdb0b+cgiT7IRNSkxy/Ac0h6gfJ
 iWmCY/0H/ONzK6QWCAA6cASleQ83LDAJfZV8SnWmKCer3FzTTstgZ1AUelmhY8ix+1VF
 FeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696933557; x=1697538357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hiWE6lqt70Q969ZpEO8q/Fz3O806MYs68jZyy2fFHv4=;
 b=RYMA9kg27RDfVW4s1BC4y94pwV+GExgACPNbPAkgcCmrsCzsOMZeulmEk5VXjF1VkF
 CgMBR7o5f64C+rhAYtUgHuBuAtPJjsxrRDuLTnY7j6XX2QSTBmgOK696vOl5JDflBzt7
 rTKXpIBqI0C+S4dB6L40/mi9niG7mysoykpG7zhpufXkWjGFdeADV7KR3SbNRJMpIF4/
 XIc1SqxAIhOUboe7KB1NL5d9mIDVPXjFAt6IoVNKUNoPP3PkuezUJQnHdlSARgBOTxsI
 2oGKb0b6BJzBidvrU6Z3yeVZq1JeUTBL+ogYmcSu1b9+B3Y83t1a+ijwkWLjebIfz3rU
 It8Q==
X-Gm-Message-State: AOJu0YxKW1evDBZirvd6W7tErI7kEtFMLxyPQgFVDorQyzTOtK7UDHwi
 nPHU0Uc9MLfub0WJGe8WBhrzXA5MzNw/g2Vzy8E=
X-Google-Smtp-Source: AGHT+IEObqBtyVe+BP+0BYgzh5fb9rSOechIN/LojWkNDii4+ry2msQn8T1oslFwABRl4mI99J2Rt/W9exjEMMCm+qU=
X-Received: by 2002:ac2:5e72:0:b0:503:385c:4319 with SMTP id
 a18-20020ac25e72000000b00503385c4319mr13613842lfr.19.1696933556332; Tue, 10
 Oct 2023 03:25:56 -0700 (PDT)
MIME-Version: 1.0
References: <99bfcf6de904357e6b07084b99193bb16309d46a.1696914208.git.jeuk20.kim@gmail.com>
In-Reply-To: <99bfcf6de904357e6b07084b99193bb16309d46a.1696914208.git.jeuk20.kim@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 10 Oct 2023 18:25:43 +0800
Message-ID: <CAEUhbmXgCmhgnM-pX5XNMH3ohqimnuNRdufcVVFki7kb0-qRVA@mail.gmail.com>
Subject: Re: [PATCH] hw/ufs: Fix incorrect register fields
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, jeuk20.kim@samsung.com, pbonzini@redhat.com, 
 qemu-block@nongnu.org, stefanha@redhat.com, kwolf@redhat.com, 
 hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=bmeng.cn@gmail.com; helo=mail-lf1-x12a.google.com
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

On Tue, Oct 10, 2023 at 1:11=E2=80=AFPM Jeuk Kim <jeuk20.kim@gmail.com> wro=
te:
>
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> This patch fixes invalid ufs register fields.
> This fixes an issue reported by Bin Meng that
> caused ufs to fail over riscv.
>

Fixes: bc4e68d362ec ("hw/ufs: Initial commit for emulated
Universal-Flash-Storage")
Reported-by: Bin Meng <bmeng@tinylab.org>

> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>  include/block/ufs.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bmeng@tinylab.org>
Tested-by: Bin Meng <bmeng@tinylab.org>

