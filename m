Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C84E70D71D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 10:19:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1NED-0003Xh-WC; Tue, 23 May 2023 04:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1NEA-0003XD-3G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:18:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q1NE8-0005Hr-4n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 04:18:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684829918;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P7zwyhwAlroGPWE1Pjq18RnRYoQAEZP7XhKei3uDSLU=;
 b=QOKHC5HAA1gK8UiNRi1P+pDAY2QKLfVnBamQl30qT3liv1WUoTeG03LCY5F6hyyJ9RplXb
 d3hJSReyUzIAWVpjAGYQE74vk9zMoRCUb6Ugvdqh0/XnVPOICKk8mYNPA0AJFy4eaRNGdo
 CPlu1uEz0EsuIE4KjSVQMlmxoJC9GVs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-7dSgAZzePMiv_7hfvx1vog-1; Tue, 23 May 2023 04:18:35 -0400
X-MC-Unique: 7dSgAZzePMiv_7hfvx1vog-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F583800B35;
 Tue, 23 May 2023 08:18:35 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EDA540C6CCF;
 Tue, 23 May 2023 08:18:34 +0000 (UTC)
Date: Tue, 23 May 2023 09:18:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, vr_qemu@t-online.de, marcandre.lureau@redhat.com
Subject: Re: [PATCH] meson: remove -no-pie linker flag
Message-ID: <ZGx22AySUhoZZuW1@redhat.com>
References: <20230522080816.66320-1-pbonzini@redhat.com>
 <ZGxysnpYm8FtL0VM@redhat.com>
 <CABgObfa+EG62MV-9xG7dtxiXj5ocosXS8kNneAoM_kTbmo0CbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfa+EG62MV-9xG7dtxiXj5ocosXS8kNneAoM_kTbmo0CbA@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 23, 2023 at 10:02:51AM +0200, Paolo Bonzini wrote:
> On Tue, May 23, 2023 at 10:00 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > I'm curious why we need to do anything ?  I would have thought that meson
> > should handle 'b_pie' itself, passing the right args to $CC that it feels
> > are appropriate. I don't recall seeing other apps using meson trying to
> > handle b_pie logic - what's special about QEMU ? IOW, is it possible to
> > delete this entire b_pie condition and thus avoid worrying about this
> > problem ?
> 
> The issue is that Meson only has "enable PIE" or "leave PIE to the
> compiler default", while QEMU also has "disable PIE"---which is the
> messy one.

Does QEMU actually need "disable PIE" ? It existed in configure of
course, is there a reason we need to continue to support it in meson ?

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


