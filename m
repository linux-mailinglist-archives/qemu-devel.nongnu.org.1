Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ABD7CEAFA
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:07:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEhC-0004UH-CW; Wed, 18 Oct 2023 18:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtEh9-0004TK-P3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:07:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtEh8-0007aK-A0
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697666833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XWtnPggCPR5+sA/EzBEkmL41H1S01Zh/G2zxw0h/XC8=;
 b=A0cWfgml/JHKiT9/LDQBZMxf+2zQjnuypu73Y/5JfVfRNfgbRNfjljSnazUzHQRAqwb+t3
 nWsVcCTqLNdvJGuVRaQy3Z+wAmcq4ouVnyGIg+YRiEmNuIXwz3CJhrEZhBF0a1cTvw5G93
 blFnm7kp00ZkEgrhFsBII5M4n0cSHag=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-57Pw31eCPNerea8RA_4iVg-1; Wed, 18 Oct 2023 18:07:10 -0400
X-MC-Unique: 57Pw31eCPNerea8RA_4iVg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5a7af473da1so21511547b3.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:07:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666830; x=1698271630;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWtnPggCPR5+sA/EzBEkmL41H1S01Zh/G2zxw0h/XC8=;
 b=Bud6NgMyOSQ+FU+vLaiEWCSIs3y7lUTqu4RDSh+0IIzKphCmXRMe0vqXLSCCtmTNUO
 XsRd06+aG1pCtJN+oRDCC2lOy49ulbtCT0mFlnvJx9pNf59xtlD5t52O/bzKi4Rcbqxn
 OgK1OT4KRAzk3Eu2qI0bPzHbu6Oqw+KgdmU503l3Nf2YcG2oI5P/Dw6lWU1WZQvZ8RWO
 2x9apyhkDviqMWyN+7m+kO/x7XNNK125X5Hk1AqDo3VOTZFFcdUPoe1Ki0fTmz1aw5qn
 Kh8puFx5LQlui3OuOn58WjvLVBrWbig1nHxUFIVruROUNBRim3DAE526N/FePrNHEznV
 SKig==
X-Gm-Message-State: AOJu0YxnnccQCl+jZ+2knp7eQzFJWM+aCjmL2HpoF7m4Y1QWqKEGzaxE
 J0evopg6m0Bm4XUFQ8xwRhquThq9E+gHXGXqBQq7PsIkTruAiivUWUaNIIIZ9J8Yxxs7DraxBYZ
 3GRY5YyPbOn1o708=
X-Received: by 2002:a81:790e:0:b0:5a7:af72:cb55 with SMTP id
 u14-20020a81790e000000b005a7af72cb55mr592984ywc.2.1697666830003; 
 Wed, 18 Oct 2023 15:07:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSmvZn1jTMam72GLteeOP/Y+qoWZX7XfDrGNGYhzrAOA2b9Mc6ssBOVminjHC7jx6XdqR0QA==
X-Received: by 2002:a81:790e:0:b0:5a7:af72:cb55 with SMTP id
 u14-20020a81790e000000b005a7af72cb55mr592965ywc.2.1697666829681; 
 Wed, 18 Oct 2023 15:07:09 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u4-20020a05620a022400b0076efaec147csm277817qkm.45.2023.10.18.15.07.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:07:09 -0700 (PDT)
Date: Wed, 18 Oct 2023 18:07:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 alex.williamson@redhat.com, clg@redhat.com,
 jean-philippe@linaro.org, mst@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, david@redhat.com, philmd@linaro.org,
 zhenzhong.duan@intel.com, yi.l.liu@intel.com
Subject: Re: [PATCH v3 02/13] memory: Introduce
 memory_region_iommu_set_iova_ranges
Message-ID: <ZTBXCqZDzfm0y1CH@x1n>
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231011175516.541374-3-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011175516.541374-3-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 11, 2023 at 07:52:18PM +0200, Eric Auger wrote:
> This helper will allow to convey information about valid
> IOVA ranges to virtual IOMMUS.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


