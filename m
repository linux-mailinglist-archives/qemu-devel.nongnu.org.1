Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5E47E6FE2
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 18:11:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r18Ym-0003sf-0i; Thu, 09 Nov 2023 12:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r18Yk-0003rk-9U
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:11:14 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r18Yi-0006Z1-OP
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 12:11:14 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5446c9f3a77so1924541a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 09:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699549871; x=1700154671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U+9y4x2z4fsA5Zt83hhNWhpPB+KEimoExJJi5qWOLcw=;
 b=Ec5HGziMBXpXd54g6Ok5vO2ZkKQRnN9P0KFdeSO4g3Q06I1HneLWt8+Dr8fDyB9lrl
 66uy0lsty+2RTHT/JEdVHoIJAUMcjBThzFWS+ex3UGVITTry+Wr0EDoZlPIc4f4hLYZ4
 9WgE3AMvlRB/yDChtBNi/l1gafn21hYOTYkElqPFY/xnINaJICy+XNIyFaEGMC3xPBZc
 HgkEugSBSds9/+EEXqvVyS9EsgMcxMU4iLL3LaWRBWsXXrgniQP+XrZtcBUcdLWCDTPk
 pk4eVsNCRA1/v29QA4uHQ2IsH/hwpQKEr+EPm5KJOd86Tzx219zP99ZumoeDKRnzL6Du
 cxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699549871; x=1700154671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U+9y4x2z4fsA5Zt83hhNWhpPB+KEimoExJJi5qWOLcw=;
 b=PkpeG8qSWe5T95qZenXOLnI6BJxRXRYmW24rccEKWelDYL1alDUTbOnedwvFLuRqSQ
 SJs2BRzH8CHKv62zTKA2wu1QAoyzijWrUCY52AOLwVsPQMN05m6V6ClKJqNcrYQRVz1k
 ke0JRtyGNt0R2325UwfeteVUdlJZEje3RAs49OjC8dLeqPraGbjMPcAOCTi9+5gxhz7F
 sylcfTENhOw+6tgo2IpToV5fcC3qjqwV4pNUfO2HJOclQxkeu2RtYwIztGXiz9BY+dAS
 SfaRssHuOIX76k784pr+n3Rnt4D8pfxGCT9sqtDi6Wme3fNDolkBdNOg7RIECgi/Yi+3
 PGDQ==
X-Gm-Message-State: AOJu0YwSbFCjj7aI6Nf6HaySuVd2kgdW4hvYCzTCnsm2WGrUpJvCzf0S
 DU7USUDdJCWCZZ4/0IsGQ0XEK+in6Mq+C6huYjtBZw==
X-Google-Smtp-Source: AGHT+IFovhhZBU8q8epkldZ8FQyCfD2pxsZoaKgTh4nV2ATsJ9betfQ69V9zealCiEP4AkkZGFzHDdy52gO8h1Kc4gs=
X-Received: by 2002:a50:9ea7:0:b0:53f:a526:779 with SMTP id
 a36-20020a509ea7000000b0053fa5260779mr4812176edf.12.1699549871438; Thu, 09
 Nov 2023 09:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20231109170715.259520-1-eric.auger@redhat.com>
In-Reply-To: <20231109170715.259520-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 17:11:00 +0000
Message-ID: <CAFEAcA_iNjy2NgxEk51_XU27qZOKjw+OuxzGhvTCMBAjxaJi+A@mail.gmail.com>
Subject: Re: [PATCH] virtio-iommu: Remove useless !sdev check in
 virtio_iommu_probe()
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 clg@redhat.com, mst@redhat.com, yanghliu@redhat.com, 
 alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 9 Nov 2023 at 17:07, Eric Auger <eric.auger@redhat.com> wrote:
>
> The code already checks iommu_mr is not NULL so there is no
> need to check container_of() is not NULL. Remove the check.
>
> Fixes: CID 1523901
> Fixes: 09b4c3d6a2 ("virtio-iommu: Record whether a probe request has
> been issued")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Coverity (CID 1523901)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

