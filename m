Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 833ED79AAE4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 20:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qflqe-0003ij-FG; Mon, 11 Sep 2023 14:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qflqb-0003iG-RV
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 14:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qflqZ-0000y1-PC
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 14:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694457679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XMLo+88NX2zws04KrGVZGS34STIONVHKxOhJuvb4Qx4=;
 b=eAf6hODMzd/f9j831LYE5+mms0Z0hsoXnhtI+c53fkcn+aYQ6d6vOyn4iHi1ImswucRe5+
 L/XL+5dZjeyZlIbqszd+qc7aWcuPloY+hek6ubMxQHVcuewX/8wX7dL6P1XtZ1scpjsGxd
 5JI5wLH9mDdsURXtmNbdlF6+yLagmpg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-hA-U2zLDO56m2U4BUAUXAw-1; Mon, 11 Sep 2023 14:41:17 -0400
X-MC-Unique: hA-U2zLDO56m2U4BUAUXAw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-413650a9d6dso12961381cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 11:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694457677; x=1695062477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMLo+88NX2zws04KrGVZGS34STIONVHKxOhJuvb4Qx4=;
 b=siebIdwK1ZZd1IaUIQ4UxlmerEh3R15Se73YAy3r3oSCRkWP1mLpnRRpRAiXytQQTf
 DE9ClboxbaLPcpkIPdMcZYmQO/rDcxWWmMCQQVHrd7+T5ShJUgcTdTgCBD+pENcEi889
 j2iirM/qSlBR/i0V5OgX98kT/PvkI1BLdumd9KdG4HWjXDGzO1l2WgbE0jN0ckSSoowu
 nDveSrv1FwMPMTb9UNPbYHWPVRjHpzUPlvP4IuRS3W01PoAxcZwuCTWPTGkFp/h3ZPOM
 dDW4YhxEelOw+IXIcGEmt1iwRKpC+eiXj6UleVn9+/AnvmseaHizDIvjWd7q05fPvcU5
 g3zw==
X-Gm-Message-State: AOJu0YwPB0oy0kdbRHNedxkb5XfePAfbctDPttA1GKLK9mE1NybItzgb
 0AVlcbOQKZxF+kJvAQdFb/nGLyffmeZOZs3U3Kn0uJMXYmkiYj/9x40FwnQEyCLb/0ZzzV4SSWR
 CeSoT7LSFaG/hZPs=
X-Received: by 2002:a05:622a:1922:b0:412:2dac:acb7 with SMTP id
 w34-20020a05622a192200b004122dacacb7mr14740174qtc.1.1694457677251; 
 Mon, 11 Sep 2023 11:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGKAFEzayMvaA+RK4pL/OdN+HLpqVz4jzvNi9bj/RH1Mt3FdQQzjRiZdvOlk92kO97u+xHNw==
X-Received: by 2002:a05:622a:1922:b0:412:2dac:acb7 with SMTP id
 w34-20020a05622a192200b004122dacacb7mr14740153qtc.1.1694457676935; 
 Mon, 11 Sep 2023 11:41:16 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 t24-20020ac865d8000000b004009f6e7e7csm2799583qto.31.2023.09.11.11.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Sep 2023 11:41:16 -0700 (PDT)
Date: Mon, 11 Sep 2023 14:41:14 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 02/13] memory: Introduce
 memory_region_iommu_set_iova_ranges
Message-ID: <ZP9fSsSHP52M0fsI@x1n>
References: <20230904080451.424731-1-eric.auger@redhat.com>
 <20230904080451.424731-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230904080451.424731-3-eric.auger@redhat.com>
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

On Mon, Sep 04, 2023 at 10:03:45AM +0200, Eric Auger wrote:
> This helper will allow to convey information about valid
> IOVA ranges to virtual IOMMUS.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


