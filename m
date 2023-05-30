Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BDD716454
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:37:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q40S8-0004lL-IW; Tue, 30 May 2023 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q40Rn-0004dm-IE
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:35:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q40Rk-0004En-7k
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:35:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685457334;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3iLVVpt4cDISVYZY0xpF5T9lDFvmjlOcHOICNWxQ46A=;
 b=NW5YSHvDmaUHxgI6ZpmOu2PRo7vMF5m3ZagfB7zGcvLP0oR6ai92O2vc6SwDW9lFFMiO6a
 MUmFkyo8ctjhDKcd76G049WanNxa9Qe8hXf6UkhbMzT/ruWtU0PfnxmyQB+S3UeB2mDFAs
 wH7caxPfn/142gawR0r2NmBJltjjjqk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-KPY2qZtFN_GqshFMVhmakg-1; Tue, 30 May 2023 10:35:33 -0400
X-MC-Unique: KPY2qZtFN_GqshFMVhmakg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f830918d47so1858921cf.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:35:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685457333; x=1688049333;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3iLVVpt4cDISVYZY0xpF5T9lDFvmjlOcHOICNWxQ46A=;
 b=eDAG1CoKMUzUEb7tva7Iz10pf//cAouuact/wJjbEAZXPkwPLzHGQi19Zcw2QEwuzU
 MIePWcudiaEddXOQDmJvlxZJ8Y8lZ9tZ7Nwnkwyx0SFuLPWM0U/rapdr7l+UptnHvBIU
 k6/snwbxB+x9XYpVEMHYkwHREABc1xYMCkR1Y60E1QqfPg81zLSjBEsDpx4qv43t1DN7
 2UoNOp6YRVnmi3sfsifrpgeWdo6eMX5SBmubRVTY+vyvI+IEj8KnxM/ag3z4Rr58HZbL
 Bisw/Td8SaQGWv8jJPMRtph+4rzNNyk3NGup3DVDe3y68+a6pXBFSXgxiJSL0XchehPo
 8oWg==
X-Gm-Message-State: AC+VfDzvnjWcvwkkinsukhXI8eEDGtsplAPHzrqVDa/k18ZSsr7mGceI
 jSqdYweCiJJn3Iyk7R0qJ1XiypKepJbL2NLyZagIlYwd2vSVO9zuhECkJ1YxDj/w7dhbCMmUM1Y
 j/lkY4kNX5tp1epw=
X-Received: by 2002:a05:622a:24d:b0:3ef:3dc3:4a3e with SMTP id
 c13-20020a05622a024d00b003ef3dc34a3emr2290686qtx.0.1685457332903; 
 Tue, 30 May 2023 07:35:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5dLpgaTwLYjtwrpIUD2cSmg9PEyp7rKmX6FjYWjIx2tumtyKALIR1I6MYmo6JPUwJ5u8IOlQ==
X-Received: by 2002:a05:622a:24d:b0:3ef:3dc3:4a3e with SMTP id
 c13-20020a05622a024d00b003ef3dc34a3emr2290670qtx.0.1685457332618; 
 Tue, 30 May 2023 07:35:32 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 bb40-20020a05622a1b2800b003e6a1bf26a4sm4671732qtb.64.2023.05.30.07.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 07:35:31 -0700 (PDT)
Date: Tue, 30 May 2023 10:35:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: quintela@redhat.com, lei4.wang@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] migration: enfocre multifd and postcopy preempt
 to be set before incoming
Message-ID: <ZHYJsJqIcQUHqiEk@x1n>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
 <20230530090259.189462-2-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530090259.189462-2-wei.w.wang@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On Tue, May 30, 2023 at 05:02:58PM +0800, Wei Wang wrote:
> qemu_start_incoming_migration needs to check the number of multifd
> channels or postcopy ram channels to configure the backlog parameter (i.e.
> the maximum length to which the queue of pending connections for sockfd
> may grow) of listen(). So enforce the usage of postcopy-preempt and
> multifd as below:
> - need to use "-incoming defer" on the destination; and
> - set_capability and set_parameter need to be done before migrate_incoming
> 
> Otherwise, disable the use of the features and report error messages to
> remind users to adjust the commands.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


