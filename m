Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D267127AF
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 15:37:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Xcs-00031L-5n; Fri, 26 May 2023 09:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2Xck-00030v-Gh
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:36:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q2Xcf-0003g3-VA
 for qemu-devel@nongnu.org; Fri, 26 May 2023 09:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685108208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M7FAwcM/NX2G6zn6EtoyoNcP0SFOPhP50Myz0I/pmIA=;
 b=frLljUTPfjjVCykmdWJKCk0vmis9pwduNogFwGErD5yp2CW7IDoiq5HOjOBHzrBfHbG6g4
 u8wYQrcrsyZOniIWiqzrsRGWQJrd7BSgp6rkHOE6fqeajqOGJOrlwyfxLdZqTQofuafd3R
 So1wHsH1l21oGD6DzLF4G8644SbTph0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-nyAynYVzO4ySmkxDZjPBHQ-1; Fri, 26 May 2023 09:36:47 -0400
X-MC-Unique: nyAynYVzO4ySmkxDZjPBHQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-75b147a2548so18321385a.1
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 06:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685108206; x=1687700206;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7FAwcM/NX2G6zn6EtoyoNcP0SFOPhP50Myz0I/pmIA=;
 b=Qt60es5hQBIebx4wjpc4G6s6aVJ7+qhww2KTgc2tZ7LrACTmvZRmELlJuOmSpMhCba
 krhkl3APENaaZtVvwxWGXYAdfrob3AJBRf3RcUcgpWUolfwl8RV9gvRKuz+zIJ6s74cf
 bDpGR/tcX46HW8YWqRrB+gegLrdIcR2QOaViw9sorVMDmt/Q8yNEpF8ItYeyMHCn1KVP
 Hy/j6VeGfknQltWt98FKpMFT8MVGSVX/2E56DFGNFWBw3AAPsD1TG4YfH7xbAoI5vmDM
 3FC9p1iLnMFEzRNRCWA2twRJm1MEZ/1e4ZPTARtsjomKCVueNCAJ3HEqJ1f0tRQSqoul
 c/oQ==
X-Gm-Message-State: AC+VfDx7w69/O/bHZRN6ydLD5Y6XmObhEgUEdZZkTlrfkMIoWOHJNCBy
 rwVcAwxY1vlQ4Jc8JKy6qzpiQrDNXIkKrNKPRhKaK7WR38tp4P4FB7qVpxMpr+3CF4Qj1c7gDrS
 xEBn0YH2oiYUZ5xk=
X-Received: by 2002:a05:620a:3b8f:b0:75b:23a1:69f0 with SMTP id
 tm15-20020a05620a3b8f00b0075b23a169f0mr1385246qkn.7.1685108206613; 
 Fri, 26 May 2023 06:36:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ585OyocpWGdTuvtM+OBCSLV00rsxT0ntCix80015ojCJW6QUEJuouq/y1QsVSEPA7Dfs82bg==
X-Received: by 2002:a05:620a:3b8f:b0:75b:23a1:69f0 with SMTP id
 tm15-20020a05620a3b8f00b0075b23a169f0mr1385234qkn.7.1685108206398; 
 Fri, 26 May 2023 06:36:46 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 w9-20020a05620a128900b0074e389245e6sm1167988qki.41.2023.05.26.06.36.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 06:36:45 -0700 (PDT)
Date: Fri, 26 May 2023 09:36:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Andrei Gudkov <gudkov.andrei@huawei.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, leobras@redhat.com, eblake@redhat.com
Subject: Re: [PATCH] qapi: better docs for calc-dirty-rate and friends
Message-ID: <ZHC17O1pmkLBmcV/@x1n>
References: <fe7d32a621ebd69ef6974beb2499c0b5dccb9e19.1684854849.git.gudkov.andrei@huawei.com>
 <87sfbkpnho.fsf@pond.sub.org> <ZG9i20k6x8n+ydTq@x1n>
 <87y1lbbalg.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y1lbbalg.fsf@pond.sub.org>
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

On Fri, May 26, 2023 at 01:23:07PM +0200, Markus Armbruster wrote:
> Going with
> 
>       # 2. Dirty bitmap mode captures writes to memory (for example by
>       #    temporarily revoking write access to all pages) and counting page
>       #    faults.  Information about modified pages is collected into a
>       #    bitmap, where each bit corresponds to one guest page.  This mode
>       #    requires that KVM accelerator property "dirty-ring-size" is *not*
>       #    set.
> 
> if you don't mind.

Looks good here, thanks!

-- 
Peter Xu


