Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542897A7424
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:31:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirfQ-00059C-GD; Wed, 20 Sep 2023 03:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qirfB-00054j-TO
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:30:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qirfA-0003cL-9H
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695195018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i2WgtYybkbUsFYRJOW6P1Ah19uLIKqMGatOtx6TDY7A=;
 b=CZH6YNNnlLKF3zyP7+QoAWV3tQCnHilc2fVBPX2cqLAGU9h/TxeEjaDGhFIpoU51MPqd5z
 hKcBDR30bKG2OqxJQhiFHdrXzJCpnqkf71+lC98WxiApknSwnXcJ0m/Xv9AdQFsqc+KJWl
 m++YEQuADV7ojONMztTRUH5Z7NMaUrw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-T5PUNI4cOF6P-f6nkHOiTg-1; Wed, 20 Sep 2023 03:30:13 -0400
X-MC-Unique: T5PUNI4cOF6P-f6nkHOiTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2BFD1185A797;
 Wed, 20 Sep 2023 07:30:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 04D25C15BB8;
 Wed, 20 Sep 2023 07:30:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F35FE21E6900; Wed, 20 Sep 2023 09:30:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  isaku.yamahata@gmail.com,  Sean
 Christopherson <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v2 03/21] HostMem: Add private property and
 associate it with RAM_KVM_GMEM
References: <20230914035117.3285885-1-xiaoyao.li@intel.com>
 <20230914035117.3285885-4-xiaoyao.li@intel.com>
 <8734zazeag.fsf@pond.sub.org>
 <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com>
Date: Wed, 20 Sep 2023 09:30:11 +0200
In-Reply-To: <d0e7e2f8-581d-e708-5ddd-947f2fe9676a@intel.com> (Xiaoyao Li's
 message of "Wed, 20 Sep 2023 07:24:06 +0800")
Message-ID: <878r91nvy4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 9/19/2023 5:46 PM, Markus Armbruster wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> From: Isaku Yamahata <isaku.yamahata@intel.com>
>>>
>>> Add a new property "private" to memory backends. When it's set to true,
>>> it indicates the RAMblock of the backend also requires kvm gmem.
>> Can you add a brief explanation why you need the property?
>
> It provides a mechanism for user to specify whether the memory can serve as private memory (need request kvm gmem).

Yes, but why would a user want such memory?


