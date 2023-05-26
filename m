Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 155E1712E28
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 22:34:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2e7O-0002L1-RA; Fri, 26 May 2023 16:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2e7L-0002K0-Js
 for qemu-devel@nongnu.org; Fri, 26 May 2023 16:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q2e7J-0006aI-3i
 for qemu-devel@nongnu.org; Fri, 26 May 2023 16:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685133171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w88dKxOFNphCNTDyDzXNErgI1kj2Vs8SaWD8y1A2bPs=;
 b=UsS0lhy852Z5dPK1qaiWDgiLS1Rr2J2+hF6D2LkC8G1KZb80LG3hJI8tq3d8oEUpE8G5XI
 MxTZ9+PL29n43LVmGfG5t7nfxdjR4HzN8RpmM+eVaF0zhZwiaoR45j652mHEM0Fq6QGavO
 KXQSiI+9Lylr3qC7U7gDS4lgIB9OMXU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-xl_oM-rdMRuwrqcHNI6L4A-1; Fri, 26 May 2023 16:32:49 -0400
X-MC-Unique: xl_oM-rdMRuwrqcHNI6L4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 393571C01510;
 Fri, 26 May 2023 20:32:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DFD9C154D1;
 Fri, 26 May 2023 20:32:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8538A21E692E; Fri, 26 May 2023 22:32:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>,  <qemu-devel@nongnu.org>,
 Michael Tsirkin <mst@redhat.com>,  Fan Ni <fan.ni@samsung.com>,
 <linux-cxl@vger.kernel.org>,  <linuxarm@huawei.com>,  Ira Weiny
 <ira.weiny@intel.com>,  Michael Roth <michael.roth@amd.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Dave Jiang
 <dave.jiang@intel.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Mike Maslenkin <mike.maslenkin@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Thomas
 Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module
 Events
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
 <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
 <87h6rz8bnj.fsf@pond.sub.org> <20230526181004.0000512d@Huawei.com>
Date: Fri, 26 May 2023 22:32:47 +0200
In-Reply-To: <20230526181004.0000512d@Huawei.com> (Jonathan Cameron's message
 of "Fri, 26 May 2023 18:10:04 +0100")
Message-ID: <87jzwu6dg0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

>> > +# @temperature: Device temperature in degrees Celsius.
>> > +#
>> > +# @dirty-shutdown-count: Number of time the device has been unable to  
>> 
>> Number of times
>> 
>> > +#                        determine whether data loss may have occurred.
>> > +#
>> > +# @corrected-volatile-error-count: Total number of correctable errors in
>> > +#                                  volatile memory.
>> > +#
>> > +# @corrected-persistent-error-count: Total number correctable errors in
>> > +#                                    persistent memory  
>> 
>> Please format like
>> 
>>    # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>>    #     Record Format, Event Record Flags for subfield definitions.
>>    #
>>    # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>>    #     Event Record for bit definitions for bit definiions.
>>    #
>>    # @health-status: Overall health summary bitmap.  See CXL r3.0 Table
>>    #     8-100 Get Health Info Output Payload, Health Status for bit
>>    #     definitions.
>>    #
>>    # @media-status: Overall media health summary.  See CXL r3.0 Table
>>    #     8-100 Get Health Info Output Payload, Media Status for bit
>>    #     definitions.
>>    #
>>    # @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
>>    #     Payload, Additional Status for subfield definitions.
>>    #
>>    # @life-used: Percentage (0-100) of factory expected life span.
>>    #
>>    # @temperature: Device temperature in degrees Celsius.
>>    #
>>    # @dirty-shutdown-count: Number of time the device has been unable to
>>    #     determine whether data loss may have occurred.
>
> With "Number of times" this runs to 71 chars. reflowed appropriately for v8

Appreciated!

>>    #
>>    # @corrected-volatile-error-count: Total number of correctable errors
>>    #     in volatile memory.
>>    #
>>    # @corrected-persistent-error-count: Total number correctable errors
>>    #     in persistent memory
>> 
>> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
>> to conform to current conventions).
>> 
>> 
>> > +#


