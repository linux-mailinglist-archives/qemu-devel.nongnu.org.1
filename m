Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DC0788158
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 09:57:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZRgy-0001e1-Im; Fri, 25 Aug 2023 03:57:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qZRgw-0001dj-BF; Fri, 25 Aug 2023 03:57:14 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frasse.iglesias@gmail.com>)
 id 1qZRgu-00024Z-4r; Fri, 25 Aug 2023 03:57:14 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2b9b50be31aso8472401fa.3; 
 Fri, 25 Aug 2023 00:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692950229; x=1693555029;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=saeE748hguQnvRRlOHEeA4K4mKZcwDQK6XDGTasI0Io=;
 b=PCR6hwpB9knXenkUYf6BfMrvv46OxJcQ6xbbjbxSS03qxUGvO5d1nj3OKQXwjO+dGL
 3jadR5kzngz+pVJEPZ5NzpDM/X6yW/eo2k8tnFXFeoLIM+FzPecpEiqJOptUGFxIMrFt
 8+E16km7QM/3ohVgFvzb9iabHXPRKhIY0ZtaDX5szkmzCXr+2WbMp1INXpkJ7hf0G9IB
 K3rEHCYunvTacsPMH96gmdKiJpJ2VbOqmMyiTelmlJPBKS0KbcVSLhEy7uv9PmNQ1qqU
 Mt/mXdXoGjxHicpPtx12VzltkRRoVq1iTQ3sG8+n98Bo0oAWk2q+P39994oBeAD0xUHj
 iSjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692950229; x=1693555029;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=saeE748hguQnvRRlOHEeA4K4mKZcwDQK6XDGTasI0Io=;
 b=WE7rI4P74OUa1vWew+S8aEJ4SatAVhhUV7DSd+yxuL8iUddW9rDWaAOt7ahXYFSY31
 DZUCYEQ9ePwUsgZ4VQ1sXY7hxLBWSBNLMp3QeANv+733Fe77IOzjJ/Zv9qxgByWctrQc
 0DcJm9wi3Nb9nr6NO6H6bBJ0CE7PcPWIOkG3z+Ed8EUALly+d2xlR7k8/FhMzG0z0i58
 OcNqg5JV4InlMV/uOV2lYDJrpJeL9vnmVCCC70ae1cDs7r4T83hVruffogevQabzfH1/
 KtPPtX17MRObVswzdSLQczG3INHq/y892D2KN5IVEjOaAL9nxyQ08uMKsL0W1jAoaW5w
 tMJQ==
X-Gm-Message-State: AOJu0YzaTQ7vfA3ZFJFs4hJhYAFMmWOIkjhyqZ4IdSxmBrlgUy3njWHe
 jDhk8AaID37lPfgZ3CFAYY8=
X-Google-Smtp-Source: AGHT+IGmzkJ9AiV7CR6aWousM027iunpFvIfKfokeIPrIuSBunH09uC8v9il5TJRjiVqVMRJB5z+2w==
X-Received: by 2002:a05:6512:3d17:b0:4fe:c6c:ac95 with SMTP id
 d23-20020a0565123d1700b004fe0c6cac95mr15149788lfv.35.1692950229254; 
 Fri, 25 Aug 2023 00:57:09 -0700 (PDT)
Received: from fralle-msi (217-76-87-243.cust.bredband2.com. [217.76.87.243])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a056512006b00b004fbad682ffesm193545lfo.88.2023.08.25.00.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 00:57:09 -0700 (PDT)
Date: Fri, 25 Aug 2023 09:57:07 +0200
From: Francisco Iglesias <frasse.iglesias@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, qemu-ppc@nongnu.org
Subject: Re: [PATCH 4/4] net/tap: Avoid variable-length array
Message-ID: <20230825075707.GP6984@fralle-msi>
References: <20230824153224.2517486-1-peter.maydell@linaro.org>
 <20230824153224.2517486-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824153224.2517486-5-peter.maydell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=frasse.iglesias@gmail.com; helo=mail-lj1-x22a.google.com
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

On [2023 Aug 24] Thu 16:32:24, Peter Maydell wrote:
> Use a heap allocation instead of a variable length array in
> tap_receive_iov().
> 
> The codebase has very few VLAs, and if we can get rid of them all we
> can make the compiler error on new additions.  This is a defensive
> measure against security bugs where an on-stack dynamic allocation
> isn't correctly size-checked (e.g.  CVE-2021-3527).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <frasse.iglesias@gmail.com>

> ---
>  net/tap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/tap.c b/net/tap.c
> index 1bf085d4228..34b1e3f0918 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -117,10 +117,11 @@ static ssize_t tap_receive_iov(NetClientState *nc, const struct iovec *iov,
>  {
>      TAPState *s = DO_UPCAST(TAPState, nc, nc);
>      const struct iovec *iovp = iov;
> -    struct iovec iov_copy[iovcnt + 1];
> +    g_autofree struct iovec *iov_copy = NULL;
>      struct virtio_net_hdr_mrg_rxbuf hdr = { };
>  
>      if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
> +        iov_copy = g_new(struct iovec, iovcnt + 1);
>          iov_copy[0].iov_base = &hdr;
>          iov_copy[0].iov_len =  s->host_vnet_hdr_len;
>          memcpy(&iov_copy[1], iov, iovcnt * sizeof(*iov));
> -- 
> 2.34.1
> 
> 

