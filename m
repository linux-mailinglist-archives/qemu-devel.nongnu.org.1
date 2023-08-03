Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F02676F3C8
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 22:03:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qReXT-0005kP-4b; Thu, 03 Aug 2023 16:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReXR-0005k5-2Q
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qReXP-0001F6-LA
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 16:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691092990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yxGZTf+vBti3CCS639NmAGT6uwdJraPVJXP9LwgdnM=;
 b=NbNSyX0jL0ztpTB68ZkmOzKI/unSUB9fbirj4KDfeZ9JoENewlSzhQriMs6dNHUBjtXxz1
 nsZH4Yy0kOiyjPFrStSClLAUECg3YKV5k5F6mXq7FMaljjYgnHk5/pBpCrxDLifGV6hazb
 6WKRe/YHebsAtSo6GBKJa/PVcUX0cU0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-rkcQfbAANlS5rvfR-1TObA-1; Thu, 03 Aug 2023 16:03:09 -0400
X-MC-Unique: rkcQfbAANlS5rvfR-1TObA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-521f84b8c42so803080a12.2
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 13:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691092988; x=1691697788;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yxGZTf+vBti3CCS639NmAGT6uwdJraPVJXP9LwgdnM=;
 b=f5Lcq8x0a8sGZsbB2HsMZXmgXG33KlRvhol1oLX5sU5hFFxQ3qAyjHRKctvTd0rf3z
 gNN2m/qkjiBpldJP3s/4dRwZPWRPkBHVyngXx/x3IIREsAawoE8AP3VDO8qShyNTTdYx
 XKDPvaO1gtzZX0mlHypMgnP76z9x/DLPI79Si0eJRjUFYLs3CT+lSfuXINMGgXss77Oz
 uoK47anyeAcaKgQGQBcJMkCAYCMW+vJKPL/yE0aqrjav6Q4o/E2peuX5SeqbwepPEnlP
 jdj/V0coTgWsVToTxtTbSlPsaTC5+am/rmS0WbsZdxBiswmMjP6KPazByxsyWLY50O8r
 HBVw==
X-Gm-Message-State: ABy/qLZPlrixwePCgGpcJAotdMgaihrtz/zLVHmSI3PuFwkBnZ6JccMT
 qJxXnfJ6cgFHST0ditDAhJyLEuwBo6MAAu63D2YnEntQmK123md+v7tjLKyaigaJnAq/uL3nEL3
 j89yrll2GZjQdR3Y=
X-Received: by 2002:aa7:dad2:0:b0:522:1fd1:1035 with SMTP id
 x18-20020aa7dad2000000b005221fd11035mr7523228eds.6.1691092988351; 
 Thu, 03 Aug 2023 13:03:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGHlNbsrlesa7bYF59soOquOZB/EMHquSToND6TzVx+dLsHUcu5c+PujQ2NT1y69ulgpkWHSA==
X-Received: by 2002:aa7:dad2:0:b0:522:1fd1:1035 with SMTP id
 x18-20020aa7dad2000000b005221fd11035mr7523225eds.6.1691092988208; 
 Thu, 03 Aug 2023 13:03:08 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 n18-20020aa7c692000000b005224d15d3dfsm215463edq.87.2023.08.03.13.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 13:03:07 -0700 (PDT)
Date: Thu, 3 Aug 2023 16:03:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 qemu-stable@nongnu.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH] Revert "virtio-scsi: Send "REPORTED LUNS CHANGED" sense
 data upon disk hotplug events"
Message-ID: <20230803160255-mutt-send-email-mst@kernel.org>
References: <20230705071523.15496-1-sgarzare@redhat.com>
 <20230710153942-mutt-send-email-mst@kernel.org>
 <2ec62ac2-763b-1211-7c25-f0513f99dd2c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ec62ac2-763b-1211-7c25-f0513f99dd2c@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 12, 2023 at 10:12:13AM +0200, Paolo Bonzini wrote:
> On 7/10/23 21:40, Michael S. Tsirkin wrote:
> > 
> > Acked-by: Michael S. Tsirkin<mst@redhat.com>
> > 
> > Seems safest to revert, but I'll let storage guys decide whether to
> > queue this.
> 
> There are multiple possibilities:
> 
> 1) it's a QEMU bug that can be fixed, so no need to revert.
> 
> 2) there's both a QEMU and a Linux bug, but fixing the QEMU side is enough
> to hide the Linux bug.  The Linux bug can be fixed leisurely.
> 
> 3) it's a Linux bug that is hard to fix, so we need to revert
> 
> 4) it's a Linux bug that is worth fixing, but depending on how easy it is to
> trigger the issue we may or may not need to revert
> 
> But yeah, reverting is on the table.
> 
> Thanks,
> 
> Paolo

time to decide?

-- 
MST


