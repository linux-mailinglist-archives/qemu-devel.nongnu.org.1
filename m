Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79219BDD50C
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 10:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wYp-0001sM-GB; Wed, 15 Oct 2025 04:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8wYn-0001rf-0u
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v8wYk-0006tB-D6
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 04:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760515709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZmrQf6BDaLQYdgBCQQDN9rbZLFnbcaTf2FNxvuvnTbg=;
 b=gRAJCy7nlNCio+onWbueptxNdufAZNCQoqGLL8F5EfcAkHDyhjq5QvWOMZatljD4Td1nW7
 SiyIG1rtGCKBBOg2pENA1EjDcPeZ0grZT9o2hb3w4kx6mTNUIaYNfQ8YHLJVzG999YnMwG
 hWLZouVylmfCqkEfKn5I8SDqap7u26w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-aIVhdfxVNsqAEuUtvKSkzg-1; Wed,
 15 Oct 2025 04:08:25 -0400
X-MC-Unique: aIVhdfxVNsqAEuUtvKSkzg-1
X-Mimecast-MFC-AGG-ID: aIVhdfxVNsqAEuUtvKSkzg_1760515703
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 703A71800744; Wed, 15 Oct 2025 08:08:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.27])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A02851955F1B; Wed, 15 Oct 2025 08:08:22 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 8025818000B2; Wed, 15 Oct 2025 10:08:20 +0200 (CEST)
Date: Wed, 15 Oct 2025 10:08:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v4 1/2] hw/uefi: add "info firmware-log" +
 "query-firmware-log" monitor commands
Message-ID: <z4sxrfotm3bse3hybroietck6njdyc3h7gejfjosovqd7eb7el@2rjj2ualeonl>
References: <20251013104954.250166-1-kraxel@redhat.com>
 <20251013104954.250166-2-kraxel@redhat.com>
 <aO4QSE7oNqpNApFZ@redhat.com>
 <gzn24uzbuady2ipi3uvuzyykqgkvp6ogbwsapghflkfyymgzrv@2bwdhvhwlzw3>
 <87sefkfw84.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sefkfw84.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 15, 2025 at 09:41:15AM +0200, Markus Armbruster wrote:
> Gerd Hoffmann <kraxel@redhat.com> writes:
> 
> >   Hi,
> >
> >> > +static void handle_ovmf_log_range(GString *out,
> >> > +                                  dma_addr_t start,
> >> > +                                  dma_addr_t end,
> >> > +                                  Error **errp)
> >> > +{
> >> > +    g_autofree char *buf = NULL;
> >> 
> >> Left-over variable - unfortunately gcc doens't warn about unused
> >> vars when g_autofree is present :-(
> >
> > Fixed.
> >
> >> > +{ 'struct': 'FirmwareLog',
> >> > +  'data': { '*version': 'str',
> >> > +            '*log': 'str' } }
> >> 
> >> Having version be optional makes sense, but what is the semantics for
> >> 'log' being optional. If the log is unavailable, wouldn't we be better
> >> raising an error ?
> >
> > That is what the current implementation actually does.  I change it.
> 
> Drawback: when some Firmware provides version, but not log, the command
> can't give us the version, because it fails.  Do we care?

Technically the current implementation has both version and log,
unconditionally, even though both can be the empty string ...

take care,
  Gerd


