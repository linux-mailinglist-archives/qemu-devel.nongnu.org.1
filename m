Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C66007763A4
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 17:26:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTl4s-000654-5z; Wed, 09 Aug 2023 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTl4p-00064g-IP
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qTl4n-0002fI-GR
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 11:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691594780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d3nAmAzY4AMAMlaFebWvfM4/rHkpnLm3Scp6iUA5vB8=;
 b=L/jy6rTETasCZzayjNG+rdwwSn/bTM414wtN26xMvZ+zoawSRqd8adrPhWKdEqGbL6Egi1
 vEYhTEkqSZQXn9OciYz2emgQNjFw03H+7bFMZWn//F8EQgDM7OD04AFnBxlfAMRr6c/F3X
 Snz2DGI0l3yPeCnuVSZr35h76l2I+oI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-dhAyFpIgPBSV_46n7F2bLA-1; Wed, 09 Aug 2023 11:26:18 -0400
X-MC-Unique: dhAyFpIgPBSV_46n7F2bLA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63f96fcb4ccso6624806d6.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 08:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691594778; x=1692199578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3nAmAzY4AMAMlaFebWvfM4/rHkpnLm3Scp6iUA5vB8=;
 b=O4qfkJ/AhwIh7qsXl7LOHm+GOC/L+/FlJIsmlxX4mruhJyPnEw36FyaSIfBXH5dG1h
 Yz8b4mV2S3MB7rb09AaGNP/df8NQt/H8Zt2PB3QZPWHKL6wem3Kx3Ix5a+Kv8joT6IWQ
 fi/qs4c3KCQNLOVl5pP2rpRjTwGS0UjwMP5b0ASR84YHBaP6LPkWcxDLbgNL6z6bp3W5
 3UJ6bDJjAHdef3pcbqFcqwqxAKYkyMHPbC6bSP9ny3ssqKXmDLX1nv3PoF1G0f40qjBk
 fu5Qoy/kHK/gpwJB6DWjhsPssKQHQfOKrWIv8Vy0kIfahhuuJTeQIt/9zGc6pgONXxrR
 Fl4g==
X-Gm-Message-State: AOJu0YwAAur1jyPn4dSKdP/6rwVvGpfzetW3xNMmocAJdqGLXQiJ0a9U
 fJlOz8CsaCUE3pUJj7+22VEiO6oGA1C3VJzGukDRldIoH61q1Za3zkBykE9y2Rb8BdlM6d2nD+r
 DaQGTh7G5UTmfFY0=
X-Received: by 2002:a05:6214:20aa:b0:635:da19:a67f with SMTP id
 10-20020a05621420aa00b00635da19a67fmr3314999qvd.1.1691594778155; 
 Wed, 09 Aug 2023 08:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6rGbCKLEPYoUkEc5Dl7kT0MVbV7oe/1KakY+kRz71RmmmRXm6P6CqAAkYTBTUGkuTXWSy/w==
X-Received: by 2002:a05:6214:20aa:b0:635:da19:a67f with SMTP id
 10-20020a05621420aa00b00635da19a67fmr3314985qvd.1.1691594777931; 
 Wed, 09 Aug 2023 08:26:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 p14-20020ae9f30e000000b0076ca401d8c7sm4057967qkg.111.2023.08.09.08.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 08:26:17 -0700 (PDT)
Date: Wed, 9 Aug 2023 11:26:16 -0400
From: Peter Xu <peterx@redhat.com>
To: gudkov.andrei@huawei.com
Cc: Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 quintela@redhat.com, leobras@redhat.com, eblake@redhat.com,
 armbru@redhat.com
Subject: Re: [PATCH v2] migration/calc-dirty-rate: millisecond-granularity
 period
Message-ID: <ZNOwGBybcBz0DpH7@x1n>
References: <8ddb0d40d143f77aab8f602bd494e01e5fa01614.1691161009.git.gudkov.andrei@huawei.com>
 <CAK9dgmbnBL2sSoUm0cgdySsA0PqAJc0yR1750-yp1eVssQ-UMw@mail.gmail.com>
 <ZNOqnLFaD/At4poY@DESKTOP-0LHM7NF.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNOqnLFaD/At4poY@DESKTOP-0LHM7NF.china.huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 09, 2023 at 06:02:52PM +0300, gudkov.andrei@huawei.com wrote:
> > Not for the patch, I'm just curious about how the predication
> > decides the network throughput, I mean QEMU predicts
> > if migration will converge based on how fast it sends the data,
> > not the actual bandwidth of the interface, which one the
> > prediction uses?
> > 
> Currently I use network nominal bandwidth, e.g. 1gbps. It would
> be nice, of course, to use measured throughput since it can take
> into account network headers overhead (as Wang Lei previously
> mentioned), compression, etc., but it looks too complicated to
> implement outside of migration process.

Using line speed is definitely wise, but qemu may be stupid enough to do
wrong calculations and when it happens migration may not switchover..

See this:

https://lore.kernel.org/r/20230803155344.11450-3-peterx@redhat.com

Probably should be used together with your ways of prediction to be even
more accurate on some workloads where mbps reports insane numbers.

Thanks,

-- 
Peter Xu


