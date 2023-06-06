Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6AB724861
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 17:59:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Z4d-0003Oa-Pu; Tue, 06 Jun 2023 11:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Z4b-0003OB-6a
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6Z4Z-0004e5-Dm
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 11:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686067092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+5uzHUZaSB3OA3SmBouhwH6OEjMe1hZxZ5qEawo6Ds=;
 b=PrXh9/9mNamW7AHEUO3O11+HKDVRElEQAstazExYmpwtsbsEVjTHxK5Hr1aBlbWNu0t8WN
 aubHgxMTCOP5Amw2MlbjZZJLzJjGNdiBuzuHQo+P3+JFJkFZ32R9HroGO6PM1+jIFip7zI
 lg0gBcLQTwbUXZuPpXS+mdpyj3bdiLI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-rb1rzg9MOfes6NRC3QkVdw-1; Tue, 06 Jun 2023 11:58:11 -0400
X-MC-Unique: rb1rzg9MOfes6NRC3QkVdw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f871a1e3f9so4104241cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 08:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686067090; x=1688659090;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+5uzHUZaSB3OA3SmBouhwH6OEjMe1hZxZ5qEawo6Ds=;
 b=aI/G3+eIYe1JV/Z6c1l3yCf/SU7Qlfvh7zdKpG64PWJ/zy4XLmWYqmTi1LrAJaPEcy
 klQzwgcFJJv/pDaue5DJovM2ZYDKUGp1U8YiKgJ2JwyaGHKWzOCmvlTxVFKLw1CYkK/H
 ypIrHGsL0wVgaREmsswpM458IVqrDRHTSy1IaTnOJY48KFExh9Gsk5Gy7/4QMXCS0qcs
 0Z5wlIblObZTjx65WQsDFp1u2skQiT+UURx07P/m5mXBwsxGb2hD5WfEYY26F56P3V1w
 0M0TmGtsymmgmZTdCV++vEN41H92Vqt7dtZwERvtJkffU2wioR/Qq50aHjnSPw6/jxIA
 02gw==
X-Gm-Message-State: AC+VfDyOTLXlRfCPM6TBrGqkkTPwXyFpMGLPeHiAOrj9WRYWYTrp9Lu1
 HAqW+1XCN368XNNzzQyefHE6qa3JpZohs4b5XTR4h6tqJpySoScBwthTIepkgHmkBWU0f9nnPrx
 z3UDcq9V6yHfEyAo=
X-Received: by 2002:ac8:58c5:0:b0:3f9:ab2c:8895 with SMTP id
 u5-20020ac858c5000000b003f9ab2c8895mr3268175qta.3.1686067090725; 
 Tue, 06 Jun 2023 08:58:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Z0n7RFDUHOHhTSr91VBrkOc/mp5gm4yBnhuRS5kYZDt5IZhfYHpmGRur8Mz7qD3VUd0zLzw==
X-Received: by 2002:ac8:58c5:0:b0:3f9:ab2c:8895 with SMTP id
 u5-20020ac858c5000000b003f9ab2c8895mr3268146qta.3.1686067090450; 
 Tue, 06 Jun 2023 08:58:10 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h8-20020ac87448000000b003e635f80e72sm5617980qtr.48.2023.06.06.08.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 08:58:09 -0700 (PDT)
Date: Tue, 6 Jun 2023 11:58:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>
Subject: Re: [PATCH 1/2] migration: switchover-hold parameter
Message-ID: <ZH9Xj6+Xfi62UegG@x1n>
References: <20230602144715.249002-1-peterx@redhat.com>
 <20230602144715.249002-2-peterx@redhat.com>
 <0c459f0c-1a04-f460-2b51-e8c3f997370d@nvidia.com>
 <ZH4IFK7tq47Ympze@x1n>
 <0a0c4cb8-042f-a1a1-f283-1b5ba14a0805@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a0c4cb8-042f-a1a1-f283-1b5ba14a0805@nvidia.com>
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

On Tue, Jun 06, 2023 at 03:34:26PM +0300, Avihai Horon wrote:
> Yes, it's specifically for qapi. It's documented here [1].
> 
> Thanks.
> 
> [1] https://lore.kernel.org/qemu-devel/20230428105429.1687850-16-armbru@redhat.com/

Thanks, I'll repost soon.

-- 
Peter Xu


