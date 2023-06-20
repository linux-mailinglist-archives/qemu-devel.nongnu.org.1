Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B49A737538
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 21:44:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBhFl-0004p6-CI; Tue, 20 Jun 2023 15:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBhFY-0004oe-Pu
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:42:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBhFU-0000Yh-Q4
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 15:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687290162;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EkAePTr8A0Bbm4IQRiLssqvdCdh9/GKBcKXM4/UMnOo=;
 b=DqdWBSi0rxXlnL7lNG5Ed0iJhc7YpMITWz5fzJ2rHaCGAl4JC9Ts24b6Bm/CCzpXg1CWQp
 qpSb0+sv1pdQJWJ+bkZ8rfgwlGr1YUTUYRhoSrfnAq68tj+cvO95DrAW4vmzhSYLD7Arek
 xc0zk/oYqq5NoLhZl8L0LQ6VshxiG/o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-gqopydWmPh-C2KF3atJf-g-1; Tue, 20 Jun 2023 15:42:37 -0400
X-MC-Unique: gqopydWmPh-C2KF3atJf-g-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7625940fbf3so49250085a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 12:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687290151; x=1689882151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkAePTr8A0Bbm4IQRiLssqvdCdh9/GKBcKXM4/UMnOo=;
 b=HP3H97zAptPjtgR6lQvnlvR+PudwfxADIvZpqjKi5Y1OIRUtGQyPgIxQ398Pjjvzba
 N39ibergrjzk7gMadIdzrcdP0TNBCWP6fPGUZb+QUCEiK/Ak+oVoy7hRiL8rq9egOa4k
 8HbMZlhxqe5sjh6nKH2U+4RCunLJSD5mWGYZcKMmmfJoYo8vTaKfgWFTLfWjpr7QQ44r
 Op25jpt4Pev+KfjjQzwtKGPs4URaXRo/xudQCJ+NGF1rA3St1OU0oHp6dvLU0qVgV0RU
 YBLb/LjwoiIqPAAvST5eOoJdTqaDeNgBNio6EFYAbyTl1JZ47cYStS6nJ+qG3cfset5h
 kx5A==
X-Gm-Message-State: AC+VfDyoLLP0BHwLkHgE8UnQ1Trkod9V8ZXwNWb/tUQMP3nsqZNM1F33
 7j67SkFh9yOT86ElW4JaY/VsD2BsBJ2O3IcfV3MTb/au31EJC8rtESPuHIiTWixlgXVQXOqm/e+
 YnfjuUGaPZ+dB3f4=
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id
 j9-20020a05620a288900b0075b23a182a4mr16086155qkp.5.1687290151278; 
 Tue, 20 Jun 2023 12:42:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6myeOIekDxvgBssbWvVWOYkKFIimTqTBs+csJ2Coz5M79U/jY+6rEt5zlUBJXY46Be0Gb2bw==
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id
 j9-20020a05620a288900b0075b23a182a4mr16086140qkp.5.1687290150987; 
 Tue, 20 Jun 2023 12:42:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 pc21-20020a05620a841500b0075ca4cd03d4sm1445406qkn.64.2023.06.20.12.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 12:42:30 -0700 (PDT)
Date: Tue, 20 Jun 2023 15:42:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 01/42] migration-test: Be consistent for ppc
Message-ID: <ZJIBJWejPqh7hJpi@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-2-quintela@redhat.com> <ZJG9utW5qi04ZM7s@x1n>
 <43fe7106-78c0-c431-aab6-395158f131e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <43fe7106-78c0-c431-aab6-395158f131e8@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Jun 20, 2023 at 09:27:17PM +0200, Laurent Vivier wrote:
> On 6/20/23 16:54, Peter Xu wrote:
> > On Fri, Jun 09, 2023 at 12:49:02AM +0200, Juan Quintela wrote:
> > > It makes no sense that we don't have the same configuration on both sides.
> > 
> > I hope Laurent can see this one out of 40s.
> 
> I had some luck...

:-D

> 
> > 
> > Makes sense to me, but does it mean that the devices are not matching
> > before on ppc?  Confused how did it work then..
> 
> I agree we need the -nodefaults on both sides.
> 
> It has been introduced by
> fc71e3e562b7 ("tests/migration: Speed up the test on ppc64") (Thomas)
> 
> I think it works because destination side doesn't check for what is missing.

Oh!  Makes sense.. just notice this (fact). Then no fixes needed either.

> 
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Thanks, Laurent!

-- 
Peter Xu


