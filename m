Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C84E7E41EE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:36:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N9u-0003qJ-MK; Tue, 07 Nov 2023 09:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0N9s-0003pT-UK
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1r0N9j-0001eA-6k
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699367653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nnWWn5GmeAqRw3fdtIt4kgMRZ5icKEfIZVd9/bGw/RE=;
 b=CGM2+yHkOI3ilzxUYeecazFyV3Lgn/C5CIcIWFAOhk4oqaTryJQZUDuS37SVx+UGRGK+dm
 eZT5HUt6+y9vAiR4selixyGpeKK0XgzXC1LRjm7XJE4zzXhH0TEoXk43nD212l7ixWCFAb
 C+VChJdurkWHhViH3SsSPHEcS/bzVVo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-8UVhGmBpOTm_QMSg41pRiw-1; Tue, 07 Nov 2023 09:34:11 -0500
X-MC-Unique: 8UVhGmBpOTm_QMSg41pRiw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2503B811E94;
 Tue,  7 Nov 2023 14:34:10 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF5A040C6EB9;
 Tue,  7 Nov 2023 14:34:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 334BB1800DDB; Tue,  7 Nov 2023 15:34:06 +0100 (CET)
Date: Tue, 7 Nov 2023 15:34:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Dario Faggioli <dfaggioli@suse.com>, Jim Fehlig <jfehlig@suse.com>,
 Charles Arnold <carnold@suse.com>
Subject: Re: [PULL 4/6] seabios: update binaries to git snapshot
Message-ID: <jyclixf6334gm7y273ajmq5v2ndleinpaagl6k6xxeljqsnzi3@bic2byyu3cau>
References: <20231010112610.2618091-1-kraxel@redhat.com>
 <20231010112610.2618091-5-kraxel@redhat.com>
 <30a82b23-ded6-f03a-727c-ed6f86657a34@suse.de>
 <terqy6i5rs6ui4wwbzmwlqi2v72c6qfl62nnu2ifgbkbrrz3z4@mneyylwzf6fo>
 <8aa3d259-6dd5-ebf7-8989-66b967434773@suse.de>
 <rdyjajgmgmk3kfbmnufqkws662xhsitcg6yx74qlczclx3i3pz@ftfqmcm7jtp4>
 <96325128-c7f2-d6c0-8ace-3c4e26bd4b91@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96325128-c7f2-d6c0-8ace-3c4e26bd4b91@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
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

  Hi,

> Thanks, this works, I tested with the 46 bit limit.

Good.  I've sent a seabios patch to limit phys-bits to 46.
OVMF does the same btw.

> Charles maybe something to update the older os info definitions (for QEMU 8.2 and newer..?)
> 
> The idea is just that the toolstack could automatically correct for
> this for older Linux guests, requiring a limit on the host-phys-bits.
> Exactly how, I don't know what's best.

That would be good to have even with the patched seabios.  At some point
in the future we probably want lift the limits in seabios and ovmf, to
allow running guests with many terabytes of memory.  Having a way to do
that without breaking old linux guests would be very helpful.

thanks & take care,
  Gerd


