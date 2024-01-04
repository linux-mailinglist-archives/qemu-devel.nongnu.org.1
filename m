Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12509823A50
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 02:43:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLCjw-0004f2-4M; Wed, 03 Jan 2024 20:41:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLCjs-0004eq-Vz
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:41:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLCje-0000ZR-5o
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 20:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704332482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=So9BRgHhVc7N8df1DD0LmU9UuDC6pfGnQTPXpOwz1wU=;
 b=MOIOSi/yJK/e6ZBupl5HHyxEs4QGqroEn63Y5pxzWUPlwZG60c27w2XT8BsFK0ag8E2dg9
 KRf8n7c1k43ov3v4ZQVgC0NdAM6hz9AC2mvytQc86dOX22r2zsDXtS7p+30Wd5+O5J8leZ
 uv73g/ikEOPdLiuxhDp9HIDnjh1uJ00=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-5_uQtwUFOX6w-j94GS37VQ-1; Wed, 03 Jan 2024 20:41:21 -0500
X-MC-Unique: 5_uQtwUFOX6w-j94GS37VQ-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6db9f726643so18321a34.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 17:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704332480; x=1704937280;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=So9BRgHhVc7N8df1DD0LmU9UuDC6pfGnQTPXpOwz1wU=;
 b=RRrwQOyU6nFsyQKycvxxxKEgGxBecS9Y/lFFq+qCK4+fMD6KGYEuNuha4pIPXyJnKX
 ajjj5CQ7wkSx7WscyAwziFwLQcSzE31CBUucmlyIQgdR3Ej9/GF8x5+mlk6TQCf7TxCe
 pPqtu5V+zeaOafhC6cBmPqmFAKUeLpeFsqpQuiv/dYKOznqQtDSty/ktlJ6/zFJv5Rso
 RrfOXhy0rJiuTyrPBXWowpU03DwEcz4wQg6rl7dPuK7ZldHBCQnYrqCTLOs2aXZpjsOa
 2cyNxKXQwP2p0i2vxIBlhNWOSqpXAsAP/0P9vU/8GYMTpYZHZZ72MaH7i8+6fDE6cq9D
 2TAA==
X-Gm-Message-State: AOJu0YwvC/aFVHDqkGltv5w7xxRKvZxmDZwn79k/agom6VZxOHm/jjVz
 s7HPyt861id8XdEIjN3EUnU6ONKz/fxFOtd0eungX5Q/Dx3e7NZ2dvJwBi/TBNq5mkDTNdsSJaL
 9f1yf2rB4ht4il3Wm9qRo7Ls=
X-Received: by 2002:a05:6359:6b87:b0:174:f9ba:9482 with SMTP id
 ta7-20020a0563596b8700b00174f9ba9482mr18385280rwb.1.1704332480701; 
 Wed, 03 Jan 2024 17:41:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8oIMxJORNGN5pnaCM9U7pxh8V9+hRpj29vUVKq97xi5t8YSS1juU/pcCGddNWI/S1Du1Emg==
X-Received: by 2002:a05:6359:6b87:b0:174:f9ba:9482 with SMTP id
 ta7-20020a0563596b8700b00174f9ba9482mr18385268rwb.1.1704332480283; 
 Wed, 03 Jan 2024 17:41:20 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v4-20020a626104000000b006d9c972ec57sm17545033pfb.174.2024.01.03.17.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jan 2024 17:41:19 -0800 (PST)
Date: Thu, 4 Jan 2024 09:41:15 +0800
From: Peter Xu <peterx@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Li Zhijian <lizhijian@fujitsu.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Remove myself as reviewer from Live Migration
Message-ID: <ZZYMuzE4XRJAWiqt@x1n>
References: <20231221170739.332378-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231221170739.332378-1-leobras@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, Dec 21, 2023 at 02:07:34PM -0300, Leonardo Bras wrote:
> I am currently focusing in kernel development, so I will probably not be
> of much help in reviewing general Live Migration changes.
> 
> For above reason I am removing my Reviewer status from Migration and RDMA
> Migration.
> 
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Leo, thanks for helping in migration areas in the past.

Queued.

-- 
Peter Xu


