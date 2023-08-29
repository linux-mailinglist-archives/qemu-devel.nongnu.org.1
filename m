Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3CD78C8E4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:50:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0yG-000187-Ho; Tue, 29 Aug 2023 11:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb0yE-00017v-IF
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:49:34 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb0y7-0005gG-PN
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:49:34 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50078e52537so7043219e87.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693324166; x=1693928966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wnRWVwfd7vhBU3wlNhPyAzzzU2AfD3fZS/EaXQwpEEE=;
 b=hSd0yEPvrBgW7JUUzvY9Lv8Rb0daOQhz++WlHFpjw+QyY57RRXaNj33nVy6x27tZL2
 iERmppyhCMUBKsZHTpTRx98HrP6oh5AIDA4FM+FPuC74Onv9/DokOh47ZIXIiorFVBNB
 QTvdJ13nauLwu6De+oK3aO9ivgMCeOBdP3ZnzCC5rWFFZKcrM8N4xLZwI1GxMan+YXzO
 j7bZljNnaPEx8lIUyf5FHRL6voq70lr1VlmsWMq6Apf6VINJSoseCSL1Mx9IDYsB0vwz
 pV/lvOXYKW2IwLcRwvC3Td8dEgNKFwk6ncORfq67rFl3QxnGvEN4FDvxmvc3mW1HIJig
 Z9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693324166; x=1693928966;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wnRWVwfd7vhBU3wlNhPyAzzzU2AfD3fZS/EaXQwpEEE=;
 b=aqAP1ZuLQxjDbwm7uPFcKOOaQ4sIFbZNkZMxNwqbY9J8dza1OM3fF2afrKVUiqAmO3
 8xi4zU8cN47hlPRg5a0aQDen+WgOTANZQZE2YFnM8C4D2rDSRkIL0JGTdTKWnbDtJG1F
 aSNzGHrN6atgsvse6cfw+EWCo6IW2TN6NNPS9wewyMTYlkALqHnwMHc/GGQLF9afMZNx
 rPse3uUMZbzWzYVEj8Tn5RCldopT4R/xyBl3ZuKZD6R93qGiPlMKLyQycNV7xfEvXnWJ
 YhpWb2rzYubYGSGnc8suLQRuWiJIiAsA8mU/xpKbRRsYwlreNjd+wYoFTec8t/sLGn3x
 Rjpw==
X-Gm-Message-State: AOJu0Yy2pufQzyL3XrPHSBMUjcmZj6o6Ems2KSeySPrqnoIt4f5/ZguT
 F2HC3/VNpeE+SX2dGwjf0gHBPF7pTa7ZY0DXIqyT/SFx4bn8pCMS
X-Google-Smtp-Source: AGHT+IGguTrPni2r78CmmGsLjv+kEN4QGKLhY3drP3ZK2+bM8fxgCitrBXtfyvy2u5KzUue/9486jKehyDW5MaoMHog=
X-Received: by 2002:ac2:4f16:0:b0:4fd:f84f:83c1 with SMTP id
 k22-20020ac24f16000000b004fdf84f83c1mr23812770lfr.64.1693324165896; Tue, 29
 Aug 2023 08:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230725113632.2386874-1-peter.maydell@linaro.org>
In-Reply-To: <20230725113632.2386874-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 16:49:15 +0100
Message-ID: <CAFEAcA-DXnmtfKYrOjrSRp=rjdV-Owqm+b0=oB6y-=H=VP9fLg@mail.gmail.com>
Subject: Re: [PATCH for-8.1] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Tue, 25 Jul 2023 at 12:36, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In query_port() we pass the address of a local pvrdma_port_attr
> struct to the rdma_query_backend_port() function.  Unfortunately,
> rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
> and the two are not the same length.
>
> Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
> long, and ibv_port_attr is 52 bytes, because it has a few extra
> fields at the end.
>
> Fortunately, all we do with the attrs struct after the call is to
> read a few specific fields out of it which are all at the same
> offsets in both structs, so we can simply make the local variable the
> correct type.  This also lets us drop the cast (which should have
> been a bit of a warning flag that we were doing something wrong
> here).
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I don't know anything about the rdma code so this fix is based
> purely on looking at the code, and is untested beyond just
> make check/make check-avocado.
> ---
>  hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> index c6ed0259821..d31c1875938 100644
> --- a/hw/rdma/vmw/pvrdma_cmd.c
> +++ b/hw/rdma/vmw/pvrdma_cmd.c
> @@ -129,14 +129,13 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
>  {
>      struct pvrdma_cmd_query_port *cmd = &req->query_port;
>      struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
> -    struct pvrdma_port_attr attrs = {};
> +    struct ibv_port_attr attrs = {};
>
>      if (cmd->port_num > MAX_PORTS) {
>          return -EINVAL;
>      }
>
> -    if (rdma_backend_query_port(&dev->backend_dev,
> -                                (struct ibv_port_attr *)&attrs)) {
> +    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
>          return -ENOMEM;
>      }

Ping for review/testing by the rdma folks, please ?
Whose tree should this patch go through?

thanks
-- PMM

