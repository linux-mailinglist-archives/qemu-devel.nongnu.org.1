Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB21712ED1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:16:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2emr-0003nR-Ml; Fri, 26 May 2023 17:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2emo-0003nG-MZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2emn-0005cX-92
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685135744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXS+kC/IWKbL/rv60euOE9T7lGBAXDntrDwtT9thVP8=;
 b=fiI+9T/t6U13FbtDyjVtufVolYIF6QeSrdlx0ilSRgPXrtrKcW1o9Wh4hxO17p8d0lC3JR
 AdIQtoRcDrFxBdtqjpkIZR32aba9yS7wjMXGHQLGKSMdHhGvNHqOwp0TPWVs1hX5DbFdrT
 P/8yg3a9noZlwqt+DxvqzUVFr8+pB4s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-CPuREwvfO7ij9oOF-jB2mg-1; Fri, 26 May 2023 17:15:42 -0400
X-MC-Unique: CPuREwvfO7ij9oOF-jB2mg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-74faf5008bbso25611585a.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685135742; x=1687727742;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gXS+kC/IWKbL/rv60euOE9T7lGBAXDntrDwtT9thVP8=;
 b=R301OpgtYs6C/PAN56Ecn6sens0TCTTG/0WajjraL52TfC5/iqbRq5n0FczqWlkL33
 t87s8TMDaVGPlwh7PBu8uaz0aqn4UgqTmQ/h+G5zBvVaSyYGNK3HYwKM5bUNOW6wxBp7
 s4AAMh+NkYo7iptUC2odZrDUNwyWlAofBL1yigQuHo0dCQT27n9QBcDPPhffKzPzPQ1D
 GGtoOF+Scj3hGfdt/UTNDlshEIXGGj92ALkT7o+BQhFaXseBG100hkXbyudc3vGM48yI
 ELiJCUXlHpRsa+PKQi96V9+PLvEjnganbwwOw1NBui3VbU9VMNuz5H/TiWIaQCRi1yrK
 a22g==
X-Gm-Message-State: AC+VfDwC9/aJNCJ2g6Yc0uiIDvALgoN9N63LBBLy2OuccvDVnduglv+f
 H9XNGpQPLXPp3TfrUDIvWIR+t8khPNmUEdqLJF7mY6WCNkjdhDj1GEL+544l2kyN8n8nW5VEwSm
 k8aND8guINEqF5L0=
X-Received: by 2002:a05:620a:640d:b0:75c:b450:cd8 with SMTP id
 pz13-20020a05620a640d00b0075cb4500cd8mr3211411qkn.5.1685135742397; 
 Fri, 26 May 2023 14:15:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lSwcBegjFPXSc71aXjuvfb9kXfRXVsIVSQWggejLu861SZp5yiRrR2VVTeRwp/N24KxdMww==
X-Received: by 2002:a05:620a:640d:b0:75c:b450:cd8 with SMTP id
 pz13-20020a05620a640d00b0075cb4500cd8mr3211400qkn.5.1685135742087; 
 Fri, 26 May 2023 14:15:42 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 p9-20020a05620a112900b0075ca4cd03d4sm1354876qkk.64.2023.05.26.14.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 14:15:41 -0700 (PDT)
Date: Fri, 26 May 2023 17:15:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 4/5] migration/rdma: It makes no sense to recive that
 flag without RDMA
Message-ID: <ZHEhfEpZvcGvS9bx@x1n>
References: <20230504114443.23891-1-quintela@redhat.com>
 <20230504114443.23891-5-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230504114443.23891-5-quintela@redhat.com>
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

On Thu, May 04, 2023 at 01:44:42PM +0200, Juan Quintela wrote:
> This could only happen if the source send
> RAM_SAVE_FLAG_HOOK (i.e. rdma) and destination don't have CONFIG_RDMA.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Bah, first patch to start reading the master code and it's already merged.
I'll stop here then... :)

-- 
Peter Xu


