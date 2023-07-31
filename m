Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8171876A301
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:37:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQaZQ-0000U8-3T; Mon, 31 Jul 2023 17:36:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qQaZL-0000Tl-TQ
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:36:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qQaZK-0008MZ-DB
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690839405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FxwBtWb2NqDjMd/Gm9nSEVdpJkuNP2kDTv/kmcJ88Js=;
 b=Vus3eM7CcS5emnUo77Db0vayWKh6CO8+df7mzQbIzrGEnuA/5suiqPbRAPJTfARHoSz4mT
 49lAq+PIOiBiiDPqWvqd3c8CoJygFTVAm6H6BnXoORDw8AHfpmAhR2rvWyzwH16yPrSIw3
 KYJ0bL51QsxInMshxCIMmdY+X8fsmVg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-fMRNU0RTNMy--2A1WuKMEw-1; Mon, 31 Jul 2023 17:36:44 -0400
X-MC-Unique: fMRNU0RTNMy--2A1WuKMEw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fd2d33fd93so32329335e9.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690839403; x=1691444203;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FxwBtWb2NqDjMd/Gm9nSEVdpJkuNP2kDTv/kmcJ88Js=;
 b=Ow0b1LESUYHLDBBb+jNhztE5Dxb/6SuA/3dqpHpdog1drVuFGlo+4t4Vtho+P3nH3q
 nW0Iat5v59DilqpAIsECViLbUjB00TzJf+FkDiuVP1wCFNxmzYNrTo2rBlmsRIbfUtJJ
 Rpo44rdaXPUZ5gfc3FO92yygjgHRnh5L5qIJ9qGdmrdR6tcDrK9C6uMBKa43snLYNWC0
 6XDnfmhQKc68x/SgW3ChrVc+vnv1fVl4R0B8blhy2yN+TdFzMi/UepcfGWFUbO3MMvvP
 bFygAE53J4/1TLXT2uLJYBpxMjewe29VzRX0q5QAIyKZvInotiwWzB2ghRqGZrGwZt6m
 v6aA==
X-Gm-Message-State: ABy/qLZe7AQmdCJGMX8bNmXOq8q8iiRKSltyNivzhhBFis8G2pO4XcN8
 PPPRr7Ipf1DGRsujEZkg9duoF4Vv7XUP2g/IIdObfpqzhjHt6L0MB887UKqf60+OCqizV1dPMRY
 pUlGvSQWMFu7SnK0=
X-Received: by 2002:a7b:c846:0:b0:3fc:d5:dc14 with SMTP id
 c6-20020a7bc846000000b003fc00d5dc14mr852183wml.5.1690839403239; 
 Mon, 31 Jul 2023 14:36:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF7RG8Yb4RDMpMwdBG53sHWSQe2vNDzyN1XUD3Ta5ran1L6plqz/LKwn/wWJeuUE2ENowVk3w==
X-Received: by 2002:a7b:c846:0:b0:3fc:d5:dc14 with SMTP id
 c6-20020a7bc846000000b003fc00d5dc14mr852165wml.5.1690839402951; 
 Mon, 31 Jul 2023 14:36:42 -0700 (PDT)
Received: from redhat.com ([2.52.21.81]) by smtp.gmail.com with ESMTPSA id
 b9-20020a05600c11c900b003fc01f7a42dsm12341696wmi.8.2023.07.31.14.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:36:42 -0700 (PDT)
Date: Mon, 31 Jul 2023 17:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Xu <peterx@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, isaku.yamahata@gmail.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [RFC PATCH 04/19] memory: Introduce memory_region_can_be_private()
Message-ID: <20230731173607-mutt-send-email-mst@kernel.org>
References: <20230731162201.271114-1-xiaoyao.li@intel.com>
 <20230731162201.271114-5-xiaoyao.li@intel.com>
 <ZMgma0cRi/lkTKSz@x1n> <ZMgo3mGKtoQ7QsB+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgo3mGKtoQ7QsB+@google.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 31, 2023 at 02:34:22PM -0700, Sean Christopherson wrote:
> On Mon, Jul 31, 2023, Peter Xu wrote:
> > On Mon, Jul 31, 2023 at 12:21:46PM -0400, Xiaoyao Li wrote:
> > > +bool memory_region_can_be_private(MemoryRegion *mr)
> > > +{
> > > +    return mr->ram_block && mr->ram_block->gmem_fd >= 0;
> > > +}
> > 
> > This is not really MAP_PRIVATE, am I right?  If so, is there still chance
> > we rename it (it seems to be also in the kernel proposal all across..)?
> 
> Yes and yes.
> 
> > I worry it can be very confusing in the future against MAP_PRIVATE /
> > MAP_SHARED otherwise.
> 
> Heh, it's already quite confusing at times.  I'm definitely open to naming that
> doesn't collide with MAP_{PRIVATE,SHARED}, especially if someone can come with a
> naming scheme that includes a succinct way to describe memory that is shared
> between two or more VMs, but is accessible to _only_ those VMs.

Standard solution is a technology specific prefix.
protect_shared, encrypt_shared etc.

-- 
MST


