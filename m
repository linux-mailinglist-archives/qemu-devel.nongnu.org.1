Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF0E79F126
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 20:32:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgUdd-0002tt-EB; Wed, 13 Sep 2023 14:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgUdb-0002ta-Aj
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 14:30:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgUdZ-0006Z6-6W
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 14:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694629850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J1wTbOMberQ7KiEziAhrevSDERUBWfASoze19riqzhw=;
 b=OeVx7Y5RgSYxGpcT1GWuDEwgcq1+tFC6BPHQ1zroCPoW4Um4wRC1/MGB/bqJkgGY5HAtca
 LPNtuTV0q/m7cWG8OGSOBlUEgLZSRUeIAwO28r/0RwRyEQQlXDHkMoDVQK3dF5WerU+4XH
 tjFm47Od7b+AJPBQkJpSUok9Jv2DGhk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-vuV85dC0Pv-940Uo5ReAXw-1; Wed, 13 Sep 2023 14:30:48 -0400
X-MC-Unique: vuV85dC0Pv-940Uo5ReAXw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76f1cc68e65so3299185a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 11:30:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694629848; x=1695234648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1wTbOMberQ7KiEziAhrevSDERUBWfASoze19riqzhw=;
 b=QmegJWytxxQZ/dTH0U9UKmDuzMWvP/4wshRyGvlvPl8/cF+3DO46nutO7wYjYPiAm9
 4ChkjV2ZbT/DyWu6dawRe3SfoIsd48Ecji1o4j+lsgNidWkjvl2TdVdJxx/9JX+N3gt9
 x+vSSFwv+tlO3xh/9GC6epTkuzpAuMi+LQqvcGiM9ludIQ2cwGC9O2HLD1pRZfXMwgnc
 ZUrQWxE0OSiUcna7qeZ7SHM8RFxREKABOe4DD4FzntZO6E+3jKeXQVxgjhgvtvw/wBMO
 TsgMvYSlqF99gVghzWOuxOLHIGRJ9lDpmRplJ59N7UrZ7YPquct67L08J+36X4OUxosl
 qHFw==
X-Gm-Message-State: AOJu0Yz/qt+L7q7DgkSlCos0MfJCNTGtO7UlVmE5iFrGRrhcOl55HtGf
 Ix1gDGtthjSd27/1JhgVbsPf2rKLHcLsOUQ8NucFc2MFZnsx30noKG+WRGQLsRTqXu/sr29BFZm
 1dm/U+LXlMyDkqNg=
X-Received: by 2002:a05:620a:17a5:b0:76d:95d3:800f with SMTP id
 ay37-20020a05620a17a500b0076d95d3800fmr3525402qkb.3.1694629848419; 
 Wed, 13 Sep 2023 11:30:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKlmyMH1ZMSVdZWW/mPEqxF9omleJW0IIwKX12BT7EHqRthKa/ShcZiREQ7WWmt/QNKcyw+g==
X-Received: by 2002:a05:620a:17a5:b0:76d:95d3:800f with SMTP id
 ay37-20020a05620a17a500b0076d95d3800fmr3525386qkb.3.1694629848168; 
 Wed, 13 Sep 2023 11:30:48 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s16-20020ae9f710000000b0076ef0fb5050sm4082426qkg.31.2023.09.13.11.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 11:30:47 -0700 (PDT)
Date: Wed, 13 Sep 2023 14:30:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/5] softmmu: Per-AddressSpace bounce buffering
Message-ID: <ZQH/1pRzHhaXbl+E@x1n>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-2-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907130410.498935-2-mnissler@rivosinc.com>
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

On Thu, Sep 07, 2023 at 06:04:06AM -0700, Mattias Nissler wrote:
> @@ -3105,6 +3105,9 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name)
>      as->ioeventfds = NULL;
>      QTAILQ_INIT(&as->listeners);
>      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> +    as->bounce.in_use = false;
> +    qemu_mutex_init(&as->map_client_list_lock);
> +    QLIST_INIT(&as->map_client_list);
>      as->name = g_strdup(name ? name : "anonymous");
>      address_space_update_topology(as);
>      address_space_update_ioeventfds(as);

Missing the counterpart in do_address_space_destroy()?

Perhaps we should assert on having no one using the buffer, or on the
client list too.

Thanks,

-- 
Peter Xu


