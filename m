Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B28070BBB0
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 13:24:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q13dq-0005w4-Ij; Mon, 22 May 2023 07:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q13dn-0005vm-Ak; Mon, 22 May 2023 07:23:51 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q13dl-0001cQ-NJ; Mon, 22 May 2023 07:23:51 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-561a41db2c0so78440497b3.3; 
 Mon, 22 May 2023 04:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684754628; x=1687346628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5qRXVuOeTZ8PUPRLaL7V8kBq8WePH9B/7MOaTDypW1c=;
 b=GMJzc3lmPs/rtJTEyXq9QmYedRK014Dp1H6u3e+qZyohCQqxXwM2p6xg9U86yYaYR4
 NcCmvSX30NCYO5BnhQ4gZttsZaCH3vMaMF5PGLMKmwqsAh4XqO9+kU0PFSHGNRC3eLiQ
 COqYyFPEYXAS7ysBw5GUDUogqBrqpVxA06cTdVYfDMzllRlq6UVZsCV99u95mA8qfsrI
 tYBVZcSUGSQ0Y81r41cn+6QD6NtomuSeepZHZHpal3ebLxeKHoHauHOj996kKe9LrSKN
 LD4ehkfkYSXNJ+hcR6uP0FPwPoi8QDaMCn5SiGUY+Wnhnpb5tVD3FsCWDIF3OpvwJPp5
 B9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684754628; x=1687346628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5qRXVuOeTZ8PUPRLaL7V8kBq8WePH9B/7MOaTDypW1c=;
 b=NF9jSHVriHFUISxLXrJGm8T+iAb2TNXbEglbukjmKovdrfdfWynRBMp9JaYjRiAcGD
 8TDcS29BvnSu28s1SnHMFjNcDceEGHXjV1u3R5cz6VF/80mETQIdiSSRC82HlhesgN+m
 5moA6O0xArQaTNN1i5zg98GWJ0CXfkaZdChuF4asq7qSRK7reHFAi1Rd8Wx2cY3MOxXG
 kmjgS/l3WljsevoSXxs0n05h1gppZ7IQkDKsAkEYJlxwBt3LrK4q8lIqVmhB0i2EGU5A
 OEB4n942CbD+mjM9MKTEZB+F158WVSunbkuP6B07yJyOGxbLV4Zs/vXo7aP15f/bxbBo
 +pMw==
X-Gm-Message-State: AC+VfDxLRegZvuDbMY2mqYCiJGrqk57pRh6joCHkNIx7GKlHeadajs79
 pA1oze0yfGkD9R6WWd/2t3V4E/jqL4Prrq1ghGc=
X-Google-Smtp-Source: ACHHUZ4IduCdkPf9BmtJKNeA1giU2pARnzO7drwKFLJStUbtcPBSfweZLx57wy3eSZ5YOBjo6nLshje85Ah7lSvwn2k=
X-Received: by 2002:a81:7405:0:b0:561:cb59:15d4 with SMTP id
 p5-20020a817405000000b00561cb5915d4mr11513626ywc.28.1684754627790; Mon, 22
 May 2023 04:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230522091011.1082574-1-thuth@redhat.com>
In-Reply-To: <20230522091011.1082574-1-thuth@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 22 May 2023 07:23:35 -0400
Message-ID: <CAJSP0QXG=PrPmpzrn8jyEC6G31A5w+0Cz_O4Tf=SxJbrkmnPjA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, 
 Bandan Das <bsd@redhat.com>, Darren Kenny <darren.kenny@oracle.com>, 
 Qiuhao Li <Qiuhao.Li@outlook.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x1129.google.com
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

On Mon, 22 May 2023 at 05:11, Thomas Huth <thuth@redhat.com> wrote:
>
> We cannot use the generic reentrancy guard in the LSI code, so
> we have to manually prevent endless reentrancy here. The problematic
> lsi_execute_script() function has already a way to detect whether
> too many instructions have been executed - we just have to slightly
> change the logic here that it also takes into account if the function
> has been called too often in a reentrant way.
>
> The code in fuzz-lsi53c895a-test.c has been taken from an earlier
> patch by Mauro Matteo Cascella.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1563
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2: Add a comment about the reentrancy problem to the source code
>
>  hw/scsi/lsi53c895a.c               | 23 +++++++++++++++------
>  tests/qtest/fuzz-lsi53c895a-test.c | 33 ++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

