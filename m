Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C41A37749D3
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 22:05:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTSw6-0001md-9V; Tue, 08 Aug 2023 16:04:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTSw1-0001m1-5S
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:04:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTSvz-0002Jn-Hr
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 16:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691525042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gf1IW1h/BZx9wuIm4lEtnrh00sxzBTSoS6b0z86SAxQ=;
 b=FBJpgkbTQGxLyxrqnYmTqY7GLppd/KUE+WYn++AvmWECbS4RPgDGG5fxNN+9XTH3DEUmz0
 Tg5BcEm4TwJRfq+f5qsTuWrm+iTe1nL0Nlz85SA4War8BQakQeap0IyLXr1miamWJXTLAl
 bd9+Hrzi9s5M9yflQhgJU/F8PM1U/is=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-BL9e_hS9N6aszCv6mXLQRA-1; Tue, 08 Aug 2023 16:04:00 -0400
X-MC-Unique: BL9e_hS9N6aszCv6mXLQRA-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-44757a2405eso136684137.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 13:04:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691525040; x=1692129840;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gf1IW1h/BZx9wuIm4lEtnrh00sxzBTSoS6b0z86SAxQ=;
 b=JINTlIvRPvda00Gt6EJmGLJewgafDs6C4pOQZ72ckV6VQP/YDNItLoPrBaTwUxasTr
 FZzWsQZOojTYvM9EChEmVkhJOXvJYYMJgjuO0iA0t+0A1Opr/xk4sIp90r6890EuUhfz
 BvcjPwNrligQSrxU73oWhk2q6zByvjVudHaqgs5181ueWw00QkvALpWZ+pm6ia4Fe1bu
 gD7KeM7VJsLD+mHbY+8hLDriF+eOFuOxpf21eA6YIAQlT5jLk+/BTAyoUhtvP2aaOqAL
 n8H01gcQwIvCFzGw4Ze5LSv7elKjUf36yyxzFF1B8lDH1IVnHbWgTdOFz0005HBcLF0z
 m9xA==
X-Gm-Message-State: AOJu0YyWiQvNx9U3b7K/gHsXczcdj1Sa8JSdjEt7FVdxtRmEjyrfoko4
 rghxRmzCe51eMu1Pie/IjIkjG4YlEhBI+lYpr6fCxa2x75cfGXWubRRF/WYn+Kv41763nxSsfZ4
 e5/dbpF8uW+8pwVk=
X-Received: by 2002:a05:6102:50a0:b0:443:5896:20fc with SMTP id
 bl32-20020a05610250a000b00443589620fcmr797097vsb.3.1691525039729; 
 Tue, 08 Aug 2023 13:03:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp9rZvuzDtkU2KwZ7Je3ilVemmdCEnaz06N4643ZcMQGdi9cqNhrfoGd7RwVqSyD+0+E4Fuw==
X-Received: by 2002:a05:6102:50a0:b0:443:5896:20fc with SMTP id
 bl32-20020a05610250a000b00443589620fcmr797084vsb.3.1691525039382; 
 Tue, 08 Aug 2023 13:03:59 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 x26-20020a0ca89a000000b0063d128e4439sm3966107qva.75.2023.08.08.13.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 13:03:59 -0700 (PDT)
Date: Tue, 8 Aug 2023 16:03:46 -0400
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
Message-ID: <ZNKfoqM0V6pcvrz/@x1n>
References: <20230803155344.11450-2-peterx@redhat.com>
 <87jzub8016.fsf@pond.sub.org> <ZM0EK3A/rnDPImXz@redhat.com>
 <ZM0g8iNXzv9LRo+w@x1n> <ZM0nX8qt1T3aZgNK@redhat.com>
 <ZM0rWiHF8voqOdyp@x1n> <ZM0r8VoF8w5vGw7p@redhat.com>
 <ZM1nXbjxWx9jvbjz@x1n> <87zg35x60f.fsf@pond.sub.org>
 <ZM/BGoSiDutVUoTF@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZM/BGoSiDutVUoTF@xz-m1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Sun, Aug 06, 2023 at 11:49:46AM -0400, Peter Xu wrote:
> > I think we have a tradeoff here.  If perpetuating the unclean and ugly
> > use of "" is what it takes to de-triplicate migration parameters, we may
> > decide to accept that.
> 
> I don't think it's a must.  As Dan raised, we can convert str -> StrOrNull
> for MigrationParameters. I assume it won't affect query-migrate-parameters
> anyway OTOH.
> 
> I assume it means there's nothing yet obvious that we overlooked on the
> whole idea.  Let me propose the formal patchset early next week.  It'll be
> mostly the patch I attached but just add those extra logics for StrOrNull,
> so the diffstat might be less attractive but hopefully still good enough to
> be accepted.

The new StrOrNull approach doesn't work with current migration object
properties.. as StrOrNull must be a pointer for @MigrationParameters not
static, and it stops working with offsetof():

../migration/options.c:218:5: error: cannot apply ‘offsetof’ to a non constant address
  218 |     DEFINE_PROP_STRING("tls-creds", MigrationState, parameters.tls_creds->u.s),
      |     ^~~~~~~~~~~~~~~~~~
../migration/options.c:219:5: error: cannot apply ‘offsetof’ to a non constant address
  219 |     DEFINE_PROP_STRING("tls-hostname", MigrationState, parameters.tls_hostname->u.s),
      |     ^~~~~~~~~~~~~~~~~~
../migration/options.c:220:5: error: cannot apply ‘offsetof’ to a non constant address
  220 |     DEFINE_PROP_STRING("tls-authz", MigrationState, parameters.tls_authz->u.s),
      |     ^~~~~~~~~~~~~~~~~~

Any easy way to fix this?  I.e., is there a way to declare StrOrNull (in
MigrationParameters of qapi/migration.json) to be statically allocated
rather than a pointer (just like default behavior of any uint* types)?

Thanks,

-- 
Peter Xu


