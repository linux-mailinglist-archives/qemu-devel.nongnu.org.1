Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C97E39F3
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:36:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JR8-0002si-Vv; Tue, 07 Nov 2023 05:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0JR5-0002sH-Ue
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:35:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0JR4-0007q9-Kj
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699353353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Uvv1xRbwlcSyApkkKwlVXtNHeD0ro5+00VnpKZh5t4=;
 b=iofy7Nb44moyJPQDYu4oq7aa9xpdbJ5VQ5dUJ54RXwEUUSFlNE3WAxjrl0baDvenQIIGew
 JAvi8MaKCHFVcxvSCa/c71fRtkRIOx7fKhL2G92reA2kxfJl78oH0G5zu9n3pNE+fK2/do
 QfwMSg2+NfdspQbqyohGmLdhGHPS9YQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-ki8X__nUMX6rIlQ4ts2Rbg-1; Tue, 07 Nov 2023 05:35:51 -0500
X-MC-Unique: ki8X__nUMX6rIlQ4ts2Rbg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C10A85A59D;
 Tue,  7 Nov 2023 10:35:51 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE4BF492BFC;
 Tue,  7 Nov 2023 10:35:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6B4091800DDB; Tue,  7 Nov 2023 11:35:49 +0100 (CET)
Date: Tue, 7 Nov 2023 11:35:49 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Dario Faggioli <dfaggioli@suse.com>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PULL 4/6] seabios: update binaries to git snapshot
Message-ID: <terqy6i5rs6ui4wwbzmwlqi2v72c6qfl62nnu2ifgbkbrrz3z4@mneyylwzf6fo>
References: <20231010112610.2618091-1-kraxel@redhat.com>
 <20231010112610.2618091-5-kraxel@redhat.com>
 <30a82b23-ded6-f03a-727c-ed6f86657a34@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a82b23-ded6-f03a-727c-ed6f86657a34@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

  Hi,

> Trying to install a simple centos7 iso for testing as in:
> 
> IMAGESDIR=/images
> ISO=${IMAGESDIR}/CentOS-7-x86_64-Minimal-2009.iso

Oh, you are running a software museum ;)

> ================================================================================
> Probing storage...
> Installation Destination

If you came that far the linux kernel has been booted.
Do you have a kernel log for me?

Also, what does "lscpu | grep -i address" print (on the host)?

take care,
  Gerd


