Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E2E737036
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6w-0003jP-D7; Tue, 20 Jun 2023 11:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBd6u-0003fG-UL
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qBd6t-0007cI-GS
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RxdPLqv9LzN2HBCEJzvr/k5ah1/TMGcT5+RGfAmDW8M=;
 b=JtkPSQ6tZSTJse3y5R98dJXTqCukgKwFZPHNF7B+IPrOmp7XgMeU+YMugaxV2pgoBNHjbF
 NZqDTRdrvlTEFVVxCfM2qqWL2uXLfwtTlPU0KGW1QHDUh2XaPVI8OaSHj4pCz6PMYPsWTF
 SMfuKjnFV74YLXF6g5BBzu2J0VSWCY8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-nGz6pk1POVC_CawuHOfBFw-1; Tue, 20 Jun 2023 11:17:23 -0400
X-MC-Unique: nGz6pk1POVC_CawuHOfBFw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-74faf5008bbso111059285a.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:17:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274243; x=1689866243;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RxdPLqv9LzN2HBCEJzvr/k5ah1/TMGcT5+RGfAmDW8M=;
 b=gMSSzeSMUll8SD89ZkGqFoyKLuvZfcxJ+BEqF8EERD0cAOCwj4VyEodPwvBe/r30BZ
 MHQwxU8AMFjpDGXYxK9JWCaH0exjIrI9ThnM4zLeI2+Ii/DSoZypKfwMbRVqIfsOxYJJ
 7Tr9OtGDiRfhJ/cRc41ELbSznqnuJXKYNtTckznB8NYpSL1TDEH6lCFfan5I9WMmcRh/
 JH7+EXVD8iP6pfWpGnA3sdyy1TLaPaVY4qpNoO6baJzckw28fYqBD/e1cR9lY5rWnLct
 NfDpJSc5hyCKteE4YmdnVO6n43o01jaCQK1H/0WbqNioInv3oXtul4wVtbRJ7H/CugRm
 yXNg==
X-Gm-Message-State: AC+VfDyYwiSUoUTa0uXRKOq3zs6lLc803TGL+rGcAqAokijqKBMGdrTj
 iN6ExP7FJAS2iyvywyklGn60GfZdF+yg9meaPhb2Vh+iQOoXL8vw5SvDil88eh6tRV84hQH/nNN
 KNFTa0Z7jszt0ekg=
X-Received: by 2002:a05:620a:444c:b0:763:a1d3:196d with SMTP id
 w12-20020a05620a444c00b00763a1d3196dmr6414241qkp.0.1687274242971; 
 Tue, 20 Jun 2023 08:17:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6+OJeLnc429TU88KbwaUQKDMvTw9TfdK8K94Bpe9aCBctU15P6eTMh7EMzOnMR2EqqjC2pgQ==
X-Received: by 2002:a05:620a:444c:b0:763:a1d3:196d with SMTP id
 w12-20020a05620a444c00b00763a1d3196dmr6414216qkp.0.1687274242701; 
 Tue, 20 Jun 2023 08:17:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c9-20020ae9e209000000b007623e63f642sm1239354qkc.32.2023.06.20.08.17.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:17:22 -0700 (PDT)
Date: Tue, 20 Jun 2023 11:17:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 09/42] migration-test: Add bootfile_create/delete()
 functions
Message-ID: <ZJHDAcQoSPxOPx+O@x1n>
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-10-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608224943.3877-10-quintela@redhat.com>
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

On Fri, Jun 09, 2023 at 12:49:10AM +0200, Juan Quintela wrote:
> The bootsector code is read only from the guest (otherwise we are
> going to have problems with it being read from both source and
> destination).
> 
> Create a single copy for all the tests.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


