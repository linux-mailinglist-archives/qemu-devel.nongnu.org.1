Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A16F47DCB76
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:09:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmct-00033X-K4; Tue, 31 Oct 2023 07:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxmck-000335-EV
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qxmch-0006bs-8L
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7Ux/KlONsR+ZS4HYjEGLuMXJ8Q8t6BYdfy5tRSAQOzc=;
 b=QBUfagWAwV6h2SwDxIPNvHPA52n3Opu8zlKHEgvazfu9W1/sKwHZ1MMG76WTMdPXbdNgoK
 GjbRBM+lQRh6FRWr1QadAEPXzct1zDMSX7jBz3jqQbHlUe/2zLKvn5VHMFZsPKZBbKLaxL
 AONtrLRjjLSHQLjLZVvTx+mfMrmqMfU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-tBWwur25NDWjbTUv1V3fvA-1; Tue, 31 Oct 2023 07:09:22 -0400
X-MC-Unique: tBWwur25NDWjbTUv1V3fvA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E3C1185A781;
 Tue, 31 Oct 2023 11:09:22 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6450E1C060AE;
 Tue, 31 Oct 2023 11:09:21 +0000 (UTC)
Date: Tue, 31 Oct 2023 12:09:20 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 peter.maydell@linaro.org, pbonzini@redhat.com, philmd@linaro.org
Subject: Re: [PATCH v2 12/12] qdev: Rework array properties based on list
 visitor
Message-ID: <ZUDgYFuGiqImrbOP@redhat.com>
References: <20231030142658.182193-1-kwolf@redhat.com>
 <20231030142658.182193-13-kwolf@redhat.com>
 <92dce7a5-6a1c-41bd-8ac0-3884e4ad9ab3@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92dce7a5-6a1c-41bd-8ac0-3884e4ad9ab3@ilande.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

Am 30.10.2023 um 21:48 hat Mark Cave-Ayland geschrieben:
> On 30/10/2023 14:26, Kevin Wolf wrote:
> 
> > Until now, array properties are actually implemented with a hack that
> > uses multiple properties on the QOM level: a static "foo-len" property
> > and after it is set, dynamically created "foo[i]" properties.
> > 
> > In external interfaces (-device on the command line and device_add in
> > QMP), this interface was broken by commit f3558b1b ('qdev: Base object
> > creation on QDict rather than QemuOpts') because QDicts are unordered
> > and therefore it could happen that QEMU tried to set the indexed
> > properties before setting the length, which fails and effectively makes
> > array properties inaccessible. In particular, this affects the 'ports'
> > property of the 'rocker' device, which used to be configured like this:
> > 
> > -device rocker,len-ports=2,ports[0]=dev0,ports[1]=dev1
> > 
> > This patch reworks the external interface so that instead of using a
> > separate top-level property for the length and for each element, we use
> > a single true array property that accepts a list value. In the external
> > interfaces, this is naturally expressed as a JSON list and makes array
> > properties accessible again. The new syntax looks like this:
> > 
> > -device '{"driver":"rocker","ports":["dev0","dev1"]}'
> > 
> > Creating an array property on the command line without using JSON format
> > is currently not possible. This could be fixed by switching from
> > QemuOpts to a keyval parser, which however requires consideration of the
> > compatibility implications.
> > 
> > All internal users of devices with array properties go through
> > qdev_prop_set_array() at this point, so updating it takes care of all of
> > them.
> 
> Is it possible to find a suitable place in the documentation to show
> how the new array syntax is used with -device on the command line? The
> description above is really useful, but I can see this being quite
> hard for users to find if it is only documented in the commit message.

Actually, it seems that the documentation doesn't explicitly mention
JSON syntax for command line options anywhere. Support for it is quite
widespread meanwhile. I can see it for at least:

-audiodev
-blockdev
-compat
-device
-display
-netdev
-object

In qemu-storage-daemon, it's additionally supported for:

--export
--monitor
--nbd-server

I think the manpage should at least mention for each of these options
that they support JSON.

Ideally, we'd then have a generic section that describes the mapping
between JSON and human syntax, but unfortunately, the human oriented
parsers differ quite a lot between these options, so there is nothing we
can describe and that is valid for all options. So maybe things like
"Specifying values for list properties is only possible with JSON
syntax" must be specified for each option where it applies.

Kevin


