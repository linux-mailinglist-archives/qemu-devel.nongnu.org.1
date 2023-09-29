Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077B7B33B2
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 15:33:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmDcQ-0003eH-R8; Fri, 29 Sep 2023 09:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qmDcO-0003ZE-MZ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qmDcI-0001by-5j
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 09:33:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695994393;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+7xgqJE1duQnFogGCbOhRpf4ZiPGJ0NJ2YmpPS1jTo=;
 b=Qb7rTaehDQGdCYsw5nPG3t2I8CZwwDVSYwUAjNo4KB0t3J5axXV6Ev1gwfdqm6Gb4Ozq7Q
 5n8TgxYvDO1iuycwld19jMeo3HLIf8Kmten92eNEqb9qIlhONUiLG7+SDkGZyKwhlPUBUt
 M4svgFn+6vFAXcmXRKJJBVpw+hTLYXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-e9LDS2dTP0uo7zmwcG_syA-1; Fri, 29 Sep 2023 09:33:11 -0400
X-MC-Unique: e9LDS2dTP0uo7zmwcG_syA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7E6111C294C0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 13:33:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CD845492B16;
 Fri, 29 Sep 2023 13:33:10 +0000 (UTC)
Date: Fri, 29 Sep 2023 14:33:08 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 3/9] qapi: golang: Generate qapi's struct types in Go
Message-ID: <ZRbSFJdaw+RMOdJf@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-4-victortoso@redhat.com>
 <ZRWIX36p8oaV0yF0@redhat.com>
 <vyefh5qpavk2kdgg6kyglvfryxbq6w2d422zr6bc5cklfaagyy@3hgytl2yl234>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vyefh5qpavk2kdgg6kyglvfryxbq6w2d422zr6bc5cklfaagyy@3hgytl2yl234>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Sep 29, 2023 at 03:29:34PM +0200, Victor Toso wrote:
> Hi,
> 
> On Thu, Sep 28, 2023 at 03:06:23PM +0100, Daniel P. Berrangé wrote:
> > On Wed, Sep 27, 2023 at 01:25:38PM +0200, Victor Toso wrote:
> > > This patch handles QAPI struct types and generates the equivalent
> > > types in Go. The following patch adds extra logic when a member of the
> > > struct has a Type that can take JSON Null value (e.g: StrOrNull in
> > > QEMU)
> > > 
> > > The highlights of this implementation are:
> > > 
> > > 1. Generating an Go struct that requires a @base type, the @base type
> > >    fields are copied over to the Go struct. The advantage of this
> > >    approach is to not have embed structs in any of the QAPI types.
> > >    Note that embedding a @base type is recursive, that is, if the
> > >    @base type has a @base, all of those fields will be copied over.
> > > 
> > > 2. About the Go struct's fields:
> > > 
> > >    i) They can be either by Value or Reference.
> > > 
> > >   ii) Every field that is marked as optional in the QAPI specification
> > >       are translated to Reference fields in its Go structure. This
> > >       design decision is the most straightforward way to check if a
> > >       given field was set or not. Exception only for types that can
> > >       take JSON Null value.
> > > 
> > >  iii) Mandatory fields are always by Value with the exception of QAPI
> > >       arrays, which are handled by Reference (to a block of memory) by
> > >       Go.
> > > 
> > >   iv) All the fields are named with Uppercase due Golang's export
> > >       convention.
> > > 
> > >    v) In order to avoid any kind of issues when encoding or decoding,
> > >       to or from JSON, we mark all fields with its @name and, when it is
> > >       optional, member, with @omitempty
> > > 
> > > Example:
> > > 
> > > qapi:
> > >  | { 'struct': 'BlockdevCreateOptionsFile',
> > >  |   'data': { 'filename': 'str',
> > >  |             'size': 'size',
> > >  |             '*preallocation': 'PreallocMode',
> > >  |             '*nocow': 'bool',
> > >  |             '*extent-size-hint': 'size'} }
> > > 
> > > go:
> > > | type BlockdevCreateOptionsFile struct {
> > > |     Filename       string        `json:"filename"`
> > > |     Size           uint64        `json:"size"`
> > > |     Preallocation  *PreallocMode `json:"preallocation,omitempty"`
> > > |     Nocow          *bool         `json:"nocow,omitempty"`
> > > |     ExtentSizeHint *uint64       `json:"extent-size-hint,omitempty"`
> > > | }
> > 
> > Note, 'omitempty' shouldn't be used on pointer fields, only
> > scalar fields. The pointer fields are always omitted when nil.
> 
> 'omitempty' should be used with pointer fields unless you want to
> Marshal JSON Null, which is not the expected output.

Oh doh, did't notice that.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


