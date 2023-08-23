Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4652786150
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuMq-0005cj-HI; Wed, 23 Aug 2023 16:22:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMo-0005bm-EK
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMm-0005EA-Va
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:22:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692822132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+tzMgDM9lpHko7ykZ540VsS7RJ3PTo9MvbBMHpxUes=;
 b=IPV7ZH2UlnI5/t4wcjgVeCkRCqIDiKuZLiHt4WRZCtbaWjjN6GU8V37zGhdNGiIkTlqAGp
 KOoW0kzha7sb8Gzg5ijbn0Yq1+HhijlI0qxa2hnbcK0vg2JIy762QEhuH22AiMbuj9ED4I
 XJbIl03fdGqRusjwzFGVacSbUqpQKtE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-l0oYYLrkPD-7QO3Zyfj2Ow-1; Wed, 23 Aug 2023 16:22:10 -0400
X-MC-Unique: l0oYYLrkPD-7QO3Zyfj2Ow-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1c8d3bfbdbfso924754fac.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822129; x=1693426929;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+tzMgDM9lpHko7ykZ540VsS7RJ3PTo9MvbBMHpxUes=;
 b=YXJCHXiYZHJXojZgn2ko3pecZe1S2t861RwdYLOQHnQptfxzWDhOyUnHAC6BxPt4+r
 9QjIE5ON/L3Gl9N8m79we8iYA0dAfNi1BaEWhpiQSdI880eutYtbxoMIGDjksmNbE6X5
 CBfMqoB6xLFYNPNJKyXT6aD9aLsfUIaOiKomQMCSB6VbYU/yCS8WnqYThFzw2zV7uS+L
 3IEK/d5zcfI0jU3Lz1oxIVia3IQKG6I8NvfoBibxNp1TO/E30k6Eo6yZKf0daehlCQ4G
 VDk2V1HeKD/h6Mbr4P6Cd+NJ/oAnS6WOCoH4xm7j7thG+stk84MVZyxWr+iFoDAaiFBS
 xL+w==
X-Gm-Message-State: AOJu0YxWK3XQ/pdVc26BWCLAL3SU8FY+pMvAuLHfpJ93J3XH1LU/WgfE
 zokL9ZgzHRCTu6Bww180JAAQSlu4qQJDfPnAeO4RpFltiizuiaDt/YAsSb9hldY1u3tL8e+IjJb
 MJkc8VBnj6P0YKy4=
X-Received: by 2002:a05:6871:5223:b0:1bf:fe4f:db58 with SMTP id
 ht35-20020a056871522300b001bffe4fdb58mr17051242oac.5.1692822129447; 
 Wed, 23 Aug 2023 13:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTO/fpFfDit1uDHaQ2yM4/696GTKtNTMydz64X6vbNCN3SEQUYrw1LQLodo/N2/6BYrcvdQQ==
X-Received: by 2002:a05:6871:5223:b0:1bf:fe4f:db58 with SMTP id
 ht35-20020a056871522300b001bffe4fdb58mr17051232oac.5.1692822129119; 
 Wed, 23 Aug 2023 13:22:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z9-20020a0cf009000000b0064bdd4239f3sm4407196qvk.126.2023.08.23.13.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:22:08 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:22:06 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 06/11] softmmu/physmem: Fail creation of new files in
 file_ram_open() with readonly=true
Message-ID: <ZOZqbn6uQQVExx9e@x1n>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823153412.832081-7-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 23, 2023 at 05:34:06PM +0200, David Hildenbrand wrote:
> Currently, if a file does not exist yet, file_ram_open() will create new
> empty file and open it writable. However, it even does that when
> readonly=true was specified.
> 
> Specifying O_RDONLY instead to create a new readonly file would
> theoretically work, however, ftruncate() will refuse to resize the new
> empty file and we'll get a warning:
>     ftruncate: Invalid argument
> And later eventually more problems when actually mmap'ing that file and
> accessing it.
> 
> If someone intends to let QEMU open+mmap a file read-only, better
> create+resize+fill that file ahead of time outside of QEMU context.
> 
> We'll now fail with:
> ./qemu-system-x86_64 \
>     -object memory-backend-file,id=ram0,mem-path=tmp,readonly=true,size=1g
> qemu-system-x86_64: can't open backing store tmp for guest RAM: No such file or directory
> 
> All use cases of readonly files (R/O NVDIMMs, VM templating) work on
> existing files, so silently creating new files might just hide user
> errors when accidentally specifying a non-existent file.
> 
> Note that the only memory-backend-file will end up calling
> memory_region_init_ram_from_file() -> qemu_ram_alloc_from_file() ->
> file_ram_open().
> 
> Move error reporting to the single caller.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


