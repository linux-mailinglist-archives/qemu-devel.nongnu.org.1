Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAEC766FF4
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:59:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPObC-0007BN-UO; Fri, 28 Jul 2023 10:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qPObB-0007BE-Px
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qPObA-0004EO-6s
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690555063;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d9FOSInf8Ut/953lgSDq5wY4XvPS8dEecrDSEKLwY2U=;
 b=ZzOciRql4oqk5hUQusBGX82XAhYWLqXNuGke1kQ6Ah7Z47MN6a0xu2q6KXpaD+vwn35Kqc
 UNv42v7YMaQHGxF9c+dZApPGDERr/dHHYuxiWGGXS3zkvSNQf1SQAQzi0nx2jjN5g54k6a
 QSapKkxCXygWiy83CDC/W8+U2RrhS9Y=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-632-wRMSQ_jTOd-2lszji7rEMQ-1; Fri, 28 Jul 2023 10:37:39 -0400
X-MC-Unique: wRMSQ_jTOd-2lszji7rEMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0FD5C1C0725A;
 Fri, 28 Jul 2023 14:37:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A24A1121330;
 Fri, 28 Jul 2023 14:37:38 +0000 (UTC)
Date: Fri, 28 Jul 2023 15:37:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC PATCH 4/6] hw/i386/intel_iommu: Fix VTD_IR_TableEntry for
 ms_struct layout
Message-ID: <ZMPSsCjZhj0AQeS0@redhat.com>
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230728142748.305341-5-thuth@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Jul 28, 2023 at 04:27:46PM +0200, Thomas Huth wrote:
> We might want to compile QEMU with Clang on Windows - but it
> does not support the __attribute__((gcc_struct)) yet. So we
> have to make sure that the structs will stay the same when
> the compiler uses the "ms_struct" layout. The VTD_IR_TableEntry
> struct is affected - rewrite it a little bit so that it works
> fine with both struct layouts.
> 
> Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/hw/i386/intel_iommu.h | 14 ++++++++------
>  hw/i386/intel_iommu.c         |  2 +-
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 89dcbc5e1e..08bf220393 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -204,18 +204,20 @@ union VTD_IR_TableEntry {
>  #endif
>          uint32_t dest_id;            /* Destination ID */
>          uint16_t source_id;          /* Source-ID */
> +        uint16_t __reserved_2;       /* Reserved 2 */
>  #if HOST_BIG_ENDIAN
> -        uint64_t __reserved_2:44;    /* Reserved 2 */
> -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> -        uint64_t sid_q:2;            /* Source-ID Qualifier */
> +        uint32_t __reserved_3:28;    /* Reserved 3 */
> +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
> +        uint32_t sid_q:2;            /* Source-ID Qualifier */
>  #else
> -        uint64_t sid_q:2;            /* Source-ID Qualifier */
> -        uint64_t sid_vtype:2;        /* Source-ID Validation Type */
> -        uint64_t __reserved_2:44;    /* Reserved 2 */
> +        uint32_t sid_q:2;            /* Source-ID Qualifier */
> +        uint32_t sid_vtype:2;        /* Source-ID Validation Type */
> +        uint32_t __reserved_3:28;    /* Reserved 3 */

Hasn't this has changed the struct layout in the else clause

 Old layout:

   source_id : 16
   sid_q : 2 
   sid_vtype : 2
   reserved_2 : 44

 New layout

   source_id : 16
   reserved_2 : 16
   sid_q : 2 
   sid_vtype : 2
   reserved_3 : 28

Was there something wrong with the change I suggested to
just make source_id be a bitfield too:

       uint64_t source_id: 16;          /* Source-ID */

which could make ms_struct layout avoid padding to the following
bitfields.

>  #endif
>      } QEMU_PACKED irte;
>      uint64_t data[2];
>  };

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


