Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC2CD7AF507
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:26:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEd8-0007oW-Jb; Tue, 26 Sep 2023 16:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEd6-0007mj-UF
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:26:00 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEd5-0005gg-3Y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:26:00 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5031ccf004cso15682897e87.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 13:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695759957; x=1696364757; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3D7SBdeuAjDBnPI4ZKbUT3u/gZaxJVcL2w+MISamGvg=;
 b=qO5ntlKm9aj6eSJ3LrVKeK9F6PK5pBdcBC5hojBsUe+4boX7ib0W2y8Dx3BdwP1tIR
 XreSageZKfGuvvS3s5vkN6IiZpk5DGQV89Mppb8E/JCQxhJ+dzBD9tdtP6Vl8ORySX36
 uSXX9dFF38YEH6b2JjnDG1CrQi7VNL12YPardTgX9KjM6uxyR3lSKWd641eBATokopk3
 XS728JCc5JYY3MA7aDs250iwUwwUkaT4GX+6cROarcExzEK3AEgFhpuXbC/qoVAduwKR
 +s29sOKAY99ifvogFYuEQeYh+AVNUWpKFMIcIKuoiuombGHYXJUjIejvzA1vkDdLgJFJ
 qD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695759957; x=1696364757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3D7SBdeuAjDBnPI4ZKbUT3u/gZaxJVcL2w+MISamGvg=;
 b=uImxU038ikxf3U+83dyIFaHcbwFQ0yqYfvzY+kjp7XwhQbtNVOTpwmPHY1DbwkpBaB
 BO/4H/kVU87r3IPPQfZLYSDoBGvCSKjT6Pk+zA+OMEpZp2BHGcTTAq3WHdjadapNaw9n
 nM1n9f0n27aQTuM2y6hXkdwVIsb5lGhZAjwDzhBwKv0HFyphizX0PtyS8bZ2/BU+FKoQ
 FbSwHVk42792CF+Zzg9VjUKx9E12aCj4j5fmfXtsBBMRQu4CVoZ4CVVn2jeIZO9MRb79
 wpmt2iNtiO9pmvA5K26QNT/JgYIpH/CHOeBaPQM4FV2kS4Wita/NB/sHZmkQ0MFu9MLm
 jwZQ==
X-Gm-Message-State: AOJu0Yyy4kS7aH1KepciPOqywjUOuoUjLxQxods6LWhCMDt1YfFK7EyY
 XZvlvNugjgIQ7NBaCcndrQIHVFqhqDZikSrNjOZrnQ==
X-Google-Smtp-Source: AGHT+IFSgPXK9B2mi9RrMTiwoS1MfTct8B1TBtRKBuOLogGAH7HPstgwxVG69CjVKVy34X7rB/DIYUlAED5YvBrRsKQ=
X-Received: by 2002:a05:6512:1282:b0:503:38c1:c848 with SMTP id
 u2-20020a056512128200b0050338c1c848mr11673805lfs.50.1695759957330; Tue, 26
 Sep 2023 13:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
 <20230926201532.221152-3-vsementsov@yandex-team.ru>
In-Reply-To: <20230926201532.221152-3-vsementsov@yandex-team.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 21:25:39 +0100
Message-ID: <CAFEAcA9ZaXEjEg9A37Nw1pK2pA0da57RkdN-jG_tPoTCZz-6kg@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] util/filemonitor-inotify:
 qemu_file_monitor_watch(): assert no overflow
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, yc-core@yandex-team.ru, 
 davydov-max@yandex-team.ru,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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
> Prefer clear assertions instead of [im]possible array overflow.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> --

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

