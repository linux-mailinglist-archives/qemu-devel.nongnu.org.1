Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C097AF502
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:25:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEcQ-00075D-E7; Tue, 26 Sep 2023 16:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEcO-000754-DJ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:25:16 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEcL-00054q-Rg
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:25:16 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5346b64f17aso2345356a12.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 13:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695759912; x=1696364712; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=th8qkzl/daAbQjQQ/cL3C0gpNypwTjBWkqsSFTd2ews=;
 b=elNbeTW9JUDso2puj+f3rmiq3R8j9TDoWd+IpHznFwkD7HUTQgfrHalxJ0QmWHXU2j
 Mucra3DrPKQWqXP75pgzzB+5lyr71BwwWXXlwt6oyXptr/GXODUX8Pd6RfD9ZytjdPTg
 awWz13e0M8ML6htyJvuvJLXIXwizfr02ftxPxtfol6bZWXHlxSr5mr0z+nvueJONEX/t
 dTmzbVtnKOpDTqTXf1Zzx4W2IOr5TezDqPG7Y1pEX9OiEzINjrv4c/ilozlOvE5FuW3G
 2cuUfDntCgvKMsgNvg3lxqdcqfMLQ8f+IQNJJaC24QylcJmMRgFdrR2PRlafBn012hAK
 r8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695759912; x=1696364712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=th8qkzl/daAbQjQQ/cL3C0gpNypwTjBWkqsSFTd2ews=;
 b=PoH/7VECVGcFUWZoTQjFPOK+ImBlj/DWmT7p3nkXiJQo8Tl4dV89+EbTfp4joGEfoQ
 vI2lRZQPW0+zYHYqGcxOgh2w4OVYEilSL11sbMJGuNQFQMCakt/HMlDqUMr1/jJmimA4
 h57k7ZmTszzpGmdlzQeFM5WcX4eJ57Maq0tYJp1P+AmzvTQcgAFJoFll1V/4mKQTdyS4
 YYgXZjgGHL+l5MB98NeIO3yigvH1tRl3Jt1XzHjCoOE7c7AfEzq/oyEcbkuTSMMdTbk/
 ySlggFmA5wpO93PZaJPGXRyUODWGjbc3quZkk653YzGPBETkPRJqLLO8YQWwpSwWuWot
 swDw==
X-Gm-Message-State: AOJu0YyHjkG+f0KTOlWE0+sitHF1GWyjkbwd7sGa9Ls6GT7Csw3lf5XU
 1FJRSmLe/OlDLhNKqLrm2a/xH2e/E4vLbkLRp/WlZA==
X-Google-Smtp-Source: AGHT+IFqJPFR+jjUoX8RzzPzULYEoIu8P5ZpryyyaumBdzGT431RCvIdmZzKSfFJV6l4lNmNhvTPnvyuoJYamRA+fGM=
X-Received: by 2002:a05:6402:6d6:b0:523:4acb:7f41 with SMTP id
 n22-20020a05640206d600b005234acb7f41mr121214edy.14.1695759912033; Tue, 26 Sep
 2023 13:25:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
 <20230926201532.221152-2-vsementsov@yandex-team.ru>
In-Reply-To: <20230926201532.221152-2-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 21:24:53 +0100
Message-ID: <CAFEAcA_9uNKsP-LeSUeiagSqUO5iQxJp5cvBSY-UoUn4gc9Srg@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] hw/i386/intel_iommu: vtd_slpte_nonzero_rsvd():
 assert no overflow
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru, 
 davydov-max@yandex-team.ru, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 26 Sept 2023 at 21:15, Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> We support only 3- and 4-level page-tables, which is firstly checked in
> vtd_decide_config(), then setup in vtd_init(). Than level fields are
> checked by vtd_is_level_supported().
>
> So here we can't have level out from 1..4 inclusive range. Let's assert
> it. That also explains Coverity that we are not going to overflow the
> array.
>
> CID: 1487158, 1487186
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/i386/intel_iommu.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

