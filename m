Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E55DF7876CA
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 19:20:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZDzU-0006N1-Er; Thu, 24 Aug 2023 13:19:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDzS-0006M8-1J; Thu, 24 Aug 2023 13:19:26 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qZDzP-0007de-SF; Thu, 24 Aug 2023 13:19:25 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4ff8f2630e3so40876e87.1; 
 Thu, 24 Aug 2023 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692897562; x=1693502362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1gCuhIL1XrnzMeV57kjeHdPqmzuo95O6XpBSOGDYEoo=;
 b=VbXu+MnCQbbdVJ2icNghqNrdsPQcAhCadqt7tOlC84pvTVWg676kaRUCTRfPxm0rAP
 Him77BBvjwi6yRjGzpZUEHV9LNw/5scJPS9k2DwGPt6v+1S45Ag33t+0Nuf1rHsfPC5/
 4oCnTP4DdT95HVcDT8Cy3GtXoD8g1tuXAI+RvikPof+s/tIxPiiG47Q8Qmd9n/lIxHsH
 V8AQ2rMvYIVrP4LP4xbR0i8pRQJxbWNBe0l2Ctbeopdc3HhDg7r60SgzPt4rvD9AMcdk
 x+2H5Il7FHmszkBHocwyY1tWni7yjOlIpkye0b248v/dkSAhy/80ouKaGn/QX+zoJdRs
 6VLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692897562; x=1693502362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1gCuhIL1XrnzMeV57kjeHdPqmzuo95O6XpBSOGDYEoo=;
 b=cumFiGOhkenYFXaaCsrRaB/K14wqhgiMlMLr4gF30FBDEeBbj5Ve3XhtpltXJlLyZg
 AO7zaqkoUL4TWmY732MeHbMmB2u78TdDDgbh0uFKAFHt5Eqp8Pd5cVJt+XFPN+X/O5IR
 QzYU1g9z+1iIGdWkVKkH7iHSSFn+2uFEMei9++DZa6ib+24NLDSv1u/mdfAm6/6sC/mr
 SWQSNX+CTUV1BmzJc+8e+Ewbm+DHZ+6y/eMAbhTRgGSbPEZlD1I4J6ZZ6X9nefc2QneF
 EfKCiuSjTZGE4UCzTZ4EgXqJPzgWNSdgZRRojiLL2iurWKt0/LjkiK0+GcGdu8Avsmcv
 dbyA==
X-Gm-Message-State: AOJu0Yxsl3a+HffFx2bn+jwJsCIeQL6EAQydYR6S64zeqkVHe877CRru
 17WKLrzmAo45tX2rJL2LDBFRgWr4Ztlnsbds21Aw2mkHfvzmk8hg4SY=
X-Google-Smtp-Source: AGHT+IEppVErHZGl80lt8//H2di+TP9a1UR6u6ldMI0AHPIRIaO9BV2AA7McS+O7ebmp0FJv7hSznMwZxsjtAWFLA1o=
X-Received: by 2002:a05:6512:3150:b0:500:9d4a:8a02 with SMTP id
 s16-20020a056512315000b005009d4a8a02mr2097082lfi.62.1692897561050; Thu, 24
 Aug 2023 10:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230824155345.109765-1-hreitz@redhat.com>
 <20230824155345.109765-5-hreitz@redhat.com>
In-Reply-To: <20230824155345.109765-5-hreitz@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Fri, 25 Aug 2023 01:18:52 +0800
Message-ID: <CAAAx-8LB0Nby_YzBX+D1AsKKFgXSEXp3+OEiOY9uzrZVkE1AXQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] file-posix: Simplify raw_co_prw's 'out' zone code
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=faithilikerun@gmail.com; helo=mail-lf1-x12f.google.com
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

Hanna Czenczek <hreitz@redhat.com> =E4=BA=8E2023=E5=B9=B48=E6=9C=8824=E6=97=
=A5=E5=91=A8=E5=9B=9B 23:53=E5=86=99=E9=81=93=EF=BC=9A
>
> We duplicate the same condition three times here, pull it out to the top
> level.
>
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>  block/file-posix.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Sam Li <faithilikerun@gmail.com>

