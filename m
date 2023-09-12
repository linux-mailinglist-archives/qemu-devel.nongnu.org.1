Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072F79D6DA
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:53:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6cx-0004zO-Co; Tue, 12 Sep 2023 12:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg6cr-0004zA-Ut
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:52:34 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg6cp-0000cy-Rq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:52:33 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1d4c9494b42so3997108fac.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694537549; x=1695142349; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pDXPtVvcCLWpk8TnXreh7+5uZdxUfruJIOWc8Dr1EHs=;
 b=TpK9vZG5nPDUs/V2V8fRKEmS30GETSByp0xGXJ+N+HJkbgB5AOEaVeKylpJZkFgzFR
 OKrRj0Dqhx0Q6mG7u8ONI+sqnnCe2nHhrcrJxuhofKzCHPkCbNC/M79hM8ETM+9xkPqu
 ZMtLwwa9+eTp1JXPAVS1qWuMVmi/Ac6syMFDJBccl2J+qSUpjYW2xrbwXeXTAZJ8bXan
 Iw6RbvxgrVY3nbO5kaY+BAERC/7LVjkzMI1+2MnQ3Ygjpxls+mcJPJ8GY5wzvHU7l5X4
 Z9leCKJgMyvJ5LtW4kUeC5/kOzUVfF/mECLaLHWe7XUXyLOyjPU8kgTRolA006RDtOFz
 WYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694537549; x=1695142349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDXPtVvcCLWpk8TnXreh7+5uZdxUfruJIOWc8Dr1EHs=;
 b=M32LeRiz4jq+rzeP8e1BqAuvv0gb9FswSgC/C28UA4hbTbYaeke9LSLaggzpFIK8Fe
 f/jMrdPA+puWGSvBEmnNlYAk/qb0yC8Moh562LEGHKPCGW21M4yP/iIQqZWUCfw+Ny+9
 vpDH4nPiY7u4Mdk4L07/5rrDuONIOeMhP5FiKKTxc4Y2eD/+3Tb/Lt+Qa57NVfqFBG1c
 6A29FGM40dWNj2JW+alwPxph52V8+JsupMi+XTCyPdMTjjA3H7FbrY5845OOh35TNMxo
 qFvEXTjBBlgNJMZ/fOaYNb1lYJD3Tu6EQv81e5dTUsFLkCxMasBXh69cOy0Iicb0g2mQ
 i8Kg==
X-Gm-Message-State: AOJu0YzR9oVUoHRE2VR6HgIK0FpxrG9ziipmjFqoMYmCneger0qXcyNY
 2Com1EMCTxIznZC5Upg3Nfwl/NzzSHyku4RknU4=
X-Google-Smtp-Source: AGHT+IHwgH15ypqmCmGeSD6bjFD2KDt6B//qdPtJs3sDb1uVcbtCoQ+D+BUaUNTubYzA4tMBfF3s4L8zq3vfGst1rNA=
X-Received: by 2002:a05:6870:459e:b0:1d5:e792:e7be with SMTP id
 y30-20020a056870459e00b001d5e792e7bemr73843oao.47.1694537549571; Tue, 12 Sep
 2023 09:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-3-stefanha@redhat.com>
 <ZQCTiTULn6rSDJSf@redhat.com>
In-Reply-To: <ZQCTiTULn6rSDJSf@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 12:52:17 -0400
Message-ID: <CAJSP0QUJWEBQOAbKRKGe9RRmMwGVmdvLs415nUX+_vs0__3Hrg@mail.gmail.com>
Subject: Re: [RFC 2/3] rcu: add drain_call_rcu_co() API
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, 12 Sept 2023 at 12:37, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 06.09.2023 um 21:01 hat Stefan Hajnoczi geschrieben:
> > call_drain_rcu() has limitations that make it unsuitable for use in
> > qmp_device_add().
>
> This sounds a bit vague with only alluding to some unnamed limitations.
> I assume that you mean the two points you add to rcu.txt. If so, maybe
> it would be better to add a reference to that in the commit message.

Yes, exactly. I will add a reference to the commit message.

>
> > Introduce a new coroutine version of drain_call_rcu()
> > with the same functionality but that does not drop the BQL. The next
> > patch will use it to fix qmp_device_add().
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> I don't understand the reasoning here. How does yielding from the
> coroutine not effectively release the BQL, too? It's just that you won't
> have explicit code here, but the mainloop will do it for you while
> waiting for new events.
>
> Is this about not dropping the BQL specifically in nested event loops,
> but letting the coroutine wait until we return to the real main loop
> where dropping the BQL is hopefully not a problem?

Yes.

Stefan

