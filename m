Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA6270BCF9
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 14:09:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q14LU-0000uw-6e; Mon, 22 May 2023 08:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1q14LR-0000ta-RG
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:08:57 -0400
Received: from esa5.hc2706-39.iphmx.com ([216.71.137.63])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1q14LP-0003Sp-NZ
 for qemu-devel@nongnu.org; Mon, 22 May 2023 08:08:57 -0400
X-IronPort-RemoteIP: 209.85.222.198
X-IronPort-MID: 292687626
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:IfDqDK/zAFtnJvyldQvFDrUDOXyTJUtcMsCJ2f8bNWPcYEJGY0x3y
 WRMDW2OPa2NYTD2LdEnOdi1/UlXsMWAz9VnTwY6pCoxFiIbosf7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yI6jefQHeCU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYqdDpMg06/gEk35q+q5WlC5gVWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv8z94X2mVTKlLjFVHmZkh+AsBOsTAbzsAG6ZvXAdJHAathZ5RlqPgqo
 DlFncTYpQ7EpcQgksxEO/VTO3gW0aGrZNYriJVw2CCe5xSuTpfi/xlhJEA/M9EGx+QmOEFPq
 sJICTwBUUGIre3jldpXSsE07igiBMziPYdao3I5iD+AXKZgTpfETKHHo9Rf2V/chOgURaeYN
 5dfM2A1Kk2RM3WjOX9OYH46tO6sln/zaRVStRSYqbdfD237ll0rjuiyboCLEjCMbd9uh36Tl
 nnbxVWnLSoDFt/AyiW83X3504cjmgu+Aur+DoaQ7/NvnRify3IeDDUQUl20p+T/jVSxM++zM
 GQR8ysq6LExrQmlF4itGRK/p3GAs1gXXN84//AG1TxhA5H8u26xblXohBYfMbTKaOdeqeQW6
 2K0
IronPort-HdrOrdr: A9a23:qvD87KjHkmUmfJ6x/RFxIi5fGXBQXgcji2hC6mlwRA09TyX4rb
 HMoB1/73TJYVkqNU3I9ertBED4ewKhyXcX2+ks1NWZMjUO41HYTr2KhLGKq1fd8kbFl9K1u5
 0OT0F1MqyUMbBc5fyKh3jfYq9QuOWvweSKoe/fynt3JDsaEZ2Ilz0JcTpyzCVNNW177aJQLu
 vg2iPtnUveRUgq
X-Talos-CUID: 9a23:Hjy/T21Mwaq+i0Tzrr4oL7xfG8krLmPgzibpA07nNzZIRLGqGFS69/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ALSqB1Q5NeYKOlOBnXuA0/mjdxoxy2L2WA3AWjK8?=
 =?us-ascii?q?35ea/LA5zZDSCtRu4F9o=3D?=
Received: from mail-qk1-f198.google.com ([209.85.222.198])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2023 08:08:36 -0400
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-759555c944dso474208085a.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 05:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1684757315; x=1687349315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DyZAyccGgGbIklvT3S2ttTlRF6QRBnOHm93pDXLBvjk=;
 b=S9EwX/YMCg3EwLxaTQFJ+BfIeaDBVMB5hg7scUtNJEPHr07bk+S41VWatn7cQOPxSQ
 9ZQ+pq03l7Bgu8xwFPUzKSvEBHhz05gN4vS3qGRdtoEB1JO7fMa+z8Vmqms2KqSwMpS1
 NX1EfU4Na8Tnl+PDJa7BR291Ni7aJJVXdrUOvPi2qMpiiqxsGuaVIQPyeP7HNG9IcjjD
 fitODmYDWs00rQ1zc4S5mVBbbDhi08vdagIPH3Q1G/5fziKeE+icjHxOYqmipCYSt77H
 oiR5BtKJtA51XPMcMe5BAFi0Vlwn8S+ClULAw6zQsZUkmj3ASnhvxBXFPgoziBW93DP/
 dboQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684757315; x=1687349315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DyZAyccGgGbIklvT3S2ttTlRF6QRBnOHm93pDXLBvjk=;
 b=K45jlCm6xlp34lojhEAEm6WV3jWfWr1xVWChGxHq/j56vljL+wXEFsQHZAYI5MIl7l
 Awy+JLgWVIkELVR3n9ZUYPEhf2/F4JIYEE9D/lDVeqLv7thyA7MDoE0N2TlQCyCI6tDe
 LZjD+aqu1hoCM7uy4VbMQ8btWsGzdZ4J3abdRh3YFAIQqLBHg2JqHgpNN7mxy6PEKT4w
 aO0mdWrapdiukNHhw/2sbsF6Yw/ETnzSWt1aMdv7F8cnhk6dmmuLzeCdEtCtRKfS+1vn
 LxMZkCjPqIRGzdjj+QjyMT4pg2aYk5y908Z8tqTv4s8vPW1zjGKuC0a1uc5fiAjAvG5y
 nVPg==
X-Gm-Message-State: AC+VfDzbIeWcGUMHj9MCI6whqMltmTVc55AbPe8n/+InEQKjQEK8TDS4
 Ua1BDARy1kEacOvYWyZ4J/1MTseTaZ/kjrCShzoEN5YQnRXyRVxanHmFf/UHJBBDfAoffOIBLIy
 laa2x4ilJNOz0NAZzTi02TINyvBVprg==
X-Received: by 2002:a05:620a:9c2:b0:75b:23a0:d9c4 with SMTP id
 y2-20020a05620a09c200b0075b23a0d9c4mr350060qky.26.1684757315381; 
 Mon, 22 May 2023 05:08:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5YYOvHAsDVoypN2LGdM67aZrMMWRH6FGGmLmMaz06p6JQG9Afk3LB+Rbkh2N+KN5MA82za8w==
X-Received: by 2002:a05:620a:9c2:b0:75b:23a0:d9c4 with SMTP id
 y2-20020a05620a09c200b0075b23a0d9c4mr350042qky.26.1684757315142; 
 Mon, 22 May 2023 05:08:35 -0700 (PDT)
Received: from mozz.bu.edu (mozz.bu.edu. [128.197.127.33])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a05620a164100b0074dfd9283afsm1656733qko.79.2023.05.22.05.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 05:08:34 -0700 (PDT)
Date: Mon, 22 May 2023 08:08:31 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] hw/scsi/lsi53c895a: Fix reentrancy issues in the LSI
 controller (CVE-2023-0330)
Message-ID: <20230522120831.spextkl64fp35yuz@mozz.bu.edu>
References: <20230522091011.1082574-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522091011.1082574-1-thuth@redhat.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.137.63; envelope-from=alxndr@bu.edu;
 helo=esa5.hc2706-39.iphmx.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 230522 1110, Thomas Huth wrote:
> We cannot use the generic reentrancy guard in the LSI code, so
> we have to manually prevent endless reentrancy here. The problematic
> lsi_execute_script() function has already a way to detect whether
> too many instructions have been executed - we just have to slightly
> change the logic here that it also takes into account if the function
> has been called too often in a reentrant way.
> 
> The code in fuzz-lsi53c895a-test.c has been taken from an earlier
> patch by Mauro Matteo Cascella.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1563
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

