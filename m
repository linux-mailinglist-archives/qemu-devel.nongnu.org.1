Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD5B7675F3
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 21:01:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPSCj-0003GT-LW; Fri, 28 Jul 2023 14:28:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPSCg-0003Cb-T0
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 14:28:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPSCf-00078i-Ft
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 14:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690568920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRyPK3U/Pq1nkhgiUFV/g7TxJfKVyXrtbrthBXETzYw=;
 b=PinVig0GMhs4NoCyzcieWnIcFtpBstgqQ3XOEf+XwE7nZrillUpey8eqpV+t5Br016fxns
 NvpL8OklbfPb/atwlPnNHu9o6b4TH+Dc39A8jBn8d0Yk6frzLh67cGWM9nGFPhBss17rZk
 8bUq6fGvdHtom10XoFjHxiAgi2H1cF8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ytgtri_xP--uZ609YYHZkQ-1; Fri, 28 Jul 2023 14:28:38 -0400
X-MC-Unique: ytgtri_xP--uZ609YYHZkQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76c7cffef41so22303885a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 11:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690568918; x=1691173718;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRyPK3U/Pq1nkhgiUFV/g7TxJfKVyXrtbrthBXETzYw=;
 b=fmIqVqnv0SRmWinSZjq85NvFv5pBljL8oZwpOujRvy2+kV6j6Gl8J2PBYB7SwUv8GZ
 nxyXLl0ALX89Hqc5/4N2L5IZY9B98p7AZ919IeMpSLN3DmeoR+wKjIKG/LyxAn0+MFEZ
 gCj5yN46VYj3rndkqX6po9wNzL3itE/joVy2hHbwvTpAEnyaB1I3dm0KoN7f/s3G9TJy
 KMcoJSi0xsAVv4EBmURKx+PZeyj33QQb7VjBWdQzobsu5qw7RsNj3WDXbABCY9/Og5KA
 Z/1n8HgP2w1AR/ZrelRkPQ/3KceAor9mme8JiOlHxMh6FjrJyBXxCtO2qn/8J988YVYY
 18cQ==
X-Gm-Message-State: ABy/qLZgsStI5DpTuYqj083C4OuJgsX+4PTt3JJgAsnoJotIGkZKtPGx
 wgtOjuONW1DANHPbZNS/y+G27foXoijTyoj1TJEaUraN7TXYzHl7YQgvAfSPD+ryhzZ9pGkLffV
 mKe32EK0v5KqwQJk=
X-Received: by 2002:a05:620a:2401:b0:763:a1d3:196d with SMTP id
 d1-20020a05620a240100b00763a1d3196dmr50620qkn.0.1690568918158; 
 Fri, 28 Jul 2023 11:28:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEkNp6BIJz6zdm0C+YQo2EO3QFZke3d9gxYjEkxnleKsgzAfgf/jhUsNIwpoeBAlOszFG5vxQ==
X-Received: by 2002:a05:620a:2401:b0:763:a1d3:196d with SMTP id
 d1-20020a05620a240100b00763a1d3196dmr50597qkn.0.1690568917852; 
 Fri, 28 Jul 2023 11:28:37 -0700 (PDT)
Received: from xz-m1.local
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 p13-20020ae9f30d000000b0076816153dcdsm1306435qkg.106.2023.07.28.11.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 11:28:37 -0700 (PDT)
Date: Fri, 28 Jul 2023 14:28:36 -0400
From: Peter Xu <peterx@redhat.com>
To: ~hyman <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH QEMU 3/3] MAINTAINERS: Add Hyman Huang as maintainer
Message-ID: <ZMQI1OjmYwebVEmJ@xz-m1.local>
References: <169056029099.1291.9838508091499564970-0@git.sr.ht>
 <169056029099.1291.9838508091499564970-3@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169056029099.1291.9838508091499564970-3@git.sr.ht>
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

On Thu, Jul 27, 2023 at 02:10:09AM +0800, ~hyman wrote:
> From: Hyman Huang(黄勇) <yong.huang@smartx.com>
> 
> I've built interests in dirty-limit and dirty page rate
> features and also have been working on projects related
> to this subsystem.
> 
> Self-recommand myself as a maintainer for this subsystem
> so that I can help to improve the dirty-limit algorithm
> and review the patches about dirty page rate.
> 
> Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


