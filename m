Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7593C72F32E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 05:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9HPD-00086j-4N; Tue, 13 Jun 2023 23:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HP8-00085S-TM; Tue, 13 Jun 2023 23:42:42 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9HP7-0006fh-H4; Tue, 13 Jun 2023 23:42:42 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-39a55e706deso2713771b6e.3; 
 Tue, 13 Jun 2023 20:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686714159; x=1689306159;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mej/8pbx1Ftg/dFhla6kZGyqZQtk9GcncMAyk+UkgpE=;
 b=q83ds6I052ouyBmHMNy8YDoRJxcpp0Uz5WNiz6JE9ABmPpQotB0yq5SAIr45ys/BsA
 8/Ik0dzqu8rsIaxZ0aYVyN8OZ7gUgHS7hTXN1xQAhBFVl1lIcGo+GHWrkKyC+ccz8OA0
 D4gPxmeajeToBtus09RoZf47n9/TgR8rkj6ji/8k0+JCE5v1i/+3sSgch6IUsGSVyEMU
 JdgtaSGWOUnOHnPRmYcppVY49ggWJvS1pn+zaWYJ9PTnkAY/YMGU/M0sKoTBEsVH0qqd
 TfpkkONghaAyCmWtyObA+l64BJ1rzhHstnYPUeyxWxbjLjYOOvsuaVoMM1P0sCzCKAns
 yvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686714159; x=1689306159;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mej/8pbx1Ftg/dFhla6kZGyqZQtk9GcncMAyk+UkgpE=;
 b=fQjG0gpqcd+otnm4YZd9aQ0+CvvoY+RU8tjHhnrZqQWBSzrDLHItVY1vywv/i9xCKk
 J+CTxm9rblFxdz28VJp4ArN66/L6e3sce7e+96xnU3Qv5Cuq1kg6eCNMJexDStD6sC0q
 RUQ9G90HAOuxB1P6vBPMl58Vmx/0pQ3R6kc+DSiMarh9xHQTgBaHGq0zgswq87S1Uyuf
 0lLj03HspvxagwBGuump+kJjKMSHB2n2svCrMSBQWIqBAcYeYy/rCBbJmvhcvsp6YHjl
 cHZ7YH9ob5gsE0NpKEoqTloqhkR65DyGkFNtX4+g19NKdBm9yVySrHc2fXLRaMaUOw7R
 Wpog==
X-Gm-Message-State: AC+VfDwcqU0+VghjbZPJsuIz2e3ZxGFDJXkaisuBohD9Wl8VwliiBliV
 ri0ujeLwghEQTMLRqAfe1iM=
X-Google-Smtp-Source: ACHHUZ6hrL7+ktzg+yumqdTuMDRqCjPjXFpRIagoby3AuxKXjLqTXRrJQVGiGYYqXXBkm1QHEyOXVg==
X-Received: by 2002:a05:6808:49a:b0:398:1045:17ed with SMTP id
 z26-20020a056808049a00b00398104517edmr8448242oid.54.1686714159084; 
 Tue, 13 Jun 2023 20:42:39 -0700 (PDT)
Received: from localhost ([1.146.66.73]) by smtp.gmail.com with ESMTPSA id
 29-20020a17090a019d00b0025bfa061287sm3820650pjc.53.2023.06.13.20.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 20:42:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jun 2023 13:42:26 +1000
Message-Id: <CTC29HK3ZXQL.2GCE26RLVYS75@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH 06/10] target/ppc: Readability improvements in exception
 handlers
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <edbb93cb67b72bb948155932767ef989cddc8aa0.1686522199.git.balaton@eik.bme.hu>
In-Reply-To: <edbb93cb67b72bb948155932767ef989cddc8aa0.1686522199.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22c.google.com
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

On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> Improve readability by shortening some long comments, removing
> comments that state the obvious and dropping some empty lines so they
> don't distract when reading the code.

Some changes are a matter of taste, but in the interest of having
somebody do some spring cleaning of this code I don't want to nitpick
it, so I won't :)

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/cpu.h         |   1 +
>  target/ppc/excp_helper.c | 180 +++++++--------------------------------
>  2 files changed, 33 insertions(+), 148 deletions(-)
>

