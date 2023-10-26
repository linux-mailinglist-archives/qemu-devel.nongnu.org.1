Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286D7D7BFC
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:08:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvsZl-0000Jl-2q; Thu, 26 Oct 2023 01:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1qvsZj-0000JI-DM
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:06:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <leo.yan@linaro.org>)
 id 1qvsZg-0000Dq-QZ
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 01:06:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so3416145ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 22:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698296786; x=1698901586; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RNM/CyI20wXyYGs9UTGgUz+tWRvyBskX9gAleyFmpiQ=;
 b=uudNw5brTt7VKWpfQhdbvLssGrqHowdqjGjTDHEn4EIPgUrs+h74Q6zs5RHsTueB5p
 LrTq7TWt3JliNKZKoICzvA3ybG1xcAwBbU5P5g6dlpE1Q4kp/ZHsIpkehxGYL+kqn8Z4
 zrkoqdgsgf3IH7FeB0oItN9W9p5TK4oS+szKNf9ochX4nyn9LxrPwN0KRLsZDBQXX06C
 GacOyefcLCjldxYCdb8jrMG91j5tWE7aYjNMCt+ueDhcqq7fST0MEr+oKvK41zQ/Owq/
 AlCtjRtuPpX17imsJ+kNPOgTe2L+eSc1NvR+8RyhnNwqOm9tv/GTomI86Ncpx6zHr6bf
 bfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698296786; x=1698901586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RNM/CyI20wXyYGs9UTGgUz+tWRvyBskX9gAleyFmpiQ=;
 b=WbFpflGumoM0Kvb8AGsUwqmnlDgaP+DVMuhnzOvGvEhDnKZ7Sk4afLD/opSk5I58aW
 W6O2mKRj/aZnPQN0RvfsmNs6W6tbtBsZelWujHAskbQUUFJhLwxwUosUrIynrjJs6UC4
 Fg8L9YqchbuzegFPQKjwADfG02o+DTwc5GsVcdk+KMrqc4Cym/Pw+M6xU1cGQp9CpF+1
 jiYKDXIPybCXDch4DmlfFWEhpi00IE9SCbDdL81JSSMc3B8PhGjDeJd4vUj6KvkNjMPY
 /9TZmq/WAiDj0vytZVL3GesDkJBgj1OPBY+OmpB19eN0TO4itwaeAqkW3dOs5cj9Ur/5
 yPoQ==
X-Gm-Message-State: AOJu0YwcMc8TsJmBzpcEHRY1jU5jWNn5nXETnvMADtVpXboy8CuLLfl4
 QbiZmlVyzzAKFckvG7//6rqtKw==
X-Google-Smtp-Source: AGHT+IE7beRwzcAkrjLeHPYSp80nZmAnCCTO/zKNDFobP9GLlzPorTrYXtDt8lP2eJGflFDII3QZhw==
X-Received: by 2002:a17:902:e746:b0:1c9:fb8e:2c33 with SMTP id
 p6-20020a170902e74600b001c9fb8e2c33mr19311718plf.7.1698296785719; 
 Wed, 25 Oct 2023 22:06:25 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-209.hinet-ip.hinet.net.
 [211.75.219.209]) by smtp.gmail.com with ESMTPSA id
 b7-20020a170902d50700b001c9ccbb8fdasm10002145plg.260.2023.10.25.22.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:06:25 -0700 (PDT)
Date: Thu, 26 Oct 2023 13:06:21 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: mst@redhat.com, viresh.kumar@linaro.org, lulu@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: rng: Check notifier helpers for
 VIRTIO_CONFIG_IRQ_IDX
Message-ID: <20231026050621.GA111564@leoy-huanghe.lan>
References: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025171841.3379663-1-mathieu.poirier@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=leo.yan@linaro.org; helo=mail-pl1-x62f.google.com
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

On Wed, Oct 25, 2023 at 11:18:41AM -0600, Mathieu Poirier wrote:
> Since the driver doesn't support interrupts, we must return early when
> index is set to VIRTIO_CONFIG_IRQ_IDX.  Basically the same thing Viresh
> did for "91208dd297f2 virtio: i2c: Check notifier helpers for
> VIRTIO_CONFIG_IRQ_IDX".
> 
> Fixes: 544f0278afca ("virtio: introduce macro VIRTIO_CONFIG_IRQ_IDX")
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Tested this patch and the vhost-user-i2c device works with it:

Tested-by: Leo Yan <leo.yan@linaro.org>

