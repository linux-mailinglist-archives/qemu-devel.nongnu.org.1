Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77673D453
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 23:08:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDWx7-0001l2-Dp; Sun, 25 Jun 2023 17:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDWx6-0001kY-4F
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qDWx4-00079s-4a
 for qemu-devel@nongnu.org; Sun, 25 Jun 2023 17:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687727220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=831qAQ5IaX+IWTpgef57yv6uK5VIKpRLUpq1/UftLHM=;
 b=Qe2rAQHm/TZUMHssjBLXXPlydIcPsU6KRIBT8MTs95Ap5O31AXxs/jVBteb9OTm7bHI+d8
 MyG1sRZDblEjr55qyLQJ70IOkcrLVB+z1UHgCytiM/8pP7FcWOf60N+iaHeu9Lfyhkp3F+
 at7JV+dBsNfx+E1taD11mQ+OgP0Zmnw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-VaevBmFMOTimAX14NaXvfw-1; Sun, 25 Jun 2023 17:06:58 -0400
X-MC-Unique: VaevBmFMOTimAX14NaXvfw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-313f0d98e3dso124497f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 14:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687727216; x=1690319216;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=831qAQ5IaX+IWTpgef57yv6uK5VIKpRLUpq1/UftLHM=;
 b=a43saL2HkMwCL0H/3zVURhx+prBvnbO78+mmVAPFg5n4vnzuB5Vkt9s0LAyxYjlhzp
 pwLCQftZ2jmfX3sMW4rgpRraKCdgkAdObwVwHQQa982xG7fx7vYmF3rDx1ffBQCeDzko
 9F8xFlZmWHaasqaePrpXVMc8eHbJVHdH9btkszgAtJL0PkoniRBvvJquFOvM+L664711
 94GAqBK+dumE45WjmofRPf/9lNyTpBsEjfT2iVcabKq1DKd/wvhE37cJZ/Emqs6uDCfd
 1AdSp+sEGAZ18dFiCEQAM9ExxKqWhCBa0I+7NDd4YHtWjy3GiqtW4aD/4seBtUukQxES
 5Y+g==
X-Gm-Message-State: AC+VfDz3vvui+fa/No98aGk/2xsWyfsUq3ax4bn9Ay6SomJcpdDvBfaM
 mfGBAgAw06c1mg/k3D+NpN8gnn7zAEmscf5qugKyXoffpv+1nB6dmay8+gL3NfkHzccFgzs83qm
 bljOz5av58IKA/cc=
X-Received: by 2002:adf:f786:0:b0:313:ec05:3e39 with SMTP id
 q6-20020adff786000000b00313ec053e39mr1613241wrp.27.1687727216371; 
 Sun, 25 Jun 2023 14:06:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5iUB3c+7Kanv1glBA9pJkFnBnTgaf8afnr3Bd/+XVBJgK2GxjTz3QWnQogaKFvIW6r2++4Gw==
X-Received: by 2002:adf:f786:0:b0:313:ec05:3e39 with SMTP id
 q6-20020adff786000000b00313ec053e39mr1613235wrp.27.1687727216054; 
 Sun, 25 Jun 2023 14:06:56 -0700 (PDT)
Received: from redhat.com ([2.52.156.102]) by smtp.gmail.com with ESMTPSA id
 w7-20020a5d4047000000b003063772a55bsm5404868wrp.61.2023.06.25.14.06.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 14:06:55 -0700 (PDT)
Date: Sun, 25 Jun 2023 17:06:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v1] virtio-mem: Simplify bitmap handling and
 virtio_mem_set_block_state()
Message-ID: <20230625170601-mutt-send-email-mst@kernel.org>
References: <20230523183036.517957-1-david@redhat.com>
 <39b97e00-fb3c-29b2-aa1f-1de4c8094899@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39b97e00-fb3c-29b2-aa1f-1de4c8094899@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jun 23, 2023 at 02:51:11PM +0200, David Hildenbrand wrote:
> On 23.05.23 20:30, David Hildenbrand wrote:
> > Let's separate plug and unplug handling to prepare for future changes
> > and make the code a bit easier to read -- working on block states
> > (plugged/unplugged) instead of on a bitmap.
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Gavin Shan <gshan@redhat.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
> 
> I queued this to
> 
> https://github.com/davidhildenbrand/qemu.git mem-next
> 
> -- 
> Cheers,
> 
> David / dhildenb

oh I queued this too.
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

-- 
MST


