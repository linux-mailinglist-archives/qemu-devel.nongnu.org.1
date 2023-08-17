Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA1477F528
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 13:26:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWb7r-00074f-9Y; Thu, 17 Aug 2023 07:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWb7l-00074D-Sk
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:25:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qWb7j-00027y-0b
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 07:25:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692271505;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ssO9zux6n7AwbvA4uizFhmJCBLwENvpQ2cwPr/thqrE=;
 b=apYLS/m0dNNVpyT3mY2bK2Au0rH2nB+Wy4NfbUYHGyKAJST3QAyXfclut5LP+8mH/eeyOh
 T92JFx9zIYis9Fy1HAt3ikcjBIT/8FVcWaM6PUnTWDSrxein6oP5DjVCMCWjNqGfrxrwwT
 oEeAI8QCtHjKym0ahRFPXeZClWO4MBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-259--IFEMcfWO0qEjvCUWl8SQw-1; Thu, 17 Aug 2023 07:25:01 -0400
X-MC-Unique: -IFEMcfWO0qEjvCUWl8SQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7CC06101A528;
 Thu, 17 Aug 2023 11:25:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A7B240C207A;
 Thu, 17 Aug 2023 11:25:00 +0000 (UTC)
Date: Thu, 17 Aug 2023 12:24:58 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Efim Shevrin <efim.shevrin@virtuozzo.com>, qemu-devel@nongnu.org,
 kkostiuk@redhat.com, michael.roth@amd.com, pbonzini@redhat.com,
 den@openvz.org
Subject: Re: [PATCH] qga: Start qemu-ga service after NetworkManager start
Message-ID: <ZN4DipkE0wPn5H0G@redhat.com>
References: <20230816200446.1408797-1-efim.shevrin@virtuozzo.com>
 <ZN318fFGAsT4up83@redhat.com>
 <59a42366-58e2-7147-1bd4-e85b446b0477@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59a42366-58e2-7147-1bd4-e85b446b0477@virtuozzo.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 17, 2023 at 12:47:48PM +0200, Denis V. Lunev wrote:
> On 8/17/23 12:26, Daniel P. Berrangé wrote:
> > On Thu, Aug 17, 2023 at 04:04:46AM +0800, Efim Shevrin via wrote:
> > > From: Fima Shevrin <efim.shevrin@virtuozzo.com>
> > > 
> > > When the guest OS starts, qemu-ga sends an event to the host.
> > > This event allows services on the host to start configuring
> > > the already running guest OS. When configuring network settings,
> > > it is possible that an external service will receive a signal
> > > from qemu-ga about the start of guest OS, while NetworkManager
> > > may not be running yet. Therefore, network setting may not
> > > be available. With the current patch, we eliminate the described
> > > race condition between qemu-ga and NetworkManager for guest OS
> > > network setting cases.
> > A host mgmt app should not be assuming that networking is
> > running at all, and if it is, the guest might not even be
> > on the same subnet as the host. Conceivably someone could
> > even be using QGA to inject files to configure networking.
> > 
> > Overall, IMHO, it is wrong to correlate host notification
> > that QGA is running, with any assumption about state of
> > the guest networking.
> > 
> > IOW, I don't think we should make an attempt to serialize
> > startup of QGA after guest networking. The QGA should be
> > run as soon as its data transport (virtio-serial/vsock)
> > is available, which is the current state.
> > 
> > If a host consumer of QGA wants to do something with
> > guest networking, they should check for guest network
> > state with the 'guest-network-get-interfaces' command.
> 
> This is very tight question at my opinion.
> 
> Frankly speaking my original intention here would be
> to put QGA at the very end of the startup sequence
> in order to avoid complications. In the other case
> any host side software, which would like to control
> the guest behavior will be in trouble.
> 
> For example, yet another common application is a
> guest backup, here I would say application based
> backup. In a normal case this is done through
>    /etc/qemu-ga/fsfreeze-hook

It will already be started after local-fs.target, since it does not
have DefaultDependencies=no set. This should be sufficient for
fsfreeze use cases IIUC.

> I would say that agent should start very last, in the
> other case *ANY* software working through the agent
> must take efforts to avoid such transient state, which
> is complicated.



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


