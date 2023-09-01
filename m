Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3E8790029
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 17:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6Qn-0000yl-PQ; Fri, 01 Sep 2023 11:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6Ql-0000yJ-Nz
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6Qg-0007L5-F3
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:51:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693583485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tLvza/wSmG1OupZ9zpi67sbtYCAsb6oMsH81gD05T7c=;
 b=JHHKGbVtwa/79MOakJikRtqKNCnTg+EEDTc/REmUm7MwXj7Z/t4m8ljiK7Lp9hbrRToGad
 4a2ypfJ9KU2I37PLOdqcHLtohsFsxHEcPLMdW1PyK5cq/XQBW+pcbau5m6AeVQgYZsIFfN
 ql3dgqj7DaK2xvTGaxnSDp+beUjXGIM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-WXdtO6KdN-q6D_XzjEvPPQ-1; Fri, 01 Sep 2023 11:51:24 -0400
X-MC-Unique: WXdtO6KdN-q6D_XzjEvPPQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40559875dd1so4308371cf.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 08:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693583484; x=1694188284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tLvza/wSmG1OupZ9zpi67sbtYCAsb6oMsH81gD05T7c=;
 b=XKO+PBjWWXQXrxxkeThUSdXdEK5STJtwtDDYRu5+G2gTALThgzgXdFaLHF1Rlf9VOr
 0f/Sc7D3ys1uhw9J5Z0iof+bcRczuIJ6x5HYm/EUdab164zx1NNhhE4IJnztzXd9AFWX
 WlXBDv+ciOnUymoNWU5F+j6l8V3EH8/bviO9MVJc2DB5IxhDbXLY0LHQDMY1SZmHwQYr
 awL4nDhlbCFCq9ZgZZv7s7ThY+ckSSn9DqCePAXSan7ShTZ01UW8J3bMa4Z8/SOUO64R
 4phpwAgPCYcWkoEazYbmgIgdoXWlBbIt+qSTV8MP++p3UM1VVPtrLjobYiYforSVo873
 rnVw==
X-Gm-Message-State: AOJu0Yxm7VFWV4mauMOH8KlQ1yH97k272xSY3tzqBTIcG6Bcn5dsfAaG
 oXosj89tmrD0zoCgmgQBhxFiYdViBvFyUGbQfbixkfZ9Drki+SKD7YUvlYxqeKngDELYVVwhd71
 AIYkhtb+D3zGNxaw=
X-Received: by 2002:a05:622a:180f:b0:411:ff8f:d5aa with SMTP id
 t15-20020a05622a180f00b00411ff8fd5aamr3049623qtc.3.1693583484069; 
 Fri, 01 Sep 2023 08:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUZf/IoAET+fDOF7FKTreSL0An7Qff2D1wc+QyfqoYN5NwiCB1gJ20KnZ386hA7YEEZck9ng==
X-Received: by 2002:a05:622a:180f:b0:411:ff8f:d5aa with SMTP id
 t15-20020a05622a180f00b00411ff8fd5aamr3049594qtc.3.1693583483775; 
 Fri, 01 Sep 2023 08:51:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ci8-20020a05622a260800b0040399fb5ef3sm1556117qtb.0.2023.09.01.08.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 08:51:23 -0700 (PDT)
Date: Fri, 1 Sep 2023 11:51:22 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH v2 5/5] vfio/migration: Block VFIO migration with
 background snapshot
Message-ID: <ZPIIeqj8VMyDz7iY@x1n>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-6-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831125702.11263-6-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 31, 2023 at 03:57:02PM +0300, Avihai Horon wrote:
> Background snapshot allows creating a snapshot of the VM while it's
> running and keeping it small by not including dirty RAM pages.
> 
> The way it works is by first stopping the VM, saving the non-iterable
> devices' state and then starting the VM and saving the RAM while write
> protecting it with UFFD. The resulting snapshot represents the VM state
> at snapshot start.
> 
> VFIO migration is not compatible with background snapshot.
> First of all, VFIO device state is not even saved in background snapshot
> because only non-iterable device state is saved. But even if it was
> saved, after starting the VM, a VFIO device could dirty pages without it
> being detected by UFFD write protection. This would corrupt the
> snapshot, as the RAM in it would not represent the RAM at snapshot
> start.
> 
> To prevent this, block VFIO migration with background snapshot.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


