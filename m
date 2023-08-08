Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D37774CFB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:24:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTUBA-0005bM-Kc; Tue, 08 Aug 2023 17:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTUB8-0005aZ-7H
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:23:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTUB6-0000V5-Lv
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691529823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZJtjkxpyExzGRDkmlguulXQVSBnY8m3jR93zJKi43y8=;
 b=GkqbLsTBICmHuVaDU9uLZb+yccPwmURdjnyD4TwMTD0xezT+ysRcuiEOQtGaBx4KrAHYEX
 xvxIoBl8jE+ELRnD/NTgXnj7StJdOW3gA+J6AOyEe4/0CB+4EXk8OMgVeTbHvM22LYnZHV
 b4XMNL0dwvykRYOv74zVtpX1neDObrM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-5mMc94gIPZ6Nppn2RR1-OA-1; Tue, 08 Aug 2023 17:23:42 -0400
X-MC-Unique: 5mMc94gIPZ6Nppn2RR1-OA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63cebe9238bso18026356d6.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691529822; x=1692134622;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZJtjkxpyExzGRDkmlguulXQVSBnY8m3jR93zJKi43y8=;
 b=OavdIKHDuXw2gKD+FRGoKm4v2k7LuGPgqA+Rt7lhUQ4UIIxjwF1VcG3jsehsXKVI7/
 KfuTuprnAXLytJvRztITpfeHAFnYPH6VpLg6dbvtr2n7jXQQGMY0T/IMJHB8jUXojc4N
 Ipl4fw0Q77rFFVwYMzLtf/9S6QPgtnYDAcodLkDgT/xNVRcgUcFuycHxgmuFzWWtKeFX
 msaKn3GxVI/4AUGNHspSrStQfs+RRQsufNAKBt5RM2sF+ElRoaPjDxXXue8H+O9x5j7+
 phsx7ZsYOC84w4O+sDDMdIXZ4ghbI2KDevKiFTR/7sV5Eb80kHmPK82IeFho+XbC1xiM
 Go5Q==
X-Gm-Message-State: AOJu0YwbsLvABD882OxlT4HIcv+YB/pgHURGT6tDP89ek6XNLuWjKuU3
 urJkEmLdRRqyBP55j7nWGneYPxQmWAwshVol6Idz8iCuM5xV3X3I2tIj0rlWStVQvQR22/3O17e
 ASy+fJFzb1zmoCPc=
X-Received: by 2002:a05:6214:2a82:b0:63c:f852:aa30 with SMTP id
 jr2-20020a0562142a8200b0063cf852aa30mr749333qvb.0.1691529821800; 
 Tue, 08 Aug 2023 14:23:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFitugVCTp0BJqmwNqTyUsWywkC49zDhqyzG31TC1819Pz+WEvwpydYDyEePbawKGLzPRY6ug==
X-Received: by 2002:a05:6214:2a82:b0:63c:f852:aa30 with SMTP id
 jr2-20020a0562142a8200b0063cf852aa30mr749321qvb.0.1691529821517; 
 Tue, 08 Aug 2023 14:23:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c12-20020a0ce14c000000b0063d162a8b8bsm3939345qvl.19.2023.08.08.14.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 14:23:41 -0700 (PDT)
Date: Tue, 8 Aug 2023 17:23:37 -0400
From: Peter Xu <peterx@redhat.com>
To: ~hyman <yong.huang@smartx.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Maintainers: 
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>;
Subject: Re: [PATCH QEMU v3 1/3] tests: Add migration dirty-limit capability
 test
Message-ID: <ZNKyWfI7VNaLs2NK@x1n>
References: <169146128144.15119.10176158487539386358-0@git.sr.ht>
 <169146128144.15119.10176158487539386358-1@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169146128144.15119.10176158487539386358-1@git.sr.ht>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 08, 2023 at 12:46:45AM +0800, ~hyman wrote:
> From: Hyman Huang(黄勇) <yong.huang@smartx.com>
> 
> Add migration dirty-limit capability test if kernel support
> dirty ring.
> 
> Migration dirty-limit capability introduce dirty limit
> capability, two parameters: x-vcpu-dirty-limit-period and
> vcpu-dirty-limit are introduced to implement the live
> migration with dirty limit.
> 
> The test case does the following things:
> 1. start src, dst vm and enable dirty-limit capability
> 2. start migrate and set cancel it to check if dirty limit
>    stop working.
> 3. restart dst vm
> 4. start migrate and enable dirty-limit capability
> 5. check if migration satisfy the convergence condition
>    during pre-switchover phase.
> 
> Note that this test case involves many passes, so it runs
> in slow mode only.
> 
> Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


