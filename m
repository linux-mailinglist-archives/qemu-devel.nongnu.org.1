Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C14736FCD
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:07:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBcwU-0007qH-4L; Tue, 20 Jun 2023 11:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcwR-0007q2-A2
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:06:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBcwP-0005HS-RJ
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687273604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+xV2W8iJLtwPgFbCEJcFvKbu73DgXwf0uIxTkmndTFc=;
 b=SFELozHVmE9ZgkMlkcWhMTdjhq5114NAc1D8WRm2EuRk9Clr/42wihAKF9FQrBJfofRgsn
 SpzYg8/RF7dmg6L2/8dIn2+hfTrnvB73+XcOAvsGKc6hIfZOKPF/yTF+a67whV/ovnX9GJ
 H8ztWU/4h6Yk5J9vl5squbFxGif+qOQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-cyPy4VdEO0K2JiMZmZgqPg-1; Tue, 20 Jun 2023 11:06:39 -0400
X-MC-Unique: cyPy4VdEO0K2JiMZmZgqPg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3fde794cd50so7668511cf.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687273585; x=1689865585;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xV2W8iJLtwPgFbCEJcFvKbu73DgXwf0uIxTkmndTFc=;
 b=Ozr9w6AHDYE+WAmVIJ7o3OLMI1ZHUObo7LNcjnocfCFLFqcAvpe9uv1lyWn2u/92eS
 0Jng2L3INe8rt64blFqZnPOZVCrWBKQO+9pc7nOQIod5M6Eh1V0uAaop0uiIi9pdApn8
 xRj94dM4ffN/qBr3Hur3sVWYDmy8m5aDHh2D9QGFALHLV1NP2+yOKAe3oTsojjEy9aNG
 4LgQg5Ku6HCpdw80UoLBmBuRoNDIA1OfoPrFwxyLTST4SosSpOjOZOobrcSCN0zHWis/
 2Q4Z4a1gbzXDhVzFMJIvaG/BdfhlYmOEOen59iRiPstTfe8/qD1OZ0o8GSCza8si92+m
 ZApg==
X-Gm-Message-State: AC+VfDzT2g5qfGgfAbSawpkvlELPAlgeAhFEoVxQyTcN6TacL42hHHSX
 m5mry+NdfHWNa8BJpTDWVETkN26nO4ZXk28nzepmbchjdqRkfJgMVkk+Bgx2W0BY3qv1Marsji3
 fei3d2gVUrz6tBFI=
X-Received: by 2002:a05:622a:1baa:b0:3f5:315f:5c1d with SMTP id
 bp42-20020a05622a1baa00b003f5315f5c1dmr15540535qtb.4.1687273585517; 
 Tue, 20 Jun 2023 08:06:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7AvQ8lHFHDc+CZ06VZ8j8wTTksI8snyawXyzpOvuGeF6xMTYROaQhRPB2dzRGklZdbQK7wMQ==
X-Received: by 2002:a05:622a:1baa:b0:3f5:315f:5c1d with SMTP id
 bp42-20020a05622a1baa00b003f5315f5c1dmr15540502qtb.4.1687273585110; 
 Tue, 20 Jun 2023 08:06:25 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 i10-20020ac860ca000000b003f9cca00552sm1172252qtm.93.2023.06.20.08.06.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:06:24 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:06:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 05/42] migration-test: Create arch_opts
Message-ID: <ZJHAb2pOF+thc2vW@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-6-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-6-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:06AM +0200, Juan Quintela wrote:
> This will contain the options needed for both source and target.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


