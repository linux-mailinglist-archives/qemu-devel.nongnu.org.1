Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B1F78815B
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:58:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRhO-0001so-IC; Fri, 25 Aug 2023 03:57:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qZRhM-0001sV-H3; Fri, 25 Aug 2023 03:57:40 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qZRhK-00027o-Ac; Fri, 25 Aug 2023 03:57:40 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5008d16cc36so919168e87.2; 
 Fri, 25 Aug 2023 00:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692950255; x=1693555055;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HTbvxrTgujyUc1hywZH9T9OGM3UOj1wjie6m5GrjsGU=;
 b=IjgAcaAGmtFeMJI0scX6VWSVQAjMv7+15IrMD015QzKk9K5HJ7ItrrMb3BiArp1n1h
 3jPEx2Gmj5iPsH28ICkTDWSHCANov4NpRJQxNGWQHhBgrifq/19EoU8K4TkDQEeFHgy4
 MbkkniMDNBtfCt3stZlc7tinv+uYViRNlSY868tAxauoSSCqaj0e2giFArS6H8qbQ9SB
 DjlwwTRM/G3J5vAmTN90gePCaPjCp4MSuIcdp+RbLqph1z2x3D2g66V+Jb3LOZiIVqjg
 YM7pT1m95PWsOflGa6yWVHYmJ74r8OwcJIom+4X9NLEOi1fuvINR3OS6F7fcpdTiMjvM
 WZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950255; x=1693555055;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTbvxrTgujyUc1hywZH9T9OGM3UOj1wjie6m5GrjsGU=;
 b=bSbMVWdLbCn4wB/572HPaTuAjZggXA5Qa/lj+5IXmF8QqOnX9bi8ZDEpHTptGPZ8+0
 P0cxPwISTcAGU8FjoRe1OsohcHMBTyX+K+Ti/cDV9ShEoKblYFMgRlsSMF8upr7CRB6w
 HkYLHw3hEoIJ1XcdSD5yuA+WZeiisVNg/tQxwlht/n0JwVNJfNo7DGQRNCgSi6sOxp6R
 zU4g73fyfhwqtfQFi1m3T55BNIdoP0avLTubhlS6OhM5k76IZNaVtsTwp9NtXqW4ihDC
 ON9DGzp0ronIZk2Z0WA8RdQUOmxhNxMd4IwVLAJU8uFx11HAsIB31xQbcCznF9FHNDXy
 plBg==
X-Gm-Message-State: AOJu0YxDsLb3zgUG2g9kJt6OhcmFH5si4i729kYgQ/dYY6n0UPOpLS/6
 O5RgWuJCrooN8eeXDlqQYyw=
X-Google-Smtp-Source: AGHT+IEWYoqgRH7YbbR3/PLdUVlm2QnAoJ+nbccOrOSKL6p0iYEQd/rqpGHYn700nGi/aGGOnmznHQ==
X-Received: by 2002:a05:6512:318a:b0:4fe:1d88:2c61 with SMTP id
 i10-20020a056512318a00b004fe1d882c61mr16389339lfe.32.1692950255283; 
 Fri, 25 Aug 2023 00:57:35 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a19700c000000b005009aa86582sm189391lfc.55.2023.08.25.00.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 00:57:34 -0700 (PDT)
Date: Fri, 25 Aug 2023 09:57:33 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 3/4] net/dump: Avoid variable length array
Message-ID: <20230825075732.GQ6984@fralle-msi>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <20230824153224.2517486-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824153224.2517486-4-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -1020
X-Spam_score: -102.1
X-Spam_bar: ---------------------------------------------------
X-Spam_report: (-102.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_WELCOMELIST=-0.01,
 USER_IN_WHITELIST=-100 autolearn=ham autolearn_force=no
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

On [2023 Aug 24] Thu 16:32:23, Peter Maydell wrote:
> Use a g_autofree heap allocation instead of a variable length
> array in dump_receive_iov().
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  net/dump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/dump.c b/net/dump.c
> index 7d05f16ca7a..16073f24582 100644
> --- a/net/dump.c
> +++ b/net/dump.c
> @@ -68,7 +68,7 @@ static ssize_t dump_receive_iov(DumpState *s, const struct iovec *iov, int cnt,
>      int64_t ts;
>      int caplen;
>      size_t size = iov_size(iov, cnt) - offset;
> -    struct iovec dumpiov[cnt + 1];
> +    g_autofree struct iovec *dumpiov = g_new(struct iovec, cnt + 1);
>  
>      /* Early return in case of previous error. */
>      if (s->fd < 0) {
> -- 
> 2.34.1
> 
> 

