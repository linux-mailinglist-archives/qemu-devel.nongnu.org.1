Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DE7ABC3DE
	for <lists+qemu-devel@lfdr.de>; Mon, 19 May 2025 18:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH32l-0000aC-EU; Mon, 19 May 2025 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH32e-0000Zq-Sb
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uH32c-0002nf-Sr
 for qemu-devel@nongnu.org; Mon, 19 May 2025 12:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747670915;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VOyqsRtgAz/YJB1gHNQipE4jNKGzZZ1Bf0kjyJ1NqU=;
 b=jAY65EAEJmeRVTQsCj5KERyJMw2k4sZz7sYd1ZK9jKXY507NY9Em2kQldsa8nxwRA4yoPd
 VcqxEm37jtia74Br8//PYZD7crg/LxGdngcj+amlsXZLislwXMxAY3I90g5HlE2BuFW9Yr
 zeqCRH+QYRMcDe3GAgpvYoDnnC/oBz0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Kw-Z3IdDMAevf_X2fyDCOA-1; Mon,
 19 May 2025 12:08:34 -0400
X-MC-Unique: Kw-Z3IdDMAevf_X2fyDCOA-1
X-Mimecast-MFC-AGG-ID: Kw-Z3IdDMAevf_X2fyDCOA_1747670913
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB30E18001EA; Mon, 19 May 2025 16:08:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 050191956095; Mon, 19 May 2025 16:08:30 +0000 (UTC)
Date: Mon, 19 May 2025 17:08:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH v3 2/9] scripts/checkpatch.pl: fix various indentation
 mistakes
Message-ID: <aCtXeywTN7rb_7us@redhat.com>
References: <20250515135936.86760-1-berrange@redhat.com>
 <20250515135936.86760-3-berrange@redhat.com>
 <CAFEAcA-v3UiKhUZsU6QhzM-A-iDcsVa190mM6pMac1AXKue7_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-v3UiKhUZsU6QhzM-A-iDcsVa190mM6pMac1AXKue7_Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, May 19, 2025 at 01:12:09PM +0100, Peter Maydell wrote:
> On Thu, 15 May 2025 at 14:59, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Various checks in the code were under-indented relative to other
> > surrounding code.
> 
> Isn't the problem here not that they're under-indented,
> but that they don't follow the "indent with hard coded
> tab characters" style that the rest of the script does?
> 
> Looking at the patch on patchew it looks like these changes do
> make the code use hardcoded tabs, but I think it would be worth
> mentioning that in the commit message. (I assumed from the wording
> -- and also because my mail client was being misleading -- that
> these changes were adding 8-space indent.)

It was a mixture of problems. Some places where using 4 spaces instead
of 1 tab, other places used a mixture of tabs and 4 spaces and one place
used only tabs, but too few of them.

> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


