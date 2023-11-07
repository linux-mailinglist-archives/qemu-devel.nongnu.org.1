Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1210E7E3A34
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:45:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JZR-00074f-Nv; Tue, 07 Nov 2023 05:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r0JZQ-00074F-Bu; Tue, 07 Nov 2023 05:44:32 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1r0JZN-0000tm-Vs; Tue, 07 Nov 2023 05:44:32 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5b8f68ba4e5so3437810a12.1; 
 Tue, 07 Nov 2023 02:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699353868; x=1699958668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKGTx1OsHxnRnBoY1fAB3133mReBCOEEXUatdlnsdSM=;
 b=Oon7YCvdWDoN9bBFEflCfMS7uYYjYb58DPIfte/YILjAiX3flp72ojjNNwArfXYk5s
 rQK4XIZH/MZgxDLJntCuIwfFWBWafr0lqdc825Fs92v7cFGRM1ZNYcUHddKvLP+PTjpa
 WfyTZnIJBOywkDnSbv1epU8y6hlWU1Wrxok8w12nihuAJdbdmKP49lCDLaBrz+9Frw6s
 Hkiam1CpsLbe6BBQbw/w0R0rluLe5CpFSLeQCzUfOVQPcIzSRK3ea8d7xWYGDQWrwRab
 HuDRkbxn03YGmzN1asgxGVVGImUft5GA2sr75hn0XYwORPJhOAhZ7UdK/PlzndtmkSb6
 7lVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699353868; x=1699958668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gKGTx1OsHxnRnBoY1fAB3133mReBCOEEXUatdlnsdSM=;
 b=GY7Y1lPQpkSrIZkmx5tYbeQj+rA+bnougcoh0PNvugDYVFTj1T2U1ibeZ2xH4Yx1MY
 5fLoPyG3Zmjyg/+yx19nqH3d0B+BupTzNW7B7PKSBZrgYQzBkys0mCw3QypvFjKuU+km
 Lwfni5GRE1R33tPSgoobVaec3NhYzu4F8B1eKMJkgx9M6qn1JrRmavxzkOWvqUb/ZAAR
 Xevqw/56z9t8MH93GR6Z/5217Xx/9BsMay3FAoDtkLHdosorvv+UWcslbPsKQZcoLUSN
 9lTDQ8w+zQGCci0LkmgQa/K9oqzouG5xliuF549tzdAlyKGa1srXktswtBDH6GbYFRHg
 laFg==
X-Gm-Message-State: AOJu0YzHXYN1LJIQvZkicosFaEFk965c0+ZJpaumaq4tecjwzC1CQ3OE
 7IVeC14iPpYYHRjLVUMHn0GkmnytfkSK2bZ6fOo=
X-Google-Smtp-Source: AGHT+IHjatSTBUzqQKax3QOae0Qu/chNDKah/QcrSFhOppO5VP9Ewu5c1DAXhKpNZowZTBi0kl7Zb4WbL+YygY/KgaM=
X-Received: by 2002:a05:6a21:4983:b0:181:1549:f1fa with SMTP id
 ax3-20020a056a21498300b001811549f1famr9802132pzc.28.1699353867711; Tue, 07
 Nov 2023 02:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20231107102104.14342-1-thuth@redhat.com>
In-Reply-To: <20231107102104.14342-1-thuth@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 7 Nov 2023 02:44:16 -0800
Message-ID: <CAMo8BfKAwHJLK44FjJ_bCK7tkQjvM=USpu_jL+0jAk2ou+Bscg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add include/hw/xtensa/mx_pic.h to the XTFPAG
 machine section
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x52b.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Nov 7, 2023 at 2:21=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> These machines are the only user of the mx_pic code, so the
> header (which is currently "unmaintained" according to the
> MAINTAINERS file) should be added to this section.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Typo in subject: s/XTFPAG/XTFPGA/
Otherwise:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

--=20
Thanks.
-- Max

