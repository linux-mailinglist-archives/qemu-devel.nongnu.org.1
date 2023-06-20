Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997A73703A
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd7h-0005zS-Jb; Tue, 20 Jun 2023 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBd7f-0005ye-9m
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBd7d-0007t9-U8
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMSaBAowJz5vhp8VW9G3sF4B0OUz8zDcE8bxaFjCyYs=;
 b=I6ZIIvAxwU5ku2hF4aiU8ktX391GMhJqCRLQw8njFkp2FELH1PEjfUhMaxpIOHM2At4blF
 Jy4lMNNMkZOPS/BL1TaOou3nvNgMBy6by67df2peG+8mWnJTYqRunXGDGH5T3AQBEr1C6n
 NYNpKpGG4RbKVHZzovxNJG4X1dJl538=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-n718pGVlN5SfMh9rHRlocg-1; Tue, 20 Jun 2023 11:18:18 -0400
X-MC-Unique: n718pGVlN5SfMh9rHRlocg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7625940fbf3so44950485a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274298; x=1689866298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vMSaBAowJz5vhp8VW9G3sF4B0OUz8zDcE8bxaFjCyYs=;
 b=CGccU3XUqF2E8TpacSJbJGuPOm4914OExgFx8Sc1PjRouBJvGeHUkMhKTUHARlu16y
 9O8mBkFrXjbOnRkEJ2fYxF7kUXxWZk4PburS6OtFj/FQYdmKG7tQ/+aMtxkoPYwN/Pgr
 ZuvL9u5kUnOlduRbe6ZZ0fLOwxRPyZovPp0FfbaEz8YUgkPXxyeWZQXMUQ74m8fFfxSU
 HLK3dGV5DE2UBfVZ9aU4PUf5Q3GpqhWNOMr8ylUayobK1UQtPYe5ekLR2nqKuZHjHvK8
 3V3nfIkWgwDv4nldrejVA0u/CKE2zte04oLUd602oDDzYVXUP2cDcaVjjL2q/BQxHhlR
 u5qw==
X-Gm-Message-State: AC+VfDwnWbANO1KpA4/P3ZLIqIzsWMiLdtk79LL7dmMtJAhUJys20nNp
 FhSLf0xIjZZ6AZWttsT7EGFkdbE97nIQ8DM4UOV0s2AzQsJYScBnJQtz2eqrMvYsu2NAkRtLRYU
 IUEVyawTFzzRPuKQ=
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id
 j9-20020a05620a288900b0075b23a182a4mr15372116qkp.5.1687274297800; 
 Tue, 20 Jun 2023 08:18:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7E4MYoE9ehd1y2BK8V4lnbSePEt4pQ0nsAvs2tmJJF4UJEnbdh0yH4Yoa9XQpDdal8T69lkw==
X-Received: by 2002:a05:620a:2889:b0:75b:23a1:82a4 with SMTP id
 j9-20020a05620a288900b0075b23a182a4mr15372096qkp.5.1687274297564; 
 Tue, 20 Jun 2023 08:18:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 k16-20020a05620a143000b0074d489e517csm1226478qkj.24.2023.06.20.08.18.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:18:17 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:18:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 10/42] migration-test: dirtylimit checks for x86_64 arch
 before
Message-ID: <ZJHDONjMjF14rnRB@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-11-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-11-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 09, 2023 at 12:49:11AM +0200, Juan Quintela wrote:
> So no need to assert we are in x86_64.
> Once there, refactor the function to remove useless variables.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


