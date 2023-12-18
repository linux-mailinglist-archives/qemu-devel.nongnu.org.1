Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A82538165F6
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 06:16:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF5yK-0006vd-IX; Mon, 18 Dec 2023 00:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rF5yF-0006vB-MA
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:15:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rF5yB-0003DB-67
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 00:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702876508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=us3d4nmHk3sAoZXoQzVjlol7teSSMXKMmltMJechvww=;
 b=GyhVXPcOMD2t1dNLv5mDM7HCXC/4CzeYXVDlidjbeMnJHEC4AYlVCt1TZ40DquFaL4PZ5r
 qtYmYWRb7MOU4MBGI/4Fytw+7V65FiI8gWnNyNlQIISbgeuY6MEFZQqt251QGWgDrzIk/I
 MpGkvwa/OKcu6tsYperdoFwu4k8lQkw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-DTDpr0zcMdagBd5D6O6maQ-1; Mon, 18 Dec 2023 00:15:06 -0500
X-MC-Unique: DTDpr0zcMdagBd5D6O6maQ-1
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-6d9f55f4765so987234a34.0
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 21:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702876506; x=1703481306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=us3d4nmHk3sAoZXoQzVjlol7teSSMXKMmltMJechvww=;
 b=jxN/zMNA0WnFi2Dm2nBW7YSKOWRGnxsS29E4R6R7Bi/s5wqp0a0NRIqrda4FirMNbF
 IkPJkryML/TS2tq6/huuE3vsznZ9/j6796cGwikE6na/YPp0XyuXh0U11CsGHXeKwN0Z
 pxi1/oM1FUM3CxWRiRReJmpYtfeMiTwDcZaerMDRlAldcxg+ljMEiTWdWu23NFReANsQ
 P/sAvyXpMbrb0+R4qo2oBmsYSm7TYaOWNJNUqGGqhu4lfnDKJsCNF2V4DQgcYXmdgJcl
 rXxu5wxstoS6a0iim7R9y96796cA7wY1WeNmL9K9gLLorpa+Ts3Ya3xcH0HRMm37QMgd
 i1Wg==
X-Gm-Message-State: AOJu0YwFLdGEyK4SgssgkYAgHGzRayHQe+jsQyN5WbUL7xS9h0eHwSrU
 2avPZAgOL5Fbi/qb2T2LRlyySqgpMkxbP74Jn0yT48GBiqBrw59CLEKI6FaA2CLn+KweNeCraKt
 XJTvRh+qd7+Xuk6E=
X-Received: by 2002:a05:6830:907:b0:6d9:d486:be6b with SMTP id
 v7-20020a056830090700b006d9d486be6bmr30313469ott.2.1702876505820; 
 Sun, 17 Dec 2023 21:15:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG4QA9KxY4Fn4YCPnsyU89ZFiETt7gugueZXTi477MfazzAvRiHFwSBh2R0w1CA/5uU2dzxlA==
X-Received: by 2002:a05:6830:907:b0:6d9:d486:be6b with SMTP id
 v7-20020a056830090700b006d9d486be6bmr30313443ott.2.1702876505570; 
 Sun, 17 Dec 2023 21:15:05 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 l2-20020a6542c2000000b005c621e0de25sm14460466pgp.71.2023.12.17.21.14.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 21:15:05 -0800 (PST)
Date: Mon, 18 Dec 2023 13:14:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paul Durrant <paul@xen.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, xen-devel@lists.xenproject.org
Subject: Re: [PATCH V8 00/12] fix migration of suspended runstate
Message-ID: <ZX_VS_KDsoiL9T2X@x1n>
References: <1702481421-375368-1-git-send-email-steven.sistare@oracle.com>
 <a9ddc1b2-d4fc-44de-857b-2aeb35fa0925@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a9ddc1b2-d4fc-44de-857b-2aeb35fa0925@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.086,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Dec 13, 2023 at 10:35:33AM -0500, Steven Sistare wrote:
> Hi Peter, all have RB's, with all i's dotted and t's crossed - steve

Yes this seems to be more migration related so maybe good candidate for a
pull from migration submodule.

But since this is still solving a generic issue, I'm copying a few more
people from get_maintainers.pl that this series touches, just in case
they'll have something to say before dev cycle starts.

Thanks,

-- 
Peter Xu


