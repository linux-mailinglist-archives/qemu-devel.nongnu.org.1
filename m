Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6D078D611
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbL3g-00048G-Lg; Wed, 30 Aug 2023 09:16:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbL3c-00047r-ER
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:16:28 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qbL3a-0001dk-0I
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:16:28 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-570e63f5224so468925eaf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693401384; x=1694006184; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5FP3trPg53yl275kW0nL0asoihxD8JeP8t9DI3qE8Yk=;
 b=DzGxKOL+AqbGHmYhKVDZxOPTwYiZs5S8Di97hIYQaipePMSRaO/uKEX1OxHnB6nwvj
 E3Lwwd8TRsXEdLcmgpJz9J0J01mGFGwKBN0eZFfstHfFczXjHuZSojqMcnrUIN5r5CKZ
 dZcg/oYwQm2UBm0fGirmFjD2Z1+qGtiGGuzYhmlz9GHSufmdbnbMTy6XGm3ucKnbe5lj
 0/2XCdz+HAAeA4OPNWC7qhlggnHvZHJ8b01JT2o53A/dIr8eHlMSZ5kLdRyrBvl27a/d
 Mkc76QcxKfM0ZdCwrtczVIntzDAKgU877nysYMNk3cSGvIRfv0uDeCQIankUEL+qH98I
 AnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693401384; x=1694006184;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5FP3trPg53yl275kW0nL0asoihxD8JeP8t9DI3qE8Yk=;
 b=ezCa+ojsYewnduAnYyp/fUNhlLN+HMYObO6jHhgtJPILBUBYjZNBsrQMwnS4amy/cZ
 6ObCNQuXKDurPuT09avlkKurQfRqTI4VwxZkbCV/6259ACOwbRZ7uJJ9MkRq+1uOpgg6
 oBTwFV/bNx98adMdJgGzlRF38GIjzAUYvbj20dSjBrVSpe9GfW3PDHz8WPOuVh/+Jl/0
 uHqundSCp/XeEt1Wv97OklVXzwMnzcxx8CsUApDNGEeqUtCGLhlRK37yNiBhsY3xq7Tw
 7VvJsJUPPP45LzBdLteSpUtEhxTsy1k+FSrqHCGit5i8RDTGUoytMHf31oyBMB9XqpWN
 eWDA==
X-Gm-Message-State: AOJu0YyWu7npxXTShBNcSl0EhCjuCeeV1LLblm/cp8cBbniThTE/xHKn
 MGL96xaoDYbl71W+oOVumlfpf7dkGPm7XgUiN7g=
X-Google-Smtp-Source: AGHT+IEu6cCasuUcqcy06lnjQc9z5fy4ksKddEwSG6mSvDxGwtyG+aNR7lGmOLgOoEtX/F+0z4Tz3RkmIM0nEB2WVxI=
X-Received: by 2002:a05:6808:130d:b0:3a8:4333:85f2 with SMTP id
 y13-20020a056808130d00b003a8433385f2mr3667707oiv.5.1693401384333; Wed, 30 Aug
 2023 06:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230830022205.57878-1-imp@bsdimp.com>
In-Reply-To: <20230830022205.57878-1-imp@bsdimp.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 30 Aug 2023 09:16:12 -0400
Message-ID: <CAJSP0QVnEswDVbvWU3Zv74L+19De+nTVmzueAP-Lg_zw4E1mtg@mail.gmail.com>
Subject: Re: [PULL 0/1] Quick fix patches
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
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

Hi,
The patch introduces the following build failure:

cc -m64 -mcx16 -Isubprojects/libvhost-user/libvhost-user.a.p
-Isubprojects/libvhost-user -I../subprojects/libvhost-user
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu99 -O2 -g
-Wsign-compare -Wdeclaration-after-statement -Wstrict-aliasing
-D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -fno-strict-aliasing
-fno-common -fwrapv -fPIE -pthread -D_GNU_SOURCE -MD -MQ
subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -MF
subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o.d -o
subprojects/libvhost-user/libvhost-user.a.p/libvhost-user.c.o -c
../subprojects/libvhost-user/libvhost-user.c
In file included from ../subprojects/libvhost-user/include/atomic.h:18,
from ../subprojects/libvhost-user/libvhost-user.c:53:
../subprojects/libvhost-user/include/compiler.h:38:40: error: missing
binary operator before token "("
38 | #if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
| ^

https://gitlab.com/qemu-project/qemu/-/jobs/4981576093

Stefan

