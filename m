Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC1470E0C9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:43:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1U9t-0001E5-8N; Tue, 23 May 2023 11:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1U9p-0001BQ-N6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:42:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1U9m-0004ui-7n
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684856557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tls9UQCbA+7zF5o9HgTPQnUflimd9135ou+GLwWR/lA=;
 b=QQdrRQwu3ToZ7CkMQUY93TLEMswVDfCHzJF5m9aIc/nACKo+WT96xsqNGA8WpawhSd0+AC
 KtIxcJsFHLiDLxRI5NCYaBfYOkAooYv6f3VrHkhpRSWVQJ7Nzs+rEteT2RSlgrAym5zmFr
 BeAXn+BBKc60zFwP5iYxFShzWTBihmg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-SH13XqoWNiW98y5znCnk3Q-1; Tue, 23 May 2023 11:42:36 -0400
X-MC-Unique: SH13XqoWNiW98y5znCnk3Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-623a2273194so9801126d6.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684856554; x=1687448554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tls9UQCbA+7zF5o9HgTPQnUflimd9135ou+GLwWR/lA=;
 b=N75zQh+U2I0ta761Csat3Pn/zbPu0LGA5uYZ/pg0ifgqhSS+lb1kdfjdUgofTfhmCk
 q14a3BaSSvUwUHT1cXzZRU7m1+m3UBlj0PwjsZ2glMRnvN8GAMMqjIEOkHs6jtWCpub3
 5v6icM1AsVxwylN8q1VVCSrtXGaz3/N83meHwQxhy3PsuG0KkDI8SUdvUHKTBMbWywrh
 NeqdnVhW6nehdvg9yzklYpkaBIlgnzGSR4Zp8pByFb70+CTQl4K5pekzBMK/ja8u7cOV
 s0HPrF4g5l1rFNU17PaQVymRmXdnps/Ee/GLLM5xuMHopjJoPpxgJgAyxPHHcvqculFm
 VJFQ==
X-Gm-Message-State: AC+VfDwEEel7HehX+ssoyxfPEBWoLkB321i9Jp9IMMdZeZWZ/+xV8nq9
 XWHj1lQZxO19FACoLrgu+HQfLjiR8muxkPMJRacT9FNeyRl6VLxAF84ILu8cELUXSo9E64pZxnK
 6ZGffHdwIU7d9TT76MhHBlmI=
X-Received: by 2002:a05:6214:4013:b0:616:73d9:b9d8 with SMTP id
 kd19-20020a056214401300b0061673d9b9d8mr22823908qvb.3.1684856554463; 
 Tue, 23 May 2023 08:42:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5G1hjTHwDtDU9UqfxypRyI0zC9imE9qt3cDMYgmKo37AvlRN9GBC7OpBq5DscjZgWMCvUhBQ==
X-Received: by 2002:a05:6214:4013:b0:616:73d9:b9d8 with SMTP id
 kd19-20020a056214401300b0061673d9b9d8mr22823886qvb.3.1684856554264; 
 Tue, 23 May 2023 08:42:34 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 fc10-20020ad44f2a000000b0062439f05b87sm2801772qvb.45.2023.05.23.08.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 08:42:33 -0700 (PDT)
Date: Tue, 23 May 2023 11:42:32 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 3/3] softmmu/physmem: Fixup qemu_ram_block_from_host()
 documentation
Message-ID: <ZGze6Gm3uCNnrkJB@x1n>
References: <20230503172121.733642-1-david@redhat.com>
 <20230503172121.733642-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503172121.733642-4-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, May 03, 2023 at 07:21:21PM +0200, David Hildenbrand wrote:
> Let's fixup the documentation (e.g., removing traces of the ram_addr
> parameter that no longer exists) and move it to the header file while at
> it.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Acked-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


