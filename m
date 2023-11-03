Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD167E0432
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 15:03:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyukA-00085t-C7; Fri, 03 Nov 2023 10:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyuk7-00085d-Dr
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:01:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyuk5-0005S1-Et
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 10:01:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699020104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7n1dCPTrSo26XAAGGMdCsD4Sm7sV/sMWNUraIPSDf2U=;
 b=fMI2V0DNHKoYpk7Nj2/azCvTFF2ATEE5pblG/6b8v+ZvOSmD2cjg98QR8HOtQhGR3OtjqZ
 aBzCmD3wdztRt6y30I2++Nr/ywMXZKgJcLthXzhOtYHxTyyNM80QBC4ZHm4XX0L8zDjV0+
 3gyfdWPnEjEeDBoebmFAZ8Bg4K20d5Q=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-LnSUTLwtNcmMRXsmg5888Q-1; Fri, 03 Nov 2023 10:01:42 -0400
X-MC-Unique: LnSUTLwtNcmMRXsmg5888Q-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41cd9e05c8bso2357441cf.1
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 07:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699020102; x=1699624902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7n1dCPTrSo26XAAGGMdCsD4Sm7sV/sMWNUraIPSDf2U=;
 b=q489BmiqfJsO7N48omBrxFnAF9XFXTVU16MT3lQUnClUovx4+K8v1j4G4CTm0Rd3//
 QRSQ/bnxLH6zrn+IZ8gEH94Ht1I8r3/wL7VADfn5OGEPm9XVreVqk7YnZmOcR6+mf0Hj
 TQo4tLt4R29MK5IV6QeI3yzKu4yQsuUGz5Oj0SI5FWuo6NnghPo725s5q6ScLWa19mG1
 4zrxaIvSvH84Eak10tkLJx0ekPROBtu/pB70EIL4RxeZA824osg749wD1KVPLO2uWepk
 phhEiw8jdxWHlTY0Sk9P0nodIOknWQv12MDilqEnOYAggR/0/gWHcdWLdNNgvI2tyQde
 QDwQ==
X-Gm-Message-State: AOJu0YzMTWUH/RaTrqFq0a+VABsAlgzNc4/GYZMsamdcWlayPustEil/
 OTk7FilQOBHSdgdrGEF9JOq9v0Xdnl4f8EwQK0RBVHZ6k1aX6H8WDuLhOwf1mJtfFWaYET051oe
 DHbsejiRJsNQWVcU=
X-Received: by 2002:ac8:5b86:0:b0:41c:d5bf:ee35 with SMTP id
 a6-20020ac85b86000000b0041cd5bfee35mr25081365qta.5.1699020101518; 
 Fri, 03 Nov 2023 07:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXyfZnG2Z8gCsz6TxrFaXuzFP/M6p4tPaJzblJUG9oh9OI3JuXDlehM3XotU8kY5N+0sw60A==
X-Received: by 2002:ac8:5b86:0:b0:41c:d5bf:ee35 with SMTP id
 a6-20020ac85b86000000b0041cd5bfee35mr25081312qta.5.1699020100982; 
 Fri, 03 Nov 2023 07:01:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 bb29-20020a05622a1b1d00b00418122186ccsm732974qtb.12.2023.11.03.07.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 07:01:40 -0700 (PDT)
Date: Fri, 3 Nov 2023 10:01:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] migration: Unlock mutex in error case
Message-ID: <ZUT9Q8w6pdWXmR0S@x1n>
References: <20231103074245.55166-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231103074245.55166-1-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.47,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Nov 03, 2023 at 08:42:45AM +0100, Juan Quintela wrote:
> We were not unlocking bitmap mutex on the error case.  To fix it
> forever change to enclose the code with WITH_QEMU_LOCK_GUARD().
> Coverity CID 1523750.
> 
> Fixes: a2326705e5 ("migration: Stop migration immediately in RDMA error paths")
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


