Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A594172663E
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 18:45:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6wH1-000396-J2; Wed, 07 Jun 2023 12:44:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6wGv-00032U-Gs
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:44:33 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1q6wGu-0000cj-2I
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 12:44:33 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5659d85876dso81023667b3.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 09:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686156271; x=1688748271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2/NpCBKT977NNTn8Nhd+tZRbixprj/kv3ntatgVGgr8=;
 b=suwCASS0czjuXT/2RqCZ3ctxORWO9t089zgFQdtDMVUfDWb2X9Tl1cNK317v8xEt8x
 +ySZI9xUrcJ+01qRpw8GXxnlvywbsACOlzIWcAwg8/o9jcvynl9oiTJQLLEJm5FWDEr5
 aXv2pEfWsCt7aUMaSLGO3SOQxPBUFZk+sap3jXZ8hRhZuErLzgGuVGsfTVm0huqDh5jv
 s6webi/vTqQCo7jgmsed5bdvFMoJYNHZed2iwt33nfkKUP6OfpbwQq+AIxtn8BrPWvTA
 g5AMNTWD42+EOpw0gwTcf8T/gvRzyhdHySphnhASzSgmyK+eQI9UK+P4x8VFchBQ5Rcz
 2oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686156271; x=1688748271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2/NpCBKT977NNTn8Nhd+tZRbixprj/kv3ntatgVGgr8=;
 b=JWDqPLDZxbFSd90avYF0H5SzS8kJwM9ERiPiaUYHtPZQYtrUU1GhoHlJG4Zns563/U
 c4m7YEc2czkVnAA5n7hQbCM0cyELu2zpjzqInSiexpVrGBaDC2/kD5ZWRbPqnFV2Dt1F
 Bxa1bYF8w7xlLGt0G1jfM5zD6itTZD3thVWnlMxWCa/xirQPUbszg5LAxZ6qypO1XI/u
 fHtxdgAmwy8qfH/2kKDQFOUmnXXV1q7fYxOwLz4nOnSLQsTp9sjIk4yk+tzJDY1bG7Bh
 xtV4UlWa/conrSpQ/jo9TMdFJ6H5+Sup4NgzRvOh6dYPSk1LgGmgj+/pXyOKvNu8Lse9
 BwGQ==
X-Gm-Message-State: AC+VfDwJLTXaUHjR6mrPR9Pj6KyVEW7SPnY0VJBaktwTOnmPiK05YiNg
 P4RI+LR9AsUE6huQ1tbcb8r3W5rXxGliMKxB3SA=
X-Google-Smtp-Source: ACHHUZ5fvEkjAsLhphSIzeFOw40ju+xis7+DcOrueZoGhr6NC1L+nqcKv30ygI692hpnJDiatjem7mvSftxZIhxCWNE=
X-Received: by 2002:a81:6a46:0:b0:568:d63e:dd2c with SMTP id
 f67-20020a816a46000000b00568d63edd2cmr6700862ywc.11.1686156270685; Wed, 07
 Jun 2023 09:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686153256.git.jag.raman@oracle.com>
In-Reply-To: <cover.1686153256.git.jag.raman@oracle.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 7 Jun 2023 12:44:18 -0400
Message-ID: <CAJSP0QWBYHY9g1dGSZYgwVJ6cojfJquK=q1ePcFzvZwkYxx7Cg@mail.gmail.com>
Subject: Re: [PATCH 0/1] update maintainers list for vfio-user & multi-process
 QEMU
To: Jagannathan Raman <jag.raman@oracle.com>
Cc: qemu-devel@nongnu.org, elena.ufimtseva@oracle.com, 
 kanth.ghatraju@oracle.com, karl.heubaum@oracle.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=stefanha@gmail.com; helo=mail-yw1-x1133.google.com
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

On Wed, 7 Jun 2023 at 11:58, Jagannathan Raman <jag.raman@oracle.com> wrote:
>
> John Johnson doesn't work at Oracle anymore. I tried to contact him to
> get his updated email address, but I haven't heard anything from him.
>
> Jagannathan Raman (1):
>   maintainers: update maintainers list for vfio-user & multi-process
>     QEMU
>
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

JJ's last email to qemu-devel was in February 2023. Since he no longer
works at Oracle, his email address is probably no longer functional.
Therefore, I think it makes sense to remove him from MAINTAINERS for
the time being. If he resumes work in this area he can be added back
with a new email address.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

