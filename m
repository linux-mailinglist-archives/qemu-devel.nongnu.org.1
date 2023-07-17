Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 765627565AA
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 16:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOlD-0001Xz-QP; Mon, 17 Jul 2023 09:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qLOlB-0001Xo-5j
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1qLOl9-00050x-4b
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689602368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=40tSCM9jAUDEgM1tv/5oSsHkuFEdvbYwLcT8ydR0GiM=;
 b=UD5sKrh5s6iFkodhrWHX6WEZajZJMAZaDS/y4LXrxOTmHOFh67B9vznIhLmPBYIfzmJfJR
 pX7vzZ7l4AawLWGAhhCKyxUhqb+a/lRFdFdA06/IPVuNSG5PzF1xE5WWTpu62KaObzw0op
 w1QW+5cyW/FOSUIeIVNnl6q/Mwk3GOE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-y7-9_NqaPz2XwgjzbjmGdQ-1; Mon, 17 Jul 2023 09:59:25 -0400
X-MC-Unique: y7-9_NqaPz2XwgjzbjmGdQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BACA33C025A2;
 Mon, 17 Jul 2023 13:59:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.170])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2064CD0C8;
 Mon, 17 Jul 2023 13:59:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A9F48180078D; Mon, 17 Jul 2023 15:59:12 +0200 (CEST)
Date: Mon, 17 Jul 2023 15:59:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org, 
 marcandre.lureau@gmail.com, cohuck@redhat.com, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v4 2/4] virtio-dmabuf: introduce virtio-dmabuf
Message-ID: <sbrp2d6kqwphonr6iftdclqjxmecixgac6hpwy64puqng2s2nz@dyiw7oz7xpob>
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-3-aesteve@redhat.com>
 <20230710145806-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710145806-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
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

> >  M: Stefan Hajnoczi <stefanha@redhat.com>
> >  S: Supported
> 
> Hmm new functionality that no one seems to care
> about enough to review,
> 
> Gerd you suggested this - ready to be a maintainer?
> co-maintain with Albert?

Quite busy with firmware, I don't really have the time to take more qemu
stuff, I'm already struggling to care about the qemu bits I'm still
listed as maintainer for ...

Patch looks fine to me.  This just maintains a list of buffers,
references by uuid.  Use case is buffer sharing, i.e. guest creates a
virtio-gpu buffers, shares it with another driver (virtio-video for
example) inside the guest, the buffer uuid can be used by the device
emulation backends on the host side to establish the same sharing.

take care,
  Gerd


