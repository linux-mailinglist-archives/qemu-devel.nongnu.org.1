Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388E79AAE3
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 20:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qflq2-0003aG-1r; Mon, 11 Sep 2023 14:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qflpm-0003Xj-GS
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 14:40:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qflpi-0000nY-Qj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 14:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694457625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nasu9EpN3g3kNe1u8UqhUn3yW+PmZuz6LASO3KzJc54=;
 b=ECpghiln7se9QXM6fscxaHfB7OHpczoZyq5n52czvSq18GRQxcsNmThnjdkijMsTSWGTQt
 nMcpkIc0+yXknTY6i7l+WfsdWuHptzGIJ36GWvYuyMJ/vq2LHg4n5kjulZD9NX94igY9Xd
 ZNfBw7r6IfDOaxoCUQTjnyhr9re4t1U=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-nYoCCXQDMNeieqsEouonQA-1; Mon, 11 Sep 2023 14:40:23 -0400
X-MC-Unique: nYoCCXQDMNeieqsEouonQA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1a9e3f67989so1279332fac.1
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694457623; x=1695062423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nasu9EpN3g3kNe1u8UqhUn3yW+PmZuz6LASO3KzJc54=;
 b=X3I+6ZniDEZatcBTiBnsz6/msD1tmEVOLfx4G347Po8a7vEd346EDKWRJRUdJSZ/Dv
 0ovi+fUH5kBbBjvzbz7f78g6fiQhVIHSNMZqsQXH3EmpFnT3YHPpz61RHKis1NxAkB37
 aFgHxg5W4mCIehhviJdKqG1X8j+OGeHOKpbHtgRcaKI22QOMjz3n5VUCpcRvbS59rEKk
 zebVI0bcX2ArMhr1cxwDdF4Rzat8pgwGg5v7JnPnDRH2aZ9pPWK0gNB8fQyhnaz1r15B
 5nH1KtFVcqxK/st22UNB7yZ9e1vaH1a3GiUMjgORZHY0T3K0lNJu4hYfRBk1dTHpzc+4
 ZIEg==
X-Gm-Message-State: AOJu0YwEuwc2wGMAqQ7lrBrDBNTZ6B2/NyiXvT9eFvQJ7EAY4rmcj0LV
 Bss86aenxFXa/qdrhwSEbQ+d/dbPVZKRWZUOrwP/YMSe1XcQSSJ30/RPK7FrO05kie8omrVOIqA
 yuxa8kXIFxvRGuSc=
X-Received: by 2002:a05:6358:45d:b0:13f:1503:92f8 with SMTP id
 29-20020a056358045d00b0013f150392f8mr6860338rwe.2.1694457622858; 
 Mon, 11 Sep 2023 11:40:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGub7GJUpiETCcCXg/Fiy9i6IvZnTLsa5Rn3thwVLLM4JQavCX/elKatQEzdQ2+/PusK1H7Lg==
X-Received: by 2002:a05:6358:45d:b0:13f:1503:92f8 with SMTP id
 29-20020a056358045d00b0013f150392f8mr6860318rwe.2.1694457622506; 
 Mon, 11 Sep 2023 11:40:22 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d10-20020a05620a136a00b0076827ce13f6sm2693648qkl.10.2023.09.11.11.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 11:40:22 -0700 (PDT)
Date: Mon, 11 Sep 2023 14:40:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 01/13] memory: Let ReservedRegion use Range
Message-ID: <ZP9fE32QCaU0SnLL@x1n>
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230904080451.424731-2-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 04, 2023 at 10:03:44AM +0200, Eric Auger wrote:
> A reserved region is a range tagged with a type. Let's directly use
> the Range type in the prospect to reuse some of the library helpers
> shipped with the Range type.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


