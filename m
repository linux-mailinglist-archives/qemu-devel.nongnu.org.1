Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA4977FACF
	for <lists+qemu-devel@lfdr.de>; Thu, 17 Aug 2023 17:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWeyn-0005uL-RF; Thu, 17 Aug 2023 11:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWeyl-0005uC-Af
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWeyi-00088x-Qz
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692286323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tZxW+zaxNaS91zJlaSdeNchwjsKN0H/6qRjtx4JUMfY=;
 b=Tm2huSvxaUWI9ZwmAObO8PdO5u9V5OORwvszM/jiHN4s9RNgd5fjnw+OpAVcCX0h13l4DC
 xiTXsGb7jEo9tiFaDCGJpdMdM8aUc3Q5DIKfn0VtKBFE3orp+HBf4JNcdqgstFyFCBdZ3Y
 mU9BmosZ2LFh0Smftd/kc0Tc9tBgZgE=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-dyUHQB82O8Wsk6HPuBwLUQ-1; Thu, 17 Aug 2023 11:31:59 -0400
X-MC-Unique: dyUHQB82O8Wsk6HPuBwLUQ-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-1bfb58ca395so990978fac.0
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 08:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692286319; x=1692891119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZxW+zaxNaS91zJlaSdeNchwjsKN0H/6qRjtx4JUMfY=;
 b=cqUWWQ3nvcjSYJSZEYE6sgfYuxMTNE49M3YEZQFnLD2n2fYXicP83esWoFtj3LAX+D
 /JFl70ot6Mky/iRQ1NGBR33nk7TCGA9b8bGhMzF5keupTg8jbVYkbvpRg8A/5NXhWFfG
 S31zOA5RI0LhP4rXTGS2ya8dyFMmyQuGI863rbNOtzS5FdobpESLl3h/fsMADZsGzOnc
 gAhDae+eAB0AHObB/eeH78wzyJYgOzQAZum3YTuQ825eomg3Z27sXgCpvXZ9ScoZL1AL
 r9r6Yb2W2zdNqKzIjhlSqchvJ2TNNFXrmrTN1m99/6TH5apMdd3rugh8v9ddcyaEtWyL
 A/pQ==
X-Gm-Message-State: AOJu0Yyfn9zdBlhchmGjh7HfmowYSuelUrdi1ZuHHTwoWldDIWjgA51S
 cpZhSeyTQJ3WPm6fRw3MkShk0O2m66UmapHF82n0siz89IEj+e3rGzOn6Q+SAPHKkuo+Mh3KvkS
 /ec0A89nBBAqg8D0=
X-Received: by 2002:a05:6870:6588:b0:1b7:613c:2e30 with SMTP id
 fp8-20020a056870658800b001b7613c2e30mr5240375oab.2.1692286318962; 
 Thu, 17 Aug 2023 08:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4/P3Soi6X+I/7uTm39LmfYRCLjfSfPdsVvZbL0FQjw80+qLk1I6e84VtZJW1zQqjzmHD+jA==
X-Received: by 2002:a05:6870:6588:b0:1b7:613c:2e30 with SMTP id
 fp8-20020a056870658800b001b7613c2e30mr5240343oab.2.1692286318662; 
 Thu, 17 Aug 2023 08:31:58 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 n16-20020a0ce550000000b0063f82020d8bsm3008797qvm.60.2023.08.17.08.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:31:58 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:31:56 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, ThinerLogoer <logoerthiner1@163.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZN49bPlANaNrgXCu@x1n>
References: <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <1b4168d2.4182.189e324e0ef.Coremail.logoerthiner1@163.com>
 <08cc9db9-b774-b027-58f5-dd7e6c374657@redhat.com>
 <2b967b3.13b7.189e82ee694.Coremail.logoerthiner1@163.com>
 <06f9a805-8150-8106-7d0a-05d0d2465cd0@redhat.com>
 <CAJSP0QVjxNQ=sMjzEFzbyhJ0e+O5bGBiXkHMgWiB2GOVw4NqHQ@mail.gmail.com>
 <9b2b884e-095c-7cd5-380b-b3b0c5aad9b6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b2b884e-095c-7cd5-380b-b3b0c5aad9b6@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.021,
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

On Thu, Aug 17, 2023 at 05:15:52PM +0200, David Hildenbrand wrote:
> > I don't know how important that requirement was (that commit was a
> > request from Kata Containers).
> 
> Let me take a look if Kata passes "share=on,readonly=on" or
> "share=off,readonly=off".

The question is whether it's good enough if we change the semantics as long
as we guarantee the original purposes of when introducing those flags would
be enough (nvdimm, kata, etc.), as anything introduced in qemu can
potentially be used elsewhere too.

David, could you share your concern on simply "having a new flag, while
keeping all existing flags unchanged on behavior"?  You mentioned it's not
wanted, but I didn't yet see the reason behind.

Thanks,

-- 
Peter Xu


