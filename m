Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C2A7EC8E8
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:46:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3J0O-0001vL-Ot; Wed, 15 Nov 2023 11:44:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r3J0M-0001vC-Tl
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:44:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r3J0L-0002R0-9V
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700066680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2uQetALKKPH6KhV2qRu5amUeImNb6TxJ3p15OXOG+qI=;
 b=Xaj+JTL/ZzywYlHsgmHeLabTdZT7LA/T4Na76u2NdFWe5RVVr4L3QyPLnyOWy2OjCBoW+O
 1KlhsU0EQPvzCZovfmU8URiAR75GGY/6A5VGtRyqyRPHt+fGCsR0oKfvnYOn4Z2CfDwpXQ
 jFMnkIjCdnFmfN7sjXIksYP9JsSzuPE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-SzYkHJUlM7231yNi5ZIOMg-1; Wed, 15 Nov 2023 11:44:38 -0500
X-MC-Unique: SzYkHJUlM7231yNi5ZIOMg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-66ffa15d354so14270826d6.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 08:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700066678; x=1700671478;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2uQetALKKPH6KhV2qRu5amUeImNb6TxJ3p15OXOG+qI=;
 b=TnsIsb5t+jMUbaxJGU+fkbg08CSQdzKup1Rq482RLqJ9yiOUaTyTen2zByt8ekJqgw
 gGRyhf4icVLRD5iF9Qua33BNPa6fVmCctbh5T6pjCoupOWAtqDMpYaUJONi6nmKUlpRz
 qhGhKk8K9IDJXYmdJR2VCCrsTEW85/Shgk6LttJBtRYvPkSYhYcKAogC2NnjOVrm6LNI
 3vI56pdcqz7YgjAAmnEuNik/9IFcMkkj4IuRVicJpJA/+C7HMfIH6YjPrYunIn/OGvjG
 Aj7zeoa3jcSbskacS8pwHCOpyceVBriPZXizZbRWm+Gj3ycJqwENNAJcOo7pFEElTciq
 bRwA==
X-Gm-Message-State: AOJu0YyLQHcvw+YzlWm4zOSVg2krKEB42Hc3mBv3alk+oXiNcp+rKUti
 xytbnJnMg24Sadbi//+Zh0ag0LR7MwNeiW2493lhcZyfgeqRIbHVHbYX5+sK06tbqmGEwltu2VZ
 SMnAd7akxwxyHMNs=
X-Received: by 2002:ad4:4d05:0:b0:66d:264c:450f with SMTP id
 l5-20020ad44d05000000b0066d264c450fmr6056270qvl.0.1700066678031; 
 Wed, 15 Nov 2023 08:44:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkkiGQJfU60FC4lPDDFs4bT1IdD+9Guwf39KDYQKkQVBgsvnjFVLMLUju5gN0sWUrMY0xYGw==
X-Received: by 2002:ad4:4d05:0:b0:66d:264c:450f with SMTP id
 l5-20020ad44d05000000b0066d264c450fmr6056236qvl.0.1700066677651; 
 Wed, 15 Nov 2023 08:44:37 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p6-20020a0ce186000000b0065b08bb01afsm649433qvl.124.2023.11.15.08.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 08:44:37 -0800 (PST)
Date: Wed, 15 Nov 2023 11:44:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Zongmin Zhou <zhouzongmin@kylinos.cn>, quintela@redhat.com,
 farosas@suse.de, leobras@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] migration: free 'saddr' since be no longer used
Message-ID: <ZVT1c3Ptd_P3Nfb_@x1n>
References: <20231115032739.933043-1-zhouzongmin@kylinos.cn>
 <ZVSUFTBwSKHxVV_9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZVSUFTBwSKHxVV_9@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Nov 15, 2023 at 09:49:09AM +0000, Daniel P. Berrangé wrote:
> On Wed, Nov 15, 2023 at 11:27:39AM +0800, Zongmin Zhou wrote:
> > Since socket_parse() will allocate memory for 'saddr',
> > and its value will pass to 'addr' that allocated
> > by migrate_uri_parse(),so free 'saddr' to avoid memory leak.
> > 
> > Fixes: 72a8192e225c ("migration: convert migration 'uri' into 'MigrateAddress'")
> > Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> > ---
> >  migration/migration.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 28a34c9068..30ed4bf6b6 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -493,6 +493,7 @@ bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
> >          }
> >          addr->u.socket.type = saddr->type;
> >          addr->u.socket.u = saddr->u;
> 
> 'saddr->u' is a union embedded in SocketAddress, containing:
> 
>     union { /* union tag is @type */
>         InetSocketAddressWrapper inet;
>         UnixSocketAddressWrapper q_unix;
>         VsockSocketAddressWrapper vsock;
>         StringWrapper fd;
>     } u;
> 
> THis assignment is *shallow* copying the contents of the union.
> 
> All the type specifics structs that are members of this union
> containing allocated strings, and with this shallow copy, we
> are stealing the pointers to these allocated strings
> 
> 
> > +        qapi_free_SocketAddress(saddr);
> 
> This meanwhle is doing a *deep* free of the contents of the
> SocketAddress, which includes all the pointers we just stole.
> 
> IOW, unless I'm mistaken somehow, this is going to cause a
> double-free

Right.  I think what we need is a g_free(saddr), with a comment explaining?

Or, is there better way to do that?  Something like a QAPI_CLONE() but not
exactly: we already have the object allocated.  We want to deep copy it to
the current object only on the fields but not the object itself.

-- 
Peter Xu


