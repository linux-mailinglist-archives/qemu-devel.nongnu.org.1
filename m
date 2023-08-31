Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A86978EFED
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 17:05:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbjCr-0008IR-92; Thu, 31 Aug 2023 11:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbjCe-0008Hd-K8
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:03:25 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qbjCc-00041Q-96
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 11:03:24 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so4466553a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 08:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693494198; x=1694098998; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1aX9TOjhlfbr3EWGRSam9s6CHNXIEvwtRT2ZHXvklWM=;
 b=DrrI3NAyCDEnC1DFCpH/oa5QKU3IXAXh+kQN9CLWzrDDgtN5vOE5Bx5/1tRhzqYOwY
 9pLl2JGjDpePzC3XGm31Di86BJT33cL+q53h+hWkkmMdSdl4EyRgBZmMfG3UxRUpo8gN
 Rl5ixUIlJsvfBcrVjNHtNCZ2TDFYWoot6OVyYYOuDCO4bRyP1utF5kvplsw4z9VrgqbV
 dBb9v+tR1RoovolpJZ8xIyefJl2bqX4RO2qI5LaqByYnrK+gbBTeHcujxP3nV6AKdg5u
 yVaQxULkBBjC6INEFKHpPDgwi7hEjxZUOV/bh/II1028t2v0RobpimyaxlAZl4ZgKUQq
 lZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693494198; x=1694098998;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1aX9TOjhlfbr3EWGRSam9s6CHNXIEvwtRT2ZHXvklWM=;
 b=OnLYUMAbUGPpihqSHtMVCfXnGEArn6I053+xvoul6iIwZ15Sh7D+5i6MbPGG2MQ/o/
 EoybBJLhNoU70S3/ldPHECiNG9phHs+96n8V1S/Vb/5TZkAoWq0Qw2thT1dDAVogIRCb
 zHlYl3xrwhLZtjPcnSSNNOJbwqCBpnebURO+NdHXMRdPb6+8DScdvc19RVC8yRiBZ/TP
 utIkE8Q2qt9VTOv7fSO6B32VyYIWt+F8l5j0bpWdKACu8fSXKV9zYrpx7Kh7E0shrJxy
 NdkS+TPD8CT5TousT8uD00BUATSgZXuOPT628lUCHUEMxsyGfbEPhJhK7PkZ+QblPNnx
 zGEw==
X-Gm-Message-State: AOJu0YwnUhkByPSSHl3t5tUUlv6yZSfni8F/JN8FSBQlBdN43/pjyDQ6
 UV34gG2nt4jVbplLE+dmhs5Wrd8OSsUv90VcGLeO0Ra1LQejjOsT
X-Google-Smtp-Source: AGHT+IFFm6v20Yy+84UQ6hOwmS0zYNb0Gzn1LksHmowZr3f4ttJLm9Ca6j6sBKgF98BH15WqBHmsBG/8yTkbxIx70bM=
X-Received: by 2002:a05:6402:50cb:b0:525:4d74:be8c with SMTP id
 h11-20020a05640250cb00b005254d74be8cmr3760154edb.14.1693494198113; Thu, 31
 Aug 2023 08:03:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230824183448.151738-1-francisco.iglesias@amd.com>
 <20230824183448.151738-6-francisco.iglesias@amd.com>
 <CAFEAcA_Es_sX4O-oqX9E49LTWUMDzv6sao2i3Fb-YCqg9M8WXA@mail.gmail.com>
 <49408ea1-c837-76b8-7a43-de6ac5c682e9@amd.com>
In-Reply-To: <49408ea1-c837-76b8-7a43-de6ac5c682e9@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Aug 2023 16:03:07 +0100
Message-ID: <CAFEAcA-dbHt4Gvy48eVkobJCMfOivTPfryAgYUBtveebkUqVjA@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] hw/misc: Introduce a model of Xilinx Versal's
 CFRAME_REG
To: Francisco Iglesias <francisco.iglesias@amd.com>
Cc: qemu-devel@nongnu.org, frasse.iglesias@gmail.com, alistair@alistair23.me, 
 edgar.iglesias@gmail.com, fkonrad@amd.com, sai.pavan.boddu@amd.com, 
 tong.ho@amd.com, vikram.garhwal@amd.com
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

On Thu, 31 Aug 2023 at 16:00, Francisco Iglesias
<francisco.iglesias@amd.com> wrote:
>
> Hi Peter,
>
> On 2023-08-29 18:44, Peter Maydell wrote:
> > You don't need to g_tree_lookup() for every address. If
> > you use g_tree_lookup_node() you get a GTreeNode* back,
> > and you can then iterate through the tree from that point using
> > g_tree_node_next(), something like this:
> >
> >       for (node = g_tree_lookup_node(s->cframes, GUINT_TO_POINTER(addr));
> >            node && GPOINTER_TO_UINT(g_tree_node_key(node)) < end_addr;
> >            node = g_tree_node_next(node)) {
> >           XlnxCFrame *f = g_tree_node_value(node);  // definitely not NULL
> >           /* Transmit the data */
> >           for (int i = 0; i < FRAME_NUM_WORDS; i += 4) {
> >               ... etc ...
> >           }
> >       }
> >
>
> I tried above but it looks to require glib 2.68 so added a comment
> instead (didn't compile on my machine with glib-2.64 :/, if I understand
> meson.build correctly the min glib version supported is 2.56). Let me
> know if some other solution would be preferred.

Whoops, yes, I didn't notice the version-statement on
g_tree_lookup_node(). Yeah, keep what you have.

thanks
-- PMM

