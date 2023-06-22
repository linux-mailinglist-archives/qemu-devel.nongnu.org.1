Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ECB73A5DA
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 18:18:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMzU-0008Lx-HG; Thu, 22 Jun 2023 12:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCMzR-0008LK-9a
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCMzP-0004Rc-Tr
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 12:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687450615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWJ6zg2et6wOyca5/YYQOedAZfrx3sINWOKa6pJOvII=;
 b=XlShJoZywH+q9zCUOSPGnl8QSdsIwft1SRAQcF1UGd6Al3+hXIY3ov5ktMWw2IUzV1yrIo
 1LMCKYUf+49mL3I0LJBMnphN2h3wIJT+uIo+u3NODo+fm47GvQbgf1rYSFoMsP80EJ8jgg
 xIH2G/tX0xH2Cfk0Etdc19G+HnW3xcw=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-L588LxabOp-RF2P5eyG6jw-1; Thu, 22 Jun 2023 12:16:38 -0400
X-MC-Unique: L588LxabOp-RF2P5eyG6jw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5706641dda9so97429957b3.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 09:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687450589; x=1690042589;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bWJ6zg2et6wOyca5/YYQOedAZfrx3sINWOKa6pJOvII=;
 b=NTJZ6JVWapSPEYwvuFTIYokANQCN700ahL4X8DdHGulxTaiId3/5z8L9DVkuIPDDdj
 xEcsU+ng+nqyxbkli6p1sCuwHLabgbo5AQsE7Z6crX5QnWyw6jhdXsnvC6rKvn1fEkEG
 Nvp5MAoJ5DdHtQb/phKHml7ObIhv6DRvDPuXR8DGAuOs76QsJrNaS6/nCcmwgzo/G8iE
 799oahUted3rPv+A2xSy1ymzf3dvEFKdyszDPG1wzONKanRAFRPKJFDmSOMGjRbOC1Jo
 3vKcpcJqn28gM1BBToBkcB9/zxNFfILMvofzxlQpMueoFeukl4yem87oACJHONLZ1scg
 HeVw==
X-Gm-Message-State: AC+VfDx4X/Ph11bITMgkax2Xvy6ZYbF6XCrc8MDozFezHCwP0RzJaYja
 AvLwkAoOA9sU+dLvAyeGzXLQJsHQbPi8py7Gn0OMoETTwHQu2NDwtbkcWhOZb87Y5eGwc4tYO2t
 4lxq2rYz8x6Z6V9x1U3zHbUZvUJ8ifeg=
X-Received: by 2002:a67:f151:0:b0:440:b63f:1dd7 with SMTP id
 t17-20020a67f151000000b00440b63f1dd7mr6869311vsm.25.1687449815115; 
 Thu, 22 Jun 2023 09:03:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6B/MmxHaxkNF9JtjN6ldWDIERn1FN0D8238qA8/hXw4kDqheTzZ8tpuRkU+QXxMUk41zq34oUsLzK1pK6zsfE=
X-Received: by 2002:a67:f151:0:b0:440:b63f:1dd7 with SMTP id
 t17-20020a67f151000000b00440b63f1dd7mr6869289vsm.25.1687449814798; Thu, 22
 Jun 2023 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230612193344.3796-1-quintela@redhat.com>
 <20230612193344.3796-5-quintela@redhat.com>
 <ZId0+HYF/ETLVri3@x1n> <875y7sflqb.fsf@secure.mitica>
 <d88c707a-abd9-6c8e-907c-13a3fa9a0219@redhat.com>
 <87wmzv7ubn.fsf@secure.mitica>
 <59f958ac-807d-e940-e5de-8109de62eb8c@redhat.com>
 <87sfaj7r3g.fsf@secure.mitica> <ZJRnokKh47xe/4CE@x1n>
In-Reply-To: <ZJRnokKh47xe/4CE@x1n>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Jun 2023 18:03:22 +0200
Message-ID: <CABgObfZTipxvR6WvZTmt1+4mAdW=XuJasroS6y4LMN2L+YFuXw@mail.gmail.com>
Subject: Re: [RFC 4/6] migration: Deprecate -incoming <uri>
To: Peter Xu <peterx@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, 
 Markus Armbruster <armbru@redhat.com>, Leonardo Bras <leobras@redhat.com>, 
 =?UTF-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Eric Blake <eblake@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 libvir-list@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Jun 22, 2023 at 5:26=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
> PS: we may want to postpone this to be later than migration_object_init()=
,
> when/if there's a real patch.

Yes, that's true.

> > > The only incompatibility is for people who are using "," in an URI,
> > > which is rare and only an issue for the "exec" protocol.
>
> If we worry on breaking anyone, we can apply the keyval parsing only when
> !exec.  Not sure whether it matters a huge lot..

No, I don't think it does.

> > Aha, that makes sense.  And will allow us to deprecate/remove the
> > --global migration.* stuff.
>
> We may still need a way to set the caps/params for src qemu?..

The source can use migrate_set_parameters normally, since migration
has to be started from the monitor anyway.

Paolo


