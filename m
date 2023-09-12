Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2179D348
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:09:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg44d-0003Fs-IQ; Tue, 12 Sep 2023 10:09:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg44b-0003FJ-J4
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:09:01 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qg44Z-0007b1-Ag
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:09:01 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52e64bc7c10so7408447a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694527737; x=1695132537; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EIEiXpdzEGspw3DS9sVHqabsXzlICPfXZ+rTGaE/EA0=;
 b=ikkR34syp8ftPIxVSNF6mgYQn2si+Saw2dGZmTVQLRoM1Urs7kM2Q5foJs6UilXkzI
 +i5oVR4co6J9GooDRz7lA8RxI7zNSn4z59iXe+IKBmjNGzJTXqiuwOEyddLmbNz5ogoi
 YChpZShVXgVxgUkQq463iaGdTuSUF/OffoO0mZN1yjDwidW9JtQpFbN87YIWsep542UM
 TaLAiJc5NzzXopueoVvBNVXC6azThpBTckvhh8afTxH8EFcO+P1GZ8+7ECv9CYHt1XNT
 Pn3e9EYIcWvSg5HOJ6nggYSbI4eLOfcJRG+aKeYdjMsXxQIlADZmbLJPEMfXu59pOZ6l
 N6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694527737; x=1695132537;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EIEiXpdzEGspw3DS9sVHqabsXzlICPfXZ+rTGaE/EA0=;
 b=sJbkfy527k8liLdBF+4omvNjK3ICRLMQ5DxqW32mpAPnP7dsXti718DD1znStztqRd
 I0ZdgukxrxIU6gSctjt39PursLdQv0ArP7uzl2WNQlyqNauA8aP4rKkw1FQmXZgTIAAW
 tBHBJLO9OiJosZqBoZIlS0hl9N7QlAP+FGta5NoCpEtF2GyA0Eac79CrwZ7bFwal7Ur+
 0qw5QasDR7hvge/RMAaeFmIncprmjTe6hrHAe2O77CFM6HAi4LSEjF5w59U7bEv7n1kB
 nG6cLQDX9ty4C2psB5Pi6EwSw+rWveJofml2ufjakBXpqZ2D72dKVHscy6N0YekSbpur
 fBag==
X-Gm-Message-State: AOJu0YxFWHuUKP3O6AA1QgQazf+lTIfmziLh7uKLZzsWGwjr4wfhWq+e
 mZbGub7OP7cd5QFhPhGXJwl/1aZ4lQn4dWBrvk6+noCaQluW1krv
X-Google-Smtp-Source: AGHT+IE4HI68aWKToRNjqRS8X7emj1c9x88fJWOwUmjrnvDVl9YXuRltXz566zXzoyh2uON4t48czDY4Wugl5I2HaTU=
X-Received: by 2002:a05:6402:2023:b0:523:aef9:3b7b with SMTP id
 ay3-20020a056402202300b00523aef93b7bmr10014140edb.4.1694527737410; Tue, 12
 Sep 2023 07:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230725113632.2386874-1-peter.maydell@linaro.org>
 <CAFEAcA-DXnmtfKYrOjrSRp=rjdV-Owqm+b0=oB6y-=H=VP9fLg@mail.gmail.com>
In-Reply-To: <CAFEAcA-DXnmtfKYrOjrSRp=rjdV-Owqm+b0=oB6y-=H=VP9fLg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2023 15:08:44 +0100
Message-ID: <CAFEAcA8YxuRGp5sfXauWfiTsOE7H6hkbRKp1Pp0ampxsct5hQg@mail.gmail.com>
Subject: Re: [PATCH for-8.1] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

Ping^2 for review/pickup by the rdma folks, please?

thanks
-- PMM

On Tue, 29 Aug 2023 at 16:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 25 Jul 2023 at 12:36, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > In query_port() we pass the address of a local pvrdma_port_attr
> > struct to the rdma_query_backend_port() function.  Unfortunately,
> > rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
> > and the two are not the same length.
> >
> > Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
> > long, and ibv_port_attr is 52 bytes, because it has a few extra
> > fields at the end.
> >
> > Fortunately, all we do with the attrs struct after the call is to
> > read a few specific fields out of it which are all at the same
> > offsets in both structs, so we can simply make the local variable the
> > correct type.  This also lets us drop the cast (which should have
> > been a bit of a warning flag that we were doing something wrong
> > here).
> >
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > I don't know anything about the rdma code so this fix is based
> > purely on looking at the code, and is untested beyond just
> > make check/make check-avocado.
> > ---
> >  hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
> > index c6ed0259821..d31c1875938 100644
> > --- a/hw/rdma/vmw/pvrdma_cmd.c
> > +++ b/hw/rdma/vmw/pvrdma_cmd.c
> > @@ -129,14 +129,13 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
> >  {
> >      struct pvrdma_cmd_query_port *cmd = &req->query_port;
> >      struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
> > -    struct pvrdma_port_attr attrs = {};
> > +    struct ibv_port_attr attrs = {};
> >
> >      if (cmd->port_num > MAX_PORTS) {
> >          return -EINVAL;
> >      }
> >
> > -    if (rdma_backend_query_port(&dev->backend_dev,
> > -                                (struct ibv_port_attr *)&attrs)) {
> > +    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
> >          return -ENOMEM;
> >      }
>
> Ping for review/testing by the rdma folks, please ?
> Whose tree should this patch go through?

