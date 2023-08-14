Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E9677C369
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 00:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVg09-00077Y-9x; Mon, 14 Aug 2023 18:25:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfzP-00073Y-6t
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfzN-0006Ta-J1
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692051880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rVCQDuqVNoZT0tcQSU6926PrT5/oGwtplgEOJKQ7epI=;
 b=Y5pMW1AA1CK8yN+4d8XSojKry8EY69mO0Y25wccjwkI4Ln30VG581N/kefGbLKRHcRZb3f
 2TULpyuZ3A0JzrXOvYWZ0t6/XTF/cA8kwQJhiOowuMCdLr/ZlEoriKyAmryI1A0Tnrja/Q
 aG/dZNijZcnJMHLvIpOKXalodx1md1A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-MK68heVdMeW5bC_g87T45g-1; Mon, 14 Aug 2023 18:24:38 -0400
X-MC-Unique: MK68heVdMeW5bC_g87T45g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cc6815f23so119381485a.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 15:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692051878; x=1692656678;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rVCQDuqVNoZT0tcQSU6926PrT5/oGwtplgEOJKQ7epI=;
 b=NYEOdsoWlOs+9Zjdc8ptmyMYmLF54F0Q/VPx5jXYB4MvwC2EqbC6iXs8e/YoallxmC
 xuPXN+MLxa+iOPzd5hcG2bVC5GdlehzqLhWAYTeEfmzTPFHFZunkoI600MQ7Tz++X08s
 UZEl9O/UXc4wWaBvA9P6w6GdwHmyUJGcBkduPksdzNp9XEZAe5056GcuMKN+QdB4xpYH
 W5TOINVVeRWXQCSUi5/5SSV0GEGFxnIRGrdIHXcITDvd+TfKBr+TbgHw1rl0DKFIgoe0
 tqt3OfF4Zrsj+HTdwLBqvvVSLK2uLqeiAIX1qPcP+zq3JejCZfXHF380YYt78GQsirlM
 c7jw==
X-Gm-Message-State: AOJu0Yzc78I/AXWmBrgFomZ5OTpoO8683YEMFWCvIOBHY97wgAgFfEWH
 biijLDBc0Nwr6kqr/qooGVX3dYaVUEzNO5e25mMhHI9oNhYEGc4QPXNJf/L0v3jPqgt69TbvnKd
 NCGe+3NNvHUmvuCU=
X-Received: by 2002:a05:620a:1994:b0:76c:b3a0:526e with SMTP id
 bm20-20020a05620a199400b0076cb3a0526emr15102489qkb.6.1692051878226; 
 Mon, 14 Aug 2023 15:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0/s+WTNDX8bGnmhiXMTlgu5ON2OUboaTXuW1IccEh83toNK81WKUJ0F4SFUGDCR29Y8Ek0A==
X-Received: by 2002:a05:620a:1994:b0:76c:b3a0:526e with SMTP id
 bm20-20020a05620a199400b0076cb3a0526emr15102478qkb.6.1692051877982; 
 Mon, 14 Aug 2023 15:24:37 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ig4-20020a05622a6a4400b0040553dac952sm3350615qtb.28.2023.08.14.15.24.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:24:37 -0700 (PDT)
Date: Mon, 14 Aug 2023 18:24:35 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Zhiyi Guo <zhguo@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 1/2] qapi/migration: Deduplicate migration
 parameter field comments
Message-ID: <ZNqpows50zk32Vs7@x1n>
References: <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n> <ZM0nX8qt1T3aZgNK@redhat.com>
 <ZM0rWiHF8voqOdyp@x1n> <ZM0r8VoF8w5vGw7p@redhat.com>
 <ZM1nXbjxWx9jvbjz@x1n> <87zg35x60f.fsf@pond.sub.org>
 <ZM/BGoSiDutVUoTF@xz-m1.local> <ZNKfoqM0V6pcvrz/@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNKfoqM0V6pcvrz/@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 08, 2023 at 04:03:46PM -0400, Peter Xu wrote:
> On Sun, Aug 06, 2023 at 11:49:46AM -0400, Peter Xu wrote:
> > > I think we have a tradeoff here.  If perpetuating the unclean and ugly
> > > use of "" is what it takes to de-triplicate migration parameters, we may
> > > decide to accept that.
> > 
> > I don't think it's a must.  As Dan raised, we can convert str -> StrOrNull
> > for MigrationParameters. I assume it won't affect query-migrate-parameters
> > anyway OTOH.
> > 
> > I assume it means there's nothing yet obvious that we overlooked on the
> > whole idea.  Let me propose the formal patchset early next week.  It'll be
> > mostly the patch I attached but just add those extra logics for StrOrNull,
> > so the diffstat might be less attractive but hopefully still good enough to
> > be accepted.
> 
> The new StrOrNull approach doesn't work with current migration object
> properties.. as StrOrNull must be a pointer for @MigrationParameters not
> static, and it stops working with offsetof():
> 
> ../migration/options.c:218:5: error: cannot apply ‘offsetof’ to a non constant address
>   218 |     DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds->u.s),
>       |     ^~~~~~~~~~~~~~~~~~
> ../migration/options.c:219:5: error: cannot apply ‘offsetof’ to a non constant address
>   219 |     DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname->u.s),
>       |     ^~~~~~~~~~~~~~~~~~
> ../migration/options.c:220:5: error: cannot apply ‘offsetof’ to a non constant address
>   220 |     DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz->u.s),
>       |     ^~~~~~~~~~~~~~~~~~
> 
> Any easy way to fix this?  I.e., is there a way to declare StrOrNull (in
> MigrationParameters of qapi/migration.json) to be statically allocated
> rather than a pointer (just like default behavior of any uint* types)?

Posted a version with 'str' replacing 'StrOrNull'.  Let's move the
discussion there:

https://lore.kernel.org/r/20230814221947.353093-1-peterx@redhat.com

-- 
Peter Xu


