Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF9872844E
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:54:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HxF-0002kG-MG; Thu, 08 Jun 2023 11:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7HxE-0002k7-Fq
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q7HxC-0008J0-Sx
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 11:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686239617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zeOAa9eV7TclDBOkWCBGE5DjHJVqvwqRRFFzfpB6g7I=;
 b=Z6GpSbrR+Snkj3XCd/AFqBc5twBcNciiEFTgCzjnhOgbveyTfThrD+rtsHsacP8im1vkAj
 KLkfShZXNoiAcpY/BhOpUdDTdPIc7NdsI6vQXyGYDm3YOyU7Y3fJ3cPEICjk1qo95Z7tC0
 E9wUxvpkEJvPWXueEUnOmOzYYhemi04=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-TbLBABJ5NEqlC_1a0r9H0A-1; Thu, 08 Jun 2023 11:53:35 -0400
X-MC-Unique: TbLBABJ5NEqlC_1a0r9H0A-1
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-465e93d2bffso31996e0c.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 08:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686239615; x=1688831615;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeOAa9eV7TclDBOkWCBGE5DjHJVqvwqRRFFzfpB6g7I=;
 b=c1P6fWHNgP4wGxWfmGvKOVcGHPjatGHHMMc/bePtmtANmgAF+UQQIrurH6WSmkp0g8
 OnCIVBzAuHluMe9/vTYNqzVqybeJCKH05xWqQzWUXfQ13G1AuZZ0eQnMY5QF6DCJ+44S
 ULd6Gxym1ypC36eLa9eApia5jYKFIqizS6SQbRiyQTV9PSN2+d6ueIObkpVucp7A2DqM
 J2yBvnqCvX+85siP5hvMkJ3TSUqpIL+3+DedR6v51vbYTzMqUVQR2XJVbfK6wrP9gvOX
 Tb4+MpQyu+eSsNvse86a+II/Yah6cQWvcYDcIh+qHwU+WOVGsa7/Lzxy9PsPs6wDgbr2
 ICgQ==
X-Gm-Message-State: AC+VfDwPoPVqAh0pTyVwP+knCHbvKhGsGEudPOzaP8rYgSawGkhnkcty
 SDvngUyBa92HMDOw+ay+oRhiNq/Stl9Nuc1RLX4XADRdXZ7FyiGuwGdu0Dqn4DspaixlpL4yNrJ
 kG5xvM8K+KsTxW14=
X-Received: by 2002:a05:6102:a48:b0:436:2ef4:5e2 with SMTP id
 i8-20020a0561020a4800b004362ef405e2mr1661872vss.2.1686239615449; 
 Thu, 08 Jun 2023 08:53:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7VBU+ogSP8GJ4rXZy2wHf/OHnZG3bpaS35gy83g1kfZMmgzp52OsX8LcVDlGTezTMxDkFtEA==
X-Received: by 2002:a05:6102:a48:b0:436:2ef4:5e2 with SMTP id
 i8-20020a0561020a4800b004362ef405e2mr1661855vss.2.1686239615244; 
 Thu, 08 Jun 2023 08:53:35 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 k4-20020a05620a142400b0075ceca53e84sm420313qkj.15.2023.06.08.08.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:53:34 -0700 (PDT)
Date: Thu, 8 Jun 2023 11:53:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 alex.williamson@redhat.com, clg@redhat.com, david@redhat.com,
 philmd@linaro.org, kwankhede@nvidia.com, cjia@nvidia.com,
 yi.l.liu@intel.com, chao.p.peng@intel.com
Subject: Re: [PATCH v3 0/5] Optimize UNMAP call and bug fix
Message-ID: <ZIH5fF7OZlud2JPJ@x1n>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230608095231.225450-1-zhenzhong.duan@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jun 08, 2023 at 05:52:26PM +0800, Zhenzhong Duan wrote:
> Hi All,
> 
> This patchset includes some fixes on VFIO dirty sync and vIOMMU.
> PATCH1 isn't needed now as dependent changes in PATCH2 is removed,
> but as Peter has given Reviewed-by, leave it to maintainer to
> decide if pick or not.

Let's drop patch 1 until it's really used.  Thanks,

-- 
Peter Xu


