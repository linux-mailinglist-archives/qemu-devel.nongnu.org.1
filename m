Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8CB736BCB
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 14:20:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBaKj-00057z-HG; Tue, 20 Jun 2023 08:19:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBaKi-00057o-DH
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:19:40 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBaKg-0004I5-Qf
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 08:19:40 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-519f6e1a16cso5459902a12.2
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 05:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687263577; x=1689855577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mA2xlTq8TaGIAGIEbsI/d42ixyZvwolv+wdO+4hgEi4=;
 b=k7GQTkPuKABvjkr0sWxfnZVd2S0csdXaROw4+OvpQlMcGzrwMkYFv5mUvb/XgVvHCa
 lHHVBgLkB0lCk+F3s/VrLQuGG8WppPpGozww4EOHutFOblWs77F8eoBA615TvvLFRRpj
 3RFvmhEVsNik4aQtToZuZy92GitcW0BfrwJTWJ0fEYUD3B6aNUOSRvVY4Rs3BYr8/SWx
 2jtoiv8mXM6F4r8k3pPHp4zLTVpQIHPDMF8sW/hVwEX/AwgGdaPD88DLXmuYyWZjC0EF
 Kr0ayGYEIxjIICa8yTIaJPRjRVgCLwH1HDcRH9ZL34MeupBynOZI7kwZuUVlepCnCnr8
 mwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687263577; x=1689855577;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mA2xlTq8TaGIAGIEbsI/d42ixyZvwolv+wdO+4hgEi4=;
 b=ZV3RKfqJ152zGpjCfgAiQwkwf76e393/7bPAzxToAiJVg0nWrZrAfu6xGWLtZCw5Pi
 CbqXBWFjufSLlKL/Pa9Vw3hz2pmP1RkMcc4iXyw3JbBF+DYyXfoqpP2MFpd034fxo2Cu
 dWB2gVGWnvHWfZOS18fXupXrMYnHjNP9iCNWzmHQSxVdB4Nkto/Y5amiVFJLsYMmUQZs
 pSowbma3rgnrxaLNr0Iu1qSpHB0KCDmmbf5Z6QYJdfRoIKdKPrOoh6aZ7LukQ0OhiX46
 Ato7D3H8idAlJuq/Xjk0PYA18APo5/ddYglVwG3OQSnCpu4pMdj3EwDX2Rsvz6mUJpVd
 jUCA==
X-Gm-Message-State: AC+VfDz1szCj4+QDDbWk04a4vbCcLLmicLoNPqciju0r2fMMfKrwO4EI
 xxhE7cACwrWhKjdlAn4WBCWYkIJHhNAiOMPcvwC0Mw==
X-Google-Smtp-Source: ACHHUZ4nV1eIZlM4IizwJ8hN2qXgwlhPF7pJckO5uZBcMrr+2J72rYRqgJYnfngqAR7VwLmf6HuazoNOZ/FyM668Gf8=
X-Received: by 2002:aa7:c6d9:0:b0:51a:3850:e846 with SMTP id
 b25-20020aa7c6d9000000b0051a3850e846mr6981167eds.7.1687263576983; Tue, 20 Jun
 2023 05:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230307182707.2298618-1-dwmw2@infradead.org>
 <20230307182707.2298618-6-dwmw2@infradead.org>
 <CAFEAcA9gzJGMqsEY5TuNmb74RskgUTMW+XcqGV53n3SsKyVVXg@mail.gmail.com>
 <CAFEAcA9aFv5c4S=Pyf3dMU-v9FnNJqWTQ7ZbiDQLTjh8Qou71g@mail.gmail.com>
In-Reply-To: <CAFEAcA9aFv5c4S=Pyf3dMU-v9FnNJqWTQ7ZbiDQLTjh8Qou71g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 13:19:26 +0100
Message-ID: <CAFEAcA--FqeioUdPb9sr5fEy3q0H0swcp+rbGxoNbhgMkYdC+A@mail.gmail.com>
Subject: Re: [PULL 05/27] hw/xen: Watches on XenStore transactions
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Paul Durrant <paul@xen.org>, Joao Martins <joao.m.martins@oracle.com>,
 Ankur Arora <ankur.a.arora@oracle.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, vikram.garhwal@amd.com, 
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, 
 Juan Quintela <quintela@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 2 Jun 2023 at 18:06, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 2 May 2023 at 18:08, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Tue, 7 Mar 2023 at 18:27, David Woodhouse <dwmw2@infradead.org> wrote:
> > >
> > > From: David Woodhouse <dwmw@amazon.co.uk>

> > Hi; Coverity's "is there missing error handling?"
> > heuristic fired for a change in this code (CID 1508359):
> >
> > >  static int transaction_commit(XenstoreImplState *s, XsTransaction *tx)
> > >  {
> > > +    struct walk_op op;
> > > +    XsNode **n;
> > > +
> > >      if (s->root_tx != tx->base_tx) {
> > >          return EAGAIN;
> > >      }
> > > @@ -720,10 +861,18 @@ static int transaction_commit(XenstoreImplState *s, XsTransaction *tx)
> > >      s->root_tx = tx->tx_id;
> > >      s->nr_nodes = tx->nr_nodes;
> > >
> > > +    init_walk_op(s, &op, XBT_NULL, tx->dom_id, "/", &n);
> >
> > This is the only call to init_walk_op() which ignores its
> > return value. Intentional, or missing error handling?
>
> Hi -- I was going through the unclassified Coverity issues
> again today, and this one's still on the list. Is this a
> bug, or intentional?

Ping^3 -- is this a false positive, or something to be fixed?
It would be nice to be able to classify the coverity issue
appropriately.

thanks
-- PMM

