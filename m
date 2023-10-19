Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920D7CFDBE
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUs8-0003Tp-M9; Thu, 19 Oct 2023 11:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUs6-0003SB-Ep
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:23:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtUs4-00056d-RU
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697729015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvHUaYOH9ILtEm0H33iJd/hF/LrkQ8efBJMcRO9YSq0=;
 b=WU+hJjwbNTdxDb6/vAJ5rLYrzxEtI08Ez5Q1urqV3Tkht7AIeKKhIb8bTlNRFz5KKPmb44
 oc9q0ARf/1Wi+bav9Jk5easz8IIYxj4s4S90FkEklXIe5wmEHKFLH4nSkzeqmF81X4AJmD
 gitjx4SBNI5F8gCD2SQYyiEddPJO2Ok=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-oMdD4tDAOWuQo81Ui8f6iQ-1; Thu, 19 Oct 2023 11:23:34 -0400
X-MC-Unique: oMdD4tDAOWuQo81Ui8f6iQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7789a2b35f1so19501685a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697729013; x=1698333813;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gvHUaYOH9ILtEm0H33iJd/hF/LrkQ8efBJMcRO9YSq0=;
 b=HFA6OWMPz+AiYBX/EwLfkzJjUVEBVqL/zBCY4rfF92vBpludlHs/0ya4HqNAW80ZVW
 BECAQ0jun+VgbzMG2kqkI+gDEkbWnNDmTUkmkSE6hfgqiRdb2PlMldMMbdwQf4zz0YhX
 j+18a0LFPknmppf5yiFZmf0U/vcRG4GB4+fwJEe8ZK95A26X1Y4bRUGegsQJ7dRrtiIk
 Or7r5YQzvXy2x9YWT+/OKf6sMq7XRjpWUhvjx/IlUj4BYLJKSxHOnuFgPS6LSPZSXDOk
 0e/qkmjK7GhT48zMEBiGCu87WnQd2/ISHSXtaIT8il6NKI9fhLuocjzyahxQTU1fKdxH
 Uing==
X-Gm-Message-State: AOJu0Yx/LmlzPa8XQPxYcweg35ipLbsuze9ZiwQejtP/Qo3aDXEViSg9
 9Ims91U9u9MgA8n6rRdjTZ2fOQZHyIhcP05y5z7ZQeDfd738/+fwhd2e+bBCclosu/BGYCvtL75
 8vgY/3U3RGONd/n8=
X-Received: by 2002:a05:620a:3d0f:b0:76f:27af:2797 with SMTP id
 tq15-20020a05620a3d0f00b0076f27af2797mr2313517qkn.0.1697729013638; 
 Thu, 19 Oct 2023 08:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0K6l8DFIPlq0nYOQqoPMmIwauq69TiZWKW62NhjPk/ipF5KIsm2Ot9QtdiKXo492x/Z7eVQ==
X-Received: by 2002:a05:620a:3d0f:b0:76f:27af:2797 with SMTP id
 tq15-20020a05620a3d0f00b0076f27af2797mr2313497qkn.0.1697729013340; 
 Thu, 19 Oct 2023 08:23:33 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 l24-20020a05620a211800b0076c8fd39407sm806142qkl.113.2023.10.19.08.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:23:32 -0700 (PDT)
Date: Thu, 19 Oct 2023 11:23:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Yuan Liu <yuan1.liu@intel.com>,
 farosas@suse.de, leobras@redhat.com, qemu-devel@nongnu.org,
 nanhai.zou@intel.com
Subject: Re: [PATCH 0/5] Live Migration Acceleration with IAA Compression
Message-ID: <ZTFJ84SnSOAcU5gY@x1n>
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <87cyxa6dso.fsf@secure.mitica> <ZTFCnqbbqlmsUkRC@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTFCnqbbqlmsUkRC@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Oct 19, 2023 at 03:52:14PM +0100, Daniel P. Berrangé wrote:
> On Thu, Oct 19, 2023 at 01:40:23PM +0200, Juan Quintela wrote:
> > Yuan Liu <yuan1.liu@intel.com> wrote:
> > > Hi,
> > >
> > > I am writing to submit a code change aimed at enhancing live migration
> > > acceleration by leveraging the compression capability of the Intel
> > > In-Memory Analytics Accelerator (IAA).
> > >
> > > Enabling compression functionality during the live migration process can
> > > enhance performance, thereby reducing downtime and network bandwidth
> > > requirements. However, this improvement comes at the cost of additional
> > > CPU resources, posing a challenge for cloud service providers in terms of
> > > resource allocation. To address this challenge, I have focused on offloading
> > > the compression overhead to the IAA hardware, resulting in performance gains.
> > >
> > > The implementation of the IAA (de)compression code is based on Intel Query
> > > Processing Library (QPL), an open-source software project designed for
> > > IAA high-level software programming.
> > >
> > > Best regards,
> > > Yuan Liu
> > 
> > After reviewing the patches:
> > 
> > - why are you doing this on top of old compression code, that is
> >   obsolete, deprecated and buggy
> > 
> > - why are you not doing it on top of multifd.
> > 
> > You just need to add another compression method on top of multifd.
> > See how it was done for zstd:
> 
> I'm not sure that is ideal approach.  IIUC, the IAA/QPL library
> is not defining a new compression format. Rather it is providing
> a hardware accelerator for 'deflate' format, as can be made
> compatible with zlib:
> 
>   https://intel.github.io/qpl/documentation/dev_guide_docs/c_use_cases/deflate/c_deflate_zlib_gzip.html#zlib-and-gzip-compatibility-reference-link
> 
> With multifd we already have a 'zlib' compression format, and so
> this IAA/QPL logic would effectively just be a providing a second
> implementation of zlib.
> 
> Given the use of a standard format, I would expect to be able
> to use software zlib on the src, mixed with IAA/QPL zlib on
> the target, or vica-verca.
> 
> IOW, rather than defining a new compression format for this,
> I think we could look at a new migration parameter for
> 
> "compression-accelerator": ["auto", "none", "qpl"]
> 
> with 'auto' the default, such that we can automatically enable
> IAA/QPL when 'zlib' format is requested, if running on a suitable
> host.

I was also curious about the format of compression comparing to software
ones when reading.

Would there be a use case that one would prefer soft compression even if
hardware accelerator existed, no matter on src/dst?

I'm wondering whether we can avoid that one more parameter but always use
hardware accelerations as long as possible.

Thanks,

-- 
Peter Xu


