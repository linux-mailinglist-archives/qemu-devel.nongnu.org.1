Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB7B752A3D
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:16:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK0qw-0004xP-Tm; Thu, 13 Jul 2023 14:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qK0qu-0004xG-Rf
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:15:44 -0400
Received: from mail-il1-f171.google.com ([209.85.166.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qK0qt-0001md-Cd
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:15:44 -0400
Received: by mail-il1-f171.google.com with SMTP id
 e9e14a558f8ab-345a76c3a2eso4214855ab.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 11:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689272142; x=1691864142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pBrSewqnDnU2j+HNkbFUuogXg7pBxGZSOSqYBUnF0Ao=;
 b=Hglvz5JsehzHdIaSwr7Y49VgJ44Cbbf9P5AyPMX8h9gk0C34xCNEk2IxmAWW6hnKO6
 O/Y8EQq0OS2q9/FEWEMCk4x8U5yYlvai9f5BOIr6dOXpiIe5xHY9+QhbLkFTWeDDDJoW
 0GIZigFNJmAg7PlcA19WFxmHJJzMTwsCaEYYzXB+raJcXMXyGmUZYbT6my8F+Yk5s1az
 I1IKUu/we9vTWfJudko7AIYyfp50ARe1vWfLnuJmIWdyDQsSURtflHINL4tsmXUaFeuu
 pykET+Vu8DPz2ra3rntdMyB79ta5nvBukloKxs0tgKAMXGIHM4+iGrVbZE/DdLwaB22P
 sjnA==
X-Gm-Message-State: ABy/qLbbeomVN5dsW19jWYNx6zq3O26lU0PGF9oLnpP3kdb9+FzZCoR5
 RhXh93lwHw2fE4PRQSraRtEX99Qk3yw=
X-Google-Smtp-Source: APBJJlEirXTHHKndWBQ70HPw7VjmDmPbDEPWm8iYL/S1VdOSBa+qI7C7t3wPszV3bwLSdP3SUoUnjA==
X-Received: by 2002:a92:cf51:0:b0:32c:9c5e:900c with SMTP id
 c17-20020a92cf51000000b0032c9c5e900cmr2185118ilr.8.1689272141751; 
 Thu, 13 Jul 2023 11:15:41 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com.
 [209.85.166.173]) by smtp.gmail.com with ESMTPSA id
 y4-20020a920904000000b00346097ca74dsm2135698ilg.71.2023.07.13.11.15.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 11:15:41 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id
 e9e14a558f8ab-345a76c3a2eso4214815ab.2
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 11:15:41 -0700 (PDT)
X-Received: by 2002:a92:d1cf:0:b0:347:712c:dc9 with SMTP id
 u15-20020a92d1cf000000b00347712c0dc9mr1805862ilg.22.1689272141320; Thu, 13
 Jul 2023 11:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-10-j@getutm.app>
 <78bd19ff-709e-d152-ffe0-5d50ecb693c5@linux.ibm.com>
In-Reply-To: <78bd19ff-709e-d152-ffe0-5d50ecb693c5@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 13 Jul 2023 11:15:30 -0700
X-Gmail-Original-Message-ID: <CA+E+eSC0M2CnOyX_EpF=FZX5yeKBsj=vh6+9T_sNV-NtGLs20A@mail.gmail.com>
Message-ID: <CA+E+eSC0M2CnOyX_EpF=FZX5yeKBsj=vh6+9T_sNV-NtGLs20A@mail.gmail.com>
Subject: Re: [PATCH 09/11] tpm_tis_sysbus: fix crash when PPI is enabled
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.166.171; envelope-from=osy86dev@gmail.com;
 helo=mail-il1-f171.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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

On Thu, Jul 13, 2023 at 9:49=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
> The tpm-tis-device doesn't work for x86_64 but for aarch64.
>
>
> We have this here in this file:
>
>      DEFINE_PROP_BOOL("ppi", TPMStateSysBus, state.ppi_enabled, false),
>
> I don't know whether ppi would work on aarch64. It needs firmware support=
 like in edk2.
> I think the best solution is to remove this DEFINE_PROP_BOOL() and if som=
eone wants
> to enable it they would have to add firmware support and test it before r=
e-enabling it.
>
>     Stefan
>
> >   static void tpm_tis_sysbus_class_init(ObjectClass *klass, void *data)

Yeah, I'm not sure if PPI works with AARCH64 since I didn't bother to
change it to not use hard coded addresses. However, isn't that "ppi"
overridable from the command line? If so, should we add a check in
"realize" to error if PPI=3Dtrue? Otherwise, it will just crash.

