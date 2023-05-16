Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F2E7049E3
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 11:58:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrRA-0006kb-Fx; Tue, 16 May 2023 05:57:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrR8-0006jc-Ob; Tue, 16 May 2023 05:57:42 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1pyrR7-00023E-4J; Tue, 16 May 2023 05:57:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-643465067d1so10225324b3a.0; 
 Tue, 16 May 2023 02:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684231059; x=1686823059;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJkIZNrVjaASDJUQ+bUBib55SB4501PNJn1iicFU6kg=;
 b=oAEIrjV/9ziVY+WsBD6Rf2RmEtq3h6XK1ws3lij52DfTc72bOvK/nPOIKPutGHWTZZ
 YcC0PQqCe1NUlAec6JjnaoIFm8uLs6yI3j0oOjOMo3LuX5fTDZ31ji/6uLyZ9DROOAVC
 viV1WoZCAxxxvmQ8h4m6W1AW0lLV8d3kkshwrihLqIfPatIblmGWjI7rTi71Epu1C/U7
 B/eclzsXNWzb/ZRzQ/Skgf2FNfYMzZMpK6gOz5JWTQ+A6gZennXbY1IWnryaevjISDeZ
 Xs+oErRe2dtEOBtyNObWgqdX34g9qVUf6fPQ+fOAn4BnjYAi0Ei2lCxKGidqN8Db1Tbl
 K1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231059; x=1686823059;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OJkIZNrVjaASDJUQ+bUBib55SB4501PNJn1iicFU6kg=;
 b=IBDfnaoAEQ2iutJGsR9syPxlyV6MPgjerVTrAQDmJCMkaPwSqKS3Y9n7NcH7cTswAZ
 6HL0MtmXsCo445ILUymjxZ0TnQGZX15LMxbwo3P3BCs5Dv9lE56nSpHn9lx/3XlXEyl5
 ynNdyOCRafUAuwmK2oNjR3f4l5Pb2kWYr8DFuUB76Ll+Me+iyCb82k1FGdI9NGvF+FB5
 qYTzLEdPPl3umyh2Te/ciCYaDKXg1xeGE99c1rp9RVSMMcp8pN12DV6+uZ4TNb+StHrH
 kfvzlUjSSco5Od77yPXGY+3gA/NDJnVGNt6rrquGd9COaLeTKXxANdiindP/T/VN4OF1
 YQHA==
X-Gm-Message-State: AC+VfDxvymhafH+qC9JhBidJ4zD1nBQ/YHHWpfOBBRxw9LCXfap/kFZc
 yLdvhsHv0VbFFs72bIFrwkU=
X-Google-Smtp-Source: ACHHUZ75KXADda5HTbJ3NvkKVWlK2GiUDOiJnvJuRNFOTMZ9WQVrv2ikdnnxQyHlS344w9RzUBLMbg==
X-Received: by 2002:a05:6a00:2e26:b0:64c:c5f9:1533 with SMTP id
 fc38-20020a056a002e2600b0064cc5f91533mr1103864pfb.33.1684231059343; 
 Tue, 16 May 2023 02:57:39 -0700 (PDT)
Received: from localhost (203-219-189-129.tpgi.com.au. [203.219.189.129])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a654387000000b0052873a7cecesm12556797pgp.0.2023.05.16.02.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 02:57:38 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 16 May 2023 19:57:34 +1000
Message-Id: <CSNM2WXID5Q1.31EUVHXGPD66F@wheely>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Harsh Prateek Bora" <harsh@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] target/ppc: Add POWER9 DD2.2 model
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.14.0
References: <20230515160201.394587-1-npiggin@gmail.com>
 <5b7f36b4-99f5-cba5-9c16-fc03457137b5@kaod.org>
In-Reply-To: <5b7f36b4-99f5-cba5-9c16-fc03457137b5@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Tue May 16, 2023 at 6:44 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/15/23 18:02, Nicholas Piggin wrote:
> > POWER9 DD2.1 and earlier had significant limitations when running KVM,
> > including lack of "mixed mode" MMU support (ability to run HPT and RPT
> > mode on threads of the same core), and a translation prefetch issue
> > which is worked around by disabling "AIL" mode for the guest.
> >=20
> > These processors are not widely available, and it's difficult to deal
> > with all these quirks in qemu +/- KVM, so create a POWER9 DD2.2 CPU
> > and make it the default POWER9 CPU.
>
> I would remove power9_v1.0 and power9_v2.0 (not shipped AFAIK) and maybe
> add power9_v2.3 since it has a little more features.

Yes to removing DD1 (and for P10), and adding 2.3. Not sure about
removing 2.0, we carry this radix MMU prefetch workaround thing for
2.0 and 2.1 in upstream KVM which causes some of this AIL-3
complication.

Having a 2.0 model might help with that, and if it doesn't cause
much effort to maintain I'd like to keep it for a bit. Can remove
it if upstream KVM drops support or it causes problems.

Thanks,
Nick

