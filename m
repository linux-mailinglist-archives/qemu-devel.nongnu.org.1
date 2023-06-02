Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF603720825
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:07:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58F0-00077g-6P; Fri, 02 Jun 2023 13:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58Ey-00077U-9c
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:07:04 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q58Ew-0007Ph-Ik
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:07:04 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f50a8f6dd7so3126571e87.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685725621; x=1688317621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X4AuYC+9A4+DdvMpLL4Ew5WTvGtxq7B6UBdOmtQcx3k=;
 b=L45w3dZ0AR2L43d8JEp9VloyyZkbnU8jw31mVGfkYiKyVv/77dsGR9DPSN0XyHwVO7
 iVR1gNzoSDGFazMJqdPzmxQWLYtepO2gT9adjyZsoBbGROLjXtrEqK0coePS1sRXa3c8
 /gQwCklLz1tYBLr3bjau17HYgV7MMmGujDaKh5I4N1sIE+6S9EWjoP5Dh0iq/juLkAXV
 aT5/06grlCDaO429ZUDiZmXojB9nHT50edQLqZabC3Xm3sZ0MUTmYwjlarDVAjmKacHL
 lDnAMUgO9Y5xpb5j8pYlpHv/IzgzDfR0UNTI6BuOCG5xe0y+hJBV9uUBpFbBCiKlVK8t
 MsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685725621; x=1688317621;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X4AuYC+9A4+DdvMpLL4Ew5WTvGtxq7B6UBdOmtQcx3k=;
 b=OygiNBksNyUdCkty9TaY3Ivt2s3UeEnvBNowWvWHtegHYbliwfzN8AnfjWw1sHpUac
 J6Ei9TaivYuSwMZezmsnWjz7mqUGUR3sV9JXYNZYFrnDUxkQKQJe3KtHvcGCbRpim7SB
 irhtIen22vJ819SbMWlzGUa2ONqvPkIfcmWrvb0vvGJ+47BCYLiU6nsJg6EeHKZRRALF
 CBPKoH64rzhxHBfsnJZJ9hqdM0dxVjK5bR+8dJrYYS1e/TJAi7HRq757ubsp9qy9c7sd
 iTM9w/5z8mPcsGn/M8A0t/A6qsVlrOush0ijFB+A9n50zf+OBIinDd1tXEx35e7QdM3a
 f0rA==
X-Gm-Message-State: AC+VfDxNDLQtnnCBBnQGw545HwEho8iVz0wc5dt4hTOmcqB7sAaafYjv
 rjmtUJsJHj+m78Se82RCElfB4u10Qvab9HJF1b4ebQ==
X-Google-Smtp-Source: ACHHUZ4aIxsMQSnb9a5maeoJXaEDyMmQ5XBYanrc+ozFpOU6ol1FJTDEv437CM7kHlsVKw/ACkgq9O/IZfRhDVmUkxE=
X-Received: by 2002:a05:6512:376f:b0:4f4:e1f8:98e with SMTP id
 z15-20020a056512376f00b004f4e1f8098emr1826158lft.23.1685725620619; Fri, 02
 Jun 2023 10:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230307182707.2298618-1-dwmw2@infradead.org>
 <20230307182707.2298618-6-dwmw2@infradead.org>
 <CAFEAcA9gzJGMqsEY5TuNmb74RskgUTMW+XcqGV53n3SsKyVVXg@mail.gmail.com>
In-Reply-To: <CAFEAcA9gzJGMqsEY5TuNmb74RskgUTMW+XcqGV53n3SsKyVVXg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Jun 2023 18:06:49 +0100
Message-ID: <CAFEAcA9aFv5c4S=Pyf3dMU-v9FnNJqWTQ7ZbiDQLTjh8Qou71g@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x135.google.com
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

On Tue, 2 May 2023 at 18:08, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 7 Mar 2023 at 18:27, David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > From: David Woodhouse <dwmw@amazon.co.uk>
> >
> > Firing watches on the nodes that still exist is relatively easy; just
> > walk the tree and look at the nodes with refcount of one.
> >
> > Firing watches on *deleted* nodes is more fun. We add 'modified_in_tx'
> > and 'deleted_in_tx' flags to each node. Nodes with those flags cannot
> > be shared, as they will always be unique to the transaction in which
> > they were created.
> >
> > When xs_node_walk would need to *create* a node as scaffolding and it
> > encounters a deleted_in_tx node, it can resurrect it simply by clearing
> > its deleted_in_tx flag. If that node originally had any *data*, they're
> > gone, and the modified_in_tx flag will have been set when it was first
> > deleted.
> >
> > We then attempt to send appropriate watches when the transaction is
> > committed, properly delete the deleted_in_tx nodes, and remove the
> > modified_in_tx flag from the others.
> >
> > Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> > Reviewed-by: Paul Durrant <paul@xen.org>
>
> Hi; Coverity's "is there missing error handling?"
> heuristic fired for a change in this code (CID 1508359):
>
> >  static int transaction_commit(XenstoreImplState *s, XsTransaction *tx)
> >  {
> > +    struct walk_op op;
> > +    XsNode **n;
> > +
> >      if (s->root_tx != tx->base_tx) {
> >          return EAGAIN;
> >      }
> > @@ -720,10 +861,18 @@ static int transaction_commit(XenstoreImplState *s, XsTransaction *tx)
> >      s->root_tx = tx->tx_id;
> >      s->nr_nodes = tx->nr_nodes;
> >
> > +    init_walk_op(s, &op, XBT_NULL, tx->dom_id, "/", &n);
>
> This is the only call to init_walk_op() which ignores its
> return value. Intentional, or missing error handling?

Hi -- I was going through the unclassified Coverity issues
again today, and this one's still on the list. Is this a
bug, or intentional?

thanks
-- PMM

