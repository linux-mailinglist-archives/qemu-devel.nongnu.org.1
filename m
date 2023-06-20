Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD50736FD8
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcxv-0001FJ-PA; Tue, 20 Jun 2023 11:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcxu-0001ES-0A
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:08:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcxs-0005hI-Kn
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687273695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6F1oEqrndWj1RP/Af7EeRetzQoR+rF2Q+zBIDPxrJOw=;
 b=OnXfhHRNTxBoX5GI5tGn2PlamKci5H8zDV06XY0MXLIg5LaPjqCF33O7/cG15Q4TNtb3iA
 QTePu8jWocp3U0PtN0HY0oQs0e5RtP1laYA+uYVT5VLXKr/L5v27EvaIT/u2Blmibw8nCr
 xNh8p2fvAh5JL1FpdMh8sW+YhqQS6Wg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-ReOamY-YOqmtsLZrUn-ryg-1; Tue, 20 Jun 2023 11:08:00 -0400
X-MC-Unique: ReOamY-YOqmtsLZrUn-ryg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-62dd9986b76so9618786d6.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273671; x=1689865671;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6F1oEqrndWj1RP/Af7EeRetzQoR+rF2Q+zBIDPxrJOw=;
 b=D1HahlYBh9XuXEB1+Kmd/7WS9/qxXeZ8yHLSmDX2XqBBKfqtvI4rEQra5bfa7rlzUC
 BJSTUmofZ5Kr5uPoDn9tXm8MUAc9SFY0VNQrquiricPjbGjoEQ9UpXC1v5ZfehRwNoWN
 OaqOaUTbJwLCEk5+rv/3aRKCXmksjHwmLsRDUEQnM0adgxFQdBKTZozYXk2RAA4OOXRE
 bH3XiSlTtxHdtIvDzfxVppxDz1EaK+96ME/ejA5pJSr01oupfVrmUSszE3RKIF1Fb1Mh
 TzV+ZHi7Wmfx6mzffxOj6Mw1z/reCYKkgJWgGoVw+C1HnNXXbQl0CTJ3GmV9AsCT82/K
 ULaA==
X-Gm-Message-State: AC+VfDwEszgmN0/dndxVehz9dinBXnSZEvT1kIiIFytCoNuHTQQQDkTi
 KB66gKnO1w1rg2GwodVYdN4/gVOBgmUlmfzQ2lEsvnqd0GDtcyZNihrfcHa8ibhOw5Koxmj8Omh
 e39soUsx5eaNHlFXzE0kKrk8=
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id
 kd26-20020a056214401a00b0062deda34333mr15324171qvb.0.1687273671354; 
 Tue, 20 Jun 2023 08:07:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nFZa+8+s/khp+YKMqJTNiFy426J25oe04idAF/XJahu0dpQTASfquKdiPfhL9az6Xr/R4Dg==
X-Received: by 2002:a05:6214:401a:b0:62d:eda3:4333 with SMTP id
 kd26-20020a056214401a00b0062deda34333mr15324148qvb.0.1687273671054; 
 Tue, 20 Jun 2023 08:07:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 a16-20020a0ce350000000b006262e5c96d0sm1304769qvm.129.2023.06.20.08.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:07:50 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:07:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 07/42] migration-test: Create kvm_opts
Message-ID: <ZJHAxEt8MLImNOC3@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-8-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-8-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:08AM +0200, Juan Quintela wrote:
> So arch_dirty_ring option becomes one option like the others.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


