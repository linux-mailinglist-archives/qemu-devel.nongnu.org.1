Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DC2779448
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:23:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUuM-00042P-0x; Fri, 11 Aug 2023 12:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUUuJ-00040f-Qi
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUUuI-0004RA-Ed
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zBdKGJSGKgIUx4YiLXZJ0QCTn0bM2gm0vF7flWDNiro=;
 b=cuNodkKvBnBjWUG/imMXkc5CqeNUsm6S0tdul5M/mw4ThXODJ175agAwGIDYzcTht9HtPH
 k1HVYLy4ucg5p5oER7CgkLo4eVJS6Mm7UgFICRNlWbaR88iCnNwT23Uod4bjtd2p9hSEP/
 Ut0Z3OQL945Iyyxxus6yMQAAm9dkfKU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-TOBlBeoVMpqs1yS_aQXHgw-1; Fri, 11 Aug 2023 12:22:32 -0400
X-MC-Unique: TOBlBeoVMpqs1yS_aQXHgw-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4871eecdfc5so162552e0c.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770951; x=1692375751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBdKGJSGKgIUx4YiLXZJ0QCTn0bM2gm0vF7flWDNiro=;
 b=d+/PYKycoqwGuokJ7MUi9qy5ftiDn86BVakPEfw1X0XxAIOmh6rcYX7CGP1j5ZRJ67
 CcHgZG3WncECuXJGYORk9dZj5qcT+Vog7+fpN17zLHFvhIU8eKDB8R+yk3bsq9AX8ZbG
 aLy0qSNltB9YOZtlDs0FsPjrBORMgBcYN5M+QKuxaXFW6tBVuKYn1kxjWNifLfmO+ILy
 iCkZ6uLmXXlRnKsDkBX22vYq1u9tZ45VjQaGPS7DiXLcEC8AMIndrlAWl/5OwuDr7svl
 ZnIgO128LCo82DBUrqi1r6jieFXi/LIRiI2rxvctJiA0iZAhiKjaGYVryESA7E2qYhWy
 /l2w==
X-Gm-Message-State: AOJu0Ywv90vgYVQhXoZ5I2xTIrw5NjeuNfqfvhBApuWVQRrCJmoo6FTF
 ys20fUexlXY7pCkiKO0cPILQXMxuUnKOEms3KRA8vwPuRASxx5WrUJtA/jsrDkFiBbuVmCvMN1l
 ZRmKhpC0h1zr3Z4g=
X-Received: by 2002:a05:6122:4219:b0:487:3c3b:461d with SMTP id
 cm25-20020a056122421900b004873c3b461dmr1474476vkb.1.1691770951568; 
 Fri, 11 Aug 2023 09:22:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9yV3auu7WzpwMa0v+jjW6GMRT3Lt+1L0X39v+4/sNrK00AVsIGSURBa7Lx3yzrM62ejhfdw==
X-Received: by 2002:a05:6122:4219:b0:487:3c3b:461d with SMTP id
 cm25-20020a056122421900b004873c3b461dmr1474462vkb.1.1691770951256; 
 Fri, 11 Aug 2023 09:22:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h14-20020a0cf40e000000b00635efe2f65csm1322654qvl.30.2023.08.11.09.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:22:30 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:22:30 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNZgRq22IXyqpun7@x1n>
References: <ZNKtHVotkfgI1tb4@x1n>
 <1d1a7d8f-6260-5905-57ea-514b762ce869@redhat.com>
 <ZNOti1OKN79t68jP@x1n>
 <e9c53fbd-369c-2605-1470-e67a765f923b@redhat.com>
 <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
 <ZNZez9ICBBf+D/d2@x1n>
 <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com>
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

On Fri, Aug 11, 2023 at 06:17:05PM +0200, David Hildenbrand wrote:
> We wouldn't touch "-mem-path".

But still the same issue when someone uses -object memory-backend-file for
hugetlb, mapping privately, expecting ram discard to work?

Basically I see that example as, "hugetlb" in general made the private
mapping over RW file usable, so forbidden that anywhere may take a risk.

Thanks,

-- 
Peter Xu


