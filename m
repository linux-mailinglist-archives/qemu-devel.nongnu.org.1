Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 307347B2D43
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 09:51:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm8GY-0001Xo-Ci; Fri, 29 Sep 2023 03:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm8GW-0001XS-Az
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 03:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm8GU-0007ww-Ns
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 03:50:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695973820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmLMBaIHDkwz7SvGaAAFinMQQUv/AvRTEW03tmt9z+4=;
 b=ObMy8ZPYrDNrchO0fIRhiuofjlcKlLbU6xmWSHi9s8Dmhpo0ILo9xeB9te+9sSIKXzNwQr
 wr02MFsRP8F6EqA2BE4uEEJ/BEuSL+9BEq/7sUOPXBcddVwpRUzhgWKOQuZSlFhwP0QOLH
 mwFCpjrqo08pVhCrZZQ3649XCxLccmM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-a7V9jkGANCi4fY2CmOAAKg-1; Fri, 29 Sep 2023 03:50:18 -0400
X-MC-Unique: a7V9jkGANCi4fY2CmOAAKg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 99A998039C1;
 Fri, 29 Sep 2023 07:50:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 74039140E96C;
 Fri, 29 Sep 2023 07:50:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E6B721E6904; Fri, 29 Sep 2023 09:50:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Fan Ni <fan.ni@samsung.com>,  qemu-devel <qemu-devel@nongnu.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  "linuxarm@huawei.com"
 <linuxarm@huawei.com>
Subject: Re: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
References: <CGME20230925152310uscas1p1b621d173ac0c0ce2163e4f2c788e4fdf@uscas1p1.samsung.com>
 <20230925152258.5444-1-Jonathan.Cameron@huawei.com>
 <20230927191327.GA4138120@sjcvldevvm72>
 <20230928132257.000039ce@Huawei.com>
Date: Fri, 29 Sep 2023 09:50:16 +0200
In-Reply-To: <20230928132257.000039ce@Huawei.com> (Jonathan Cameron's message
 of "Thu, 28 Sep 2023 13:22:57 +0100")
Message-ID: <878r8ph0zr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Wed, 27 Sep 2023 19:13:35 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
>
>> On Mon, Sep 25, 2023 at 04:22:58PM +0100, Jonathan Cameron wrote:
>> 
>> > Rename the version not burried in the macro to cap_h.  
>> The change looks good to me. Just one minor thing. why "version" get
>> involved here?
>>
>
> Used in the sense of two copies of something with slightly differences
> given if it were straight code without a macro, we'd have just
> have used the copy being changed here for all of the calls. 
> With hindsight, not the best word to choose given the many other meanings!

Fan, good enough to get your R-by?


