Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C5092E84B
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jul 2024 14:31:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRswb-0000CM-5E; Thu, 11 Jul 2024 08:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRswY-00008D-Dt
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:30:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRswW-0003rA-Aq
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 08:30:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720701035;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eXr/Ztmnwl9jHml53fjJqMZ7lyq+57Yn1QzEuYZjgrs=;
 b=aDsDGRWcjz/cQC13UUUCChF0B4akcxDU9iq/DGI+gCASlowHMeZnasRh9y1giCrnxQy9ZH
 n+IuFAcFKWAQpw4zDBkU6finK46dFUGXKyXhw64AIVnY/8IdS8v1ASZOC3EZcliC2SyQt+
 j+XODvV8DeW72+OVYIe63EjqdDtaRy8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-CPtrlcINOpKEfikTo6iZTg-1; Thu,
 11 Jul 2024 08:30:34 -0400
X-MC-Unique: CPtrlcINOpKEfikTo6iZTg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C6961955F29; Thu, 11 Jul 2024 12:30:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 836DC19560AE; Thu, 11 Jul 2024 12:30:29 +0000 (UTC)
Date: Thu, 11 Jul 2024 13:30:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
Subject: Re: Avocado 88.1 vs Python 3.12
Message-ID: <Zo_QYmbLBFsPv8Ia@redhat.com>
References: <6d22c5c5-cab0-49d3-88a8-3dd34c8c4938@linaro.org>
 <56ef21cc-f2e3-42df-a114-b7368c77253b@linaro.org>
 <5aa7be9d-1ce1-4448-97c4-fb0d5c4c0985@linaro.org>
 <4aa7d5cd-259b-4b63-9ce2-b73c9027848f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4aa7d5cd-259b-4b63-9ce2-b73c9027848f@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Thu, Jul 11, 2024 at 02:01:25PM +0200, Thomas Huth wrote:
> On 10/07/2024 01.45, Richard Henderson wrote:
> > On 7/9/24 09:26, Philippe Mathieu-Daudé wrote:
> > > On 9/7/24 17:41, Richard Henderson wrote:
> > > > Hi guys,
> > > > 
> > > > I have reinstalled my development box to ubuntu 24 (because the
> > > > Rust support is better than my previous install; ho hum).  I
> > > > thought I had tested everything in a VM before committing, but I
> > > > missed out on Avocado:
> > > > 
> > > > >   AVOCADO Downloading avocado tests VM image for aarch64
> > > > > Failed to load plugin from module "avocado.plugins.list":
> > > > > ModuleNotFoundError("No module named 'imp'") :
> > > 
> > > 
> > > > If I understand things correctly, the python "imp" package was
> > > > deprecated, and has been removed before v3.12.  This is fixed in
> > > > upstream avocado as of v93.  But we have a hard stop in
> > > > pythondeps.toml at v92.
> > > > 
> > > > Remind me what the blocker is to upgrading?
> > > 
> > > IIRC we're waiting for v2 of:
> > > https://lore.kernel.org/qemu-devel/20231208190911.102879-1-crosa@redhat.com/
> > 
> > Yes indeed.  There are two minor conflicts in rebasing this branch, but
> > otherwise it works.  Cleber, do you have time to pick this up again?
> 
> As an alternative, if nobody has time to work on that Avocado update, we
> could maybe also try to integrate the python-based tests directly with the
> meson test runner. A prototype can be found here:
> 
>  https://lore.kernel.org/qemu-devel/20240711115546.40859-1-thuth@redhat.com/

Ooh, that looks remarkably straightford. I'd love to see use using pytest as
the test harness, even if we keep using avocado framework in some of the
test case impls. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


