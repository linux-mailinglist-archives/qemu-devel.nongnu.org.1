Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A50B47030B0
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 16:56:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyZbl-0007WY-O2; Mon, 15 May 2023 10:55:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyZbj-0007WI-Vb
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pyZbi-0002jy-6d
 for qemu-devel@nongnu.org; Mon, 15 May 2023 10:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684162525;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qgTjbEdhnjrIv9TRDfcMehEJEwDTdurj7551gtA6ZXg=;
 b=YIJeGgteMJMvTy0SQTGvBOiHwDKX2flLNUOztwga8c1Rf8dmlyNC9yn+IVGASjuGWxvwc8
 47GzNoAkV3nIqQkdXFEl2klujwtHauKg8Occq4R56GMElXmUkTPw24KpgY4q4HK9Nsbj1Z
 YO9x1qMLuFe46TukAm9KjFfT1yDllFU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-9my-uMxOPyixRSqHZsJaiA-1; Mon, 15 May 2023 10:55:23 -0400
X-MC-Unique: 9my-uMxOPyixRSqHZsJaiA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso30556885e9.1
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684162522; x=1686754522;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qgTjbEdhnjrIv9TRDfcMehEJEwDTdurj7551gtA6ZXg=;
 b=dyiCgSOJLjx+IzwTy3kuIOz7BxXHfLl4QY555Ag/gfso8ekhHkA5VGI2wzpxGx4r98
 E2C1pq9ClgIYio6AbrhSWkwTALRIuIVrmTLlNPNidiNxMXddc6dlDS87dq++q+CDqZvn
 27CnGIgcB8OPcGwdTvR2R+/TaelLLsvtgAAiNA1nMGYZn1CtgWZZIaLBJnncSmvJu+rs
 GFVfVwBS5jozal0r2DEFDvU/dhsyfUtzrxfFPo+MJijtHFqt6wRjYSd8qcfICsuUpMLh
 LRClST9E+iPDzeWseVKwU3173sab+SGX/gxecZUXxyRjOsUOb7wH1C5P/DTOohWlde6Y
 /+bg==
X-Gm-Message-State: AC+VfDzuyz/3hGHhQQz1EISYkpuSjTST19oYTpEhEa2MuzZ6OMlYDJj6
 lQOQCS6xBccdsWuCKlJZ6l8D3rgy/FrTVFFcdBxmFP14Oz84sJ9wSaLmlhAFcVgn0dj5DVF9odG
 nNFjC3NxkVIZThbg=
X-Received: by 2002:a05:600c:b4b:b0:3f4:2897:4eb7 with SMTP id
 k11-20020a05600c0b4b00b003f428974eb7mr16200414wmr.38.1684162522682; 
 Mon, 15 May 2023 07:55:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Dzmd3WgNzcJSm1yHH/2CFVwSaCB3hkULjM84UB+4e66WeHQT4JHLPeqPBFoeVg3bJE11qiw==
X-Received: by 2002:a05:600c:b4b:b0:3f4:2897:4eb7 with SMTP id
 k11-20020a05600c0b4b00b003f428974eb7mr16200404wmr.38.1684162522398; 
 Mon, 15 May 2023 07:55:22 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 l2-20020a1ced02000000b003f19b3d89e9sm37421106wmh.33.2023.05.15.07.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 May 2023 07:55:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  jasowang@redhat.com,  philmd@linaro.org,
 thuth@redhat.com,  berrange@redhat.com,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  leobras@redhat.com,  peterx@redhat.com,
 zhanghailiang@xfusion.com,  chen.zhang@intel.com,  lukasstraub2@web.de
Subject: Re: [PATCH v5 0/3] COLO: improve build options
In-Reply-To: <20230515130640.46035-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Mon, 15 May 2023 16:06:37 +0300")
References: <20230515130640.46035-1-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Mon, 15 May 2023 16:55:21 +0200
Message-ID: <87lehpy78m.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> Hi all!

Hi

Queued the three patches for the next migration pull request.

Thanks.

>
> Most patches merged, thanks to Juan!
>
> Here is remaining three patches.
>
> 01: update commit msg, add r-b by Zhang,
>   - patch is unrelated to 02-03, may be merged in separate
>
> 02: fix missed invocation in migration/rdma.c
> 03: fix reversed assertion
>
> Vladimir Sementsov-Ogievskiy (3):
>   configure: add --disable-colo-proxy option
>   migration: split migration_incoming_co
>   migration: process_incoming_migration_co(): move colo part to colo
>
>  include/migration/colo.h      |  9 +++++++-
>  meson_options.txt             |  2 ++
>  migration/colo.c              | 43 ++++++++++++++++++++++++++++++++---
>  migration/migration.c         | 30 ++++--------------------
>  migration/migration.h         |  9 +++++++-
>  migration/rdma.c              |  5 ++--
>  net/meson.build               | 13 ++++++++---
>  scripts/meson-buildoptions.sh |  3 +++
>  stubs/colo-compare.c          |  7 ++++++
>  stubs/colo.c                  |  6 ++---
>  stubs/meson.build             |  1 +
>  11 files changed, 88 insertions(+), 40 deletions(-)
>  create mode 100644 stubs/colo-compare.c


