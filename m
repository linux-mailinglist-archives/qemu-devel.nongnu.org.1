Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A99FE7828E6
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 14:21:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY3tI-0005Kj-Mo; Mon, 21 Aug 2023 08:20:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qY3tE-0005Ka-7P
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:20:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qY3tB-0000M4-VB
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 08:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692620408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=20AhhS1qGEFbCoWpnCAFz/CpwwrhCZFsTOfUFrhiE30=;
 b=NYXJcTQF9znmMDH6zbbvhtZzM270UhXkJHyQwd/hVFG1X0/XlD78YHBn3spUKM0n9QFx9P
 sUbHILufuTEq73jjCRY0M4xFTK0MJu0B4mxHdfzSk88xFafdGZvOm51RyEt9wpwlfuV8oP
 rnIc7wqdlXaMrwR2XfnkDwnaGtb5l+s=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-_GVsP5QbMI28m4XIHft95Q-1; Mon, 21 Aug 2023 08:20:06 -0400
X-MC-Unique: _GVsP5QbMI28m4XIHft95Q-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a1a16b1602so32359566b.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 05:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692620405; x=1693225205;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=20AhhS1qGEFbCoWpnCAFz/CpwwrhCZFsTOfUFrhiE30=;
 b=OM5z/pWB/CgVzjyFBlbXM5gRqQFxb7X/T+KcUFHt+ACXsytMMjNSJwGZbvxTxU+T1K
 HBLid40mrwvdbfjxBnl1kId0VyFjdGrk0q6YvpM8Sod5NaRLaTEGP++UeFxVjv1/GaJE
 SE8mM/Sw8xE46vjby1JRr2iXs/ybQCKqNVzWtOwaZfYeNk7oEiyx/UmmrdS6pUywnpQG
 ZL1WPKFa3Y5IfJL/zDICpqXNwSLZXzJSb0gC5Jq7bbFQy67Nc76RHa4bTXRwxkE57guy
 s+QHuplop1z1qaO34Gq9pbNr3mwZ2Z1mRpMF+inOu0Gci3JWQwEgMgVzUL5Fls76siaM
 E/Yw==
X-Gm-Message-State: AOJu0YxQEoXAuBDKAu6AeJFrcYL+nGtgs79MR+s9f64GNRWWNSkrBgRc
 O7R1GWOq22bWWlSasC0bPKZtfqVzNtyt48Iao1JdVnYA1FBJFeY1C+LHP8HzGZMujjE+ZzV0tN8
 eZ0k+ggRUCxuqyAU=
X-Received: by 2002:a17:907:2cf1:b0:992:6064:f32b with SMTP id
 hz17-20020a1709072cf100b009926064f32bmr5159775ejc.46.1692620405502; 
 Mon, 21 Aug 2023 05:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFK759X0KQFMmKR/ek9y2IdBpk235/fXibNCp8qaAak/hTgNzM20NHsRUI2oLnu5EG8+mdIzg==
X-Received: by 2002:a17:907:2cf1:b0:992:6064:f32b with SMTP id
 hz17-20020a1709072cf100b009926064f32bmr5159765ejc.46.1692620405254; 
 Mon, 21 Aug 2023 05:20:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 p12-20020a1709060dcc00b009944e955e19sm6484188eji.30.2023.08.21.05.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 05:20:04 -0700 (PDT)
Date: Mon, 21 Aug 2023 14:20:03 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, ThinerLogoer <logoerthiner1@163.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <20230821142003.789b692f@imammedo.users.ipa.redhat.com>
In-Reply-To: <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
References: <20230807190736.572665-1-david@redhat.com>
 <20230807190736.572665-2-david@redhat.com> <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
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

On Fri, 11 Aug 2023 17:26:24 +0200
David Hildenbrand <david@redhat.com> wrote:

[...]
> Nowadays, "-mem-path" always defaults to MAP_PRIVATE. For the original 
> hugetlb use case, it's still good enough. For anything else, I'm not so 
> sure.

We can deprecate -mem-path and direct users to use explicitly
defined memory backend with legacy compatible example.
That way users won't come back again trying to fix it or
try inventing options to alter its behavior when using
explicit '-machine memory-backend=foo' can do the job.



