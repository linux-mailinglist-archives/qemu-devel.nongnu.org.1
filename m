Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E85F370E0C5
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:42:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1U8J-0007rN-Cy; Tue, 23 May 2023 11:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1U8H-0007qP-CD
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1U82-0004d8-MT
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L+lGOlNAADPbJnZ5Q20cIDYiJbrwm3i2SH/48VDKDd8=;
 b=eUnUEcytSptfHB9SP1as6U+/971O+vLe9EPQn4xCHFaW3bQodTzDkKapEMp3xCfmw1Byco
 Shj+Nu5yeXvYHC5GqTdPLGCWCztS6zf7A0/X18XEoagJ15LuFm+Ycptg+qOhPTgjJb75YC
 6zmHEhfhiPSaqayb6g8e1lmtilLuluA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-AgZYCoqYMnibtjeHWFhcDQ-1; Tue, 23 May 2023 11:40:44 -0400
X-MC-Unique: AgZYCoqYMnibtjeHWFhcDQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-624a29df9feso5059186d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:40:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856444; x=1687448444;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L+lGOlNAADPbJnZ5Q20cIDYiJbrwm3i2SH/48VDKDd8=;
 b=li5uE5nb0r9+HKfqkfDuGZob95hPZTrrmlDU/s3BOcV+JnWlJMRRRYHjht8B9+B6zj
 sjWoH6PQlLsczYWelJMQrHPML10AeqI6fUH5F4XXkeg5dd3fBEkwlqxd3ZvVdfWRdnse
 AGJODpmO2RRyGI5vYXPQ5l++Y/RjybywbYFXg9SXCpHfrIpb9PTi5F2grRi+F/Lw8Y0I
 p7mA1ettwVF/NiTTsKQrQ7nW4WXZIYI9sXcsRECFU7YJJSyljhfFeWZThkutTO+QtZDu
 uJxnKaPb9ZKwhmb0PWiuLF6MFzTj3tFCRDUPzUDKpRbieng4sH1eMQqwPKXWAxE/bfQD
 UzgA==
X-Gm-Message-State: AC+VfDycJZF2VxAjEgpphvEt32NNPNU7TfqafvOsFUcy3yqAyQBBnvJz
 O8vV28rE0/ZHy4wQatWx+SQ0NZR3BL5Mhf2pYGv2soWRNVYJeIwd2Oqub5Ey+rVPk0Y2D3ctIHG
 zTzcVT0kU6+vUR5o=
X-Received: by 2002:a05:6214:400f:b0:625:86ed:8ab4 with SMTP id
 kd15-20020a056214400f00b0062586ed8ab4mr7313669qvb.3.1684856443863; 
 Tue, 23 May 2023 08:40:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cnI6o2Fr8eW7smEZdcS0l6+ByKusysqe3MUtCsOcGLipGeaSa5QZXJlnmA3WBd8maoGahYQ==
X-Received: by 2002:a05:6214:400f:b0:625:86ed:8ab4 with SMTP id
 kd15-20020a056214400f00b0062586ed8ab4mr7313642qvb.3.1684856443420; 
 Tue, 23 May 2023 08:40:43 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 m11-20020ad44b6b000000b0061b75f3d9bcsm2882176qvx.38.2023.05.23.08.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 08:40:42 -0700 (PDT)
Date: Tue, 23 May 2023 11:40:41 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 2/3] vhost: Remove vhost_backend_can_merge() callback
Message-ID: <ZGzeeWnQnoTQRexj@x1n>
References: <20230503172121.733642-1-david@redhat.com>
 <20230503172121.733642-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503172121.733642-3-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 03, 2023 at 07:21:20PM +0200, David Hildenbrand wrote:
> Checking whether the memory regions are equal is sufficient: if they are
> equal, then most certainly the contained fd is equal.

Looks reasonable to me.

I double checked the src of the change and there's no bug report attached
either.  Maybe just a double safety belt, but definitely Michael will know
the best.

https://lore.kernel.org/qemu-devel/1456067090-18187-1-git-send-email-mst@redhat.com/

> 
> The whole vhost-user memslot handling is suboptimal and overly
> complicated. We shouldn't have to lookup a RAM memory regions we got
> notified about in vhost_user_get_mr_data() using a host pointer. But that
> requires a bigger rework -- especially an alternative vhost_set_mem_table()
> backend call that simply consumes MemoryRegionSections.
> 
> For now, let's just drop vhost_backend_can_merge().
> 
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


