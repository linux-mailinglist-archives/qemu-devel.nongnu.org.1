Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81906736C03
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaa9-0005mX-Nh; Tue, 20 Jun 2023 08:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBaa6-0005mM-BW
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:35:34 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBaa4-00005s-Kd
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:35:34 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b466073e19so47207101fa.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687264530; x=1689856530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L571Z6tUd5RtNEJnPCaUu/a41xXqdAyoU024RzMTA/c=;
 b=dwXBXTF3M4Dk1qoPxPvOWedyiyTdWiAPfmxPb4J2xuGSmup8vz7aEHi87zNfwMZvdk
 dL80cvFzH3wt95vznYGLaTo65s5gkr7X6ob5mqMrOR5JU5PCjqfZ3Jz5QNzUr2k7mhbB
 z87AEAFW1twmmzVzh7bo7C68ZPpSxXN3B283W6w04E5JfrBSyn+uAvXqzsfZjeQT7wDN
 jemsLzl67g1HMcbDfnfpJHAWTClXdnGnItl/1NK9NM3AP0TWUCqkSzAS9GLJZ9Q6fFQm
 gI2FAqCaCvspHVNLJaPD4M42mENZGje7o2YHlY0Sx9R63SX0iEPC5Zd1gN5cZnS3F92K
 sDFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687264530; x=1689856530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L571Z6tUd5RtNEJnPCaUu/a41xXqdAyoU024RzMTA/c=;
 b=P98Jxl3TyuydWQe4GhZ/3L5xEjEwqsjOB2DHw3ICu3xrAEwYaZbENAIi6eR8+CPP9o
 eugmn3Lx0gc/BN9tv86jUH7qBcMsp6i1nWkX0RewFrWXLeuX6NsOCu4TomqtGPfaL60W
 DYxxL+UZQWO/2dzYMSyGMcHknD6fJjTzqPPFwBepI0YO96C98iEmg0RMgOCGjMKXkYsa
 4WfjhmymIwpUGpWozNlfwRXJ+Qo9ZBup25N1qDVAKZSFi9xZSahbJKcyUmxcsCDejbx3
 zb+Zi+QnwAVCIXqOIIDPMNgypr51AabBnHITaRExrQizRHFphw4RFMehgJ7znRMzTe3D
 pk+Q==
X-Gm-Message-State: AC+VfDwOOCpdAC6ErmGp4N5nZFDS1MD08L4wU++uMEedgK+A1yp5Ezys
 Z1C+4MGOfNvmhE3Ub0HdlS3AIVZu/ylCEv69Ff7N7ID47W/xGuUs
X-Google-Smtp-Source: ACHHUZ4JkjMSI9EmBgwWUJ3menhi6mMI4oSBwQAiXD+ihUWXvaQHr64o9y/BBryuQYQrWHwrBZDukXWJVjMMTYntelI=
X-Received: by 2002:a2e:9ad6:0:b0:2b4:78f6:d32b with SMTP id
 p22-20020a2e9ad6000000b002b478f6d32bmr4577461ljj.39.1687264529710; Tue, 20
 Jun 2023 05:35:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180219114332.70443-1-marcel@redhat.com>
 <20180219114332.70443-9-marcel@redhat.com>
In-Reply-To: <20180219114332.70443-9-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 13:35:18 +0100
Message-ID: <CAFEAcA-ghxbM_mjv2UpXVg9uRh30q6Pt+kxK8xw7sy2hAN6G1g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH PULL v2 08/10] hw/rdma: PVRDMA commands and
 data-path ops
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x231.google.com
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

On Mon, 19 Feb 2018 at 11:44, Marcel Apfelbaum <marcel@redhat.com> wrote:
>
> From: Yuval Shaia <yuval.shaia@oracle.com>
>
> First PVRDMA sub-module - implementation of the PVRDMA device.
> - PVRDMA commands such as create CQ and create MR.
> - Data path QP operations - post_send and post_recv.
> - Completion handler.
>
> Reviewed-by: Dotan Barak <dotanb@mellanox.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@oracle.com>
> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
> Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>

Hi; I know this is a 5 year old commit, but Coverity has just
noticed something odd in this code (CID 1507146):

> +static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
> +                      union pvrdma_cmd_resp *rsp)
> +{
> +    struct pvrdma_cmd_query_port *cmd = &req->query_port;
> +    struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
> +    struct pvrdma_port_attr attrs = {0};
> +
> +    pr_dbg("port=%d\n", cmd->port_num);
> +
> +    if (rdma_backend_query_port(&dev->backend_dev,
> +                                (struct ibv_port_attr *)&attrs)) {

rdma_backend_query_port() wants a pointer to a struct ibv_port_attr.
But instead of passing it one, we have a local struct
pvrdma_port_attr and then explicitly cast it to the
other type.

Unfortunately, ibv_port_attr is larger than pvrdma_port_attr
(50 bytes vs 48 bytes), so this could overrun the local
variable.

What's going on here, and what should the code be doing instead?

Given that we are just copying fields out of the structure,
and (other than the extra field at the end of ibv_port_attr)
the struct layout is identical, it looks to me that the simple
fix would be to make the local variable have the correct type
'struct ibv_port_attr' and drop the cast.

> +        return -ENOMEM;
> +    }
> +
> +    memset(resp, 0, sizeof(*resp));
> +    resp->hdr.response = cmd->hdr.response;
> +    resp->hdr.ack = PVRDMA_CMD_QUERY_PORT_RESP;
> +    resp->hdr.err = 0;
> +
> +    resp->attrs.state = attrs.state;
> +    resp->attrs.max_mtu = attrs.max_mtu;
> +    resp->attrs.active_mtu = attrs.active_mtu;
> +    resp->attrs.phys_state = attrs.phys_state;
> +    resp->attrs.gid_tbl_len = MIN(MAX_PORT_GIDS, attrs.gid_tbl_len);
> +    resp->attrs.max_msg_sz = 1024;
> +    resp->attrs.pkey_tbl_len = MIN(MAX_PORT_PKEYS, attrs.pkey_tbl_len);
> +    resp->attrs.active_width = 1;
> +    resp->attrs.active_speed = 1;
> +
> +    return 0;
> +}

thanks
-- PMM

