Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7883F7DE653
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 20:19:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyGjU-00058P-TW; Wed, 01 Nov 2023 15:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyGjS-000588-0S
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 15:18:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyGjP-00006H-Hj
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 15:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698866302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YB2p/Yge7SrWi7crm8YFi5rd/npzGYBR5qPMQ7ZlBto=;
 b=WZpIu7aNcBf7mvq9W+7tgYdeEs1WMVPoON9MCCsCV6pxEDKwOGOjDxpt2lt+Q73PdsQkkJ
 eru+TyOaiFlPY+S6mzjORd3GztcuehjC0nK8eKTnXoPIVhqvXUd9mXX7Om4l3eZQn4tZey
 nVhRVdycWD+drpHiNIZyqamw+RmmOq4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-lkozvxoNPg6BAaCa7S42CQ-1; Wed, 01 Nov 2023 15:18:16 -0400
X-MC-Unique: lkozvxoNPg6BAaCa7S42CQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5a7b5754de7so394967b3.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 12:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698866296; x=1699471096;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YB2p/Yge7SrWi7crm8YFi5rd/npzGYBR5qPMQ7ZlBto=;
 b=rYVDaceSr7gzUx1oUyRezexvTICoKZ4uJbdtvuVnYz9CpzLXgLSHKo9kT7RpSyOWbo
 ynXYluoMM2rxY65zOek1J6BmwgxodDmlGl4sone2S0y3eLhjjLu7IUVjzAhDwIrCY96d
 h9jyMFRvEHvl/5IyjqEdURhAuOvkqIXa6ahysRBGDgu58s1ELPfzTfcn7saviFAP79xp
 uYTApATULZCNxbhTM4I1iLr/EpQD4ijCa0EgvsWtq1+SYkqJXqJJ6xVTrNAJqREGz0bT
 CiZQCMQB3indPv9VtEOestBSWTcubXffOEgAj3u/GrmCJKah3HCyYIYUHCDUwdrFtQWl
 RyTw==
X-Gm-Message-State: AOJu0YwgVM4BSA4mnj28xaDGUiITbguST1LPgNVI8/xe8mhag4CGXvi4
 Zb2gh5Y5L9fXOy0mCulhCVXT9ST80OfQzigupL3QVTg7rSdAZ2OePFrz+YFMlWCp62eROt+1NW5
 KSZXFCLeu3dJrEIs=
X-Received: by 2002:a05:690c:4502:b0:5a7:ba54:5127 with SMTP id
 gt2-20020a05690c450200b005a7ba545127mr10832102ywb.3.1698866295916; 
 Wed, 01 Nov 2023 12:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN5qBl/6mGwc75mKrFts6Lvq2OdOInmBT9Xs/WUwkp/M7ZAk7srkCTedY/JVdFMah3kMn/UA==
X-Received: by 2002:a05:690c:4502:b0:5a7:ba54:5127 with SMTP id
 gt2-20020a05690c450200b005a7ba545127mr10832091ywb.3.1698866295668; 
 Wed, 01 Nov 2023 12:18:15 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v14-20020a0cf90e000000b0063d5d173a51sm1731537qvn.50.2023.11.01.12.18.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 12:18:15 -0700 (PDT)
Date: Wed, 1 Nov 2023 15:16:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 1/5] softmmu: Per-AddressSpace bounce buffering
Message-ID: <ZUKkGcg+PPn/6M+L@x1n>
References: <20231101131611.775299-1-mnissler@rivosinc.com>
 <20231101131611.775299-2-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231101131611.775299-2-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Wed, Nov 01, 2023 at 06:16:07AM -0700, Mattias Nissler wrote:
> Instead of using a single global bounce buffer, give each AddressSpace
> its own bounce buffer. The MapClient callback mechanism moves to
> AddressSpace accordingly.
> 
> This is in preparation for generalizing bounce buffer handling further
> to allow multiple bounce buffers, with a total allocation limit
> configured per AddressSpace.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


