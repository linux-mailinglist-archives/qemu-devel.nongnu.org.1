Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344DF7B1F64
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 16:22:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlruB-00076z-2B; Thu, 28 Sep 2023 10:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlru9-000766-HI
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qlru7-0007VO-Rs
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 10:22:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695910931;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=1Q3sLW6wnVEf2VSwGpMREHNaKhjVIw0niZsSnVi8vZc=;
 b=I1Wj+KNATl+9XzNlm2DPBTsE5HsFCd4eIObKWf79ZHlALDEsFdUXvO5LgdoNVcRNHxI9hI
 Q7+S14CgD9XRNdKSEwf7ciA8s0wUuCjxJ27IG6t7QOr5LUmm0F7W5rp3UnWiQMsGMsO5K3
 x3K+Tpe8SkYuSdsT1cwynbSxB4Lj1A8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-7OA9cnNmN66z1H4QNnW5MA-1; Thu, 28 Sep 2023 10:22:09 -0400
X-MC-Unique: 7OA9cnNmN66z1H4QNnW5MA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A1983816CAC
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 14:22:05 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8FB3492B16;
 Thu, 28 Sep 2023 14:22:03 +0000 (UTC)
Date: Thu, 28 Sep 2023 15:21:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Victor Toso <victortoso@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v1 5/9] qapi: golang: Generate qapi's union types in Go
Message-ID: <ZRWMB5qq4E7Xh9ME@redhat.com>
References: <20230927112544.85011-1-victortoso@redhat.com>
 <20230927112544.85011-6-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927112544.85011-6-victortoso@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 27, 2023 at 01:25:40PM +0200, Victor Toso wrote:
> This patch handles QAPI union types and generates the equivalent data
> structures and methods in Go to handle it.
> 
> The QAPI union type has two types of fields: The @base and the
> @Variants members. The @base fields can be considered common members
> for the union while only one field maximum is set for the @Variants.
> 
> In the QAPI specification, it defines a @discriminator field, which is
> an Enum type. The purpose of the  @discriminator is to identify which
> @variant type is being used.
> 
> Not that @discriminator's enum might have more values than the union's
> data struct. This is fine. The union does not need to handle all cases
> of the enum, but it should accept them without error. For this
> specific case, we keep the @discriminator field in every union type.

I still tend think the @discriminator field should not be
present in the union structs. It feels like we're just trying
to directly copy the C code in Go and so smells wrong from a
Go POV.

For most of the unions the @discriminator field will be entirely
redundant, becasue the commonm case is that a @variant field
exists for every possible @discriminator value.

To take one example

  type SocketAddress struct {
        Type SocketAddressType `json:"type"`

        // Variants fields
        Inet  *InetSocketAddress  `json:"-"`
        Unix  *UnixSocketAddress  `json:"-"`
        Vsock *VsockSocketAddress `json:"-"`
        Fd    *String             `json:"-"`
  }

If one was just writing Go code without the pre-existing knowledge
of the QAPI C code, 'Type' is not something a Go programmer would
be inclined add IMHO.

And yet you are right that we need a way to represent a @discriminator
value that has no corresponding @variant, since QAPI allows for that
scenario. To deal with that I would suggest we just use an empty
interface type. eg


  type SocketAddress struct {
        Type SocketAddressType `json:"type"`

        // Variants fields
        Inet  *InetSocketAddress  `json:"-"`
        Unix  *UnixSocketAddress  `json:"-"`
        Vsock *VsockSocketAddress `json:"-"`
        Fd    *String             `json:"-"`
	Fish  *interface{}        `json:"-"`
	Food  *interface()        `json:"-"`
  }

the pointer value for 'Fish' and 'Food' fields here merely needs to
be non-NULL, it doesn't matter what the actual thing assigned is.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


