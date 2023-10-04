Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E607E7B85F3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:57:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Bl-0008BO-Le; Wed, 04 Oct 2023 12:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5Bi-0008AM-NI
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:57:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5Bh-00034U-7z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:57:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696438648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ezd/CoV/GEBcVf/HfHpFk/z0Ot+fDjvjJnet0zxS+vo=;
 b=DILOGUkkF0bq7dUwu+1bC1XMCrbd1vk2jZhubn09bY1mgyFYUDap9C3PurP+b4eTf5+cEz
 HO0bzZIYmj8veleH+l5ULu141tXUhFpv6nFCudU+uVofRik4UE4SFGIYfCuo07wSBkC/8/
 NaUIGl6gEsi5VlZPN+GQGlvyLsCOl6w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-hF3c0OOBPl2Yi7uIXaGZZA-1; Wed, 04 Oct 2023 12:57:06 -0400
X-MC-Unique: hF3c0OOBPl2Yi7uIXaGZZA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41951447612so67811cf.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696438626; x=1697043426;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ezd/CoV/GEBcVf/HfHpFk/z0Ot+fDjvjJnet0zxS+vo=;
 b=mJOBPcC7ALsPM0N7YJ/VLRi41ZBqOsjsODq8vk8vxPq75hTlw129RQbv1p+b5cXO8G
 JLnqTsq2i4/8ui39NRbZtCRedZ+vN8rwwNluL82yFZR/Cemxl5GkG+/eWhrZjzA2Oc4k
 /FBWPj7idp/vY7g6wyekCFDaK/8385SAvqngSFePekOgwLBeK7ZSvv85R3GMde7jvsQm
 GP73/le0X9YjwPL72CzIGslF/JQ0gKG7Rxf1LMI7wNWKvr5n5k/nFDklmYC97nvfyAw7
 L0VXvBZ34r+N7jeMvBN9mYI8vqSa8Yrxv4kPEiGkOHbFUv84I6eZpH3CuDFWJmN+4LLV
 w9sg==
X-Gm-Message-State: AOJu0YxNnBg3VBDtfKAgzxAl98NQKc4/10pO7Yxp6HW7PVmKhWiFzVWu
 gl6IwjYH7Z8GEIs2LxNMtUO/Hj+L8kUjkQnsykhAkbJ3Z6a2B1iTVUkV1bSbBH0KgwUHHeoz5b/
 YJwsGRvpxR7nSgIQ=
X-Received: by 2002:a05:6214:21e4:b0:668:e10e:3ca9 with SMTP id
 p4-20020a05621421e400b00668e10e3ca9mr2926550qvj.6.1696438626435; 
 Wed, 04 Oct 2023 09:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTITEzhvh11qmI4n5mdOEaklQrb1aSYwK9TQ2j+WZzntBR318ZNjTDyDZRLuLWXJyFLy8+IA==
X-Received: by 2002:a05:6214:21e4:b0:668:e10e:3ca9 with SMTP id
 p4-20020a05621421e400b00668e10e3ca9mr2926533qvj.6.1696438626107; 
 Wed, 04 Oct 2023 09:57:06 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f14-20020a0caa8e000000b006516780a0a5sm1457086qvb.117.2023.10.04.09.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:57:05 -0700 (PDT)
Date: Wed, 4 Oct 2023 12:57:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leobras@redhat.com" <leobras@redhat.com>
Subject: Re: [PATCH 28/52] migration/rdma: Check negative error values the
 same way everywhere
Message-ID: <ZR2ZYNB2Mw1Tej9i@x1n>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-29-armbru@redhat.com>
 <5b2560b5-63ed-37f0-5367-07ca55d43ab4@fujitsu.com>
 <87wmwed824.fsf@pond.sub.org> <87jzs2uz5d.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzs2uz5d.fsf@secure.mitica>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sorry Zhijian, I missed this email.

On Wed, Oct 04, 2023 at 06:32:14PM +0200, Juan Quintela wrote:
> > * Avoid non-negative integer error values.

Perhaps we need to forbid that if doing this.

I can see Zhijian's point, where "if (ret)" can also capture unexpected
positive returns, while "if (ret < 0)" is not clear on who's handling ret>0
case.  Personally I like that, too.

> 3 - I fully agree that code is more maintenable this way.  I.e. if any
>     function changes to return positive values for non error, we get
>     better coverage.

This patch does at least try to unify error handling, though..

$ git grep "ret < 0" migration/rdma.c | wc -l
36

So we have half doing this and half doing that, makes sense to do the same.

Let's assume no vote from my side due to pros and cons, so it's 2:1. :)

Thanks,

-- 
Peter Xu


