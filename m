Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C845756D17
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:23:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTni-0001ll-Fg; Mon, 17 Jul 2023 15:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qLTng-0001W3-4H
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:22:28 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mborgerson@gmail.com>)
 id 1qLTnd-000090-NB
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:22:27 -0400
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-4fb7373dd35so7544018e87.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689621743; x=1692213743;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ouxF9qXoWCUDMaFMA3v/SPSOWglngf66rNGtGadaCg=;
 b=I3xlX6ffBVVUHFz03/7GG83KzLbiN1tmoEXEDLgdzNmPcrIVfvsvFC519QTDLMDf6+
 S/N88SQArloTm6zzni1nz8zAX7DypZ+oI5EvZ161d3lfKYdA2h9juz6/uXk4qvb9SHzv
 8Rdd60pytMcCmEX5XYHIfjD2bAp4u0cP0i0DacVsCj7yvo7aBU2+NOdrZ4Ls/ytliPA3
 FekLeUUIlFPCHZDwAJVqJag1DUIywFXVxQ3dJSiPPHjRbHbD+AGbPoZlxqtz0jV0XCGC
 yArD8p2nMww4RvnG8k/WfYooMZd/jFkhlNc35Q4DSrOS3FWo3DCcrxELuZveTfx2wwUW
 bxNg==
X-Gm-Message-State: ABy/qLb/oQYbd1IQNqR97KjLOPitnU975126go+G0EKwt3L7lhkf1oiP
 lrIJNj38RJ/0yopHhyXPzCxwDYStb6jn4FkA
X-Google-Smtp-Source: APBJJlHABOlgOuiZ84cKvgjlWQ7AULT+WfWnTaIhOVmCi0GoLs8h1eUYyMHtcpXm165v2/vqxmJr2w==
X-Received: by 2002:a05:6512:3d86:b0:4fb:a5b9:98ef with SMTP id
 k6-20020a0565123d8600b004fba5b998efmr4504251lfv.26.1689621743654; 
 Mon, 17 Jul 2023 12:22:23 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com.
 [209.85.208.177]) by smtp.gmail.com with ESMTPSA id
 f25-20020a19ae19000000b004fa039eb84csm49738lfc.198.2023.07.17.12.22.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 12:22:23 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-2b7441bfa9eso60965211fa.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 12:22:23 -0700 (PDT)
X-Received: by 2002:a2e:88c1:0:b0:2b4:677e:1433 with SMTP id
 a1-20020a2e88c1000000b002b4677e1433mr3664969ljk.5.1689621743329; Mon, 17 Jul
 2023 12:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <CADc=-s5F10muEhLs4f3mxqsEPAHWj0XFfOC2sfFMVHrk9fcpMg@mail.gmail.com>
 <20230714142812.244646-1-pbonzini@redhat.com>
In-Reply-To: <20230714142812.244646-1-pbonzini@redhat.com>
From: Matt Borgerson <contact@mborgerson.com>
Date: Mon, 17 Jul 2023 12:22:12 -0700
X-Gmail-Original-Message-ID: <CADc=-s5u40OX0DGoxM62-EWyRqgwuxJb6Uojr71ZTfh3RtTyBg@mail.gmail.com>
Message-ID: <CADc=-s5u40OX0DGoxM62-EWyRqgwuxJb6Uojr71ZTfh3RtTyBg@mail.gmail.com>
Subject: Re: [PATCH] target/i386: Check CR0.TS before enter_mmx
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Matt Borgerson <contact@mborgerson.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.42; envelope-from=mborgerson@gmail.com;
 helo=mail-lf1-f42.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Thanks Paolo!

On Fri, Jul 14, 2023 at 7:28=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Queued, thanks.
>
> Paolo
>

