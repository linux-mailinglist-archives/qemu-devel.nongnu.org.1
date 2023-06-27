Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5DB73F7F0
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 10:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE4VW-00048U-GA; Tue, 27 Jun 2023 04:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qE4VQ-00047y-LM
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:57:01 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qE4VO-0008C9-2l
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 04:56:59 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1a28de15c8aso4061211fac.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 01:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687856216; x=1690448216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qlXVO+p/e8/qPARrLoujHM/77BruZ4xR27xhkiJKcqw=;
 b=sM+9aorPBrEMwE4JxE5w1a4vDcr7/BOELSXmyoAx3QtWe9vr9/RK7MeKSNJXPS7WgZ
 gft/JSfKMEGkaAO6DoyaSH0F/LLHbz1h+2YGySNzWaP5zifndHTa1TfL8cTXYenRdsw0
 nk4LmuGVlLuWtlqtec44jjlbLWOi7z4NIqcncEwRDprsITvVTUmlIXzgyHFaaCP7gQlQ
 nhyyj4K8ksteZiP0KX2x9Aiq0WtVOHfegucLQt2TosEhHztafISow0Vytg6f9AK/u1nq
 koCKTQ2hPQPhe2FT2tGrjSZOYXDbmvHuJr9hhpeS4f9NeBkkjXmsKqEbWWG83laozZa2
 icxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687856216; x=1690448216;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qlXVO+p/e8/qPARrLoujHM/77BruZ4xR27xhkiJKcqw=;
 b=aBTM8Z3QIW5KaKGIvSt9KK8guLeAY6sWD5HllutwaZpDMk2Q2Qxz5P8cmmKcjdCCWp
 Pq9jFyu4BYQjxuHCWQwv9HSCc3xljoqV/SiG0auyh2IAOS/ZOJZbo3gzQDVl/p8E9C+8
 P54CXBAYmnb/2ReuglUQfNVNK1G4z9hZKUQwpcAAIBLN5EbU5KztQ+eJ6lkDHYWOJ3Yx
 78EWvAefvdwbXCljhIF4nIC9Or/xurlX0TKNW3AJbUN/MjycMg/iKAHEF3PFaHnzaNjg
 07No9AYGrjl37/KsoBGEeX1ee//p33ib81DzDmJIcT0yuv+bQ3CwOXphWkKeIHfSbOZS
 Bozw==
X-Gm-Message-State: AC+VfDxhbWq05b4Q4tt1eLKfnjo/PX5C/lvww0RYEd51w9LRt7CdVizQ
 6rsYCyE182xGtEgdEQyCh6J3DofYTmAJFrXxnMU=
X-Google-Smtp-Source: ACHHUZ61yf6k/ECi8IzGX9NnijmaBgaa9jGWZtOJG9LeqTo5KgprXFUheygUZqt3GxSQATzbho96VI3PExOK8dM0BYo=
X-Received: by 2002:a05:6870:9202:b0:1b0:57f8:daaf with SMTP id
 e2-20020a056870920200b001b057f8daafmr2135017oaf.18.1687856216331; Tue, 27 Jun
 2023 01:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230622215824.2173343-1-i.maximets@ovn.org>
In-Reply-To: <20230622215824.2173343-1-i.maximets@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 27 Jun 2023 10:56:43 +0200
Message-ID: <CAJSP0QV5pjCxXm9U0FPYxBWKAyyLmTmWx4YcGfVtumSatJNW7g@mail.gmail.com>
Subject: Re: [PATCH] net: add initial support for AF_XDP network backend
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Can multiple VMs share a host netdev by filtering incoming traffic
based on each VM's MAC address and directing it to the appropriate
XSK? If yes, then I think AF_XDP is interesting when SR-IOV or similar
hardware features are not available.

The idea of an AF_XDP passthrough device seems interesting because it
would minimize the overhead and avoid some of the existing software
limitations (mostly in QEMU's networking subsystem) that you
described. I don't know whether the AF_XDP API is suitable or can be
extended to build a hardware emulation interface, but it seems
plausible. When Stefano Garzarella played with io_uring passthrough
into the guest, one of the issues was guest memory translation (since
the guest doesn't use host userspace virtual addresses). I guess
AF_XDP would need an API for adding/removing memory translations or
operate in a mode where addresses are relative offsets from the start
of the umem regions (but this may be impractical if it limits where
the guest can allocate packet payload buffers).

Whether you pursue the passthrough approach or not, making -netdev
af-xdp work in an environment where QEMU runs unprivileged seems like
the most important practical issue to solve.

Stefan

