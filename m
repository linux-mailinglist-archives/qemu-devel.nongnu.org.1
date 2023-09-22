Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EC67AB280
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 15:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjfoB-0006DJ-6C; Fri, 22 Sep 2023 09:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjfo9-0006Bg-3U
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjfo7-0001Mf-Ch
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 09:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695387772;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iFbe4u/VT+844w2fTOOBxBg1GrlZQN72v78sqFETLDg=;
 b=Q0WwjdDJu//iwmk/t9J7KVaTsZNz4ZeNqyqDp5ado2U+KjvVbs2gDLLM57ou/Y3MNatugB
 zuEkMVk8E0Czm3wN94wHTYTnDo7RiV71C+WC5MosDsOsi3HO9yO9/oWj3IyD2Wyv8Yb5aA
 Mu4g1LyU9kIarUnDy/30+WoPN5QmPns=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-VUCamUyzM0S68KEJ-mjmIw-1; Fri, 22 Sep 2023 09:02:50 -0400
X-MC-Unique: VUCamUyzM0S68KEJ-mjmIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01609811E7D;
 Fri, 22 Sep 2023 13:02:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11B2940C6EBF;
 Fri, 22 Sep 2023 13:02:48 +0000 (UTC)
Date: Fri, 22 Sep 2023 14:02:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 James Bottomley <jejb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v6 2/2] tpm: add backend for mssim
Message-ID: <ZQ2QdBr1a90RX7Wm@redhat.com>
References: <20230109161532.6892-1-jejb@linux.ibm.com>
 <20230109161532.6892-3-jejb@linux.ibm.com>
 <87bkduwxv7.fsf@pond.sub.org>
 <2629ce63-e4dd-67f3-6341-d477c39b29f7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2629ce63-e4dd-67f3-6341-d477c39b29f7@linux.ibm.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Sep 22, 2023 at 08:41:19AM -0400, Stefan Berger wrote:
> 
> On 9/22/23 02:00, Markus Armbruster wrote:
> > Found this cleaning out old mail, sorry for missing it until now!
> > 
> > I think we owe James a quick decision wether we're willing to take the
> > feature.  Stefan, thoughts?
> 
> I thought we discusses it back then. Does it handle snapshotting and
> migration correctly?

To quote the patch itself:

  +The mssim backend supports snapshotting and migration, but the state
  +of the Microsoft Simulator server must be preserved (or the server
  +kept running) outside of QEMU for restore to be successful.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


