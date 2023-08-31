Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5956A78EF1A
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:58:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbiBA-0003dS-Vr; Thu, 31 Aug 2023 09:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbiAy-0003Xw-VA
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:57:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qbiAw-00074O-CH
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693490253;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Sy9cg8nx8tCkJRJ0pyY0ZKZgu50QcenXslkFYH/Fxxc=;
 b=G/dlsB0C+7ac2u6zmKS7Kgo+m0VclQPDPYHbLWKsHu34EdPVGpMdsFCxfPzg7+nmlbtnMX
 OjHI9VAHmpRq0IOdDayPYoItjJu46/UJ9TskreGTY7S35G7s6q/PRau636BmsLUmTbGY66
 tJyZGBfkQlflhU+2VPM8ILQS067E0pw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-NtemnZ3GOs6HhNzxI-UupA-1; Thu, 31 Aug 2023 09:57:28 -0400
X-MC-Unique: NtemnZ3GOs6HhNzxI-UupA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 613B4101A52E;
 Thu, 31 Aug 2023 13:57:27 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A23F8492C14;
 Thu, 31 Aug 2023 13:57:26 +0000 (UTC)
Date: Thu, 31 Aug 2023 14:57:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Bug 1863025 <1863025@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [Bug 1863025] Re: Use-after-free after flush in TCG accelerator
Message-ID: <ZPCcRD/zv/l80WWC@redhat.com>
References: <158154486735.14935.3370403781300872079.malonedeb@soybean.canonical.com>
 <169348611423.1472917.10027704436078423318.malone@juju-98d295-prod-launchpad-3>
 <cb2807f0-fc7d-fc03-376e-09c3d5f10a7f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2807f0-fc7d-fc03-376e-09c3d5f10a7f@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Aug 31, 2023 at 03:40:25PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Samuel,
> 
> On 31/8/23 14:48, Samuel Henrique wrote:
> > CVE-2020-24165 was assigned to this:
> > https://nvd.nist.gov/vuln/detail/CVE-2020-24165
> > 
> > I had no involvement in the assignment, posting here for reference only.
> > 
> > ** CVE added: https://cve.mitre.org/cgi-bin/cvename.cgi?name=2020-24165
> 
> QEMU 4.2.0 was released in 2019. The issue you report
> has been fixed in commit 886cc68943 ("accel/tcg: fix race
> in cpu_exec_step_atomic (bug 1863025)") which is included
> in QEMU v5.0, released in April 2020, more than 3 years ago.
> 
> What do you expect us to do here? I'm not sure whether assigning
> CVE for 3 years old code is a good use of engineering time.

In any case per our stated security policy, we do not consider TCG to
be providing a security boundary between host and guest, and thus bugs
in TCG aren't considered security flaws:

 https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


