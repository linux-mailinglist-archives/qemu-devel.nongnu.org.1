Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C83736FD6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:07:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcx3-0008ER-4P; Tue, 20 Jun 2023 11:07:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcx0-00084a-C2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcwy-0005Ub-VE
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687273639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ANiPZXkn8bkUJwZQttDj58B1ALcq0No2563fnzQ3l/A=;
 b=L9uR6b0MXqBWENg4ylm9iNGqZ5emDhsLtuCWDnL5h/JiQhDR6MXF0F97cp1XyrsMKmOqF8
 K5IrevKDFe7RTdTKNgS3XvDvxVFfVFYp8/y5GbCffkOruprTS5uIcizbyPezjsEpm3NR5m
 SQpvwQtftUoxz7qWYPJUe2ECCCUtqR8=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-ZISvXVbMNL6hoA17XNCUfQ-1; Tue, 20 Jun 2023 11:07:10 -0400
X-MC-Unique: ZISvXVbMNL6hoA17XNCUfQ-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-39c77d6b2b7so587203b6e.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273622; x=1689865622;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANiPZXkn8bkUJwZQttDj58B1ALcq0No2563fnzQ3l/A=;
 b=ctSXN3iIXVFGGC25CJ404y8b4J+aFyvb3CmUukq43IHY9AKr/64h8+eDUOLW7cYFrg
 7hahfq37agI89UvPMshTcQ4UcY+c5SwScmhNaXVSxDzy+0yP//Rc0XWIZJ8aqn1RwNPI
 CMubZuxGtVOY2to6sT0MVKqCizi9rmHodhuoqZ9+Uw2i0w1JbL4n0bzvI/pLgp12m8th
 dcVXk6RWkj88oE0eEvyxBhngoJ+4VzA3v5y5cPy7S82qwL88v/qoBtXjiyb4gKnJB9jm
 wAW7A0YmiYeOuOix3aaw/QAil3KW/l+IGG2YhXEpSQ2bMvm6KWYOMDRyLPoUQGcd73Mw
 7LaA==
X-Gm-Message-State: AC+VfDyXoLtPcimx1jQmjzl4eKGKvRWMdrDahg+uZGRQBYu3d19AWZv2
 o5KGdAeb1hCEIwbUjR5zfJHiGC8boTm/Mz1OwFjT+BLWhT98Pm8PJ2Sg9uGxWiOfN7NsZGBsQg3
 se9ti5vZMi/UNHts=
X-Received: by 2002:aca:f243:0:b0:39a:b2f4:b60f with SMTP id
 q64-20020acaf243000000b0039ab2f4b60fmr2764929oih.0.1687273622715; 
 Tue, 20 Jun 2023 08:07:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DQnLkzSn8cM4pq+LLfM/oGlC/PBdpL/IeoC7zNpRg1vD3urNYuCbpke6ZeHFxgoj2ikACmw==
X-Received: by 2002:aca:f243:0:b0:39a:b2f4:b60f with SMTP id
 q64-20020acaf243000000b0039ab2f4b60fmr2764914oih.0.1687273622413; 
 Tue, 20 Jun 2023 08:07:02 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d16-20020ac85350000000b003f6b0562ad7sm1205582qto.16.2023.06.20.08.07.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:07:02 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:07:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 06/42] migration-test: machine_opts is really arch specific
Message-ID: <ZJHAlQo/L1Bt5hFT@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-7-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-7-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:07AM +0200, Juan Quintela wrote:
> And it needs to be in both source and target, so put it on arch_opts.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


