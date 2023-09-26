Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F36B7AEAFD
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 13:01:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5o6-0004ye-Lk; Tue, 26 Sep 2023 07:00:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5nu-0004xm-AD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:00:39 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql5nr-0006Md-3t
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 07:00:33 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so9799952a12.0
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 04:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695726029; x=1696330829; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZvIgzYO3WY23cchAe70jI9rCKkfj5FTQcaFN01GRYw=;
 b=WiQcpCG1pXSHllGUnCd4b6OUw7D31EFhjO8wkaLchPydMWWGJGN5y7mOGUowR9tWV7
 BSrGS7yfCDxY5hIJ1+Ilol4yQ0k5XBgNkLNchGWm16C+zMwczZllBXnxaQq1lMu2U5Id
 08UZGycPF01i157Vo7eGsEvaZu/x557+ubAMMRiNX2NMLE3ni4Rl2XYwNeA9LNYk7DGH
 +fjBGflOuz1vM6RU50bAPwvxZX8gqYVT8IGbHVkZJDnK2fRey61Jx81yMXat99wYdGct
 eMYBZbFLuQQsvOewoq3Fe/UF/N76ewcWabZGZ92pvQAgjsLSwx+7fdNjQ11VFvLlA7+Q
 b5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695726029; x=1696330829;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7ZvIgzYO3WY23cchAe70jI9rCKkfj5FTQcaFN01GRYw=;
 b=dOi2/xKOjxa+Y37yV6udb6zY6mE6jab6X/QBKMd7hxyN72gQC/qsqqwo8H6V3gcPH4
 eNbrLRJTuVFkK5+dimDcTyuMa+mZIuU63mdO6TCfKlbwiKUIQhEOlIXAuxO7e22m7kXo
 jccm+QNw6jUFNNYm6RIzWdbNaMedx7mON7J3rEraI4qte4QjftO2NSnEmFp5Nd22k/Jm
 OK58nH5kk7rCqtw2frRKGfXVrNX3ZcB2KMTtVkfn9/tfDDNEpQBLbCCoEc/puU0tLVh4
 /yvnw04g5+suD1MS8okjh7CJH3DGXR10wGtf3EnP5y0L0Tg2koeitjZmixI8BbSBTCl/
 Kz1Q==
X-Gm-Message-State: AOJu0YzeVIck6z2oPlj7sKgz9Cje66E3PoGbJEcWim93wLPkF7abiXCP
 thGZOpD8zD8lkGn5W4y0hKcIeLacKvUop1Na1ohKSg==
X-Google-Smtp-Source: AGHT+IHOZTrFqi9lC4dtAzGg6sylC5QM7NY3WA/97NRwZhX5nNGJMbfxHpsYIGzyn82iBCQcMzGkIAkfHlqtYelHY0Y=
X-Received: by 2002:a50:ed02:0:b0:523:47b0:9077 with SMTP id
 j2-20020a50ed02000000b0052347b09077mr8174545eds.38.1695726029007; Tue, 26 Sep
 2023 04:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-9-vsementsov@yandex-team.ru>
In-Reply-To: <20230925194040.68592-9-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 12:00:10 +0100
Message-ID: <CAFEAcA889eFarBEnM6xK2p773Xe5mMyN=MvwhPPb6k0P-=Qz0g@mail.gmail.com>
Subject: Re: [PATCH 08/12] block/nvme: nvme_process_completion() fix bound for
 cid
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, 
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "open list:NVMe Block Driver" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, 25 Sept 2023 at 20:42, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> NVMeQueuePair::reqs as length NVME_NUM_REQS, which less than
> NVME_QUEUE_SIZE by 1.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  block/nvme.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/block/nvme.c b/block/nvme.c
> index b6e95f0b7e..7f11ce1d46 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -416,9 +416,9 @@ static bool nvme_process_completion(NVMeQueuePair *q)
>              q->cq_phase = !q->cq_phase;
>          }
>          cid = le16_to_cpu(c->cid);
> -        if (cid == 0 || cid > NVME_QUEUE_SIZE) {
> -            warn_report("NVMe: Unexpected CID in completion queue: %"PRIu32", "
> -                        "queue size: %u", cid, NVME_QUEUE_SIZE);
> +        if (cid == 0 || cid > NVME_NUM_REQS) {
> +            warn_report("NVMe: Unexpected CID in completion queue: %" PRIu32
> +                        ", should be within is: 1..%u", cid, NVME_NUM_REQS);
>              continue;
>          }
>          trace_nvme_complete_command(s, q->index, cid);

A slightly different patch for this one was sent to the list back in 2020 but
apparently fell through the cracks:

https://patchew.org/QEMU/20201208144452.91172-1-alex.chen@huawei.com/

-- PMM

