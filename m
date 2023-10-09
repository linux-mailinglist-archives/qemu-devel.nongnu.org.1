Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E15F7BE29F
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 16:23:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpr8n-0005i3-SJ; Mon, 09 Oct 2023 10:21:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qpr8m-0005ho-4C
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:21:48 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qpr8k-0000M8-5n
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 10:21:47 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-57bb6a2481fso2173024eaf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 07:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696861303; x=1697466103; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G6Dmn+gIc/izfE4aO3wcEJfuDwv49qHA6lV8GfVbPXw=;
 b=JZ+QDWE78/P+FhC9X0pCSMkbJ7yiYvyNhAG/U3rRWzHwiatCzIZvtyLT2wMosGYGQZ
 AkqZZ7EaIyRcKsOiXAF1fgKPXaORakp/59UPNI4om0JDwCRIW5ABKNSt6tImR37RDMwC
 JuZUY7RS9KdTi5VMbVL2GxFmGo0mqfqEinZrCVsa38poGHE6naDWmAucnw+qM+05FkX7
 5thpHbXNYJUR03qv54ejy/JQ1IUPhQJYnOsTxItn1+EbUCcpFqwzzTI230XlJimybc4L
 lAB90ghDC5L7CsM42GAk9atd+p4PPsGEjrnToES+20AA4lmt4/ikt4O5AGTZvweL2sKO
 TFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696861303; x=1697466103;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G6Dmn+gIc/izfE4aO3wcEJfuDwv49qHA6lV8GfVbPXw=;
 b=H5xThKtfIPzXK9xxn5I+IJXibWPFyONm8tJSAPvyPbuesL8QTqcRGJHqOVKY6qHWyk
 MOTl/lXLOULE7ZqB1bpakXCjIcCgf1dD63G2eHKqYVNx2on6vwpao7QfG4VJCkP2nitC
 RU7wAwDk3T9Gmk1sbXkOzZottkZ4D3qfZ6PdS2ejRcbStRhrz4z4Uu/SR6jra+Nc2TeH
 acDLbfyA9VsZu2XRHHs1/bcYo1eUWHE9xkniemWQZUXVAwy6fI2pWFPsDiL5rcIV575r
 Bw2fc1MReUebBSsY7hcoB/yW4w2GZCTiLKBqUqPTE1FkAaFDYPghz9DDer7gaGqglQp5
 UJfA==
X-Gm-Message-State: AOJu0YzA2A4UtPquagKnUtYUF7mSlSuKkHW2vlEgVml9OtGPxnIH1rmq
 gQkN+jJEipzJwDIYikC2m21BDUdZWbaK25587fACV5X65nM=
X-Google-Smtp-Source: AGHT+IFcGoRm+7xLgJZp+hKeXibnv/7SZAAoFPAiPG3HhlVMmXEPbzy4zPoAc2Ga0AE9j4+zYAT4EL9zm0so9tNQP9A=
X-Received: by 2002:a4a:6c02:0:b0:57b:8f92:aefb with SMTP id
 q2-20020a4a6c02000000b0057b8f92aefbmr12726688ooc.7.1696861303444; Mon, 09 Oct
 2023 07:21:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1696855875.git.yong.huang@smartx.com>
In-Reply-To: <cover.1696855875.git.yong.huang@smartx.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 9 Oct 2023 10:21:31 -0400
Message-ID: <CAJSP0QVgdmViSEzYuNqEt5kcp1Q+jjGgXuGcUkC5iUPF0GTUUA@mail.gmail.com>
Subject: Re: [PULL 0/2] Dirty page rate and dirty page limit 20231009 patches
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2a.google.com
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

On Mon, 9 Oct 2023 at 09:02, Hyman Huang <yong.huang@smartx.com> wrote:
>
> The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:
>
>   Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20231009
>
> for you to fetch changes up to 84719f6d0b75448400068adb78d85000e884f0cd:
>
>   migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time (2023-10-08 15:06:12 +0800)
>
> ----------------------------------------------------------------
> Dirtylimit and dirtyrate 20231009 patches PULL request
>
> Dirty page rate measurement optimization.
> Please apply, thanks, Yong.
>
> ----------------------------------------------------------------
> Andrei Gudkov via (2):
>   migration/calc-dirty-rate: millisecond-granularity period
>   migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time

Please adjust the author email on these commits using "git commit
--amend --author=Andrei Gudkov <gudkov.andrei@huawei.com>" and resend
the pull request.

Sometimes qemu-devel delivers emails with "Name via
<qemu-devel@nongnu.org>" in the email From: header because of the
sender's email server security configuration. When this happens it is
necessary to fix the author email in the commit or to apply the
original commit that has not been modified by the mailing list (e.g.
lore.kernel.org).

Thank you,
Stefan

>
>  migration/dirtyrate.c | 122 +++++++++++++++++++++++++++---------------
>  migration/dirtyrate.h |  12 +++--
>  qapi/migration.json   |  58 ++++++++++++++++----
>  3 files changed, 134 insertions(+), 58 deletions(-)
>
> --
> 2.39.1
>
>

