Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A31078FF5B
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 16:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc5Kr-0003zD-KZ; Fri, 01 Sep 2023 10:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc5Km-0003yV-Hd
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc5KX-00071k-3Q
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 10:41:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693579260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vx5OIcvqltmH9Xho0MP35R1N6LlfjIM2asT9noUJXQs=;
 b=hIeAbrspI9aqyzOgZSrAwPxFVxI3EYz5RjBY9iF5rJMrI0ejiJCCHnqU1MdkdHD3+iX8SJ
 dSNDTXl4txRvakBTr8WYfB+yF52wRz5CDgpOrLAgm6SiFBmlrsPh4fqHLfC+ioYTklp5Jm
 Cb9JNHqu5b0IRWlu3t6mVz/ye14G6AE=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Q7uMVfZlPCCLNNKg7-3yCg-1; Fri, 01 Sep 2023 10:40:59 -0400
X-MC-Unique: Q7uMVfZlPCCLNNKg7-3yCg-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1c537d413c8so512648fac.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 07:40:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693579258; x=1694184058;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vx5OIcvqltmH9Xho0MP35R1N6LlfjIM2asT9noUJXQs=;
 b=ZwV76Sebj81GpMPEc1fUxUkXESjOnfWWD+1+7CQ9B3bgNfZtmzgcvjXdMyvPrJOvSL
 cPV32jNHBJFo3TLHkw78KJOnA8F6CsZjZFCq8RoIllbCCAMVqp0RWL6hmCBAGLaoPEXp
 hGV7PcEsDZsfj2TY/vqepSLVb8lyGl60papiw8QOGLLPR8xppnHJNtV9dIqv7+K4iheS
 YcN4xHy6yyZC+O4Um4eOQkZpWvbMMowteokh26YmterjFSn06Zpq/YnRBcBwMVq/daR2
 cTpulxy9PIUjBKnfUZlR8EQoTqKObd6HuXQEI+O8VwuhMQhDcGC5NYHTUjud052fMAlc
 g0vg==
X-Gm-Message-State: AOJu0YxGDtg0qMfvVrzg+OaVOipxR2CVdhrvrHluC1UbHBUW1konP1aK
 KMTJNaX1Wu5EBuU8YwzNvLeXj1bhnGkFP7NXqVyx3Cj6nRRORdmdZC449kvkR2A2o61BW3IDRf5
 qI0uhnfLGnPyIlgE=
X-Received: by 2002:a05:6359:6795:b0:13c:cb79:c3b4 with SMTP id
 sq21-20020a056359679500b0013ccb79c3b4mr2815988rwb.1.1693579258004; 
 Fri, 01 Sep 2023 07:40:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIylTTKEPllrYR0yNKKkgz53yCls0BMdJbS1D1q4GU0kFnkFArH/wCxC76t+DumF8WuuW6Dg==
X-Received: by 2002:a05:6359:6795:b0:13c:cb79:c3b4 with SMTP id
 sq21-20020a056359679500b0013ccb79c3b4mr2815973rwb.1.1693579257566; 
 Fri, 01 Sep 2023 07:40:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c18-20020ac853d2000000b0040ff234b9c4sm1498734qtq.25.2023.09.01.07.40.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 07:40:57 -0700 (PDT)
Date: Fri, 1 Sep 2023 10:40:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 Zhiyi Guo <zhguo@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Chensheng Dong <chdong@redhat.com>
Subject: Re: [PATCH for-8.2 v2 2/2] migration: Allow user to specify
 migration switchover bandwidth
Message-ID: <ZPH399XvYl+AiFxE@x1n>
References: <20230803155344.11450-1-peterx@redhat.com>
 <20230803155344.11450-3-peterx@redhat.com>
 <8bb36b56-e2f6-ece8-0d8f-90b87a3b5c40@intel.com>
 <ZPGizMa52LF7Qek1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPGizMa52LF7Qek1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Sep 01, 2023 at 09:37:32AM +0100, Daniel P. Berrangé wrote:
> > Hi Peter. I'm curious if we specify max-switchover-bandwidth to 5Gbps over a
> > 10Gbps network, in the completion stage will it send the remaining data in 5Gbps
> > using downtime_limit time or in 10Gbps (saturate the network) using the
> > downtime_limit / 2 time? Seems this parameter won't rate limit the final stage:)
> 
> Effectively the mgmt app is telling QEMU to assume that this
> much bandwidth is available for use during switchover. If QEMU
> determines that, given this available bandwidth, the remaining
> data can be sent over the link within the downtime limit, it
> will perform the switchover. When sending this sitchover data,
> it will actually transmit the data at full line rate IIUC.

Right, currently it's only a way for QEMU to do more accurate calculations
on the switchover decision, while we always use full speed to transfer
during switchover.

The old name "available-bandwidth" might reflect more on that side (telling
qemu the available bandwidth QEMU can use only), but it might be unclear on
when the value will be used (only during making decisions for switchover).
So it seems there's no ideal name for it.

To be explicit, see migration_completion() has a call there with:

        migration_rate_set(RATE_LIMIT_DISABLED);

And this patch won't change that behavior (to use full line speed).

Interestingly this question let me also notice that when switchover for
postcopy we did it slightly different.  I believe postcopy also use line
speed because we put mostly everything needed in the package, and flushed
in qemu_savevm_send_packaged() with line speed too.

Thanks,

-- 
Peter Xu


