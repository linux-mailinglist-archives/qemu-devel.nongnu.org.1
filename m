Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5207DF215
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:13:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWZ7-00039Y-AI; Thu, 02 Nov 2023 08:12:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyWZ4-00039J-QD
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:12:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyWZ3-0001PQ-1o
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698927163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tq6GrRzpjE6z4b6izNsBFGfmkai53Q0UZvXQNZVlYy0=;
 b=NsKHWojl9T2uGe0blcaD4Voe/bESNM4tprQ7jlohhQxGm6vr67+2wDL3SKgrVbhV3P3/JG
 j6uz6xjoKJgxFgIngtmd3mHPlOfiGcIAeqZNCOxIO+v+KPmlJPH/CRL8IU/KtEtN0OQGDv
 3KdSaUOFc2ncNCCMsgu6awgykk4ixc8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-geax_15eNu-frhG5ZtHL0w-1; Thu, 02 Nov 2023 08:12:42 -0400
X-MC-Unique: geax_15eNu-frhG5ZtHL0w-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32de95ec119so425049f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698927161; x=1699531961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tq6GrRzpjE6z4b6izNsBFGfmkai53Q0UZvXQNZVlYy0=;
 b=cUXAkE8NbYgVfzhQ+FGa9cp7rjCwIKT8Wp+zR7ilihKlALCcg7J7MTc7JAGEBab7WH
 X2PsA9bPhtg0IPtjb6yAbWs6zBgEyWXPexJkzpWoLV90BdIze8cBiSbiwcYYSQquZNNM
 INJxoB2uTavS5L2PD7RfeiJvxjOWVo6NNv4bNSwK7bl5Gq1dzvIQU39ahZ4OLOfMPrLZ
 jEDQI2gqesEtyJ9vom5YZw7aFTA5b2FS5gZXou7W1rM48inHQw/+N68T0SKokHFjSXAl
 IDBUq+X3u1MTAfSnOZ9hSGt7m0akhLjielPjkiOQg1JCK3FRXEYTfqTl9QqQA8gB6qtt
 16MA==
X-Gm-Message-State: AOJu0YzsDRM+pTRJWO5UqNlZX5gYtYUUBmHdMR+kahwITY26kHNpvm1Y
 nVQtzO9I5dvFd2yEBLwZCSDF+X4oeCbmfBLGGWtsVul6UEeiO4f+CD5Yl0+sMTt1QkDKqFUHv22
 R9Mx3mK60Px8Pe+7WTUUUB4E=
X-Received: by 2002:adf:fac2:0:b0:32d:825d:f153 with SMTP id
 a2-20020adffac2000000b0032d825df153mr14305952wrs.61.1698927161017; 
 Thu, 02 Nov 2023 05:12:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGPm5KNIWuYFKPnHhwPRHL40v+eyz9fr6ZLf+bgBo2GVn8RsL/rlU+lf/LI5RbI9jZtG8CpA==
X-Received: by 2002:adf:fac2:0:b0:32d:825d:f153 with SMTP id
 a2-20020adffac2000000b0032d825df153mr14305924wrs.61.1698927160613; 
 Thu, 02 Nov 2023 05:12:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 g8-20020a5d5548000000b0031ad5fb5a0fsm2310589wrw.58.2023.11.02.05.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 05:12:39 -0700 (PDT)
Date: Thu, 2 Nov 2023 08:12:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 eduardo@habkost.net, berrange@redhat.com, pbonzini@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 den-plotnikov@yandex-team.ru, yc-core@yandex-team.ru,
 Peter Krempa <pkrempa@redhat.com>, nshirokovskiy@openvz.org,
 devel@lists.libvirt.org
Subject: Re: [PATCH v8 0/4] pci hotplug tracking
Message-ID: <20231102080801-mutt-send-email-mst@kernel.org>
References: <20231005092926.56231-1-vsementsov@yandex-team.ru>
 <20231102072800-mutt-send-email-mst@kernel.org>
 <d69f0aeb-303a-4721-b25b-52a08b8cd63f@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d69f0aeb-303a-4721-b25b-52a08b8cd63f@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Nov 02, 2023 at 03:00:01PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 02.11.23 14:31, Michael S. Tsirkin wrote:
> > On Thu, Oct 05, 2023 at 12:29:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > Hi all!
> > > 
> > > Main thing this series does is DEVICE_ON event - a counter-part to
> > > DEVICE_DELETED. A guest-driven event that device is powered-on.
> > > Details are in patch 2. The new event is paried with corresponding
> > > command query-hotplug.
> > 
> > Several things questionable here:
> > 1. depending on guest activity you can get as many
> >     DEVICE_ON events as you like
> 
> No, I've made it so it may be sent only once per device

Maybe document that?

> > 2. it's just for shpc and native pcie - things are
> >     confusing enough for management, we should make sure
> >     it can work for all devices
> 
> Agree, I'm thinking about it
> 
> > 3. what about non hotpluggable devices? do we want the event for them?
> > 
> 
> I think, yes, especially if we make async=true|false flag for device_add, so that successful device_add must be always followed by DEVICE_ON - like device_del is followed by DEVICE_DELETED.
> 
> Maybe, to generalize, it should be called not DEVICE_ON (which mostly relate to hotplug controller statuses) but DEVICE_ADDED - a full counterpart for DEVICE_DELETED.
> 
> > 
> > I feel this needs actual motivation so we can judge what's the
> > right way to do it.
> 
> My first motivation for this series was the fact that successful device_add doesn't guarantee that hard disk successfully hotplugged to the guest. It relates to some problems with shpc/pcie hotplug we had in the past, and they are mostly fixed. But still, for management tool it's good to understand that all actions related to hotplug controller are done and we have "green light".

what does "successfully" mean though? E.g. a bunch of guests will not
properly show you the device if the disk is not formatted properly.

> 
> Recently new motivation come, as I described in my "ping" letter <6bd19a07-5224-464d-b54d-1d738f5ba8f7@yandex-team.ru>, that we have a performance degradation because of 7bed89958bfbf40df, which introduces drain_call_rcu() in device_add, to make it more synchronous. So, my suggestion is make it instead more asynchronous (probably with special flag) and rely on DEVICE_ON event.

This one?

commit 7bed89958bfbf40df9ca681cefbdca63abdde39d
Author: Maxim Levitsky <mlevitsk@redhat.com>
Date:   Tue Oct 6 14:38:58 2020 +0200

    device_core: use drain_call_rcu in in qmp_device_add
    
    Soon, a device removal might only happen on RCU callback execution.
    This is okay for device-del which provides a DEVICE_DELETED event,
    but not for the failure case of device-add.  To avoid changing
    monitor semantics, just drain all pending RCU callbacks on error.
    
    Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
    Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
    Message-Id: <20200913160259.32145-4-mlevitsk@redhat.com>
    [Don't use it in qmp_device_del. - Paolo]
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
index e9b7228480..bcfb90a08f 100644
--- a/softmmu/qdev-monitor.c
+++ b/softmmu/qdev-monitor.c
@@ -803,6 +803,18 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, errp);
+
+    /*
+     * Drain all pending RCU callbacks. This is done because
+     * some bus related operations can delay a device removal
+     * (in this case this can happen if device is added and then
+     * removed due to a configuration error)
+     * to a RCU callback, but user might expect that this interface
+     * will finish its job completely once qmp command returns result
+     * to the user
+     */
+    drain_call_rcu();
+
     if (!dev) {
         qemu_opts_del(opts);
         return;



So maybe just move drain_call_rcu under if (!dev) then and be done with
it?

-- 
MST


