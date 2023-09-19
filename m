Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC847A692E
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:51:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidvB-00015D-Og; Tue, 19 Sep 2023 12:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qidv9-00014p-O5
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:49:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qidv8-0008Je-0u
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695142192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hcGWIoKTjUv/FeL7chZB9ZjOetRnhOuFSltwcF3tjaU=;
 b=IxcSoGUXTbe3x/mnYJWBLhBOYiPdFDTs8l7Lp6VBUacqQtcgsMtBb7u1VOhQ3hgz/4sMrB
 Zyx7iKVaR1CbSmN1VC53e/Wb/ODScLw9hXapMRJAQpfmmtVorVD2me78pod2lEa9+oVE8t
 fUjb9bjOOhM6p6o4JXaqODBxQtE1JYg=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-PzYq067IMZWLxAAZM2o_tQ-1; Tue, 19 Sep 2023 12:49:51 -0400
X-MC-Unique: PzYq067IMZWLxAAZM2o_tQ-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3adbb2df6a2so910345b6e.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695142190; x=1695746990;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hcGWIoKTjUv/FeL7chZB9ZjOetRnhOuFSltwcF3tjaU=;
 b=TIDRNSJQ+OyiQ5OLicBoVDlSBsW/RHZ/QcCDy1De4zabxsYJtkpH3Lk6/d/H8CRis2
 6gfjvRm354WJfM2537zGV32JSuSghG+RG1bzcQJw5ETFjB8PKjlfrsVyWuflE4QqhZFH
 PWFdAVzLgJSfqQAPqvmrSgRIb9R8kbz2y+xe4Z+XkcIrjFRivZ1iJVdQ6vAYPh0UnWV6
 Mtp9f05VZ5GYMU6KqED9Iwl9Xo8g7DQCd7oHeNfJKnzXEXv2isDRTzzXU3mZHo4MGQm8
 UriC4OHciqjGIZVNA+nPezdls7zDrqCMlOkGjW5AYep1h/Z2S8KXVtSleTB+xWsbFiWB
 20XQ==
X-Gm-Message-State: AOJu0YwotaT8CmeimXZZ/6nSna+/hGM934jiSEJ+MnnKzTzdoY0wr3Xo
 FUWLE9dHgWRH47emDlXymf13y43cRv6NNHUb+/33SF9V8WV5cLv6SCdFioPV/Q0HoDcRDOS+bcy
 vMpDTUDiO9iHtnlk=
X-Received: by 2002:a05:6808:15a8:b0:3ac:de2e:11a3 with SMTP id
 t40-20020a05680815a800b003acde2e11a3mr13792642oiw.0.1695142190239; 
 Tue, 19 Sep 2023 09:49:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNRgemZcrdiE5f6X6D1Cj+eGCxXtplrKkSCWNhdObobBVYCoVsGOxOc5CE5+T6pn9o9V70Jw==
X-Received: by 2002:a05:6808:15a8:b0:3ac:de2e:11a3 with SMTP id
 t40-20020a05680815a800b003acde2e11a3mr13792617oiw.0.1695142189942; 
 Tue, 19 Sep 2023 09:49:49 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y9-20020a37e309000000b0076d1e149701sm4100747qki.115.2023.09.19.09.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:49:49 -0700 (PDT)
Date: Tue, 19 Sep 2023 12:49:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 00/52] migration/rdma: Error handling fixes
Message-ID: <ZQnRKjo0M50BRbZh@x1n>
References: <20230918144206.560120-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918144206.560120-1-armbru@redhat.com>
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

On Mon, Sep 18, 2023 at 04:41:14PM +0200, Markus Armbruster wrote:
> Oh dear, where to start.  There's so much wrong, and in pretty obvious
> ways.  This code should never have passed review.  I'm refraining from
> saying more; see the commit messages instead.
> 
> Issues remaining after this series include:
> 
> * Terrible error messages
> 
> * Some error message cascades remain
> 
> * There is no written contract for QEMUFileHooks, and the
>   responsibility for reporting errors is unclear

Even being removed.. because no one is really extending that..

https://lore.kernel.org/all/20230509120700.78359-1-quintela@redhat.com/#t

> 
> * There seem to be no tests whatsoever

I always see rdma as "odd fixes" stage.. for a long time.  But maybe I was
wrong.

Copying Zhijian for status of rdma; Zhijian, I saw that you just replied to
the hwpoison issue.  Maybe we should have one entry for rdma too, just like
colo?

Thanks,

-- 
Peter Xu


