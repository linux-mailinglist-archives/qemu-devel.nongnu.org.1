Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D16749B5E
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:07:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNk2-0006m9-QH; Thu, 06 Jul 2023 08:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHNk0-0006lV-80
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:05:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHNjy-0005hS-KT
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:05:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688645141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dpsrKkCdFTvbHEAcFl7IrATej5Z/ON7JWoq5B6JCjlY=;
 b=DC2pvxH+Olem2GTjIJFZfmlhLKnRRDHdhQAgSvRM0hXj4WcqXXyPDTa01j+9wkYpj1A2h/
 FD9E7DKyx7N07eDsoP7anhcGwhJ5Fhi1NaiwhNv8/41b6F3+bFZ1M8v4rkVMmL/eyTsflA
 7Ic9jjKGSg3kM/u6sEbRbVXmX+IzxuM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-VMcoEuG8NImivwWkXBbd0A-1; Thu, 06 Jul 2023 08:05:39 -0400
X-MC-Unique: VMcoEuG8NImivwWkXBbd0A-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4034b144d3bso2031141cf.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688645139; x=1689249939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dpsrKkCdFTvbHEAcFl7IrATej5Z/ON7JWoq5B6JCjlY=;
 b=aiOkkGwRf3UvsexaSDQa4oytH2FTXulxeNotStf8sQlubYdPITkHkQXArMOc+3BnPN
 qha9b02cIq9KppNlRMno5vP66nJc9RSLbxgS+YDARtYQUQQFdhGltlwhwY/BJ8nNeayH
 XavjzATlks5K6sEATcEul69tTxgwi5IX/fHDIdKnlgTaHrYYGSLeX6pt300ACw2NK8p7
 MVOjPBUZ75Dca9K41Xac3nNQRxao/EGoYaLLLtRJDWbN7rbOEd1MB6jZFhsJzkCmUG+L
 OMTMXJmmJEiMJJIlDVE+lCtxCA+/StPPLoChGpxJoWjPeN1g9lZGdpnIg/mrYuC7rTHf
 Ebmg==
X-Gm-Message-State: ABy/qLY1JlD9T7vIqG46CLYWJdLk5G0D27HVJGvrYjPBgMQu9qkGXd9L
 5t0cLG1BQpIJfaC/55t6mY1aEJO9j2TqjzjFcief8UPaNrgCaD7fVtjsuWvtKYSjPDiCJ9I06AC
 jzYAAqIvt67UUm2o=
X-Received: by 2002:a05:6214:1c49:b0:635:e528:521a with SMTP id
 if9-20020a0562141c4900b00635e528521amr1586988qvb.5.1688645139188; 
 Thu, 06 Jul 2023 05:05:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFlsxr6GMPcji8rAk4rAan61aATxlSig5GOGe0alNSt2WYJ6xtV+YjURmZ8yc0S3BEILUT6Uw==
X-Received: by 2002:a05:6214:1c49:b0:635:e528:521a with SMTP id
 if9-20020a0562141c4900b00635e528521amr1586970qvb.5.1688645138865; 
 Thu, 06 Jul 2023 05:05:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f3-20020a0cf3c3000000b00635ef3a34ebsm798290qvm.48.2023.07.06.05.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 05:05:38 -0700 (PDT)
Date: Thu, 6 Jul 2023 08:05:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH 0/2] migration: trivialities
Message-ID: <ZKauEVBEYTcRqR+p@x1n>
References: <20230706102937.82490-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706102937.82490-1-lersek@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 06, 2023 at 12:29:35PM +0200, Laszlo Ersek wrote:
> SSIA; originally for RHBZ#2018404 (hence the links in the commit
> messages).
> 
> Cc: Juan Quintela <quintela@redhat.com> (maintainer:Migration)
> Cc: Leonardo Bras <leobras@redhat.com> (reviewer:Migration)
> Cc: Peter Xu <peterx@redhat.com> (reviewer:Migration)
> Cc: qemu-trivial@nongnu.org
> 
> Laszlo Ersek (2):
>   migration: factor out "resume_requested" in qmp_migrate()
>   migration: unexport migrate_fd_error()

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


